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

    var __neckPoints: Array<Point> = [];
	var __neckArr1A: Array<Point> = [];
	var __neckArr1B: Array<Point> = [];
	var __neckArr2A: Array<Point> = [];
	var __neckArr2B: Array<Point> = [];
	var __neckArr3A: Array<Point> = [];
	var __neckArr3B: Array<Float> = [];

	public function new() {
		var library = swf.exporters.animate.AnimateLibrary.get("sdt");
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

        __neckPoints = [];
        __neckArr1A = [];
        __neckArr1B = [];
        __neckArr2A = [];
        __neckArr2B = [];
        __neckArr3A = [];
        __neckArr3B = [];
        for (point in this.neckPoints) {
            __neckPoints.push(point.clone());
            __neckArr1A.push(new Point());
            __neckArr1B.push(new Point());
            __neckArr2A.push(new Point());
            __neckArr2B.push(new Point());
            __neckArr3A.push(new Point());
            __neckArr3B.push(0);
        }
    }

    public function swallow() {
        this.swallowing = true;
		this.swallowProgress = this.swallowStart;
	}

    private static inline var NECK_FACTOR: Float = 0.6;

	public function render(param1:Float) {
		var i:UInt = 0;
        var px: Float = 0;
        var py: Float = 0;

		while (i < this.neckPoints.length) {
            // Assuming the base neck points are always static here
            __neckPoints[i].x = this.neckPoints[i].x;
            __neckPoints[i].y = this.neckPoints[i].y;
            i++;
        }

		this.bulgeSize = 35 * (1 + (G.him.getPenisWidthWithTwitch() - 1) * 1.5);

		i = 0;
		while (i < this.frontEndPoint) {
			if (this.throatBulgeAmount > 0) {
				var bulge1 = i / this.frontEndPoint - param1;
				var bulge2 = 1 / (1 + Math.pow(2, bulge1 * 35)) * this.throatBulgeAmount;
				var bulge3 = Math.min(1, 0.6 + 0.6 * param1) * Math.min(35, this.bulgeSize * bulge2 * Math.pow(1 - i / this.frontEndPoint, 1.4));
				__neckPoints[i].x += bulge3;
				__neckPoints[i].y += 0.3 * bulge3;
			}
			if (this.swallowing) {
				var swallowFactor = this.swallowSize * Math.max(0, 2 / (2 + Math.pow(8 * (i / this.frontEndPoint - this.swallowProgress), 2)) - 0.2);
                swallowFactor *= Math.min(1, Math.min((this.swallowProgress - this.swallowStart) * 5, 2 - this.swallowProgress * 2));
				__neckPoints[i].x += swallowFactor * 0.8;
				__neckPoints[i].y += swallowFactor * 0.5;
			}
			i++;
		}

		if (this.swallowing) {
			this.swallowProgress += 0.05;
			if (this.swallowProgress > 1) {
				this.swallowing = false;
			}
		}

		this.graphics.clear();
		this.graphics.beginGradientFill(GradientType.RADIAL, [this.shade1, this.shade3], [1, 1], [209, 250], this.mainGradient, "pad", "rgb", 0.1);

        var ptx = (__neckPoints[0].x + __neckPoints[1].x) * 0.5;
        var pty = (__neckPoints[0].y + __neckPoints[1].y) * 0.5;
		if (this.tanAlpha > 0) {
			this._tanLayer.graphics.clear();
			this._tanLayer.graphics.beginFill(0, this.tanAlpha);
			this._tanLayer.graphics.moveTo(__neckPoints[0].x, __neckPoints[0].y);
			this._tanLayer.graphics.lineTo(ptx, pty);
		}
		this.graphics.moveTo(__neckPoints[0].x, __neckPoints[0].y);
		this.graphics.lineTo(ptx, pty);

		i = 1;
		while (i < this.numPoints - 1) {
            px = (__neckPoints[i].x + __neckPoints[i + 1].x) * 0.5;
			py = (__neckPoints[i].y + __neckPoints[i + 1].y) * 0.5;
			this.graphics.curveTo(__neckPoints[i].x, __neckPoints[i].y, px, py);
			if (this.tanAlpha > 0) {
				this._tanLayer.graphics.curveTo(__neckPoints[i].x, __neckPoints[i].y, px, py);
			}
			i++;
		}

        px = (__neckPoints[__neckPoints.length - 1].x + __neckPoints[0].x) * 0.5;
		py = (__neckPoints[__neckPoints.length - 1].y + __neckPoints[0].y) * 0.5;
		this.graphics.lineTo(__neckPoints[i].x, __neckPoints[i].y);
		this.graphics.lineStyle();
		this.graphics.curveTo(px, py, __neckPoints[0].x, __neckPoints[0].y);
		this.graphics.endFill();
		if (this.tanAlpha > 0) {
			this._tanLayer.graphics.lineTo(__neckPoints[i].x, __neckPoints[i].y);
			this._tanLayer.graphics.lineStyle();
			this._tanLayer.graphics.curveTo(px, py, __neckPoints[0].x, __neckPoints[0].y);
			this._tanLayer.graphics.endFill();
		}

		this.graphics.beginGradientFill(GradientType.RADIAL, [this.shadeLight, this.shade1], [1, 1], [215, 250], this.highlightGradient, "pad", "rgb", 0.1);
		this.graphics.moveTo(this.highlightPoints[0].x, this.highlightPoints[0].y);

        px = (this.highlightPoints[0].x + this.highlightPoints[1].x) * 0.5;
        py = (this.highlightPoints[0].y + this.highlightPoints[1].y) * 0.5;
		this.graphics.lineTo(px, py);

		i = 1;
		while (i < this.numHighlightPoints - 1) {
            px = (this.highlightPoints[i].x + this.highlightPoints[i + 1].x) * 0.5;
            py = (this.highlightPoints[i].y + this.highlightPoints[i + 1].y) * 0.5;
			this.graphics.curveTo(this.highlightPoints[i].x, this.highlightPoints[i].y, px, py);
			i++;
		}
		this.graphics.lineTo(this.highlightPoints[i].x, this.highlightPoints[i].y);
		this.graphics.lineStyle();

        px = (this.highlightPoints[this.highlightPoints.length - 1].x + this.highlightPoints[0].x) * 0.5;
        py = (this.highlightPoints[this.highlightPoints.length - 1].y + this.highlightPoints[0].y) * 0.5;
		this.graphics.curveTo(px, py, this.highlightPoints[0].x, this.highlightPoints[0].y);
		this.graphics.endFill();

		graphics.beginFill(5849907, 1);
		graphics.moveTo(__neckPoints[0].x, __neckPoints[0].y);

		__neckArr1A[0].x = __neckPoints[0].x;
		__neckArr1A[0].y = __neckPoints[0].y;
		__neckArr1B[0].x = __neckPoints[0].x;
        __neckArr2B[0].y = __neckPoints[0].y;

		i = 0;
		while (i < this.numPoints - 1) {
            px = __neckPoints[i + 1].x - __neckPoints[i].x;
            py = __neckPoints[i + 1].y - __neckPoints[i].y;
			var pLen = Math.sqrt(px * px + py * py);
			px /= pLen;
			py /= pLen;
			__neckArr3A[i].x = px;
			__neckArr3A[i].y = py;
			__neckArr3B[i] = Math.atan2(px, py);
			if (i > 0) {
				var neckPoint = __neckArr3A[i - 1];
                var ppx = (neckPoint.y + py) * NECK_FACTOR;
                var ppy = -((neckPoint.x + px) * NECK_FACTOR);
				__neckArr1A[i].x = __neckPoints[i].x - ppx;
				__neckArr1A[i].y = __neckPoints[i].y - ppy;
				__neckArr1B[i].x = __neckPoints[i].x + ppx;
				__neckArr1B[i].y = __neckPoints[i].y + ppy;
				__neckArr2A[i].x = __neckArr1A[i - 1].x + (__neckArr1A[i].x - __neckArr1A[i - 1].x) * 0.5;
                __neckArr2A[i].y = __neckArr1A[i - 1].y + (__neckArr1A[i].y - __neckArr1A[i - 1].y) * 0.5;
				__neckArr2B[i].x = __neckArr1B[i - 1].x + (__neckArr1B[i].x - __neckArr1B[i - 1].x) * 0.5;
                __neckArr2B[i].y = __neckArr1B[i - 1].y + (__neckArr1B[i].y - __neckArr1B[i - 1].y) * 0.5;
			}
			i++;
		}

		__neckArr2A[i].x = __neckArr1A[i - 1].x + (__neckPoints[i].x - __neckArr1A[i - 1].x) * 0.5;
		__neckArr2A[i].y = __neckArr1A[i - 1].y + (__neckPoints[i].y - __neckArr1A[i - 1].y) * 0.5;
		__neckArr2B[i].x = __neckArr1B[i - 1].x + (__neckPoints[i].x - __neckArr1B[i - 1].x) * 0.5;
		__neckArr2B[i].y = __neckArr1B[i - 1].y + (__neckPoints[i].y - __neckArr1B[i - 1].y) * 0.5;

		graphics.lineTo(__neckArr2A[1].x, __neckArr2A[1].y);
		i = 1;

		while (i < this.numPoints - 1) {
			graphics.curveTo(__neckArr1A[i].x, __neckArr1A[i].y, __neckArr2A[i + 1].x, __neckArr2A[i + 1].y);
			i++;
		}
		graphics.lineTo(__neckPoints[this.numPoints - 1].x, __neckPoints[this.numPoints - 1].y);
		i = this.numPoints - 1;
		graphics.lineTo(__neckArr2B[i].x, __neckArr2B[i].y);
		i = this.numPoints - 1;
		while (i > 1) {
			graphics.curveTo(__neckArr1B[i - 1].x, __neckArr1B[i - 1].y, __neckArr2B[i - 1].x, __neckArr2B[i - 1].y);
			i--;
		}
		graphics.lineTo(__neckPoints[0].x, __neckPoints[0].y);
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
