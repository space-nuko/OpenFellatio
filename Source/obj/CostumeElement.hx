package obj;

import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.Point;
import openfl.Vector;

class CostumeElement extends Sprite {
	public var showing:Bool = true;
	public var toggleable:Bool = true;
	public var linkedTo:Vector<CostumeElement> = new Vector<CostumeElement>();
	public var linked:Bool = false;
	public var dynamicAnchored:Bool = false;
	public var anchorContainer:Null<DisplayObject>;
	public var anchorPoint:Point;
	public var currentAnchor:Point;

	public function new() {
		this.linkedTo = new Vector<CostumeElement>();
		super();
		this.mouseChildren = false;
		this.addEventListener(MouseEvent.CLICK, this.clicked);
	}

	public function makeUnToggleable() {
		this.toggleable = false;
		this.removeEventListener(MouseEvent.CLICK, this.clicked);
	}

	public function dynamicAnchor(param1:Float, param2:Float, param3:Null<DisplayObject>) {
		this.anchorContainer = param3;
		this.dynamicAnchored = true;
		this.anchorPoint = new Point(param1, param2);
		this.addEventListener(Event.ENTER_FRAME, this.tick);
	}

	public function tick(param1:Event) {
		if (this.dynamicAnchored) {
			this.currentAnchor = G.sceneLayer.globalToLocal(this.anchorContainer.localToGlobal(this.anchorPoint));
			this.x = this.currentAnchor.x;
			this.y = this.currentAnchor.y;
			this.rotation = this.anchorContainer.rotation;
		}
	}

	public function showingString():String {
		if (this.showing) {
			return "1";
		}
		return "0";
	}

	public function tryToHide() {
		var _loc1_:CostumeElement = null;
		if (this.toggleable) {
			this.hideMe();
			if (this.linked) {
				for (_tmp_ in this.linkedTo) {
					_loc1_ = _tmp_;
					_loc1_.hideMe();
				}
			}
		}
	}

	public function hideMe() {
		this.alpha = 0;
		this.showing = false;
	}

	public function showMe() {
		this.alpha = 1;
		this.showing = true;
	}

	public function linkTo(param1:CostumeElement, param2:Bool = false) {
		this.linkedTo.push(param1);
		this.linked = true;
		if (param2) {
			param1.addEventListener(MouseEvent.CLICK, this.clicked);
		}
	}

	public function clicked(param1:MouseEvent) {
		var _loc2_:CostumeElement = null;
		if (this.toggleable && G.shiftDown) {
			if (this.showing) {
				this.hideMe();
				if (this.linked) {
					for (_tmp_ in this.linkedTo) {
						_loc2_ = _tmp_;
						_loc2_.hideMe();
					}
				}
			} else {
				this.showMe();
				if (this.linked) {
					for (_tmp_ in this.linkedTo) {
						_loc2_ = _tmp_;
						_loc2_.showMe();
					}
				}
			}
			dispatchEvent(new Event("toggled"));
		}
	}

	public function kill() {
		var _loc1_:CostumeElement = null;
		if (this.toggleable) {
			this.makeUnToggleable();
		}
		if (this.dynamicAnchored) {
			this.removeEventListener(Event.ENTER_FRAME, this.tick);
		}
		for (_tmp_ in this.linkedTo) {
			_loc1_ = _tmp_;
			_loc1_.removeEventListener(MouseEvent.CLICK, this.clicked);
		}
		if (this.parent != null) {
			this.parent.removeChild(this);
		}
	}
}
