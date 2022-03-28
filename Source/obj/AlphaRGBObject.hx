package obj;

using obj.Maths;

class AlphaRGBObject {
	public var a:Float = 1.0;
	public var r:UInt = 0;
	public var g:UInt = 0;
	public var b:UInt = 0;

	public function new(param1:Float = 0, param2:UInt = 0, param3:UInt = 0, param4:UInt = 0) {
		this.a = param1;
		this.r = param2;
		this.g = param3;
		this.b = param4;
	}

    public function equals(other: AlphaRGBObject): Bool {
        return this.a == other.a && this.r == other.r && this.g == other.g && this.b == other.b;
    }

	static var isPureHex = ~/^([0-9a-f]{2}){3,4}$/i;

	public function fromYaml(data:Dynamic) {
		var s = cast(data, String);

		if (!isPureHex.match(s)) {
			if (s.substr(0, 1) == "#") {
				if (s.length == 4)
					s = s.charAt(1) + s.charAt(1) + s.charAt(2) + s.charAt(2) + s.charAt(3) + s.charAt(3);
				else if (s.length == 5)
					s = s.charAt(1) + s.charAt(1) + s.charAt(2) + s.charAt(2) + s.charAt(3) + s.charAt(3) + s.charAt(4) + s.charAt(4);
				else
					s = s.substr(1);
			} else if (s.substr(0, 2) == "0x")
				s = s.substr(2);
			else
                throw "Invalid hex color: " + data;
		}

		var channels = [];
		while (s.length > 0) {
			channels.push(Std.parseInt('0x${s.substr(0, 2)}'));
			s = s.substr(2);
		}

        if (channels[0] != null)
            this.r = channels[0];
		if (channels[1] != null)
			this.g = channels[1];
		if (channels[2] != null)
			this.b = channels[2];

		if (channels[3] != null) {
            this.a = channels[3] / 255.0;
        }
        else {
            this.a = 1.0;
        }
	}

	public function toYaml(): String {
        var s = '#${StringTools.hex(r, 2)}${StringTools.hex(g, 2)}${StringTools.hex(b, 2)}';
        if (this.a < 1.0) {
            s += StringTools.hex(Maths.clamp(Std.int(a * 255.0), 0, 255), 2);
        }
        return s;
    }
}
