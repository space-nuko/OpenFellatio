package obj;

import openfl.geom.Point;
import openfl.events.Event;
import obj.Maths;

@:rtti
@:access(swf.exporters.animate)
class Droplet extends openfl.display.MovieClip {
	public var speed:Point;
	public var padding:Float = 30;
	public var sizeFactor:Float = Math.NaN;
	public var sizeDecrease:Float = Math.NaN;

	public function new(param1:Point, param2:Point, param3:Float, param4:Float = 0.2, param5:Float = 1.0, param6:Bool = false) {
		var library = swf.exporters.animate.AnimateLibrary.get("a8olP6aXvP6aAaPJMwlV");
		var symbol = library.symbols.get(2057);
		symbol.__init(library);

		super();

		if (param6) {
			this.gotoAndStop("cum");
		} else {
			this.stop();
		}
		this.alpha = param5;
		this.x = param1.x;
		this.y = param1.y;
		this.speed = param2.clone();
		this.sizeFactor = param3;
		this.sizeDecrease = param4;
		var _loc7_:Float = Maths.getAngle(this.speed.x, this.speed.y);
		var _loc8_ = Math.sqrt(this.speed.x * this.speed.x + this.speed.y * this.speed.y);
		this.rotation = _loc7_;
		this.scaleY = Math.min(6, Math.max(1, _loc8_ / 10)) * this.sizeFactor;
		this.scaleX = this.sizeFactor;
		this.addEventListener(Event.ENTER_FRAME, this.tick);
	}

	public function tick(param1:Event) {
		this.speed.x /= G.friction;
		this.speed.y /= G.friction;
		this.x += this.speed.x;
		this.y += this.speed.y + G.gravity;
		var _loc2_:Float = Maths.getAngle(this.speed.x, this.speed.y);
		var _loc3_ = Math.sqrt(this.speed.x * this.speed.x + this.speed.y * this.speed.y);
		this.rotation = _loc2_;
		this.scaleY = Math.min(6, Math.max(1, _loc3_ / 10)) * this.sizeFactor;
		this.scaleX = this.sizeFactor;
		this.sizeFactor -= this.sizeDecrease;
		if (this.x < -this.padding || this.x > G.screenSize.x + this.padding) {
			this.killMe();
		} else if (this.y > G.screenSize.y + this.padding) {
			this.killMe();
		} else if (this.sizeFactor <= 0) {
			this.killMe();
		}
	}

	public function killMe() {
		this.removeEventListener(Event.ENTER_FRAME, this.tick);
		this.parent.removeChild(this);
	}
}
