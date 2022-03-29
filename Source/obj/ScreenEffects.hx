package obj;

   import openfl.display.MovieClip;
   import openfl.events.Event;

@:rtti
@:access(swf.exporters.animate)
class ScreenEffects extends openfl.display.MovieClip
{
    public var flashing:Bool = false;
    public var pulsing:Bool = false;
    public var stoppingPulse:Bool = false;

    @:keep public var whiteout(default, null):sDT_1_21_1b_fla.ScreenEffectWhiteout_901;
	@:keep public var whiteFlash(default, null):openfl.display.MovieClip;

	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdt");
		var symbol = library.symbols.get(116);
		symbol.__init(library);

		super();

        this.whiteout.stop();
        this.whiteFlash.stop();
        this.addEventListener(Event.ENTER_FRAME, this.tick);
	}

	public function showWhiteout(param1:Float) {
		param1 = Math.min(100, Math.max(1, Math.fround(param1)));
		this.whiteout.gotoAndStop(param1);
	}

	public function showFlash() {
		this.whiteFlash.gotoAndPlay("flash");
		this.flashing = true;
		this.pulsing = false;
		this.stoppingPulse = false;
	}

	public function showPulse() {
		if (!this.pulsing) {
			this.whiteFlash.gotoAndPlay("pulse");
			this.stoppingPulse = false;
			this.pulsing = true;
		}
	}

	public function stopPulse() {
		if (this.pulsing) {
			this.stoppingPulse = true;
		}
	}

	public function tick(param1:Event) {
		if (this.flashing) {
			if (this.whiteFlash.currentLabel == "flashDone") {
				this.flashing = false;
				this.whiteFlash.gotoAndStop("normal");
			}
		}
		if (this.pulsing) {
			if (this.whiteFlash.currentLabel == "pulseDone") {
				if (this.stoppingPulse) {
					this.stoppingPulse = false;
					this.pulsing = false;
					this.whiteFlash.gotoAndStop("normal");
				} else {
					this.whiteFlash.gotoAndPlay("pulse");
				}
			}
		}
	}
}
