package obj.her;

import openfl.geom.Point;

class TearPoint extends Point {
	public var speedMult:Float = 1.0;
	public var alphaMult:Float = 1.0;
	public var scaling:Float = 1.0;
	public var age:UInt = 0;
	public var mascaraTime:Float = Math.NaN;
	public var hasMascara:Bool = false;

	public function new(param1:Float, param2:Float, param3:Float) {
		super(param1, param2);
		this.speedMult = param3;
		this.alphaMult = param3;
		if (Math.random() > Math.max(0.2, 1 - G.mascaraAmount * 0.015)) {
			this.hasMascara = true;
		} else {
			this.hasMascara = false;
		}
		if (Math.random() > 0.96 - G.mascaraAmount * 0.008) {
			this.mascaraTime = Math.random() * 100 + 200;
		} else {
			this.mascaraTime = Math.random() * 50 + 50;
		}
		this.mascaraTime = 1 / this.mascaraTime;
	}

	public function tick():Bool {
		++this.age;
		this.speedMult -= 0.005;
		this.alphaMult -= 0.005;
		if (this.speedMult <= 0 || this.alphaMult <= 0) {
			return false;
		}
		return true;
	}

	public function getAge():Float {
		return this.age * this.mascaraTime;
	}
}
