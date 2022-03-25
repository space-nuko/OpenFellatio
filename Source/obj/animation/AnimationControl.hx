package obj.animation;

import flash.geom.Matrix;
import flash.geom.Point;
import obj.EventBus;

class AnimationControl {
	public static var DEFAULT:String = "default";
	public static var FACE_FUCK:String = "face_fuck";

	public var currentAnimation:String = "default";

	public var animations:ASDictionary<String, MainAnimation>;
	public var linearPenisOutTransition:Float = 0;
	public var smoothedPenisOutTransition:Float = 0;

	public function new() {
		/*
		 * Decompilation error
		 * Code may be obfuscated
		 * Tip: You can try enabling "Automatic deobfuscation" in Settings
		 * Error type: NullPointerException (null)
		 */
	}

	public function stepAnimation() {
		var _loc1_:Float = G.her.move(G.currentPos.x, G.currentPos.y);
		G.herCurrentPos = _loc1_;
		G.him.move(_loc1_, G.currentPos.x, G.currentPos.y);
		G.her.updateArms();
	}

	public function setAnimation(param1:String) {
		this.currentAnimation = param1;
		this.dispatchUpdates();
		this.stepAnimation();
	}

	public function loadStyle(param1:String) {
		if (this.animations.exists(param1)) {
			this.currentAnimation = param1;
			this.dispatchUpdates();
		}
	}

	public function dispatchUpdates() {
		G.him.animationChanged();
		G.her.updateKneeTarget();
		EventBus.dispatch("penisTipPosChanged");
	}

	@:flash.property public var currentAnimationID(get, never):UInt;

	function get_currentAnimationID():UInt {
		if (this.currentAnimation == FACE_FUCK) {
			return 2;
		}
		return 1;
	}

	@:flash.property public var currentAnimationName(get, never):String;

	function get_currentAnimationName():String {
		return this.currentAnimation;
	}

	public function debugSetLeftFoot(param1:Point) {
		this.animations[this.currentAnimation].hisLeftFootTarget = param1;
		G.him.animationChanged();
	}

	public function debugSetRightFoot(param1:Point) {
		this.animations[this.currentAnimation].hisRightFootTarget = param1;
		G.him.animationChanged();
	}

	public function update() {
		if (G.penisOut && this.linearPenisOutTransition < 1) {
			this.linearPenisOutTransition = Math.min(1, this.linearPenisOutTransition + 0.1);
			this.smoothedPenisOutTransition = (1 - Math.cos(this.linearPenisOutTransition * Math.PI)) * 0.5;
		} else if (!G.penisOut && this.linearPenisOutTransition > 0) {
			this.linearPenisOutTransition = Math.max(0, this.linearPenisOutTransition - 0.1);
			this.smoothedPenisOutTransition = (1 - Math.cos(this.linearPenisOutTransition * Math.PI)) * 0.5;
		}
	}

	@:flash.property public var penisOutTransition(get, never):Float;

	function get_penisOutTransition():Float {
		return this.smoothedPenisOutTransition;
	}

	public function estimateTipPos():Float {
		return this.animations[this.currentAnimation].estimateTipPos;
	}

	public function getHerMatrix(param1:Float, param2:Float):Matrix {
		var _loc3_:MainAnimation = this.animations[this.currentAnimation];
		var _loc4_:Matrix;
		(_loc4_ = _loc3_.getHerMatrix(param1,
			param2 * Math.max(this.smoothedPenisOutTransition,
				Math.max(0, param1 * 2 - 0.5)))).translate(0, -G.him.currentPenisBaseWidth * 0.5 * (param1 > 0 ? param1 : 0));
		var _loc5_ = new Point(_loc4_.tx - _loc3_.herKneeTarget.x, _loc4_.ty - _loc3_.herKneeTarget.y);
		var _loc6_ = Math.sqrt(_loc5_.x * _loc5_.x + _loc5_.y * _loc5_.y);
		var _loc7_ = 1100 * G.her.bodyScale;
		if (_loc6_ > _loc7_) {
			_loc5_.x *= _loc7_ / _loc6_;
			_loc5_.y *= _loc7_ / _loc6_;
			_loc4_.tx = _loc3_.herKneeTarget.x + _loc5_.x;
			_loc4_.ty = _loc3_.herKneeTarget.y + _loc5_.y;
		}
		return _loc4_;
	}

	public function getHerKneeTarget():Point {
		var _loc1_:MainAnimation = this.animations[this.currentAnimation];
		return _loc1_.herKneeTarget.clone();
	}

	public function getHisMatrix(param1:Float):Matrix {
		var _loc2_:MainAnimation = this.animations[this.currentAnimation];
		return _loc2_.getHisMatrix(param1);
	}

	public function getHisLeftFootTarget():Point {
		var _loc1_:MainAnimation = this.animations[this.currentAnimation];
		return _loc1_.hisLeftFootTarget.clone();
	}

	public function getHisRightFootTarget():Point {
		var _loc1_:MainAnimation = this.animations[this.currentAnimation];
		return _loc1_.hisRightFootTarget.clone();
	}

	@:flash.property public var torsoMinAng(get, never):Float;

	function get_torsoMinAng():Float {
		var _loc1_:MainAnimation = this.animations[this.currentAnimation];
		return _loc1_.torsoMinAng;
	}

	@:flash.property public var torsoStartAng(get, never):Float;

	function get_torsoStartAng():Float {
		var _loc1_:MainAnimation = this.animations[this.currentAnimation];
		return _loc1_.torsoStartAng;
	}

	@:flash.property public var torsoAngMultiplier(get, never):Float;

	function get_torsoAngMultiplier():Float {
		var _loc1_:MainAnimation = this.animations[this.currentAnimation];
		return _loc1_.torsoAngMultiplier;
	}

	@:flash.property public var torsoMinDist(get, never):Float;

	function get_torsoMinDist():Float {
		var _loc1_:MainAnimation = this.animations[this.currentAnimation];
		return _loc1_.torsoMinDist;
	}

	@:flash.property public var torsoStartDist(get, never):Float;

	function get_torsoStartDist():Float {
		var _loc1_:MainAnimation = this.animations[this.currentAnimation];
		return _loc1_.torsoStartDist;
	}

	@:flash.property public var torsoDistMultiplier(get, never):Float;

	function get_torsoDistMultiplier():Float {
		var _loc1_:MainAnimation = this.animations[this.currentAnimation];
		return _loc1_.torsoDistMultiplier;
	}
}
