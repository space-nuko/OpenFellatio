package obj;

import openfl.display.DisplayObject;
import openfl.geom.Point;

class AnchorProp {
	public var hit:Bool = true;
	public var forceHit:Bool = false;
	public var localPoint:Point;
	public var container:DisplayObject;
	public var originalHitTarget:DisplayObject;
	public var eyeHit:Bool = false;

	public function new(param1:Point = null, param2:DisplayObject = null, param3:Bool = true) {
		this.localPoint = param1;
		this.container = param2;
		this.forceHit = param3;
	}

	public function setContainer(param1:DisplayObject) {
		this.container = param1;
		if (this.originalHitTarget != null) {
			this.originalHitTarget = param1;
		}
	}

	public function setOriginalHitTarget(param1:DisplayObject) {
		this.originalHitTarget = param1;
	}

	public function setEyeHit() {
		this.eyeHit = true;
	}

	@:flash.property public var hitTarget(get, never):DisplayObject;

	function get_hitTarget():DisplayObject {
		return this.originalHitTarget != null ? this.originalHitTarget : this.container;
	}

	public function clone():AnchorProp {
		return new AnchorProp(this.localPoint.clone(), this.container, this.forceHit);
	}
}
