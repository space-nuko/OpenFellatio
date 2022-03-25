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
	public var _startSkew:Point = new Point();
	public var _endSkew:Point = new Point();
	public var _baseObject:DisplayObject;
	public var _offsetMatrices:ASDictionary<DisplayObject, Matrix>;
	public var _skewed:Bool = false;

	public function new(rest:Array<DisplayObject> = null) {
		if (rest == null)
			rest = [];
		this._targets = new Vector<DisplayObject>();
		this._offsetMatrices = new ASDictionary<DisplayObject, Matrix>();
		for (displayObj in rest) {
			this._targets.push(displayObj);
			if (this._baseObject == null) {
				this._baseObject = displayObj;
			} else if (displayObj.parent != this._baseObject.parent) {
				var offsetMatrix = this._baseObject.parent.transform.matrix;
				var parentMatrix = displayObj.parent.transform.matrix;
                parentMatrix.invert();
                offsetMatrix.concat(parentMatrix);
				this._offsetMatrices[displayObj] = offsetMatrix;
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

	public function tween(t:Float):Matrix {
		if (this._skewed) {
			this._tweenMatrix.a = this._startMatrix.a + t * (this._endMatrix.a - this._startMatrix.a);
			this._tweenMatrix.d = this._startMatrix.d + t * (this._endMatrix.d - this._startMatrix.d);
			this._tweenMatrix.c = Math.tan(this._startSkew.x + t * (this._endSkew.x - this._startSkew.x));
			this._tweenMatrix.b = Math.tan(this._startSkew.y + t * (this._endSkew.y - this._startSkew.y));
		} else {
			var i = this._startAng + t * (this._endAng - this._startAng);
			var j = Math.cos(i);
			var k = Math.sin(i);
			this._tweenMatrix.a = j;
			this._tweenMatrix.b = k;
			this._tweenMatrix.c = -k;
			this._tweenMatrix.d = j;
		}
		this._tweenMatrix.tx = this._startMatrix.tx + t * (this._endMatrix.tx - this._startMatrix.tx);
		this._tweenMatrix.ty = this._startMatrix.ty + t * (this._endMatrix.ty - this._startMatrix.ty);
		for (displayObj in this._targets) {
			if (this._offsetMatrices[displayObj] != null) {
                var tweenMatrix = this._tweenMatrix.clone();
				tweenMatrix.concat(this._offsetMatrices[displayObj]);
				displayObj.transform.matrix = tweenMatrix;
			} else {
				displayObj.transform.matrix = this._tweenMatrix;
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
