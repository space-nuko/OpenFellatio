package obj.animation;

import openfl.geom.Matrix;
import openfl.geom.Point;
import obj.EventBus;

class AnimationControl {
	public static var DEFAULT:String = "default";
	public static var FACE_FUCK:String = "face_fuck";

	public var currentAnimation:String = "default";

	public var animations:ASDictionary<String, MainAnimation> = new ASDictionary();
	public var linearPenisOutTransition:Float = 0;
	public var smoothedPenisOutTransition:Float = 0;

	public function new() {
        var defaultAnimation = new MainAnimation();

        var defaultHer = new LinearTween();
        defaultHer.offsetStart(-40, 270, -15);
        defaultHer.offsetEnd(250, 367.3, -20);

        var defaultHim = new LinearTween();
        defaultHim.offsetStart(420, 135, -3);
        defaultHim.offsetEnd(340, 135);

        defaultAnimation.herTween = defaultHer;
        defaultAnimation.herKneeTarget = new Point(160, 1240);
        defaultAnimation.altVector = new Point(0, 1);
        defaultAnimation.altRange = 80;

        defaultAnimation.hisTween = defaultHim;
        defaultAnimation.hisLeftFootTarget = new Point(625, 1315);
        defaultAnimation.hisRightFootTarget = new Point(620, 1168);

        defaultAnimation.torsoMinAng = 4.3;
        defaultAnimation.torsoStartAng = 3.43;
        defaultAnimation.torsoAngMultiplier = 0.61;
        defaultAnimation.torsoMinDist = 180;
        defaultAnimation.torsoStartDist = 130;
        defaultAnimation.torsoDistMultiplier = 35;

        animations[DEFAULT] = defaultAnimation;

        var faceFuckAnimation: MainAnimation = new MainAnimation();

        var ffHer = new LinearTween();
        ffHer.offsetStart(35, 300, -15);
        ffHer.offsetEnd(145, 382.3, -20);

        var ffHim = new LinearTween();
        ffHim.offsetStart(470, 160, -3);
        ffHim.offsetEnd(235, 150);

        faceFuckAnimation.herTween = ffHer;
        faceFuckAnimation.herKneeTarget = new Point(20, 1240);
        faceFuckAnimation.altVector = new Point(0, 1);
        faceFuckAnimation.altRange = 80;

        faceFuckAnimation.hisTween = ffHim;
        faceFuckAnimation.hisLeftFootTarget = new Point(520, 1300);
        faceFuckAnimation.hisRightFootTarget = new Point(550, 1133);

        faceFuckAnimation.torsoMinAng = 4.3;
        faceFuckAnimation.torsoStartAng = 3.9;
        faceFuckAnimation.torsoAngMultiplier = 0.3;
        faceFuckAnimation.torsoMinDist = 180;
        faceFuckAnimation.torsoStartDist = 145;
        faceFuckAnimation.torsoDistMultiplier = 5;

        animations[FACE_FUCK] = faceFuckAnimation;
	}

	public function stepAnimation(deltaTime:Float = 0.0) {
		var _loc1_:Float = G.her.move(deltaTime, G.currentPos.x, G.currentPos.y);
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

	public function update(deltaTime:Float) {
		if (G.penisOut && this.linearPenisOutTransition < 1) {
			this.linearPenisOutTransition = Math.min(1, this.linearPenisOutTransition + 0.1 * deltaTime);
			this.smoothedPenisOutTransition = (1 - Math.cos(this.linearPenisOutTransition * Math.PI)) * 0.5;
		} else if (!G.penisOut && this.linearPenisOutTransition > 0) {
			this.linearPenisOutTransition = Math.max(0, this.linearPenisOutTransition - 0.1 * deltaTime);
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
