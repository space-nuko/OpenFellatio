package obj.her;

import openfl.display.MovieClip;
import openfl.display.BlendMode;
import openfl.display.GradientType;
import openfl.display.MovieClip;
import openfl.display.Sprite;
import openfl.geom.Matrix;
import openfl.geom.Point;

@:rtti
@:access(swf.exporters.animate)
class Neck extends MovieClip {
	public var neckPoints:Array<Point>;
	public var numPoints:UInt = 0;
	public var highlightPoints:Array<Point>;
	public var numHighlightPoints:UInt = 0;
	public var frontEndPoint:UInt = 0;
	public var shadeLight:UInt = 16178890;
	public var shade1:UInt = 14925224;
	public var shade2:UInt = 13541515;
	public var shade3:UInt = 11306097;
	public var mainGradient:Matrix;
	public var highlightGradient:Matrix;
	public var swallowing:Bool = false;
	public var swallowProgress:Float = 0;
	public var swallowSize:Float = 10;
	public var swallowStart:Float = 0.2;
	public var bulgeSize:Float = 35;
	public var bulgeVec:Point;
	public var throatBulgeAmount:Float = 1;
	public var _tanLayer:Sprite;
	public var tanAlpha:Float = 1;

	@:keep public var outline0(default, null):MovieClip;
	@:keep public var outline1(default, null):MovieClip;
	@:keep public var outline2(default, null):MovieClip;
	@:keep public var outline3(default, null):MovieClip;
	@:keep public var outline4(default, null):MovieClip;
	@:keep public var outline5(default, null):MovieClip;
	@:keep public var outline6(default, null):MovieClip;
	@:keep public var outline7(default, null):MovieClip;
	@:keep public var outline8(default, null):MovieClip;
	@:keep public var outline9(default, null):MovieClip;
	@:keep public var outline10(default, null):MovieClip;
	@:keep public var outline11(default, null):MovieClip;
	@:keep public var outline12(default, null):MovieClip;
	@:keep public var outline13(default, null):MovieClip;
	@:keep public var outline14(default, null):MovieClip;
	@:keep public var outline15(default, null):MovieClip;
	@:keep public var outline16(default, null):MovieClip;
	@:keep public var highlight0(default, null):MovieClip;
	@:keep public var highlight1(default, null):MovieClip;
	@:keep public var highlight2(default, null):MovieClip;
	@:keep public var highlight3(default, null):MovieClip;
	@:keep public var highlight4(default, null):MovieClip;
	@:keep public var highlight5(default, null):MovieClip;
	@:keep public var highlight6(default, null):MovieClip;
	@:keep public var highlight7(default, null):MovieClip;
	@:keep public var highlight8(default, null):MovieClip;
	@:keep public var highlight9(default, null):MovieClip;
	@:keep public var highlight10(default, null):MovieClip;
	@:keep public var highlight11(default, null):MovieClip;

	public function new() {
		var library = swf.exporters.animate.AnimateLibrary.get("sdthx-lib");
		var symbol = library.symbols.get(992);
		symbol.__init(library);

		super();

        _tanLayer = new Sprite();
		_tanLayer.blendMode = BlendMode.OVERLAY;
		addChild(_tanLayer);

		neckPoints = new Array<Point>();
		for (p in [
			outline0, outline1, outline2, outline3, outline4, outline5, outline6, outline7, outline8, outline9, outline10, outline11, outline12, outline13,
			outline14, outline15, outline16
		]) {
			if (p != null) {
				neckPoints.push(new Point(p.x, p.y));
				numPoints += 1;
			}
		}

		highlightPoints = new Array<Point>();
		for (p in [
			highlight0, highlight1, highlight2, highlight3, highlight4, highlight5, highlight6, highlight7, highlight8, highlight9, highlight10, highlight11
		]) {
			if (p != null) {
				highlightPoints.push(new Point(p.x, p.y));
				numHighlightPoints += 1;
			}
		}

		respacePoints();

		mainGradient = new Matrix();
		mainGradient.a = -3.204345703125E-4;
		mainGradient.b = -0.142364501953125;
		mainGradient.c = 0.2744293212890625;
		mainGradient.d = -6.40869140625E-4;
		mainGradient.tx = -19.099;
		mainGradient.ty = 76.85;

		highlightGradient = new Matrix();
		highlightGradient.a = 0.0777435302734375;
		highlightGradient.b = 0.0058441162109375;
		highlightGradient.c = -0.0086517333984375;
		highlightGradient.d = 0.114990234375;
		highlightGradient.tx = -8.649;
		highlightGradient.ty = 109.;

		bulgeVec = Maths.getUnitVector(Math.PI * 0.75);
	}

	public function setSkin(param1:SkinPalette) {
		this.shadeLight = param1.light.rgb;
		this.shade1 = param1.shade1.rgb;
		this.shade2 = param1.shade2.rgb;
		this.shade3 = param1.shade3.rgb;
	}

	public function respacePoints() {
		var _loc2_:Point = null;
		var pt1:Point = null;
		var pt2:Point = null;
		var _loc6_ = Math.NaN;
		var _loc7_:Point = null;
		var _loc8_:Point = null;
		var _loc9_:Point = null;
		var _loc10_:Point = null;
		var _loc11_:Point = null;
		var _loc12_ = Math.NaN;
		var newPointCount:UInt = 0;
		var i:UInt = 0;
		var _loc1_ = new Array<Point>();
		for (_tmp_ in this.neckPoints) {
			_loc2_ = _tmp_;
			_loc1_.push(_loc2_.clone());
		}
		this.neckPoints = new Array<Point>();
		var index = -1;
		this.numPoints = this.numPoints - 1;
        _loc12_ = 6;
		newPointCount = Std.int(_loc12_ * 5);
		i = 0;
		while (i < newPointCount) {
			if (index != Math.ffloor(i / newPointCount * _loc12_)) {
				index = Math.floor(i / newPointCount * _loc12_);
				pt1 = new Point((_loc1_[index].x + _loc1_[index + 1].x) * 0.5, (_loc1_[index].y + _loc1_[index + 1].y) * 0.5);
				pt2 = new Point((_loc1_[index + 1].x + _loc1_[index + 2].x) * 0.5, (_loc1_[index + 1].y + _loc1_[index + 2].y) * 0.5);
				_loc10_ = new Point(_loc1_[index + 1].x - pt1.x, _loc1_[index + 1].y - pt1.y);
				_loc11_ = new Point(pt2.x - _loc1_[index + 1].x, pt2.y - _loc1_[index + 1].y);
			}
			_loc6_ = i / newPointCount * _loc12_ - index;
			_loc7_ = new Point(pt1.x + _loc10_.x * _loc6_, pt1.y + _loc10_.y * _loc6_);
			_loc8_ = new Point(_loc1_[index + 1].x + _loc11_.x * _loc6_, _loc1_[index + 1].y + _loc11_.y * _loc6_);
			_loc9_ = new Point(_loc8_.x - _loc7_.x, _loc8_.y - _loc7_.y);
			this.neckPoints.push(new Point(_loc7_.x + _loc9_.x * _loc6_, _loc7_.y + _loc9_.y * _loc6_));
			i++;
		}
		this.frontEndPoint = this.neckPoints.length;
		this.neckPoints = this.neckPoints.concat(_loc1_.slice(Std.int(_loc12_ + 1)));
		this.numPoints = this.neckPoints.length;
	}

	public function swallow() {
		this.swallowing = true;
		this.swallowProgress = this.swallowStart;
	}

	public function render(param1:Float) {
		var _loc2_:UInt = 0;
		var _loc4_:Point = null;
		var _loc14_ = Math.NaN;
		var _loc15_ = Math.NaN;
		var _loc16_ = Math.NaN;
		var _loc17_ = Math.NaN;
		var _loc18_:Point = null;
		var _loc19_ = Math.NaN;
		var _loc20_:Point = null;
		var _loc21_ = Math.NaN;
		var _loc22_:Point = null;
		var _loc3_ = new Array<Point>();
		for (_tmp_ in this.neckPoints) {
			_loc4_ = _tmp_;
			_loc3_.push(_loc4_.clone());
		}
		this.bulgeSize = 35 * (1 + (G.him.getPenisWidthWithTwitch() - 1) * 1.5);
		_loc2_ = 0;
		while (_loc2_ < this.frontEndPoint) {
			if (this.throatBulgeAmount > 0) {
				_loc14_ = _loc2_ / this.frontEndPoint - param1;
				_loc15_ = 1 / (1 + Math.pow(2, _loc14_ * 35)) * this.throatBulgeAmount;
				_loc16_ = Math.min(1, 0.6 + 0.6 * param1) * Math.min(35, this.bulgeSize * _loc15_ * Math.pow(1 - _loc2_ / this.frontEndPoint, 1.4));
				_loc3_[_loc2_].x += _loc16_;
				_loc3_[_loc2_].y += 0.3 * _loc16_;
			}
			if (this.swallowing) {
				_loc17_ = (_loc17_ = this.swallowSize * Math.max(0,
					2 / (2
						+ Math.pow(8 * (_loc2_ / this.frontEndPoint - this.swallowProgress),
							2)) - 0.2)) * Math.min(1, Math.min((this.swallowProgress - this.swallowStart) * 5, 2 - this.swallowProgress * 2));
				_loc3_[_loc2_].x += _loc17_ * 0.8;
				_loc3_[_loc2_].y += _loc17_ * 0.5;
			}
			_loc2_++;
		}
		if (this.swallowing) {
			this.swallowProgress += 0.05;
			if (this.swallowProgress > 1) {
				this.swallowing = false;
			}
		}
		this.graphics.clear();
		this.graphics.beginGradientFill(GradientType.RADIAL, [this.shade1, this.shade3], [1, 1], [209, 250], this.mainGradient, "pad", "rgb", 0.1);
		var _loc5_:Point;
		var _loc6_ = (_loc5_ = new Point((_loc3_[0].x + _loc3_[1].x) * 0.5, (_loc3_[0].y + _loc3_[1].y) * 0.5)).clone();
		if (this.tanAlpha > 0) {
			this._tanLayer.graphics.clear();
			this._tanLayer.graphics.beginFill(0, this.tanAlpha);
			this._tanLayer.graphics.moveTo(_loc3_[0].x, _loc3_[0].y);
			this._tanLayer.graphics.lineTo(_loc6_.x, _loc6_.y);
		}
		this.graphics.moveTo(_loc3_[0].x, _loc3_[0].y);
		this.graphics.lineTo(_loc6_.x, _loc6_.y);
		_loc2_ = 1;
		while (_loc2_ < this.numPoints - 1) {
			_loc5_ = new Point((_loc3_[_loc2_].x + _loc3_[_loc2_ + 1].x) * 0.5, (_loc3_[_loc2_].y + _loc3_[_loc2_ + 1].y) * 0.5);
			this.graphics.curveTo(_loc3_[_loc2_].x, _loc3_[_loc2_].y, _loc5_.x, _loc5_.y);
			if (this.tanAlpha > 0) {
				this._tanLayer.graphics.curveTo(_loc3_[_loc2_].x, _loc3_[_loc2_].y, _loc5_.x, _loc5_.y);
			}
			_loc2_++;
		}
		_loc5_ = new Point((_loc3_[_loc3_.length - 1].x + _loc3_[0].x) * 0.5, (_loc3_[_loc3_.length - 1].y + _loc3_[0].y) * 0.5);
		this.graphics.lineTo(_loc3_[_loc2_].x, _loc3_[_loc2_].y);
		this.graphics.lineStyle();
		this.graphics.curveTo(_loc5_.x, _loc5_.y, _loc3_[0].x, _loc3_[0].y);
		this.graphics.endFill();
		if (this.tanAlpha > 0) {
			this._tanLayer.graphics.lineTo(_loc3_[_loc2_].x, _loc3_[_loc2_].y);
			this._tanLayer.graphics.lineStyle();
			this._tanLayer.graphics.curveTo(_loc5_.x, _loc5_.y, _loc3_[0].x, _loc3_[0].y);
			this._tanLayer.graphics.endFill();
		}
		this.graphics.beginGradientFill(GradientType.RADIAL, [this.shadeLight, this.shade1], [1, 1], [215, 250], this.highlightGradient, "pad", "rgb", 0.1);
		this.graphics.moveTo(this.highlightPoints[0].x, this.highlightPoints[0].y);
		_loc6_ = (_loc5_ = new Point((this.highlightPoints[0].x + this.highlightPoints[1].x) * 0.5,
			(this.highlightPoints[0].y + this.highlightPoints[1].y) * 0.5)).clone();
		this.graphics.lineTo(_loc6_.x, _loc6_.y);
		_loc2_ = 1;
		while (_loc2_ < this.numHighlightPoints - 1) {
			_loc5_ = new Point((this.highlightPoints[_loc2_].x + this.highlightPoints[_loc2_ + 1].x) * 0.5,
				(this.highlightPoints[_loc2_].y + this.highlightPoints[_loc2_ + 1].y) * 0.5);
			this.graphics.curveTo(this.highlightPoints[_loc2_].x, this.highlightPoints[_loc2_].y, _loc5_.x, _loc5_.y);
			_loc2_++;
		}
		this.graphics.lineTo(this.highlightPoints[_loc2_].x, this.highlightPoints[_loc2_].y);
		this.graphics.lineStyle();
		_loc5_ = new Point((this.highlightPoints[this.highlightPoints.length - 1].x + this.highlightPoints[0].x) * 0.5,
			(this.highlightPoints[this.highlightPoints.length - 1].y + this.highlightPoints[0].y) * 0.5);
		this.graphics.curveTo(_loc5_.x, _loc5_.y, this.highlightPoints[0].x, this.highlightPoints[0].y);
		this.graphics.endFill();
		graphics.beginFill(5849907, 1);
		graphics.moveTo(_loc3_[0].x, _loc3_[0].y);
		var _loc7_ = new Array<Point>();
		var _loc8_ = new Array<Point>();
		var _loc9_ = new Array<Point>();
		var _loc10_ = new Array<Point>();
		var _loc11_ = new Array<Point>();
		var _loc12_ = new Array<Float>();
		var _loc13_ = 0.6;
		_loc7_[0] = new Point(_loc3_[0].x, _loc3_[0].y);
		_loc8_[0] = new Point(_loc3_[0].x, _loc3_[0].y);
		_loc2_ = 0;
		while (_loc2_ < this.numPoints - 1) {
			_loc18_ = new Point(_loc3_[_loc2_ + 1].x - _loc3_[_loc2_].x, _loc3_[_loc2_ + 1].y - _loc3_[_loc2_].y);
			_loc19_ = Math.sqrt(_loc18_.x * _loc18_.x + _loc18_.y * _loc18_.y);
			_loc18_.x /= _loc19_;
			_loc18_.y /= _loc19_;
			_loc11_[_loc2_] = _loc18_;
			_loc12_[_loc2_] = Math.atan2(_loc18_.y, _loc18_.x);
			if (_loc2_ > 0) {
				_loc20_ = _loc11_[_loc2_ - 1];
				_loc21_ = _loc13_;
				_loc22_ = new Point((_loc20_.y + _loc18_.y) * _loc21_, -((_loc20_.x + _loc18_.x) * _loc21_));
				_loc7_[_loc2_] = new Point(_loc3_[_loc2_].x - _loc22_.x, _loc3_[_loc2_].y - _loc22_.y);
				_loc8_[_loc2_] = new Point(_loc3_[_loc2_].x + _loc22_.x, _loc3_[_loc2_].y + _loc22_.y);
				_loc9_[_loc2_] = new Point(_loc7_[_loc2_ - 1].x + (_loc7_[_loc2_].x - _loc7_[_loc2_ - 1].x) * 0.5,
					_loc7_[_loc2_ - 1].y + (_loc7_[_loc2_].y - _loc7_[_loc2_ - 1].y) * 0.5);
				_loc10_[_loc2_] = new Point(_loc8_[_loc2_ - 1].x + (_loc8_[_loc2_].x - _loc8_[_loc2_ - 1].x) * 0.5,
					_loc8_[_loc2_ - 1].y + (_loc8_[_loc2_].y - _loc8_[_loc2_ - 1].y) * 0.5);
			}
			_loc2_++;
		}
		_loc9_[_loc2_] = new Point(_loc7_[_loc2_ - 1].x + (_loc3_[_loc2_].x - _loc7_[_loc2_ - 1].x) * 0.5,
			_loc7_[_loc2_ - 1].y + (_loc3_[_loc2_].y - _loc7_[_loc2_ - 1].y) * 0.5);
		_loc10_[_loc2_] = new Point(_loc8_[_loc2_ - 1].x + (_loc3_[_loc2_].x - _loc8_[_loc2_ - 1].x) * 0.5,
			_loc8_[_loc2_ - 1].y + (_loc3_[_loc2_].y - _loc8_[_loc2_ - 1].y) * 0.5);
		graphics.lineTo(_loc9_[1].x, _loc9_[1].y);
		_loc2_ = 1;
		while (_loc2_ < this.numPoints - 1) {
			graphics.curveTo(_loc7_[_loc2_].x, _loc7_[_loc2_].y, _loc9_[_loc2_ + 1].x, _loc9_[_loc2_ + 1].y);
			_loc2_++;
		}
		graphics.lineTo(_loc3_[this.numPoints - 1].x, _loc3_[this.numPoints - 1].y);
		_loc2_ = this.numPoints - 1;
		graphics.lineTo(_loc10_[_loc2_].x, _loc10_[_loc2_].y);
		_loc2_ = this.numPoints - 1;
		while (_loc2_ > 1) {
			graphics.curveTo(_loc8_[_loc2_ - 1].x, _loc8_[_loc2_ - 1].y, _loc10_[_loc2_ - 1].x, _loc10_[_loc2_ - 1].y);
			_loc2_--;
		}
		graphics.lineTo(_loc3_[0].x, _loc3_[0].y);
	}

	@:flash.property public var throatBulge(never, set):Float;

	function set_throatBulge(param1:Float):Float {
		return this.throatBulgeAmount = param1;
	}

	@:flash.property public var tan(get, never):Sprite;

	function get_tan():Sprite {
		return this._tanLayer;
	}
}
