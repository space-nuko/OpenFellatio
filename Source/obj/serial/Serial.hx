package obj.serial;

import haxe.macro.TypeTools;
import haxe.macro.Type;
import haxe.macro.Context;
import haxe.macro.Expr;

using Lambda;

class Serial {
	macro static public function fromYaml(yaml: Expr):Expr {
		// Grab the variables accessible in the context the macro was called.
		var locals = Context.getLocalVars();
		var fields = Context.getLocalClass().get().fields.get();

		var exprs:Array<Expr> = [];

		for (field in getSaveFields(fields)) {
            var s = macro $v{field.name};
            pushTypeDeserializers(field.name, field.type, yaml, s, exprs);
		}

		// Generates a block expression from the given expression array
		return macro $b{exprs};
	}

    private static function pushTypeDeserializers(name: String, type: haxe.macro.Type, yaml: Expr, yName: Expr, exprs: Array<Expr>) {
		switch (type) {
            case TLazy(t):
                try {
                    pushTypeDeserializers(name, t(), yaml, yName, exprs);
                }
                // Only seems to error here on method types, so no big deal
                catch (_) {}
            case TAbstract(t, params):
                var type = t.get();

                var expr:Expr;

                if (type.name == "ABSNull") {
                    pushTypeDeserializers(name, params[0], yaml, yName, exprs);
                }
                else {
					expr = macro {
						if ($yaml.exists($yName)) {
                            this.$name = $yaml.get($yName);
                        }
					};

                    exprs.push(expr);
                }
			case TInst(t, _):
				var complexType = TypeTools.toComplexType(type);
                var type = t.get();

                var expr:Expr;
				if (isSimpleType(type)) {
					expr = macro {
						if ($yaml.exists($yName)) {
							this.$name = cast($yaml.get($yName), $complexType);
						}
					};
				}
                else if (type.name == "Class") {
					expr = macro {
						if ($yaml.exists($yName)) {
							this.$name = Type.resolveClass(cast($yaml.get($yName), String));
						}
					};
                }
                else {
                    var typePath = makeTypePath(type);
					expr = macro {
						if ($yaml.exists($yName)) {
							this.$name = new $typePath();
                            this.$name.fromYaml($yaml.get($yName));
						}
					};
                }

                exprs.push(expr);
            case TDynamic(_):
				var expr = macro {
					if ($yaml.exists($yName)) {
						this.$name = $yaml.get($yName);
					}
				};

                exprs.push(expr);
			default:
		}
    }

	macro static public function toYaml():Expr {
		// Grab the variables accessible in the context the macro was called.
		var locals = Context.getLocalVars();
        var klass = Context.getLocalClass().get();
		var fields = klass.fields.get();

		var exprs:Array<Expr> = [];

        var klassPath = makeTypePath(klass);
        exprs.push(macro var base = new $klassPath());

		for (field in getSaveFields(fields)) {
            pushTypeSerializers(field.name, field.type, exprs);
        }

        // exprs.push(macro return yaml);

        // Generates a block expression from the given expression array
        return macro $b{exprs};
	}

    private static function pushTypeSerializers(name: String, type: haxe.macro.Type, exprs: Array<Expr>) {
		switch (type) {
            case TLazy(t):
                try {
                    pushTypeSerializers(name, t(), exprs);
                }
                // Only seems to error here on method types, so no big deal
                catch(_) {}
            case TAbstract(t, params):
                var type = t.get();

                var expr:Expr;
                if (type.name == "ABSNull") {
                    pushTypeSerializers(name, params[0], exprs);
                }
                else {
					expr = macro {
						if (this.$name != base.$name) {
							yaml.$name = this.$name;
						}
					};

                    exprs.push(expr);
                }
            case TInst(t, _):
                var type = t.get();

                var expr:Expr;

                if (isSimpleType(type)) {
                    expr = macro {
                        if (this.$name != base.$name) {
                            yaml.$name = this.$name;
                        }
                    };
                }
                else if (type.name == "Class") {
                    expr = macro {
                        if (!this.$name != base.$name) {
                            yaml.$name = Type.getClassName(this.$name);
                        }
                    };
                }
                else {
                    if (hasEquals(type)) {
                        expr = macro {
                            if (this.$name != null && !this.$name.equals(base.$name)) {
                                yaml.$name = this.$name.toYaml();
                            }
                        };
                    }
                    else {
                        expr = macro yaml.$name = this.$name.toYaml();
                    }
                }
                exprs.push(expr);
            case TDynamic(_):
                exprs.push(macro yaml.$name = this.$name);
            default:
        }
    }

    private static function getSaveFields(fields: Array<ClassField>): Array<ClassField> {
		var saveFields: Array<ClassField> = [];

		for(field in fields){
            if (field.meta.has(":save")) {
                saveFields.push(field);
            }
        }

        return saveFields;
    }

	private static inline function makeTypePath(clazz: BaseType): TypePath {
		var result: TypePath = {name: clazz.name, pack: clazz.pack};
		var module = clazz.module.substring(clazz.module.lastIndexOf(".") + 1);
		if (clazz.name != module) {
			result.name = module;
			result.sub = clazz.name;
		}

		return result;
	}

	static final simpleTypes: Map<String, Bool> = [
		"Bool" => true,
		"Int" => true,
		"Float" => true,
		"String" => true,
		"Void" => true
	];

	private static function isSimpleType(t:ClassType):Bool {
		return simpleTypes.exists(t.name);
	}

	private static function hasEquals(t:ClassType):Bool {
        for (field in t.fields.get()) {
            if (field.name == "equals") {
                switch (field.type) {
                    case TFun(_, _):
                        return true;
                    default:
                        return false;
                }
            }
        }

        return false;
	}
}
