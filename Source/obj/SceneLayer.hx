package obj;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.filters.ColorMatrixFilter;
import openfl.geom.Point;

class SceneLayer extends Sprite {
	public var camera:Point = new Point();
	public var magnitude:Point = new Point();
	public var shaking:Bool = false;
	public var t:UInt = 0;
	public var externalLayers:Array<Sprite>;
	public var currentZoom:Float = Math.NaN;
	public var targetZoom:Float = Math.NaN;
	public var zooming:Bool = false;
	public var extendedBackgroundHeight:Float = 825;
	public var backgroundHeight:Float = 825;
	public var bgYLimit:Float = Math.NaN;

	public function new(param1:Float) {
		this.bgYLimit = G.screenSize.y - this.backgroundHeight;
		super();
		this.externalLayers = new Array<Sprite>();
		this.zoomTo(param1, true);
		this.addEventListener(Event.ENTER_FRAME, this.tick);
	}

	public function giveExternalLayer(param1:Sprite) {
		param1.x = this.x;
		param1.y = this.y;
		param1.scaleX = this.scaleX;
		param1.scaleY = this.scaleY;
		this.externalLayers.push(param1);
	}

	public function toggleMirrored() {
		G.mirrored = !G.mirrored;
		this.updateCamera();
	}

	public function applyHSL(param1:ColorMatrixFilter) {
		var _loc2_:Sprite = null;
		if (this.externalLayers != null) {
			this.filters = [param1];
			for (_tmp_ in this.externalLayers) {
				_loc2_ = _tmp_;
				_loc2_.filters = [param1];
			}
		}
	}

	public function setSceneVisible(param1:Bool) {
		var _loc2_:Sprite = null;
		visible = param1;
		for (_tmp_ in this.externalLayers) {
			_loc2_ = _tmp_;
			_loc2_.visible = param1;
		}
	}

	public function setCustomBGHeight(param1:Float) {
		this.backgroundHeight = param1;
		this.bgYLimit = G.screenSize.y - this.backgroundHeight;
		this.updateBGScroll();
	}

	public function removeCustomBGHeight() {
		this.backgroundHeight = this.extendedBackgroundHeight;
		this.bgYLimit = G.screenSize.y - this.backgroundHeight;
		this.updateBGScroll();
	}

	public function tick(param1:Event) {
		var _loc2_ = Math.NaN;
		++this.t;
		if (this.shaking) {
			this.x = this.camera.x + Math.sin(this.t * 1.5) * this.magnitude.x;
			this.y = this.camera.y + Math.sin(this.t * 1.5) * this.magnitude.y;
			this.magnitude.x *= 0.8;
			this.magnitude.y *= 0.8;
			if (Math.abs(this.magnitude.x) < 0.1 && Math.abs(this.magnitude.y) < 0.1) {
				this.x = this.camera.x;
				this.y = this.camera.y;
				this.shaking = false;
			}
			this.updateExternalLayerPositions();
		}
		if (this.zooming) {
			_loc2_ = this.currentZoom + (this.targetZoom - this.currentZoom) / 4;
			if (Math.abs(_loc2_ - this.targetZoom) < 0.0001) {
				_loc2_ = this.targetZoom;
				this.zooming = false;
			}
			this.currentZoom = _loc2_;
			this.updateCamera();
		}
	}

	public function updateExternalLayerPositions() {
		var _loc1_:Sprite = null;
		for (_tmp_ in this.externalLayers) {
			_loc1_ = _tmp_;
			_loc1_.x = this.x;
			_loc1_.y = this.y;
		}
	}

	public function updateExternalLayerScales() {
		var _loc1_:Sprite = null;
		for (_tmp_ in this.externalLayers) {
			_loc1_ = _tmp_;
			_loc1_.scaleX = this.scaleX;
			_loc1_.scaleY = this.scaleY;
		}
	}

	public function updateCamera() {
		this.scaleX = !!G.mirrored ? -this.currentZoom : this.currentZoom;
		this.scaleY = this.currentZoom;
		this.updateExternalLayerScales();
		this.updateBGScroll();
		var _loc1_ = Math.max(200, 370 - this.currentZoom * 200);
		if (G.mirrored) {
			_loc1_ = G.screenSize.x - _loc1_;
		}
		this.aimCamera(_loc1_, 50);
		this.x = this.camera.x;
		this.y = this.camera.y;
		this.updateExternalLayerPositions();
	}

	public function updateBGScroll() {
		G.bg.y = Math.min(0, Math.max(this.bgYLimit, -40 / (this.currentZoom - 0.264) + 68));
	}

	public function zoomTo(param1:Float, param2:Bool = false) {
		G.sceneZoom = param1;
		param1 += 0.4;
		this.targetZoom = param1;
		if (param2) {
			this.currentZoom = this.targetZoom;
			this.updateCamera();
			this.zooming = false;
		} else {
			this.zooming = true;
		}
	}

	public function zoomIn(param1:Float = 0.25) {
		var _loc2_ = Math.max(0.05, G.sceneZoom * G.sceneZoom * param1);
		this.zoomTo(Math.min(1, G.sceneZoom + _loc2_));
		G.inGameMenu.updateZoomSlider();
	}

	public function zoomOut(param1:Float = 0.25) {
		var _loc2_ = Math.max(0.05, G.sceneZoom * G.sceneZoom * param1);
		this.zoomTo(Math.max(0, G.sceneZoom - _loc2_));
		G.inGameMenu.updateZoomSlider();
	}

	public function aimCamera(param1:Float, param2:Float) {
		this.camera = new Point(param1, param2);
		this.x = this.camera.x;
		this.y = this.camera.y;
	}

	public function shake(param1:Float) {
		this.magnitude.x = Math.random() * Math.min(9 * this.currentZoom, param1 * this.currentZoom);
		this.magnitude.y = 0;
		this.shaking = true;
	}
}
