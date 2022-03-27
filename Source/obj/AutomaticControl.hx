package obj;

import openfl.geom.Point;

class AutomaticControl {
	public static var autoModeNameList:Array<String> = ["Normal", "Soft", "Hard", "Self"];

	public var t:UInt = 0;
	public var nextModeTimer:Int = 0;
	public var randomMode:ASFunction;
	public var transitioning:Bool = false;
	public var transitionSpeed:Float = 0.01;
	public var modeRatio:Float = Math.NaN;
	public var currentPos:Point = new Point(0, 0);
	public var lastPos:Point = new Point(0, 0);
	public var currentPenisTipPos:Float = 0;
	public var fullLength:Float = 1.0;
	public var lastMode:ASFunction;
	public var currentMode:ASFunction;
	public var singleAction:ASFunction;
	public var waitingForSingleAction:Bool = false;
	public var singleActionTimer:UInt = 0;
	public var singleActionTime:UInt = 0;
	public var standardModes:Array<ASFunction>;
	public var softModes:Array<ASFunction>;
	public var hardModes:Array<ASFunction>;
	public var selfModes:Array<ASFunction>;
	public var standardHJModes:Array<ASFunction>;
	public var softHJModes:Array<ASFunction>;
	public var hardHJModes:Array<ASFunction>;
	public var selfHJModes:Array<ASFunction>;
	public var currentSelfModes:Array<ASFunction>;
	public var singleActions:Array<ASFunction>;
	public var happySingleActions:Array<ASFunction>;
	public var singleActionModes:ASDictionary<ASFunction, ASFunction>;
	public var lastModeNo:UInt = 0;
	public var offTilt:Float = 0;
	public var offTiltTarget:Float = 0;
	public var offTiltChangeTimer:UInt = 0;
	public var ejaculatingModes:Array<ASFunction>;
	public var normalEjacModes:Array<ASFunction>;
	public var hardEjacModes:Array<ASFunction>;
	public var softEjacModes:Array<ASFunction>;
	public var selfEjacModes:Array<ASFunction>;
	public var lastEjacMode:ASFunction;
	public var deepthroatTarget:Float = 0;
	public var deepthroatProgress:Float = 0;
	public var usingDeepSlow:Bool = false;
	public var usingFullSlow:Bool = false;

	public function new() {
		this.standardModes = new Array<ASFunction>();
		this.standardModes[0] = this.holdDown;
		this.standardModes[1] = this.activeHoldDown;
		this.standardModes[2] = this.offHold;
		this.standardModes[3] = this.fullSlow;
		this.standardModes[4] = this.fullFast;
		this.standardModes[5] = this.deepFast;
		this.standardModes[6] = this.shallowSlow;
		this.standardModes[7] = this.shallowMedium;
		this.standardModes[8] = this.shallowFast;
		this.standardModes[9] = this.mediumSlow;
		this.standardModes[10] = this.tipToDeepMedium;
		this.standardModes[11] = this.mediumFast;
		this.softModes = new Array<ASFunction>();
		this.softModes[0] = this.offHold;
		this.softModes[1] = this.shallowSlow;
		this.softModes[2] = this.shallowMedium;
		this.softModes[3] = this.mediumSlow;
		this.softModes[4] = this.tipToDeepMedium;
		this.softModes[5] = this.tipToDeepSlow;
		this.hardModes = new Array<ASFunction>();
		this.hardModes[0] = this.holdDown;
		this.hardModes[1] = this.activeHoldDown;
		this.hardModes[2] = this.offHold;
		this.hardModes[3] = this.fullFast;
		this.hardModes[4] = this.deepFast;
		this.hardModes[5] = this.shallowFast;
		this.hardModes[6] = this.mediumFast;
		this.hardModes[7] = this.tipToDeepFast;
		this.hardModes[8] = this.fullSlam;
		this.hardModes[9] = this.hiltMove;
		this.selfModes = new Array<ASFunction>();
		this.selfModes[0] = this.offHold;
		this.selfModes[1] = this.shallowSlow;
		this.selfModes[2] = this.shallowMedium;
		this.selfModes[3] = this.shallowMedium;
		this.selfModes[4] = this.mediumSlow;
		this.selfModes[5] = this.tipToDeepSlow;
		this.selfModes[6] = this.tipToDeepMedium;
		this.selfModes[7] = this.tipToDeepMedium;
		this.selfModes[8] = this.tipHold;
		this.selfModes[9] = this.outsideLickBalls;
		this.standardHJModes = new Array<ASFunction>();
		this.standardHJModes[0] = this.fullSlow;
		this.standardHJModes[1] = this.fullFast;
		this.standardHJModes[2] = this.deepFast;
		this.standardHJModes[3] = this.shallowSlow;
		this.standardHJModes[4] = this.shallowMedium;
		this.standardHJModes[5] = this.shallowFast;
		this.standardHJModes[6] = this.mediumSlow;
		this.standardHJModes[7] = this.tipToDeepMedium;
		this.standardHJModes[8] = this.mediumFast;
		this.softHJModes = new Array<ASFunction>();
		this.softHJModes[0] = this.shallowSlow;
		this.softHJModes[1] = this.shallowMedium;
		this.softHJModes[2] = this.mediumSlow;
		this.softHJModes[3] = this.tipToDeepMedium;
		this.softHJModes[4] = this.tipToDeepSlow;
		this.hardHJModes = new Array<ASFunction>();
		this.hardHJModes[0] = this.fullFast;
		this.hardHJModes[1] = this.deepFast;
		this.hardHJModes[2] = this.shallowFast;
		this.hardHJModes[3] = this.mediumFast;
		this.hardHJModes[4] = this.tipToDeepFast;
		this.hardHJModes[5] = this.fullSlam;
		this.selfHJModes = new Array<ASFunction>();
		this.selfHJModes[0] = this.shallowSlow;
		this.selfHJModes[1] = this.shallowMedium;
		this.selfHJModes[2] = this.shallowMedium;
		this.selfHJModes[3] = this.mediumSlow;
		this.selfHJModes[4] = this.tipToDeepSlow;
		this.selfHJModes[5] = this.tipToDeepMedium;
		this.selfHJModes[6] = this.tipToDeepMedium;
		this.singleActions = new Array<ASFunction>();
		this.singleActions[0] = this.oneDeep;
		this.happySingleActions = new Array<ASFunction>();
		this.happySingleActions[0] = this.waggleEyebrows;
		this.happySingleActions[1] = this.waggleEyebrowsWithTongue;
		this.happySingleActions[2] = this.oneDeep;
		this.singleActionModes = new ASDictionary<ASFunction, ASFunction>();
		this.singleActionModes[this.waggleEyebrows] = this.offHold;
		this.singleActionModes[this.waggleEyebrowsWithTongue] = this.offHold;
		this.singleActionModes[this.oneDeep] = this.offHold;
		this.normalEjacModes = new Array<ASFunction>();
		this.normalEjacModes[0] = this.activeHoldDown;
		this.normalEjacModes[1] = this.shallowHold;
		this.normalEjacModes[2] = this.offHold;
		this.normalEjacModes[3] = this.offHold;
		this.softEjacModes = new Array<ASFunction>();
		this.softEjacModes[0] = this.shallowHold;
		this.softEjacModes[1] = this.offHold;
		this.softEjacModes[2] = this.offHold;
		this.hardEjacModes = new Array<ASFunction>();
		this.hardEjacModes[0] = this.activeHoldDown;
		this.hardEjacModes[1] = this.shallowHold;
		this.hardEjacModes[2] = this.offHold;
		this.hardEjacModes[3] = this.offHold;
		this.hardEjacModes[4] = this.hiltMove;
		this.selfEjacModes = new Array<ASFunction>();
		this.selfEjacModes[0] = this.tipHold;
		this.selfEjacModes[1] = this.shallowHold;
		this.selfEjacModes[2] = this.offHold;
		this.selfEjacModes[3] = this.offHold;
		this.currentMode = this.noMovement;
		this.ejaculatingModes = this.normalEjacModes;
		this.randomMode = this.standardAuto;
		EventBus.addListener("penisTipPosChanged", this.updatePenisTipPos);
	}

	public function updatePenisTipPos() {
		this.currentPenisTipPos = G.animationControl.estimateTipPos();
		this.fullLength = 1 - this.currentPenisTipPos;
	}

	public function findAutoMode(param1:String) {
		var _loc2_:UInt = autoModeNameList.length;
		var _loc3_:UInt = 0;
		while (_loc3_ < _loc2_) {
			if (param1 == autoModeNameList[_loc3_]) {
				G.setAuto(_loc3_);
				G.inGameMenu.updateAutoList();
				break;
			}
			_loc3_++;
		}
	}

	public function reducePleasureLoss():Bool {
		if (G.autoModeOn && this.randomMode == this.softAuto) {
			return true;
		}
		return false;
	}

	public function resetSelfMode() {
		this.currentSelfModes = this.selfModes.slice(0);
		this.usingDeepSlow = false;
		this.usingFullSlow = false;
		this.deepthroatProgress = this.currentPenisTipPos + 0.4;
	}

	public function startAuto(param1:Point) {
		this.t = 0;
		this.lastPos = param1;
		if (G.autoModeOn) {
			switch (G.autoMode) {
				case 0:
					G.him.setArmPosition(0);
					this.randomMode = this.standardAuto;
					this.ejaculatingModes = this.normalEjacModes;

				case 1:
					G.him.setArmPosition(0);
					this.randomMode = this.softAuto;
					this.ejaculatingModes = this.softEjacModes;

				case 2:
					G.him.setArmPosition(0);
					this.randomMode = this.hardAuto;
					this.ejaculatingModes = this.hardEjacModes;

				case 3:
					G.him.setArmPosition(1);
					this.randomMode = this.handsOffAuto;
					this.ejaculatingModes = this.selfEjacModes;

				default:
					G.him.setArmPosition(0);
					this.randomMode = this.standardAuto;
					this.ejaculatingModes = this.normalEjacModes;
			}
			this.runRandomMode();
			G.inGameMenu.updateHisArmList();
		} else {
			G.him.resetArmPosition();
		}
	}

	public function runRandomMode() {
		G.her.movementRelease();
		this.randomMode();
	}

	public function dialogueStarting() {
		if (this.randomMode == this.handsOffAuto) {
			this.handsOffAuto();
		}
	}

	public function ejaculate() {
		if (G.autoModeOn) {
			this.randomEjaculatingMode();
		}
	}

	public function doneEjaculating() {
		this.nextModeTimer = Math.floor(Math.random() * 90 + 60);
	}

	public function standardAuto() {
		var _loc2_:UInt = 0;
		this.lastMode = this.currentMode;
		var _loc1_ = !!G.handJobMode ? this.standardHJModes : this.standardModes;
		if (G.her.isActingOff()) {
			this.lastModeNo = 2;
			this.currentMode = _loc1_[2];
		} else {
			do {
				if (G.her.intro) {
					_loc2_ = Std.int(Math.ffloor(Math.random() * (_loc1_.length - 2)) + 2);
				} else {
					_loc2_ = Math.floor(Math.random() * _loc1_.length);
				}
			} while (_loc2_ == this.lastModeNo);

			this.lastModeNo = _loc2_;
			this.currentMode = _loc1_[_loc2_];
		}
		if (this.currentMode == this.offHold) {
			this.nextModeTimer = Math.floor(Math.random() * 120 + 60);
		} else {
			this.nextModeTimer = Math.floor(Math.random() * 300 + 60);
		}
		this.modeRatio = 0;
		this.transitioning = true;
		this.transitionSpeed = 0.01;
	}

	public function hardAuto() {
		var _loc2_:UInt = 0;
		this.lastMode = this.currentMode;
		var _loc1_ = !!G.handJobMode ? this.hardHJModes : this.hardModes;
		if (G.her.isActingOff()) {
			this.lastModeNo = 2;
			this.currentMode = _loc1_[2];
		} else {
			do {
				if (G.her.intro) {
					_loc2_ = Std.int(Math.ffloor(Math.random() * (_loc1_.length - 2)) + 2);
				} else {
					_loc2_ = Math.floor(Math.random() * _loc1_.length);
				}
			} while (_loc2_ == this.lastModeNo);

			this.lastModeNo = _loc2_;
			this.currentMode = _loc1_[_loc2_];
		}
		if (this.currentMode == this.offHold) {
			this.nextModeTimer = Math.floor(Math.random() * 60 + 30);
		} else {
			this.nextModeTimer = Math.floor(Math.random() * 150 + 60);
		}
		this.modeRatio = 0;
		this.transitioning = true;
		this.transitionSpeed = 0.25;
	}

	public function softAuto() {
		var _loc2_:UInt = 0;
		this.lastMode = this.currentMode;
		var _loc1_ = !!G.handJobMode ? this.softHJModes : this.softModes;
		if (G.her.isActingOff()) {
			this.lastModeNo = 0;
			this.currentMode = _loc1_[0];
		} else if (!G.handJobMode && Math.random() > 0.8) {
			this.singleAction = this.oneDeep;
			this.currentMode = this.offHold;
			this.waitingForSingleAction = true;
		} else if (!G.handJobMode && G.breathLevel > G.outOfBreathPoint) {
			this.currentMode = this.offHold;
		} else {
			do {
				_loc2_ = Math.floor(Math.random() * _loc1_.length);
			} while (_loc2_ == this.lastModeNo);

			this.lastModeNo = _loc2_;
			this.currentMode = _loc1_[_loc2_];
		}
		if (this.currentMode == this.offHold) {
			this.nextModeTimer = Math.floor(Math.random() * 120 + 60);
		} else {
			this.nextModeTimer = Math.floor(Math.random() * 300 + 60);
		}
		this.modeRatio = 0;
		this.transitioning = true;
		this.transitionSpeed = 0.01;
	}

	public function handsOffAuto() {
		var _loc2_:UInt = 0;
		this.lastMode = this.currentMode;
		var _loc1_ = !!G.handJobMode ? this.selfHJModes : this.selfModes;
		if (G.her.isActingOff()) {
			this.lastModeNo = 0;
			this.currentMode = _loc1_[0];
		} else if (!G.handJobMode && Math.random() > (!!this.usingFullSlow ? 0.9 : 0.6)) {
			if (Math.random() > 0.99) {
				this.singleAction = this.waggleEyebrowsWithTongue;
			} else {
				this.singleAction = this.oneDeep;
			}
			this.currentMode = this.singleActionModes[this.singleAction];
			this.waitingForSingleAction = true;
			this.lastModeNo = 1;
		} else if (!G.handJobMode && Math.random() > 0.8) {
			_loc2_ = Math.floor(Math.random() * this.singleActions.length);
			this.singleAction = this.singleActions[_loc2_];
			this.currentMode = this.singleActionModes[this.singleAction];
			this.waitingForSingleAction = true;
		} else if (G.breathLevel > G.outOfBreathPoint) {
			this.currentMode = this.offHold;
			this.lastModeNo = 0;
		} else {
			do {
				_loc2_ = Math.floor(Math.random() * this.currentSelfModes.length);
			} while (_loc2_ == this.lastModeNo);

			this.lastModeNo = _loc2_;
			this.currentMode = this.currentSelfModes[_loc2_];
		}
		if (this.currentMode == this.offHold) {
			this.nextModeTimer = Math.floor(Math.random() * 60 + 30);
		} else if (this.currentMode == this.tipHold || this.currentMode == this.shallowHold) {
			this.nextModeTimer = Math.floor(Math.random() * 150 + 30);
		} else {
			this.nextModeTimer = Math.floor(Math.random() * 300 + 60);
		}
		this.modeRatio = 0;
		this.transitioning = true;
		this.transitionSpeed = 0.01;
	}

	public function randomOffTilt() {
		this.offTiltTarget = Math.random() * 1.4 - 0.9;
		this.offTiltChangeTimer = Math.floor(Math.random() * 300 + 60);
	}

	public function randomEjaculatingMode() {
		var _loc1_:UInt = 0;
		this.lastMode = this.currentMode;
		do {
			_loc1_ = Math.floor(Math.random() * this.ejaculatingModes.length);
		} while (this.ejaculatingModes[_loc1_] == this.lastEjacMode);

		this.currentMode = this.ejaculatingModes[_loc1_];
		this.lastEjacMode = this.currentMode;
		this.nextModeTimer = 600;
		this.modeRatio = 0;
		this.transitioning = true;
		this.transitionSpeed = 0.05;
	}

	public function getPos():Point {
		var _loc1_:Point = null;
		var _loc2_:Point = null;
		++this.t;
		if (G.her.released && !G.handsOff) {
			this.lastPos.x = Math.max(0, this.lastPos.x - 0.1);
			this.lastPos.y *= 0.8;
		} else if (this.transitioning) {
			this.modeRatio += this.transitionSpeed;
			if (this.modeRatio >= 1) {
				if (this.waitingForSingleAction) {
					this.waitingForSingleAction = false;
					this.singleAction();
				} else {
					this.singleActionTime = 0;
				}
				this.singleActionTimer = 0;
				this.transitioning = false;
				this.modeRatio = 1;
			}
			_loc1_ = this.lastMode().clone();
			_loc2_ = this.currentMode();
			this.lastPos.x = _loc1_.x * (1 - this.modeRatio) + _loc2_.x * this.modeRatio;
			this.lastPos.y = _loc1_.y * (1 - this.modeRatio) + _loc2_.y * this.modeRatio;
		} else {
			this.lastPos = this.currentMode().clone();
			if (this.singleActionTimer < this.singleActionTime) {
				++this.singleActionTimer;
			} else if (this.nextModeTimer > 0) {
				--this.nextModeTimer;
			} else {
				this.runRandomMode();
			}
		}
		this.offTilt += (this.offTiltTarget - this.offTilt) * 0.2;
		if (this.offTiltChangeTimer > 0) {
			--this.offTiltChangeTimer;
		} else {
			this.randomOffTilt();
		}
		this.deepthroatProgress = Math.max(this.deepthroatProgress, this.lastPos.x);
		if (G.handJobMode) {
			this.lastPos.x = this.lastPos.x * 0.9 + 0.1;
		}
		return this.lastPos;
	}

	public function adjustAim() {
		var _loc1_ = Math.NaN;
		if (ASCompat.thisOrDefault(G.her.isInMouth(), G.handJobMode)) {
			this.currentPos.y *= 0.8;
		} else {
			_loc1_ = G.her.getPenisMouthOffset();
			if (Math.abs(_loc1_) < 5) {
				return;
			}
			this.currentPos.y += Math.max(-0.5, Math.min(0.5, _loc1_ * Math.min(0.3, 10 * Math.abs(this.lastPos.x - this.currentPos.x))));
		}
	}

	public function avoidPenisOut() {
		if (!this.transitioning) {
			G.her.movementRelease();
			this.currentPos.x = Math.max(-0.2, this.currentPenisTipPos - 0.2);
			this.adjustAim();
		}
	}

	public function sinWave(param1:Float, param2:Float, param3:Float):Float {
		return param3 + (Math.sin(this.t * param1) + 1) * param2 * 0.5;
	}

	public function noMovement():Point {
		if (G.penisOut) {
			this.avoidPenisOut();
			return this.currentPos;
		}
		this.currentPos.x = this.currentPenisTipPos - 0.2;
		this.currentPos.y = this.lastPos.y * 0.8;
		return this.currentPos;
	}

	public function fullSlow():Point {
		if (G.penisOut) {
			this.avoidPenisOut();
			return this.currentPos;
		}
		this.currentPos.x = Math.max(this.currentPenisTipPos - 0.3, this.sinWave(0.06, this.fullLength + 0.6, this.currentPenisTipPos - 0.4));
		if (this.currentPos.x - this.lastPos.x < 0) {
			this.currentPos.y = this.offTilt * (Math.cos(this.t * 0.06) * 0.5 + 0.5);
		} else {
			this.adjustAim();
		}
		return this.currentPos;
	}

	public function fullFast():Point {
		if (G.penisOut) {
			this.avoidPenisOut();
			return this.currentPos;
		}
		this.currentPos.x = this.sinWave(0.25, this.fullLength + 0.2, this.currentPenisTipPos);
		this.currentPos.y = Math.min(0.2, Math.max(-0.2, this.offTilt));
		return this.currentPos;
	}

	public function deepFast():Point {
		if (G.penisOut) {
			this.avoidPenisOut();
			return this.currentPos;
		}
		this.currentPos.x = this.sinWave(0.5, this.fullLength - 0.1, 1.25 - this.fullLength);
		this.adjustAim();
		return this.currentPos;
	}

	public function deepSlow():Point {
		if (G.penisOut) {
			this.avoidPenisOut();
			return this.currentPos;
		}
		this.currentPos.x = this.sinWave(0.25, this.fullLength - 0.1, 1.15 - this.fullLength);
		this.adjustAim();
		return this.currentPos;
	}

	public function shallowSlow():Point {
		if (G.penisOut) {
			this.avoidPenisOut();
			return this.currentPos;
		}
		this.currentPos.x = this.sinWave(0.25, Math.min(0.5, this.fullLength - 0.3), this.currentPenisTipPos + 0.05);
		if (this.currentPos.x - this.lastPos.x < 0 && G.her.isInMouth()) {
			this.currentPos.y = this.offTilt;
			if (this.randomMode == this.handsOffAuto) {
				G.her.suck();
				G.him.givePleasure(7);
			}
		} else {
			this.adjustAim();
		}
		return this.currentPos;
	}

	public function shallowMedium():Point {
		if (G.penisOut) {
			this.avoidPenisOut();
			return this.currentPos;
		}
		this.currentPos.x = this.sinWave(0.35, this.fullLength - 0.3, this.currentPenisTipPos + 0.05);
		if (this.currentPos.x - this.lastPos.x < 0 && G.her.isInMouth()) {
			this.currentPos.y = this.offTilt;
			if (this.randomMode == this.handsOffAuto) {
				G.her.suck();
				G.him.givePleasure(7);
			}
		} else {
			this.adjustAim();
		}
		return this.currentPos;
	}

	public function shallowFast():Point {
		if (G.penisOut) {
			this.avoidPenisOut();
			return this.currentPos;
		}
		this.currentPos.x = this.sinWave(0.5, this.fullLength - 0.3, this.currentPenisTipPos + 0.05);
		this.currentPos.y = Math.min(0.2, Math.max(-0.2, this.offTilt));
		return this.currentPos;
	}

	public function mediumSlow():Point {
		if (G.penisOut) {
			this.avoidPenisOut();
			return this.currentPos;
		}
		this.currentPos.x = Math.max(0, this.sinWave(0.05, this.fullLength + 0.1, this.currentPenisTipPos - 0.2));
		if (this.currentPos.x - this.lastPos.x < 0 && G.her.isInMouth()) {
			this.currentPos.y = this.offTilt;
			if (this.randomMode == this.handsOffAuto) {
				G.her.suck();
				G.him.givePleasure(7);
			}
		} else {
			this.adjustAim();
		}
		return this.currentPos;
	}

	public function tipToDeepSlow():Point {
		if (G.penisOut) {
			this.avoidPenisOut();
			return this.currentPos;
		}
		this.currentPos.x = Math.max(0, this.sinWave(0.08, this.fullLength - 0.1, this.currentPenisTipPos + 0.1));
		if (this.currentPos.x - this.lastPos.x < 0 && G.her.isInMouth()) {
			this.currentPos.y = this.offTilt;
		} else {
			this.adjustAim();
		}
		return this.currentPos;
	}

	public function tipToDeepMedium():Point {
		if (G.penisOut) {
			this.avoidPenisOut();
			return this.currentPos;
		}
		this.currentPos.x = Math.max(0, this.sinWave(0.2, this.fullLength - 0.1, this.currentPenisTipPos + 0.1));
		if (this.currentPos.x - this.lastPos.x < 0 && G.her.isInMouth()) {
			this.currentPos.y = this.offTilt;
		} else {
			this.adjustAim();
		}
		return this.currentPos;
	}

	public function tipToDeepFast():Point {
		if (G.penisOut) {
			this.avoidPenisOut();
			return this.currentPos;
		}
		this.currentPos.x = Math.max(0, this.sinWave(0.35, this.fullLength - 0.1, this.currentPenisTipPos + 0.1));
		this.adjustAim();
		return this.currentPos;
	}

	public function mediumFast():Point {
		if (G.penisOut) {
			this.avoidPenisOut();
			return this.currentPos;
		}
		this.currentPos.x = this.sinWave(0.25, this.fullLength, this.currentPenisTipPos - 0.2);
		if (this.currentPos.x - this.lastPos.x < 0 && G.her.isInMouth()) {
			this.currentPos.y = this.offTilt;
		} else {
			this.adjustAim();
		}
		return this.currentPos;
	}

	public function fullSlam():Point {
		if (G.penisOut) {
			this.avoidPenisOut();
			return this.currentPos;
		}
		var _loc1_ = Math.max(this.currentPenisTipPos - 0.2, Math.min(1.25, 1.5 * Math.fceil(this.t * 0.05) - this.t * 0.05 * 1.5));
		this.currentPos.x = Math.min(this.lastPos.x + 0.5, _loc1_);
		this.adjustAim();
		return this.currentPos;
	}

	public function hiltMove():Point {
		if (G.penisOut) {
			this.avoidPenisOut();
			return this.currentPos;
		}
		if (G.her.currentPenisDistance > G.her.currentHiltDistance) {
			this.currentPos.x = this.lastPos.x + Math.random() * 0.04 - 0.02;
		} else {
			this.currentPos.x = Math.min(this.lastPos.x + 0.1, 1.2);
		}
		if (Math.random() > 0.6) {
			G.her.activeHold(false);
		}
		this.adjustAim();
		return this.currentPos;
	}

	public function holdDown():Point {
		if (G.penisOut) {
			this.avoidPenisOut();
			return this.currentPos;
		}
		if (Math.random() > 0.99) {
			G.her.activeHold(false);
		}
		this.currentPos.x = Math.min(this.lastPos.x + 0.1, 1.2);
		this.adjustAim();
		return this.currentPos;
	}

	public function activeHoldDown():Point {
		if (G.penisOut) {
			this.avoidPenisOut();
			return this.currentPos;
		}
		if (Math.random() > 0.6) {
			G.her.activeHold(false);
		}
		this.currentPos.x = 1.2;
		this.adjustAim();
		return this.currentPos;
	}

	public function singleDeepthroat():Point {
		if (G.penisOut) {
			this.avoidPenisOut();
			return this.currentPos;
		}
		this.currentPos.x = Math.min(this.deepthroatTarget, this.lastPos.x + 0.02);
		G.him.givePleasure(5);
		if (this.currentPos.x == this.deepthroatTarget) {
			this.currentPos.x += Math.random() * 0.01 - 0.005;
			G.her.wince();
		}
		if (this.singleActionTimer / this.singleActionTime > 0.8) {
			this.currentMode = this.moveOff;
			G.her.lookUp();
		}
		this.adjustAim();
		return this.currentPos;
	}

	public function shallowHold():Point {
		if (G.penisOut) {
			this.avoidPenisOut();
			return this.currentPos;
		}
		this.currentPos.x = this.sinWave(0.1, 0.05, this.currentPenisTipPos + 0.75);
		this.adjustAim();
		return this.currentPos;
	}

	public function offHold():Point {
		this.currentPos.x = Math.max(-0.2, this.sinWave(0.1, 0.05, this.currentPenisTipPos - 0.3));
		this.currentPos.y = this.offTilt;
		if (G.her.isActingOff()) {
			++this.nextModeTimer;
		}
		return this.currentPos;
	}

	public function moveOff():Point {
		this.currentPos.x = Math.max(this.currentPenisTipPos - 0.2, this.lastPos.x - 0.03);
		this.currentPos.y = this.offTilt;
		return this.currentPos;
	}

	public function offHoldWithTongue():Point {
		this.currentPos.x = Math.max(-0.2, this.sinWave(0.1, 0.05, this.currentPenisTipPos - 0.3));
		this.currentPos.y = this.offTilt;
		G.her.tongueContainer.tongue.encourage();
		return this.currentPos;
	}

	public function tipHold():Point {
		var _loc1_:Float = G.her.getPenisMouthDist() + 10;
		this.currentPos.x -= _loc1_ * 0.001;
		this.currentPos.y = this.offTilt;
		G.her.tongueContainer.tongue.encourage();
		return this.currentPos;
	}

	public function outsideLickBalls():Point {
		if (this.transitioning) {
			this.currentPos.x = Math.max(this.currentPenisTipPos - 0.2, this.lastPos.x - 0.03);
		} else if (G.penisOut) {
			if (G.him.currentBalls > 0) {
				this.currentPos.x = Math.min(1, this.lastPos.x + 0.03);
				this.currentPos.y = this.lastPos.y + (0.8 + Math.random() * 0.2 - this.lastPos.y) * 0.1;
			} else {
				this.currentPos.x = this.sinWave(0.073, this.fullLength - 0.3, this.currentPenisTipPos + 0.3);
				this.currentPos.y = this.sinWave(0.04, 0.6, -0.2);
			}
			G.her.tongueContainer.tongue.encourage();
		} else {
			this.currentPos.x = Math.max(this.currentPenisTipPos - 0.2, this.lastPos.x - 0.03);
			this.currentPos.y = this.offTilt;
			G.her.mousePressed();
		}
		return this.currentPos;
	}

	public function waggleEyebrows() {
		this.nextModeTimer = 0;
		this.singleActionTime = 25;
		G.her.waggleEyebrows();
	}

	public function waggleEyebrowsWithTongue() {
		this.nextModeTimer = 0;
		this.singleActionTime = 25;
		G.her.waggleEyebrows();
		G.her.tongueContainer.tongue.encourage(50);
	}

	public function oneDeep() {
		this.nextModeTimer = 0;
		this.singleActionTime = 120;
		this.deepthroatTarget = Math.random() * 0.1 + 0.1 + this.deepthroatProgress;
		if (G.her.currentPenisDistance > G.her.deepthroatDistance && !this.usingDeepSlow) {
			this.usingDeepSlow = true;
			this.currentSelfModes.push(this.deepSlow);
		}
		if (G.her.currentPenisDistance > G.her.currentHiltDistance && !this.usingFullSlow) {
			this.usingFullSlow = true;
			this.currentSelfModes.push(this.fullSlow);
		}
		this.currentMode = this.singleDeepthroat;
		G.her.lookDown();
	}
}
