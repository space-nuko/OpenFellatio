package obj.her;

import openfl.geom.Point;
import openfl.events.Event;

@:rtti
@:access(swf.exporters.animate)
class BreathMist extends openfl.display.MovieClip {
	public var speed:Point;
	public var angSpeed:Float = Math.NaN;
	public var fadingIn:Bool = false;
	public var maxAlpha:Float = Math.NaN;

	public function new() {
		var library = swf.exporters.animate.AnimateLibrary.get("Ld39TJPQZsVJfqCLrG3m");
		var symbol = library.symbols.get(2060);
		symbol.__init(library);

		super();

		var _loc1_ = Math.random() * (G.breathLevel / 40) + 3;
		var _loc2_ = Math.random() * 2 - 1.2;
		this.speed = new Point(_loc1_, _loc2_);
		this.angSpeed = (Math.random() - 0.5) / 10;
		this.rotation = Math.random() * 360;
		this.alpha = 0;
		var _loc3_ = 0.3 + Math.random() / 5;
		this.scaleX = _loc3_;
		this.scaleY = _loc3_;
		this.maxAlpha = Math.min(1, G.breathLevel / G.outOfBreathPoint) / 5;
		this.fadingIn = true;
		this.addEventListener(Event.ENTER_FRAME, this.tick);
	}

	public function tick(param1:Event) {
		this.x += this.speed.x;
		this.y += this.speed.y;
		this.scaleX += 0.01;
		this.scaleY += 0.01;
		this.rotation += this.angSpeed;
		if (this.fadingIn) {
			this.alpha += 0.1;
			if (this.alpha >= this.maxAlpha) {
				this.fadingIn = false;
			}
		} else {
			this.alpha -= 0.005;
			if (this.alpha <= 0) {
				this.removeEventListener(Event.ENTER_FRAME, this.tick);
				this.parent.removeChild(this);
			}
		}
	}
}
