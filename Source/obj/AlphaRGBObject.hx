package obj;

class AlphaRGBObject {
	public var a:Float = Math.NaN;
	public var r:UInt = 0;
	public var g:UInt = 0;
	public var b:UInt = 0;

	public function new(param1:Float = 0, param2:UInt = 0, param3:UInt = 0, param4:UInt = 0) {
		this.a = param1;
		this.r = param2;
		this.g = param3;
		this.b = param4;
	}
}
