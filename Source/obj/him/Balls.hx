package obj.him;

import openfl.display.MovieClip;
import openfl.display.Sprite;
import openfl.geom.Point;

@:rtti
@:access(swf.exporters.animate)
class Balls extends Sprite {
	public static var GRAVITY:Float = 3;
	public static var PUSH:Float = 0.08;
	public static var FRICTION:Float = 0.8;

	public var leftBallPos:Point = new Point();
	public var leftBallSpeed:Point = new Point();
	public var rightBallPos:Point = new Point();
	public var rightBallSpeed:Point = new Point();
	public var posDiff:Point = new Point();
	public var leftBallRatio:Float = 0;
	public var leftBallRatioChange:Float = 0;
	public var rightBallRatio:Float = 0;
	public var rightBallRatioChange:Float = 0;

	@:keep public var rightOutline(default, null):openfl.display.MovieClip;
	@:keep public var leftOutline(default, null):openfl.display.MovieClip;
	@:keep public var rightFill(default, null):openfl.display.MovieClip;
	@:keep public var leftFill(default, null):openfl.display.MovieClip;
	@:keep public var rightHighlight(default, null):openfl.display.MovieClip;
	@:keep public var leftHighlight(default, null):openfl.display.MovieClip;

	public function new() {
		var library = swf.exporters.animate.AnimateLibrary.get("Ld39TJPQZsVJfqCLrG3m");
		var symbol = library.symbols.get(265);
		symbol.__init(library);

		super();
	}

	public function pushBalls(param1:Float = 0, param2:Float = 0) {
		this.leftBallSpeed.x += param1 * this.leftBallRatio;
		this.leftBallSpeed.y += param2 * this.leftBallRatio;
		this.rightBallSpeed.x += param1 * this.rightBallRatio;
		this.rightBallSpeed.y += param2 * this.rightBallRatio;
	}

	public function update() {
		this.leftBallRatioChange += (Math.random() - 0.5) * 0.1;
		this.leftBallRatioChange = Math.min(0.1, Math.max(-0.1, this.leftBallRatioChange));
		this.leftBallRatio += this.leftBallRatioChange;
		this.leftBallRatio = Math.min(1, Math.max(1 - this.rightBallRatio, this.leftBallRatio));
		this.rightBallRatioChange += (Math.random() - 0.5) * 0.1;
		this.rightBallRatioChange = Math.min(0.1, Math.max(-0.1, this.rightBallRatioChange));
		this.rightBallRatio += this.rightBallRatioChange;
		this.rightBallRatio = Math.min(1, Math.max(1 - this.leftBallRatio, this.rightBallRatio));
		this.updateBall(this.leftBallPos, this.leftBallSpeed, this.leftHighlight, this.leftFill, this.leftOutline);
		this.updateBall(this.rightBallPos, this.rightBallSpeed, this.rightHighlight, this.rightFill, this.rightOutline);
		this.posDiff.x = this.leftBallPos.x - this.rightBallPos.x;
		this.posDiff.y = this.leftBallPos.y - this.rightBallPos.y;
		this.leftBallSpeed.x -= this.posDiff.x * 0.05;
		this.leftBallSpeed.y -= this.posDiff.y * 0.05;
		this.rightBallSpeed.x += this.posDiff.x * 0.05;
		this.rightBallSpeed.y += this.posDiff.y * 0.05;
	}

	public function updateBall(param1:Point, param2:Point, param3:Sprite, param4:Sprite, param5:Sprite) {
		param2.x -= param1.x * 0.2;
		param2.y += Balls.GRAVITY - param1.y * 0.2;
		param2.x *= Balls.FRICTION;
		param2.y *= Balls.FRICTION;
		param1.x += param2.x;
		param1.y += param2.y;
		param3.scaleY = 1 + param1.y * 0.012;
		param3.y = param1.y * 0.2;
		param4.scaleY = 1 + param1.y * 0.012;
		param5.scaleY = 1 + param1.y * 0.012;
		param3.rotation = -param1.x * 20;
		param4.rotation = -param1.x * 20;
		param5.rotation = -param1.x * 20;
	}

	public function setSkin(param1:String) {
		this.leftFill.gotoAndStop(param1);
		this.leftHighlight.gotoAndStop(param1);
		this.rightFill.gotoAndStop(param1);
		this.rightHighlight.gotoAndStop(param1);
	}
}
