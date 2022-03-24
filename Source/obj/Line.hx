package obj;

import openfl.geom.Point;

class Line {
	public var p1:Point;
	public var p2:Point;

	public function new(param1:Point, param2:Point) {
		// super();
		this.p1 = param1;
		this.p2 = param2;
	}

	@:flash.property public var A(get, never):Float;

	function get_A():Float {
		return this.p2.y - this.p1.y;
	}

	@:flash.property public var B(get, never):Float;

	function get_B():Float {
		return this.p1.x - this.p2.x;
	}

	@:flash.property public var C(get, never):Float;

	function get_C():Float {
		return (this.p2.y - this.p1.y) * this.p1.x + (this.p1.x - this.p2.x) * this.p1.y;
	}

	@:flash.property public var x1(get, never):Float;

	function get_x1():Float {
		return this.p1.x;
	}

	@:flash.property public var y1(get, never):Float;

	function get_y1():Float {
		return this.p1.y;
	}

	@:flash.property public var x2(get, never):Float;

	function get_x2():Float {
		return this.p2.x;
	}

	@:flash.property public var y2(get, never):Float;

	function get_y2():Float {
		return this.p2.y;
	}
}
