package obj;

import openfl.display.DisplayObject;
import openfl.display.MovieClip;
import openfl.events.Event;
import openfl.geom.Point;
import G;

@:rtti
class RigidBody extends MovieClip {
	public var rgbFill:MovieClip;

	public var movement:Point;

	public var lastMovement:Point;

	public var acceleration:Point;

	public var lastPos:Point;

	public var pos:Point;

	public var angSpeed:Float = 0;

	public var hanging:Bool = true;

	public var lengthMultiplier:Float;

	public var lastFrameLabel:String = "";

	public var clockwiseLimit:Float;

	public var haveClockwiseLimit:Bool = false;

	public var antiClockwiseLimit:Float;

	public var haveAntiClockwiseLimit:Bool = false;

	public function new() {
		this.movement = new Point();
		this.lastMovement = new Point();
		this.acceleration = new Point();
		super();
		addEventListener(Event.ENTER_FRAME, this.tick);
		addEventListener(Event.ADDED, this.childAdded);
		this.frameChanged();
		try {
			this.lastPos = parent.localToGlobal(new Point(this.x, this.y));
		} catch (e) {}
	}

	public function childAdded(param1:Event) {
		if (param1.target != this) {
			this.frameChanged();
		}
	}

	public function setLimit(param1:Float, param2:Bool = true) {
		if (param2) {
			this.clockwiseLimit = param1;
			this.haveClockwiseLimit = true;
		} else {
			this.antiClockwiseLimit = param1;
			this.haveAntiClockwiseLimit = true;
		}
	}

	public function frameChanged() {
		this.lastFrameLabel = currentLabel;
		this.lengthMultiplier = Math.max(0.2, height * 0.002);
		if (height < 20) {
			rotation = 0;
			this.hanging = false;
		} else {
			this.hanging = true;
		}
	}

	public function tick(param1:Event) {
		var _loc2_:Float = Math.NaN;
		var _loc3_:DisplayObject = null;
		var _loc4_:Point = null;
		var _loc5_:Float = Math.NaN;
		var _loc6_:Point = null;
		var _loc7_:Float = Math.NaN;
		if (currentLabel != this.lastFrameLabel) {
			this.lastFrameLabel = currentLabel;
			this.frameChanged();
		}
		this.pos = parent.localToGlobal(new Point(this.x, this.y));
		if (this.hanging) {
			_loc2_ = 180;
			_loc3_ = parent;
			while (_loc3_ != null && _loc3_ != G.sceneLayer) {
				_loc2_ -= _loc3_.rotation;
				_loc3_ = _loc3_.parent;
			}
			_loc2_ = _loc2_ * Math.PI / 180;
			_loc4_ = new Point(Math.sin(_loc2_), -Math.cos(_loc2_));
			this.movement.x = this.pos.x - this.lastPos.x;
			this.movement.y = this.pos.y - this.lastPos.y;
			this.acceleration.x = this.movement.x - this.lastMovement.x - _loc4_.x * 40;
			this.acceleration.y = this.movement.y - this.lastMovement.y - _loc4_.y * 40;
			this.lastMovement = this.movement.clone();
			_loc5_ = rotation * Math.PI / 180 + Math.PI * 0.5;
			_loc7_ = (_loc6_ = new Point(Math.sin(_loc5_), -Math.cos(_loc5_))).x * this.acceleration.x + _loc6_.y * this.acceleration.y;
			this.angSpeed += _loc7_ * this.lengthMultiplier * (0.9 + Math.random() * 0.2);
			this.angSpeed *= 0.9;
			rotation += this.angSpeed;
			if (this.haveAntiClockwiseLimit && this.angSpeed < 0 && rotation < this.antiClockwiseLimit) {
				this.angSpeed *= -0.7;
			}
			if (this.haveClockwiseLimit && this.angSpeed > 0 && rotation > this.clockwiseLimit) {
				this.angSpeed *= -0.7;
			}
		}
		this.lastPos = this.pos.clone();
	}
}
