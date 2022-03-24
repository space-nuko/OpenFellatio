package obj.graphics;

import obj.AlphaRGBObject;

class PaletteUtils {
	public static function randomSwatch(param1:Array<AlphaRGBObject>, param2:Bool = false):AlphaRGBObject {
		var _loc3_ = param1[Math.floor(Math.random() * param1.length)];
		if (param2) {
			_loc3_.a = Math.random() * 0.8 + 0.2;
		} else {
			_loc3_.a = 1;
		}
		return _loc3_;
	}

	public static function midRandom():Float {
		return 0.5 + (Math.random() - 0.5) * (Math.random() - 0.5);
	}

	public static function getHue(param1:Float, param2:Float, param3:Float = -1):AlphaRGBObject {
		var _loc8_ = 0;
		var _loc4_:UInt = Math.floor(hueWave(param1, 0, 360) * 255);
		var _loc5_:UInt = Math.floor(hueWave(param1, 1, 360) * 255);
		var _loc6_:UInt = Math.floor(hueWave(param1, 2, 360) * 255);
		var _loc7_ = (_loc4_ + _loc5_ + _loc6_) / 3;
		_loc4_ = Math.round(_loc7_ + (_loc4_ - _loc7_) * param2);
		_loc5_ = Math.round(_loc7_ + (_loc5_ - _loc7_) * param2);
		_loc6_ = Math.round(_loc7_ + (_loc6_ - _loc7_) * param2);
		if (param3 != -1) {
			param3 *= 255 * 3;
			_loc8_ = Math.floor((param3 - _loc4_ - _loc5_ - _loc6_) / 3);
			_loc4_ = Std.int(Math.max(0, Math.min(255, _loc4_ + _loc8_)));
			_loc5_ = Std.int(Math.max(0, Math.min(255, _loc5_ + _loc8_)));
			_loc6_ = Std.int(Math.max(0, Math.min(255, _loc6_ + _loc8_)));
		}
		return new AlphaRGBObject(1, _loc4_, _loc5_, _loc6_);
	}

	public static function hueWave(param1:Float, param2:UInt, param3:Float = 100):Float {
		param3 /= 3;
		param1 /= param3;
		param1 += param2;
		var _loc4_ = 6 * (param1 / 3 - Math.ffloor(param1 / 3 + 0.5));
		return Math.max(0, Math.min(1, Math.abs(_loc4_) - 1));
	}
}
