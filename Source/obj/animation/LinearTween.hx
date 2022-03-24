package obj.animation;

import openfl.display.DisplayObject;
import openfl.geom.Matrix;
import openfl.geom.Point;
import obj.Maths;
import openfl.Vector;

class LinearTween {
	public var _targets:Vector<DisplayObject>;
	public var _inverseRatio:Float = Math.NaN;
	public var _startMatrix:Matrix;
	public var _endMatrix:Matrix;
	public var _tweenMatrix:Matrix;
	public var _startAng:Float = 0;
	public var _endAng:Float = 0;
	public var _startSkew:Point;
	public var _endSkew:Point;
	public var _baseObject:DisplayObject;
	public var _offsetMatrices:ASDictionary<DisplayObject, Matrix>;
	public var _skewed:Bool = false;

	public function new(rest:Array<DisplayObject> = null) {
		if (rest == null)
			rest = [];
		tween = tween_l;
		offsetStart = offsetStart_l;
		offsetEnd = offsetEnd_l;
		skewStart = skewStart_l;
		skewEnd = skewEnd_l;
		rotateStart = rotateStart_l;
		rotateEnd = rotateEnd_l;
		var _loc2_:ASAny = /*undefined*/ null;
		var _loc3_:Matrix = null;
		var _loc4_:Matrix = null;
		this._startSkew = new Point();
		this._endSkew = new Point();
		// super();
		this._targets = new Vector<DisplayObject>();
		this._offsetMatrices = new ASDictionary<DisplayObject, Matrix>();
		for (_tmp_ in rest) {
			_loc2_ = _tmp_;
			if (Std.is(_loc2_, DisplayObject)) {
				this._targets.push(_loc2_);
				if (this._baseObject == null) {
					this._baseObject = _loc2_;
				} else if (_loc2_.parent != this._baseObject.parent) {
					_loc3_ = this._baseObject.parent.transform.matrix;
					(_loc4_ = _loc2_.parent.transform.matrix).invert();
					_loc3_.concat(_loc4_);
					this._offsetMatrices[_loc2_] = _loc3_;
				}
			}
		}
		this._startMatrix = new Matrix();
		this._endMatrix = new Matrix();
		this._tweenMatrix = new Matrix();
		if (this._targets.length > 0) {
			this._startMatrix = this._targets[0].transform.matrix.clone();
			this._endMatrix = this._targets[0].transform.matrix.clone();
		}
	}

	public function tween(param1:Float):Matrix {
		var _loc2_:DisplayObject = null;
		var _loc3_ = Math.NaN;
		var _loc4_ = Math.NaN;
		var _loc5_ = Math.NaN;
		var _loc6_:Matrix = null;
		if (this._skewed) {
			this._tweenMatrix.a = this._startMatrix.a + param1 * (this._endMatrix.a - this._startMatrix.a);
			this._tweenMatrix.d = this._startMatrix.d + param1 * (this._endMatrix.d - this._startMatrix.d);
			this._tweenMatrix.c = Math.tan(this._startSkew.x + param1 * (this._endSkew.x - this._startSkew.x));
			this._tweenMatrix.b = Math.tan(this._startSkew.y + param1 * (this._endSkew.y - this._startSkew.y));
		} else {
			_loc3_ = this._startAng + param1 * (this._endAng - this._startAng);
			_loc4_ = Math.cos(_loc3_);
			_loc5_ = Math.sin(_loc3_);
			this._tweenMatrix.a = _loc4_;
			this._tweenMatrix.b = _loc5_;
			this._tweenMatrix.c = -_loc5_;
			this._tweenMatrix.d = _loc4_;
		}
		this._tweenMatrix.tx = this._startMatrix.tx + param1 * (this._endMatrix.tx - this._startMatrix.tx);
		this._tweenMatrix.ty = this._startMatrix.ty + param1 * (this._endMatrix.ty - this._startMatrix.ty);
		for (_tmp_ in this._targets) {
			_loc2_ = _tmp_;
			if (this._offsetMatrices[_loc2_]) {
				(_loc6_ = this._tweenMatrix.clone()).concat(this._offsetMatrices[_loc2_]);
				_loc2_.transform.matrix = _loc6_;
			} else {
				_loc2_.transform.matrix = this._tweenMatrix;
			}
		}
		return this._tweenMatrix;
	}

	public function offsetStart(param1:Float = 0, param2:Float = 0, param3:Float = 0) {
		this._startMatrix.translate(param1, param2);
		if (param3 != 0) {
			this._startAng = param3 / 180 * Math.PI;
			this._skewed = false;
		}
	}

	public function offsetEnd(param1:Float = 0, param2:Float = 0, param3:Float = 0) {
		this._endMatrix.translate(param1, param2);
		if (param3 != 0) {
			this._endAng = param3 / 180 * Math.PI;
			this._skewed = false;
		}
	}

	public function skewStart(param1:Float, param2:Float, param3:Float = 0, param4:Float = 0) {
		this._startSkew = new Point(param1 / 180 * Math.PI, param2 / 180 * Math.PI);
		if (ASCompat.floatAsBool(param3)) {
			this._startMatrix.a = param3;
		}
		if (ASCompat.floatAsBool(param4)) {
			this._startMatrix.d = param4;
		}
		this._skewed = true;
	}

	public function skewEnd(param1:Float, param2:Float, param3:Float = 0, param4:Float = 0) {
		this._endSkew = new Point(param1 / 180 * Math.PI, param2 / 180 * Math.PI);
		if (ASCompat.floatAsBool(param3)) {
			this._endMatrix.a = param3;
		}
		if (ASCompat.floatAsBool(param4)) {
			this._endMatrix.d = param4;
		}
		this._skewed = true;
	}

	public function rotateStart(param1:Float) {
		this._startAng = param1;
		this._skewed = false;
	}

	public function rotateEnd(param1:Float) {
		this._endAng = param1;
		this._skewed = false;
	}

	@:flash.property public var start(get, never):Matrix;

	function get_start():Matrix {
		return this._startMatrix;
	}

	@:flash.property public var end(get, never):Matrix;

	function get_end():Matrix {
		return this._endMatrix;
	}

	@:flash.property public var translationLength(get, never):Float;

	function get_translationLength():Float {
		var _loc1_ = new Point(this._endMatrix.tx - this._startMatrix.tx, this._endMatrix.ty - this._startMatrix.ty);
		return Maths.vectorLength(_loc1_);
	}
}
