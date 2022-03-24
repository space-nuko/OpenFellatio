package obj.him.bodies;

import openfl.display.MovieClip;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Point;
import obj.Him;

class HimBody implements IHimBody {
	static var _bodyMenuContainer:Sprite;

	public var _him:Him;

	public var lastPos:Float = 0;

	public var movementSpeed:Float = 0;

	public var lastHandPos:Float = 0;

	public var lastYPos:Float = 0;

	public var _bodyMenu:MovieClip;

	public function new(param1:Him) {
		// super();
		this._him = param1;
		this.initElements();
		this.initMenu();
	}

	@:flash.property public static var bodyMenuContainer(never, set):Sprite;

	static function set_bodyMenuContainer(param1:Sprite):Sprite {
		return _bodyMenuContainer = param1;
	}

	public function move(param1:Float, param2:Float, param3:Float) {
		this.movementSpeed = param1 - this.lastPos;
		this.lastPos = param1;
		this.lastHandPos = param2;
		this.lastYPos = param3;
	}

	public function redoLastMove() {
		this.move(this.lastPos, this.lastHandPos, this.lastYPos);
	}

	public function debugMove(param1:Point) {
		this._him.x = param1.x;
		this._him.y = param1.y;
	}

	public function loadDataPairs(param1:Array<ASAny>) {}

	public function getDataString():String {
		return "";
	}

	public function animationChanged() {}

	public function toggleBodySettings() {}

	public function shuffle() {}

	public function initElements() {}

	public function initMenu() {}

	public function setup() {
		this.setupElements();
		this.setupAnimation();
		if (this._bodyMenu != null) {
			_bodyMenuContainer.addChild(this._bodyMenu);
			this._bodyMenu.addEventListener(Event.ENTER_FRAME, this.fadeInMenu);
			this._bodyMenu.alpha = 0;
		}
		this.setupMenu();
		this.updateSharedMenuItems();
	}

	public function fadeInMenu(param1:Event) {
		if (this._bodyMenu != null) {
			this._bodyMenu.alpha = Math.min(1, this._bodyMenu.alpha + 0.1);
			if (this._bodyMenu.alpha == 1) {
				this._bodyMenu.removeEventListener(Event.ENTER_FRAME, this.fadeInMenu);
			}
		}
	}

	public function breakdown() {
		if (this._bodyMenu != null) {
			_bodyMenuContainer.removeChild(this._bodyMenu);
			this._bodyMenu.removeEventListener(Event.ENTER_FRAME, this.fadeInMenu);
		}
		this.breakdownBody();
	}

	public function breakdownBody() {}

	public function updateSharedMenuItems() {
		g.inGameMenu.updateHisBodyList();
	}

	public function setupElements() {}

	public function setupAnimation() {}

	public function setupMenu() {}

	@:flash.property public var xDelta(get, never):Float;

	function get_xDelta():Float {
		return 0;
	}
}
