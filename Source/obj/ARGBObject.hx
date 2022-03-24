package obj;

class ARGBObject {
	public var a:UInt = 0;
	public var r:UInt = 0;
	public var g:UInt = 0;
	public var b:UInt = 0;

	public function new(a:UInt = 0, r:UInt = 0, g:UInt = 0, b:UInt = 0) {
		this.a = a;
		this.r = r;
		this.g = g;
		this.b = b;
	}

	public function setARGB(rest:Array<ASAny> = null):ASAny {
		if (rest == null)
			rest = [];
		if (rest.length == 1) {
			this.split(rest[0]);
		} else {
			this.fillARGB(rest);
		}
	}

	@:flash.property public var argb(get, never):UInt;

	function get_argb():UInt {
		return this.a << 24 | this.r << 16 | this.g << 8 | this.b;
	}

	@:flash.property public var rgb(get, never):UInt;

	function get_rgb():UInt {
		return this.r << 16 | this.g << 8 | this.b;
	}

	public function split(param1:UInt) {
		if (param1 < 16777215) {
			this.a = 255;
		} else {
			this.a = (param1 & 4278190080) >>> 24;
		}
		this.r = (param1 & 16711680) >>> 16;
		this.g = (param1 & 65280) >>> 8;
		this.b = param1 & 255;
	}

	public function fillARGB(param1:Array<UInt>) {
		if (param1.length == 4) {
			this.a = param1.shift();
		}
		if (param1.length > 0) {
			this.r = param1.shift();
		}
		if (param1.length > 0) {
			this.g = param1.shift();
		}
		if (param1.length > 0) {
			this.b = param1.shift();
		}
	}
}
