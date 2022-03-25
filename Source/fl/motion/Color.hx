package fl.motion;

import openfl.geom.ColorTransform;

class Color extends ColorTransform {
	public var _tintColor:Float = 0;
	public var _tintMultiplier:Float = 0;

	public function new(param1:Float = 1.0, param2:Float = 1.0, param3:Float = 1.0, param4:Float = 1.0, param5:Float = 0, param6:Float = 0, param7:Float = 0,
			param8:Float = 0) {
		super(param1, param2, param3, param4, param5, param6, param7, param8);
	}

	// public static function fromXML(param1:compat.XML):Color {
	// 	return cast(new Color().parseXML(param1), Color);
	// }

	public static function interpolateTransform(param1:ColorTransform, param2:ColorTransform, param3:Float):ColorTransform {
		var _loc4_ = 1 - param3;
		return new ColorTransform(param1.redMultiplier * _loc4_
			+ param2.redMultiplier * param3,
			param1.greenMultiplier * _loc4_
			+ param2.greenMultiplier * param3, param1.blueMultiplier * _loc4_
			+ param2.blueMultiplier * param3,
			param1.alphaMultiplier * _loc4_
			+ param2.alphaMultiplier * param3, param1.redOffset * _loc4_
			+ param2.redOffset * param3,
			param1.greenOffset * _loc4_
			+ param2.greenOffset * param3, param1.blueOffset * _loc4_
			+ param2.blueOffset * param3,
			param1.alphaOffset * _loc4_
			+ param2.alphaOffset * param3);
	}

	public static function interpolateColor(param1:UInt, param2:UInt, param3:Float):UInt {
		var _loc4_ = 1 - param3;
		var _loc5_:UInt = param1 >> 24 & 255;
		var _loc6_:UInt = param1 >> 16 & 255;
		var _loc7_:UInt = param1 >> 8 & 255;
		var _loc8_:UInt = param1 & 255;
		var _loc9_:UInt = param2 >> 24 & 255;
		var _loc10_:UInt = param2 >> 16 & 255;
		var _loc11_:UInt = param2 >> 8 & 255;
		var _loc12_:UInt = param2 & 255;
		var _loc13_:UInt = Std.int(_loc5_ * _loc4_ + _loc9_ * param3);
		var _loc14_:UInt = Std.int(_loc6_ * _loc4_ + _loc10_ * param3);
		var _loc15_:UInt = Std.int(_loc7_ * _loc4_ + _loc11_ * param3);
		var _loc16_:UInt = Std.int(_loc8_ * _loc4_ + _loc12_ * param3);
		return _loc13_ << 24 | _loc14_ << 16 | _loc15_ << 8 | _loc16_;
	}

	@:flash.property public var brightness(get, set):Float;

	function get_brightness():Float {
		return !!ASCompat.floatAsBool(this.redOffset) ? 1 - this.redMultiplier : this.redMultiplier - 1;
	}

	function set_brightness(param1:Float):Float {
		if (param1 > 1) {
			param1 = 1;
		} else if (param1 < -1) {
			param1 = -1;
		}
		var _loc2_ = 1 - Math.abs(param1);
		var _loc3_:Float = 0;
		if (param1 > 0) {
			_loc3_ = param1 * 255;
		}
		this.redMultiplier = this.greenMultiplier = this.blueMultiplier = _loc2_;
		this.redOffset = this.greenOffset = this.blueOffset = _loc3_;
		return param1;
	}

	public function setTint(param1:UInt, param2:Float) {
		this._tintColor = param1;
		this._tintMultiplier = param2;
		this.redMultiplier = this.greenMultiplier = this.blueMultiplier = 1 - param2;
		var _loc3_:UInt = param1 >> 16 & 255;
		var _loc4_:UInt = param1 >> 8 & 255;
		var _loc5_:UInt = param1 & 255;
		this.redOffset = Math.fround(_loc3_ * param2);
		this.greenOffset = Math.fround(_loc4_ * param2);
		this.blueOffset = Math.fround(_loc5_ * param2);
	}

	@:flash.property public var tintColor(get, set):UInt;

	function get_tintColor():UInt {
		return Std.int(this._tintColor);
	}

	function set_tintColor(param1:UInt):UInt {
		this.setTint(param1, this.tintMultiplier);
		return param1;
	}

	public function deriveTintColor():UInt {
		var _loc1_ = 1 / this.tintMultiplier;
		var _loc2_:UInt = Math.round(this.redOffset * _loc1_);
		var _loc3_:UInt = Math.round(this.greenOffset * _loc1_);
		var _loc4_:UInt = Math.round(this.blueOffset * _loc1_);
		return _loc2_ << 16 | _loc3_ << 8 | _loc4_;
	}

	@:flash.property public var tintMultiplier(get, set):Float;

	function get_tintMultiplier():Float {
		return this._tintMultiplier;
	}

	function set_tintMultiplier(param1:Float):Float {
		this.setTint(this.tintColor, param1);
		return param1;
	}

	// public function parseXML(param1:compat.XML = null):Color {
	// 	var _loc3_:compat.XML = null;
	// 	var _loc4_:String = null;
	// 	var _loc5_:UInt = 0;
	// 	if (param1 == null) {
	// 		return this;
	// 	}
	// 	var _loc2_:compat.XML = param1.elements()[0];
	// 	if (_loc2_ == null) {
	// 		return this;
	// 	}
	// 	for (_tmp_ in _loc2_.attributes()) {
	// 		_loc3_ = _tmp_;
	// 		if ((_loc4_ = _loc3_.localName()) == "tintColor") {
	// 			_loc5_ = Std.int(ASCompat.toNumber(_loc3_.toString()));
	// 			this.tintColor = _loc5_;
	// 		} else {
	// 			(this : ASAny)[_loc4_] = ASCompat.toNumber(_loc3_.toString());
	// 		}
	// 	}
	// 	return this;
	// }
}
