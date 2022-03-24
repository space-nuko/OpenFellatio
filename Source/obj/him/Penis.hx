package obj.him;

import openfl.display.DisplayObject;
import openfl.display.MovieClip;
import openfl.display.Sprite;
import openfl.geom.Point;
import obj.Maths;
import openfl.Vector;

class SimplePenisWidth
{
    public var width: Float;
    public var startY: Float;

    public function new(_width:Float, _startY:Float) {
        width = _width;
        startY = _startY;
    }
}

class PenisWidth {
	public var width:Float;
	public var startY:Float;
	public var topOffset:Float;
	public var bottomOffset:Float;
	public var pos:Float;
	public var angOffset:Float;

    public function new(_width:Float, _startY:Float, _topOffset:Float, _bottomOffset:Float, _pos:Float, _angOffset:Float) {
        width = _width;
        startY = _startY;
        topOffset = _topOffset;
        bottomOffset = _bottomOffset;
        pos = _pos;
        angOffset = _angOffset;
    }
}

class LipstickElements {
	@:keep public var lipstickContainer(default, null):MovieClip;
	@:keep public var lipstickMask(default, null):MovieClip;
}

class Penis extends MovieClip {
    public var _sourceGraphic:DisplayObject;
	public var _tip:Point;
	public var _length:Float = Math.NaN;
	public var _fullLength:Float = Math.NaN;
	public var _widths:Vector<WidthDefinition>;
	public var _baseWidth:Float = 0;
	public var _basePos:Float = -ASCompat.MAX_FLOAT;
	public var debug:Sprite;

	@:keep public var lipstickElements: LipstickElements;
	@:keep public var wetMask(default, null):MovieClip;
	@:keep public var wet(default, null):MovieClip;

	public function new(param1:DisplayObject, param2:Point) {
        super();
		this._sourceGraphic = param1;
		this._tip = param2;
		this._length = Maths.vectorLength(this._tip);
		this._fullLength = this._length;
		this._widths = new Vector<WidthDefinition>();
	}

	public function getGlobalTip(param1:Float = 0, param2:Float = 0):Point {
		var localTip = new Point(this._tip.x + param1, this._tip.y + param2);
		return this._sourceGraphic.localToGlobal(localTip);
	}

	@:flash.property public var length(get, never):Float;

	function get_length():Float {
		return this._length;
	}

	@:flash.property public var fullLength(get, never):Float;

	function get_fullLength():Float {
		return this._fullLength;
	}

	@:flash.property public var baseWidth(get, never):Float;

	function get_baseWidth():Float {
		return this._baseWidth;
	}

	public function defineWidth(param1:Float, param2:Float, param3:Float) {
		this._widths.push(new WidthDefinition(param1, param2, param3));
		if (param1 > this._basePos) {
			this._baseWidth = param3;
			this._basePos = param1;
		}
		this._fullLength = Math.max(this._fullLength, this._basePos - param1);
	}

	public function getPosOnPenis(param1:Point):Float {
		var _loc2_ = this._sourceGraphic.globalToLocal(param1);
		return Math.max(0, Math.min(1, (this._fullLength + _loc2_.x) / this._fullLength));
	}

	public function getSimplePenisWidth(param1:Point):ASObject {
		var _loc4_:WidthDefinition = null;
		var _loc5_:WidthDefinition = null;
		var _loc6_:WidthDefinition = null;
		var width = Math.NaN;
		var startY = Math.NaN;
		var _loc9_ = Math.NaN;
		var _loc10_ = Math.NaN;
		var _loc2_ = this._sourceGraphic.globalToLocal(param1);
		var _loc3_ = _loc2_.x;
		for (_tmp_ in this._widths) {
			_loc6_ = _tmp_;
			if (_loc6_.lengthPos < _loc3_) {
				if (_loc4_ == null || _loc4_.lengthPos < _loc6_.lengthPos) {
					_loc4_ = _loc6_;
				}
			} else if (_loc5_ == null || _loc5_.lengthPos > _loc6_.lengthPos) {
				_loc5_ = _loc6_;
			}
		}
		if (_loc4_ != null && _loc5_ != null) {
			_loc9_ = _loc5_.lengthPos - _loc4_.lengthPos;
			_loc10_ = (_loc3_ - _loc4_.lengthPos) / _loc9_;
			width = _loc4_.positionWidth + _loc10_ * (_loc5_.positionWidth - _loc4_.positionWidth);
			startY = _loc4_.startY + _loc10_ * (_loc5_.startY - _loc4_.startY);
		} else if (_loc4_ != null) {
			width = _loc4_.positionWidth;
			startY = _loc4_.startY;
		} else if (_loc5_ != null) {
			width = _loc5_.positionWidth;
			startY = _loc5_.startY;
		} else {
			width = 0;
			startY = 0;
		}

		return new SimplePenisWidth(width, startY);
	}

	public function getPenisWidth(param1:Point, param2:Point):PenisWidth {
		var _loc6_:WidthDefinition = null;
		var _loc7_:WidthDefinition = null;
		var _loc8_:WidthDefinition = null;
		var width = Math.NaN;
		var startY = Math.NaN;
		var _loc14_ = Math.NaN;
		var _loc15_ = Math.NaN;
		var _loc3_ = this._sourceGraphic.globalToLocal(param1);
		var _loc4_ = this._sourceGraphic.globalToLocal(param2);
		var pos = _loc3_.x;
		for (_tmp_ in this._widths) {
			_loc8_ = _tmp_;
			if (_loc8_.lengthPos < pos) {
				if (_loc6_ == null || _loc6_.lengthPos < _loc8_.lengthPos) {
					_loc6_ = _loc8_;
				}
			} else if (_loc7_ == null || _loc7_.lengthPos > _loc8_.lengthPos) {
				_loc7_ = _loc8_;
			}
		}
		if (_loc6_ != null && _loc7_ != null) {
			_loc14_ = _loc7_.lengthPos - _loc6_.lengthPos;
			_loc15_ = (pos - _loc6_.lengthPos) / _loc14_;
			width = _loc6_.positionWidth + _loc15_ * (_loc7_.positionWidth - _loc6_.positionWidth);
			startY = _loc6_.startY + _loc15_ * (_loc7_.startY - _loc6_.startY);
		} else if (_loc6_ != null) {
			width = _loc6_.positionWidth;
			startY = _loc6_.startY;
		} else if (_loc7_ != null) {
			width = _loc7_.positionWidth;
			startY = _loc7_.startY;
		} else {
			width = 0;
			startY = 0;
		}
		var topOffset = startY - _loc3_.y - 5;
		var bottomOffset = startY + width - _loc4_.y + 5;
		var angOffset:Float = 90
			+ Maths.getAngle(pos, Math.min(0, topOffset) * Math.abs(pos / this._fullLength))
			+ (90 + Maths.getAngle(pos, Math.max(0, bottomOffset) * Math.abs(pos / this._fullLength)));
		angOffset = Maths.normaliseAngle(angOffset);
		return new PenisWidth(width, startY, topOffset, bottomOffset, pos, angOffset);
		return {
			"width": width,
			"startY": startY,
			"topOffset": topOffset,
			"bottomOffset": bottomOffset,
			"pos": pos,
			"angOffset": angOffset
		};
	}
}
