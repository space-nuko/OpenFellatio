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
        var argb = new ARGBObject(0, 0, 0, 0);
        argb.split(param1);
        return argb;
	}
}
