package obj.animation;

import openfl.display.DisplayObject;
import openfl.geom.Matrix;
import openfl.geom.Point;

class BreastController {
	public var _breast:DisplayObject;
	public var _costumeLayers:Array<DisplayObject>;
	public var _breastOrigin:Point;
	public var _originalRotation:Float = Math.NaN;
	public var _breastFirmness:Float = 0.2;
	public var _breastMatrix:Matrix = new Matrix();
	public var _costumeOn:Bool = false;
	public var _flip:Int = 1;
	public var _skew:Float = 0;
	public var _speed:Float = 0;

	public function new(param1:DisplayObject, rest:Null<Array<DisplayObject>> = null) {
		if (rest == null)
			rest = [];
		var _loc3_:UInt = 0;
		var _loc4_:UInt = 0;
		// super();
		this._breast = param1;
		this._breastOrigin = new Point(this._breast.x, this._breast.y);
		this._originalRotation = this._breast.rotation;
		this._flip = Math.round(this._breast.transform.matrix.a / this._breast.scaleX);
		this._costumeLayers = new Array<DisplayObject>();
		if (rest != null) {
			_loc3_ = rest.length;
			_loc4_ = 0;
			while (_loc4_ < _loc3_) {
                this._costumeLayers.push(rest[_loc4_]);
                _loc4_++;
            }
		}
	}

	public function accelerate(param1:Float) {
		this._speed += param1;
	}

	public function update(param1:Float = 0, param2:Float = 0, param3:Float = 0, param4:Float = 0) {
		// var _loc5_:DisplayObject = null;
		// this._speed += -this._skew * this._breastFirmness + param1;
		// this._speed *= 0.7 + Math.random() * 0.1;
		// this._skew += this._speed;
		// this._breastMatrix.identity();
		// this._breastMatrix.rotate(param2 / 180 * Math.PI);
		// this._breastMatrix.translate(this._breastOrigin.x + param3, this._breastOrigin.y + param4);
		// this._breastMatrix.scale(0.95 + Math.cos(this._skew * 5) * 0.1, 1);
		// this._breastMatrix.b = this._skew;
		// this._breast.transform.matrix = this._breastMatrix;
		// for (_tmp_ in this._costumeLayers) {
		// 	_loc5_ = _tmp_;
		// 	_loc5_.transform.matrix = this._breastMatrix;
		// }
	}

	public function updateFirmness(param1:UInt, param2:Bool = false) {
		this._breastFirmness = Math.max(0.2, 0.2 + (60 - param1) * 0.01);
		this._costumeOn = param2;
		if (this._costumeOn) {
			this._breastFirmness = Math.max(0.2, this._breastFirmness + 0.1);
		}
	}
}
