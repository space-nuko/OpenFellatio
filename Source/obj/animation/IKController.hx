package obj.animation;

import openfl.display.DisplayObject;
import openfl.geom.Matrix;
import openfl.geom.Point;
import obj.Maths;

class IKController {
	public var dropping:Bool = false;
	public var reversed:Int = 0;
	public var coordinateSpace:DisplayObject;
	public var s1:DisplayObject;
	public var s2:DisplayObject;
	public var s3:DisplayObject;
	public var s1L:Float = Math.NaN;
	public var s1LSq:Float = Math.NaN;
	public var s1OffsetAng:Float = Math.NaN;
	public var s1StartPoint:Point;
	public var s2L:Float = Math.NaN;
	public var s2LSq:Float = Math.NaN;
	public var s2OffsetAng:Float = Math.NaN;
	public var s2StartPoint:Point;
	public var s3StartPoint:Point;
	public var lastS1Ang:Float = Math.NaN;
	public var lastS2Ang:Float = Math.NaN;
	public var s1AS:Float = 0;
	public var s2AS:Float = 0;
	public var maxL:Float = Math.NaN;
	public var scaling:Float = 1;
	public var endRotationTargets:Array<DisplayObject>;
	public var endRotationAngle:Float = 0;
	public var v:Point;
	public var offsetAng:Float = Math.NaN;
	public var totalL:Float = Math.NaN;
	public var totalLSq:Float = Math.NaN;
	public var minTotalLSq:Float = Math.NaN;
	public var s1Ang:Float = 0;
	public var s2Ang:Float = 0;
	public var s3Ang:Float = 0;
	public var m1Ang:Float = 0;
	public var m2Ang:Float = 0;
	public var m1:Matrix;
	public var m2:Matrix;
	public var m3:Matrix;
	public var springV:Point;
	public var s3Mass:Float = 6;
	public var reversedEnd:Bool = false;
	public var maxSlipDist:Float = 65;
	public var slipping:Bool = false;
	public var slipTimer:UInt = 0;
	public var slipTime:UInt = 15;
	public var gravity:Float = 15;
	public var speed:Point;
	public var friction:Float = 0.6;
	public var mass:Float = 10;
	public var currentPoint:Point;
	public var localTargetPoint:Point;
	public var originalTarget:Point;
	public var targetPoint:Point;
	public var targetPointCoordinateSpace:DisplayObject;
	public var tapping:Bool = false;
	public var tapVector:Point;
	public var tapDist:Float = 0;
	public var tapSpeed:Float = 0;
	public var tapMultiplier:Float = 1;
	public var tapPower:Float = 0;
	public var maxTapPower:Float = 4;

	public function new(param1:DisplayObject, param2:DisplayObject, param3:DisplayObject, param4:DisplayObject, param5:Bool = false) {
		this.endRotationTargets = new Array<DisplayObject>();
		this.m1 = new Matrix();
		this.m2 = new Matrix();
		this.m3 = new Matrix();
		this.springV = new Point();
		this.tapVector = new Point();
		// super();
		this.coordinateSpace = param1;
		this.s1 = param2;
		this.s2 = param3;
		this.s3 = param4;
		this.calculateLengths();
		this.s1OffsetAng = Maths.getRadAngle(this.s2.x, this.s2.y);
		this.s2OffsetAng = Maths.getRadAngle(this.s3.x, this.s3.y);
		this.s1StartPoint = new Point(this.s1.x, this.s1.y);
		this.s2StartPoint = new Point(this.s2.x, this.s2.y);
		this.s3StartPoint = new Point(this.s3.x, this.s3.y);
		this.currentPoint = new Point(0, 0);
		this.targetPoint = new Point(this.currentPoint.x, this.currentPoint.y);
		this.speed = new Point();
		this.targetPointCoordinateSpace = G.sceneLayer;
		this.reversed = !!param5 ? -1 : 1;
	}

	public function newSegments(param1:DisplayObject, param2:DisplayObject, param3:DisplayObject, param4:Bool = true) {
		this.s1 = param1;
		this.s2 = param2;
		this.s3 = param3;
		if (param4) {
			this.calculateLengths();
			this.s1OffsetAng = Maths.getRadAngle(this.s2.x, this.s2.y);
			this.s2OffsetAng = Maths.getRadAngle(this.s3.x, this.s3.y);
			this.s1StartPoint = new Point(this.s1.x, this.s1.y);
			this.s2StartPoint = new Point(this.s2.x, this.s2.y);
			this.s3StartPoint = new Point(this.s3.x, this.s3.y);
		}
	}

	public function newTarget(param1:Point, param2:DisplayObject, param3:Bool = false) {
		var _loc4_:Point = null;
		this.originalTarget = param1.clone();
		this.targetPoint = param1.clone();
		if (param2 != null) {
			this.targetPointCoordinateSpace = param2;
		}
		if (param3) {
			this.mass = 1;
			this.currentPoint.x = this.targetPoint.x;
			this.currentPoint.y = this.targetPoint.y;
		} else if (this.targetPointCoordinateSpace != null) {
			_loc4_ = this.targetPointCoordinateSpace.localToGlobal(this.currentPoint);
			this.jumpTo(_loc4_);
		}
	}

	public function calculateLengths() {
		this.s1LSq = (this.s2.x * this.s2.x + this.s2.y * this.s2.y) * this.scaling * this.scaling;
		this.s1L = Math.sqrt(this.s1LSq);
		this.s2LSq = (this.s3.x * this.s3.x + this.s3.y * this.s3.y) * this.scaling * this.scaling;
		this.s2L = Math.sqrt(this.s2LSq);
		this.maxL = this.s1L + this.s2L - 5;
		this.minTotalLSq = (this.s1L - this.s2L) * (this.s1L - this.s2L) + 10;
	}

	public function getMaxLength():Float {
		return this.s1L + this.s2L;
	}

	public function rescale(param1:Float) {
		this.scaling = param1;
		this.calculateLengths();
	}

	public function setEndRotationTarget(param1:Float = 0, param2:Array<DisplayObject> = null) {
		this.endRotationTargets = param2;
		this.endRotationAngle = param1;
	}

	public function startDropping(param1:Float = 15) {
		if (!this.dropping) {
			this.slipping = true;
		}
		this.dropping = true;
		this.slipTime = Std.int(param1);
		this.slipTimer = 0;
	}

	public function stopDropping() {
		this.dropping = false;
		this.slipping = false;
	}

	public function startTrackingTarget(param1:Bool = false) {
		this.dropping = false;
		this.slipping = false;
		this.tapping = false;
		this.s3Mass = 10;
		if (param1) {
			this.mass = 6;
		}
	}

	public function drop() {
		var _loc1_ = Math.NaN;
		var _loc2_ = Math.NaN;
		if (this.slipping) {
			++this.slipTimer;
			this.slip(this.slipTimer / this.slipTime * this.slipTimer / this.slipTime * 40, false);
			if (this.slipTimer >= this.slipTime) {
				this.slipping = false;
			}
			this.updateTarget();
			this.localTargetPoint = this.coordinateSpace.globalToLocal(this.globalPoint);
			this.trackTarget();
		} else {
			_loc1_ = this.getDown();
			this.s1AS += Math.asin(Math.sin(this.m1Ang - _loc1_)) * 0.05;
			this.s2AS += Math.asin(Math.sin(this.m2Ang + Math.PI)) * 0.05;
			this.s1AS *= 0.8;
			this.s2AS *= 0.8;
			_loc2_ = Math.max(0, 0.1 + this.m2Ang * 0.5);
			this.s1AS -= _loc2_ * 0.5;
			this.s2AS -= _loc2_;
			this.s1Ang += this.s1AS;
			this.s2Ang += this.s2AS;
			this.m1Ang = this.offsetAng - this.s1Ang - this.s1OffsetAng;
			this.m2Ang = this.s2Ang + this.s1Ang + this.s1OffsetAng - this.s2OffsetAng;
			this.m2Ang = Math.max(-Math.PI * 0.7, Math.min(0, this.m2Ang));
			this.m1.identity();
			this.m1.scale(this.scaling, this.scaling);
			this.m1.rotate(this.m1Ang);
			this.m1.translate(this.s1StartPoint.x, this.s1StartPoint.y);
			this.m2.identity();
			this.m2.rotate(this.m2Ang);
			this.m2.translate(this.s2StartPoint.x, this.s2StartPoint.y);
			this.s3Ang *= 0.8;
			this.m3.identity();
			if (this.reversedEnd) {
				this.m3.scale(-1, 1);
			}
			this.m3.rotate(this.s3Ang);
			this.m3.translate(this.s3StartPoint.x, this.s3StartPoint.y);
		}
	}

	public function update(target:Point = null, param2:Bool = false) {
		this.updateTarget();
		this.localTargetPoint = this.coordinateSpace.globalToLocal(this.globalPoint);
		if (this.dropping) {
			this.drop();
		} else {
			this.trackTarget(target);
		}
		if (param2) {
			this.s1.transform.matrix = this.section1Matrix;
			this.s2.transform.matrix = this.section2Matrix;
			this.s3.transform.matrix = this.section3Matrix;
		}
	}

	public function trackTarget(target:Point = null) {
		if (target != null) {
			this.s1.x = target.x;
			this.s1.y = target.y;
			this.s1StartPoint = target;
		}
		this.v = new Point(this.localTargetPoint.x - this.s1StartPoint.x, this.localTargetPoint.y - this.s1StartPoint.y);
		this.offsetAng = Maths.getRadAngle(this.v.x, this.v.y);
		this.totalLSq = Math.max(this.minTotalLSq, this.v.x * this.v.x + this.v.y * this.v.y);
		this.totalL = Math.max(1, Math.sqrt(this.totalLSq));
		if (this.totalL > this.maxL) {
			this.totalL = this.maxL;
			this.totalLSq = this.totalL * this.totalL;
		}
		this.springV.x = -this.v.x / this.maxL;
		this.springV.y = -this.v.y / this.maxL;
		this.lastS1Ang = this.s1Ang;
		this.lastS2Ang = this.s2Ang;
		this.s1Ang = -Math.acos((this.totalLSq + this.s1LSq - this.s2LSq) / (2 * this.totalL * this.s1L)) * this.reversed;
		this.m1Ang = this.offsetAng - this.s1Ang - this.s1OffsetAng;
		this.s2Ang = -Math.acos((this.totalLSq + this.s2LSq - this.s1LSq) / (2 * this.totalL * this.s2L)) * this.reversed;
		this.m2Ang = this.s2Ang + this.s1Ang + this.s1OffsetAng - this.s2OffsetAng;
		this.m1.identity();
		this.m1.scale(this.scaling, this.scaling);
		this.m1.rotate(this.m1Ang);
		this.m1.translate(this.s1StartPoint.x, this.s1StartPoint.y);
		this.m2.identity();
		this.m2.rotate(this.m2Ang);
		this.m2.translate(this.s2StartPoint.x, this.s2StartPoint.y);
		if (!this.tapping) {
			this.s3Ang = -(this.s1.parent.rotation / 180 * Math.PI) - this.offsetAng - this.s2Ang + this.s2OffsetAng;
			this.s3Ang += this.getEndRotation();
			this.s3Ang = this.s3.rotation / 180 * Math.PI + (this.s3Ang - this.s3.rotation / 180 * Math.PI) / this.s3Mass;
			this.s3Ang = Math.max(-1.22, Math.min(1.22, this.s3Ang));
			this.s3Ang = !!ASCompat.floatAsBool(this.s3Ang) ? this.s3Ang : 0;
		}
		if (this.s3Mass > 1) {
			this.s3Mass = Math.max(1, this.s3Mass - 1);
		}
		this.m3.identity();
		if (this.reversedEnd) {
			this.m3.scale(-1, 1);
		}
		if (this.tapping) {
			this.m3.rotate(this.s3Ang + this.tapDist * 0.005);
		} else {
			this.m3.rotate(this.s3Ang);
		}
		this.m3.translate(this.s3StartPoint.x, this.s3StartPoint.y);
		this.s1AS = this.s1Ang - this.lastS1Ang;
		this.s2AS = this.s2Ang - this.lastS2Ang;
	}

	public function jumpTo(param1:Point) {
		param1 = this.targetPointCoordinateSpace.globalToLocal(param1);
		this.currentPoint.x = param1.x;
		this.currentPoint.y = param1.y;
	}

	public function tap(param1:Float = 1, param2:Float = 0) {
		if (!this.tapping && !this.dropping) {
			this.tapVector = new Point(Math.cos(this.getEndRotation() + param2), Math.sin(this.getEndRotation() + param2));
			this.tapMultiplier = param1;
			this.tapPower = this.tapMultiplier * this.maxTapPower;
			this.tapDist = 0;
			this.tapSpeed = -this.tapPower * 6;
			this.tapping = true;
		}
	}

	public function dropTarget(param1:Point) {
		this.speed.x += param1.x;
		this.speed.y += param1.y + this.gravity;
		this.currentPoint.x += this.speed.x;
		this.currentPoint.y += this.speed.y;
		this.speed.x *= 0.9;
		this.speed.y *= 0.9;
	}

	public function slip(param1:Float, param2:Bool = true) {
		var _loc5_ = Math.NaN;
		var _loc6_ = Math.NaN;
		var _loc3_ = this.s3Ang;
		var _loc4_:Point;
		if ((_loc4_ = new Point(Math.sin(_loc3_), -Math.cos(_loc3_))).y < 0) {
			_loc4_.x = -_loc4_.x;
			_loc4_.y = -_loc4_.y;
		}
		this.targetPoint.x += _loc4_.x * param1;
		this.targetPoint.y += _loc4_.y * param1;
		if (param2) {
			if ((_loc5_ = this.targetPoint.x - this.originalTarget.x) > this.maxSlipDist) {
				this.targetPoint.x = this.originalTarget.x + this.maxSlipDist;
			} else if (_loc5_ < -this.maxSlipDist) {
				this.targetPoint.x = this.originalTarget.x - this.maxSlipDist;
			}
			if ((_loc6_ = this.targetPoint.y - this.originalTarget.y) > this.maxSlipDist) {
				this.targetPoint.y = this.originalTarget.y + this.maxSlipDist;
			} else if (_loc6_ < -this.maxSlipDist) {
				this.targetPoint.y = this.originalTarget.y - this.maxSlipDist;
			}
		}
	}

	public function resetTarget(param1:Float) {
		this.targetPoint.x += (this.originalTarget.x - this.targetPoint.x) * param1;
		this.targetPoint.y += (this.originalTarget.y - this.targetPoint.y) * param1;
	}

	public function updateTarget() {
		this.speed.x = (this.targetPoint.x - this.currentPoint.x) / this.mass;
		this.speed.y = (this.targetPoint.y - this.currentPoint.y) / this.mass;
		this.currentPoint.x += this.speed.x;
		this.currentPoint.y += this.speed.y;
		this.mass = Math.max(1, this.mass - 1);
		if (this.tapping) {
			this.tapDist += this.tapSpeed;
			this.tapSpeed += this.tapPower;
			this.tapPower *= 2;
			if (this.tapDist > 0) {
				this.tapDist = 8;
				G.soundControl.playGrab(1, this.tapMultiplier);
				this.tapping = false;
			}
		} else if (this.tapDist > 0) {
			this.tapDist = Math.max(0, this.tapDist - 4);
		}
		this.currentPoint.x -= this.tapVector.x * this.tapDist;
		this.currentPoint.y -= this.tapVector.y * this.tapDist;
	}

	@:flash.property public var globalPoint(get, never):Point;

	function get_globalPoint():Point {
		if (this.targetPointCoordinateSpace != null) {
			return this.targetPointCoordinateSpace.localToGlobal(this.currentPoint);
		}
		return new Point();
	}

	public function getDown():Float {
		var _loc1_:Float = 0;
		var _loc2_:DisplayObject = this.s1.parent;
		var _loc3_:UInt = 0;
		while (_loc2_ != this.s1.stage && _loc2_ != null && _loc3_ < 5) {
			_loc1_ -= _loc2_.rotation / 180 * Math.PI;
			_loc3_++;
			_loc2_ = _loc2_.parent;
		}
		return _loc1_;
	}

	public function trigBound(param1:Float):Float {
		return param1 > 1 ? param1 % 1 - 1 : (param1 < -1 ? param1 % 1 + 1 : param1);
	}

	public function getEndRotation():Float {
		var target:DisplayObject = null;
		var _loc1_:Float = 0;
		for (target in this.endRotationTargets) {
			_loc1_ += target.rotation / 180 * Math.PI;
		}
		return _loc1_ + this.endRotationAngle / 180 * Math.PI;
	}

	@:flash.property public var section1Matrix(get, never):Matrix;

	function get_section1Matrix():Matrix {
		return this.m1;
	}

	@:flash.property public var section2Matrix(get, never):Matrix;

	function get_section2Matrix():Matrix {
		return this.m2;
	}

	@:flash.property public var section3Matrix(get, never):Matrix;

	function get_section3Matrix():Matrix {
		return this.m3;
	}

	@:flash.property public var section1Angle(get, never):Float;

	function get_section1Angle():Float {
		return this.offsetAng - this.s1Ang - this.s1OffsetAng;
	}

	@:flash.property public var section2Angle(get, never):Float;

	function get_section2Angle():Float {
		return this.s2Ang + this.s1Ang + this.s1OffsetAng - this.s2OffsetAng;
	}

	@:flash.property public var section3Angle(get, never):Float;

	function get_section3Angle():Float {
		return this.s3Ang;
	}

	@:flash.property public var springVector(get, never):Point;

	function get_springVector():Point {
		return this.springV;
	}
}
