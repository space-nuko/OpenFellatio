package obj;

import openfl.geom.Point;

class RopeLink extends Point {
	public var speed:Point;
	public var friction:Float = Math.NaN;
	public var mass:Float = Math.NaN;
	public var lastPos:Point;

	public function new(_x:Float, _y:Float, _friction:Float, _mass:Float) {
		super();
		this.x = _x;
		this.y = _y;
		this.friction = _friction;
		this.mass = _mass;
		this.speed = new Point();
		this.lastPos = new Point();
	}

	public function move(param1:Point) {
		this.lastPos.x = this.x;
		this.lastPos.y = this.y;
		this.x += param1.x * this.mass;
		this.y += param1.y * this.mass;
	}
}
