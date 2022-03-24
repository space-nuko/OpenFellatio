package obj.her;

import obj.ARGBObject;

class SkinPalette {
	public static var LIGHT_SKIN:String = "Light";
	public static var PALE_SKIN:String = "Pale";
	public static var TAN_SKIN:String = "Tan";
	public static var DARK_SKIN:String = "Dark";

	public var skinName:String;
	public var light:ARGBObject;
	public var shade1:ARGBObject;
	public var shade2:ARGBObject;
	public var shade3:ARGBObject;
	public var nippleLight:ARGBObject;
	public var nippleShade:ARGBObject;
	public var lipAlpha:Float = Math.NaN;

	public function new(param1:UInt, param2:UInt, param3:UInt, param4:UInt, param5:UInt, param6:UInt, param7:Float = 1.0) {
		this.light = this.split(param1);
		this.shade1 = this.split(param2);
		this.shade2 = this.split(param3);
		this.shade3 = this.split(param4);
		this.nippleLight = this.split(param5);
		this.nippleShade = this.split(param6);
		this.lipAlpha = param7;
	}

	public function split(param1:UInt): ARGBObject {
		var _loc2_:UInt = 0;
		var _loc3_:UInt = 0;
		var _loc4_:UInt = 0;
		var _loc5_:UInt = 0;
		if (param1 < 16777215) {
			_loc2_ = 255;
		} else {
			_loc2_ = (param1 & 4278190080) >>> 24;
		}
		_loc3_ = (param1 & 16711680) >>> 16;
		_loc4_ = (param1 & 65280) >>> 8;
		_loc5_ = param1 & 255;
		return new ARGBObject(_loc2_, _loc3_, _loc4_, _loc5_);
	}
}
