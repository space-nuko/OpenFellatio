package obj.her;

import openfl.display.MovieClip;
import openfl.display.BlendMode;
import openfl.display.GradientType;
import openfl.display.MovieClip;
import openfl.display.Sprite;
import openfl.geom.Matrix;
import openfl.geom.Point;

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
	@:keep public var outline2(default, null):MovieClip;
	@:keep public var outline3(default, null):MovieClip;
	@:keep public var outline4(default, null):MovieClip;
	@:keep public var outline5(default, null):MovieClip;
	@:keep public var outline6(default, null):MovieClip;
	@:keep public var outline1(default, null):MovieClip;
	@:keep public var outline7(default, null):MovieClip;
	@:keep public var outline8(default, null):MovieClip;
	@:keep public var outline9(default, null):MovieClip;
	@:keep public var outline10(default, null):MovieClip;
	@:keep public var outline11(default, null):MovieClip;
	@:keep public var outline13(default, null):MovieClip;
	@:keep public var outline14(default, null):MovieClip;
	@:keep public var outline15(default, null):MovieClip;
	@:keep public var outline16(default, null):MovieClip;
	@:keep public var outline12(default, null):MovieClip;
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
	@:keep public var highlight11(default, null):MovieClip;
	@:keep public var highlight10(default, null):MovieClip;

	public function new() {
		var library = swf.exporters.animate.AnimateLibrary.get("FYA8BqNO2PenTmHMYgDK");
		var symbol = library.symbols.get(992);
		symbol.__init(library);

		super();

        _tanlayer.display = BlendMode.OVERLAY;
        addChild(_tanlayer);
	}
}
