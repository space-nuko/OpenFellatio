package utils;

class TypeUtils {
	public static function tryInstantiate(klassName: String, baseType: Dynamic): Dynamic {
		try {
			var klass = Type.resolveClass(klassName);
			var value = Type.createInstance(klass, []);

			if (Std.isOfType(value, baseType)) {
				return Std.downcast(value, baseType);
			} else {
				throw "Type " + klassName + " is not a subclass of CharacterElement";
			}
		} catch (e) {
			throw "Could not instantiate type " + klassName + ": " + e;
		}
	}
}
