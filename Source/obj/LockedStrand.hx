package obj;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.DisplayObjectContainer;
import openfl.display.MovieClip;
import openfl.events.Event;

class LockedStrand extends MovieClip {
	public var strandBitmap:Bitmap;
	public var container:DisplayObjectContainer;
	public var step:UInt = 0;

	public function new(param1:BitmapData, param2:DisplayObjectContainer) {
		super();
		this.strandBitmap = new Bitmap(param1);
		this.addChild(this.strandBitmap);
		this.container = param2;
		this.addEventListener(Event.ENTER_FRAME, this.tick);
	}

	public function tick(param1:Event) {
		if (this.step >= 10) {
			this.step = 0;
			if (this.alpha > 0) {
				this.alpha -= 0.00025;
			} else {
				this.kill();
			}
		} else {
			++this.step;
		}
	}

	public function kill() {
		G.strandControl.delistLockedStrand(this);
		this.removeEventListener(Event.ENTER_FRAME, this.tick);
		this.parent.removeChild(this);
	}
}
