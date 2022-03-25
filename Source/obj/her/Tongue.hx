package obj.her;

import openfl.display.MovieClip;
import openfl.events.Event;
import openfl.geom.Point;
import obj.Maths;

@:rtti
@:access(swf.exporters.animate)
class Tongue extends openfl.display.MovieClip {
	public var tongueOut:Bool = false;
	public var tongueOutStartFrame:UInt = 3;
	public var tongueOutEndFrame:UInt = 33;
	public var mouthFull:Bool = false;
	public var mouthFullTimer:Float = 0;
	public var mouthFullTime:Int = 0;
	public var currentPos:Float = 0;
	public var nearTip:Bool = false;
	public var startedOff:Bool = false;
	public var playingAction:Bool = false;
	public var cumOnTongue:Int = 0;
	public var swallowTimer:UInt = 0;
	public var swallowTime:UInt = 0;
	public var increasedAction:UInt = 0;
	public var waitingForOut:Bool = false;
	public var waitingForIn:Bool = false;
	public var fastIn:Bool = false;
	public var waitingToTouch:Bool = false;
	public var tiltOffset:Float = 0;
	public var actionTimer:UInt = 0;
	public var nextActionTime:UInt = 0;
	public var nearTimer:UInt = 0;
	public var nearTime:UInt = 0;
	public var wiggleSpeed:Float = 0;
	public var nextAction:ASFunction = null;
	public var currentAction:ASFunction = null;
	public var offActions:Array<ASFunction>;
	public var tipActions:Array<ASFunction>;
	public var shaftActions:Array<ASFunction>;
	public var actionTime:UInt = 0;
	public var hangingOut:Bool = false;
	public var solidAction:ASDictionary<ASFunction, Bool>;
	public var tiltSpeeds:ASDictionary<ASFunction, Float>;
	public var pushPower:ASDictionary<ASFunction, Float>;

	@:keep public var piercingBack(default, null):MovieClip;
	@:keep public var tipPoint(default, null):MovieClip;
	@:keep public var piercing(default, null):MovieClip;

	public function new() {
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("FYA8BqNO2PenTmHMYgDK");
		var symbol = library.symbols.get(975);
		symbol.__initObject(library, this);

		this.nextActionTime = Std.int(Math.ffloor(Math.random() * 60) + 15);
		this.nearTime = Std.int(Math.fceil(Math.random() * 20) + 10);

		addFrameScript(75, this.frame76);
		addFrameScript(114, this.frame115);
		addFrameScript(138, this.frame139);
		addFrameScript(164, this.frame165);
		addFrameScript(188, this.frame189);
		addFrameScript(205, this.frame206);

		this.nextAction = this.doNothing;
		this.offActions = new Array<ASFunction>();
		this.offActions[0] = this.startMovingTongueIn;
		this.offActions[1] = this.startMovingTongueIn;
		this.offActions[2] = this.startMovingTongueIn;
		this.offActions[3] = this.startMovingTongueOut;
		this.offActions[4] = this.doNothing;
		this.offActions[5] = this.lick;
		this.offActions[6] = this.longLick;
		this.offActions[7] = this.smallLick;
		this.offActions[8] = this.tinyLick;
		this.offActions[9] = this.quickLick;
		this.shaftActions = new Array<ASFunction>();
		this.shaftActions[0] = this.startMovingTongueIn;
		this.shaftActions[1] = this.doNothing;
		this.shaftActions[2] = this.tinyLick;
		this.shaftActions[3] = this.shaftLick;
		this.tipActions = new Array<ASFunction>();
		this.tipActions[0] = this.lick;
		this.tipActions[1] = this.longLick;
		this.tipActions[2] = this.smallLick;
		this.tipActions[3] = this.tinyLick;
		this.tipActions[4] = this.quickLick;
		this.solidAction = new ASDictionary<ASFunction, Bool>();
		this.solidAction[this.startMovingTongueIn] = false;
		this.solidAction[this.startMovingTongueOut] = false;
		this.solidAction[this.doNothing] = false;
		this.solidAction[this.lick] = true;
		this.solidAction[this.longLick] = true;
		this.solidAction[this.smallLick] = true;
		this.solidAction[this.tinyLick] = true;
		this.solidAction[this.quickLick] = true;
		this.solidAction[this.shaftLick] = false;
		this.tiltSpeeds = new ASDictionary<ASFunction, Float>();
		this.tiltSpeeds[this.lick] = 0.3;
		this.tiltSpeeds[this.longLick] = 0.15;
		this.tiltSpeeds[this.smallLick] = 0.25;
		this.tiltSpeeds[this.tinyLick] = 0.25;
		this.tiltSpeeds[this.quickLick] = 0.3;
		this.pushPower = new ASDictionary<ASFunction, Float>();
		this.pushPower[this.lick] = -0.1;
		this.pushPower[this.longLick] = -0.1;
		this.pushPower[this.smallLick] = -0.05;
		this.pushPower[this.tinyLick] = -0.05;
		this.pushPower[this.quickLick] = -0.05;
		this.gotoAndStop("InDone");
		addEventListener(Event.ENTER_FRAME, this.tick);
	}

	public function tick(param1:Event) {
		this.updatePiercing();
	}

	public function setMouthFull(param1:Bool = true) {
		this.mouthFull = param1;
		this.mouthFullTimer = 0;
		this.mouthFullTime = Math.floor(Math.random() * 60);
	}

	public function encourage(param1:UInt = 5) {
		this.increasedAction = param1;
	}

	public function hangOut() {
		this.hangingOut = true;
		this.startMovingTongue("out");
	}

	public function stopHangingOut() {
		this.hangingOut = false;
		this.startFastIn();
	}

	public function startMovingTongue(param1:String) {
		if (param1 == "out") {
			if (G.tongue && !this.tongueOut && !G.her.isSpeaking() && !G.her.teethClenched) {
				this.waitingForIn = false;
				this.waitingForOut = true;
				this.mouthFullTimer = 0;
			}
		} else if (param1 == "in" && this.tongueOut) {
			this.waitingForIn = true;
			this.waitingForOut = false;
		}
	}

	public function startFastIn() {
		this.waitingForIn = true;
		this.waitingForOut = false;
		this.fastIn = true;
	}

	@:flash.property public var tip(get, never):Point;

	function get_tip():Point {
		return new Point(this.tipPoint.x, this.tipPoint.y);
	}

	public function getPush():Float {
		if (this.solidAction[this.currentAction]) {
			return this.pushPower[this.currentAction];
		}
		return 0;
	}

	public function getHeadTilt():Float {
		return this.tiltOffset;
	}

	public function block():Bool {
		if (this.solidAction[this.currentAction] && this.startedOff) {
			return true;
		}
		return false;
	}

	public function okayToHit():Bool {
		if (this.tongueOut) {
			return true;
		}
		return false;
	}

	public function cumHit() {
		this.swallowTimer = 0;
		++this.cumOnTongue;
	}

	public function cumRemoved() {
		this.cumOnTongue = Std.int(Math.max(0, this.cumOnTongue - 1));
	}

	public function ejaculating() {
		if (this.checkOff()) {
			this.startMovingTongue("out");
		}
	}

	public function touched():Bool {
		if (this.waitingToTouch) {
			G.him.givePleasure(Math.random() * 25 + 100);
			this.waitingToTouch = false;
			G.soundControl.playLick();
			return true;
		}
		return false;
	}

	public function update(param1:Float, param2:Float, param3:Float, param4:Float) {
		this.currentPos = param1;
		this.tiltOffset *= 0.8;
		if (param2 > 30 || param4 > 300) {
			this.startFastIn();
		}
		if (this.waitingForOut && (this.currentAction == null || this.currentAction == this.startMovingTongueOut)) {
			this.moveTongueOut();
		} else if (this.waitingForIn && (this.currentAction == null || this.currentAction == this.startMovingTongueIn)) {
			this.moveTongueIn();
		} else if (this.playingAction) {
			++this.actionTime;
			if (this.solidAction[this.currentAction]) {
				this.tiltOffset -= 0.5 * (1 - Math.cos(this.actionTime * this.tiltSpeeds[this.currentAction]));
			}
			if (this.currentFrameLabel == "InDone" || this.currentFrameLabel == "OutDone") {
				this.playingAction = false;
				this.currentAction = null;
				this.waitingToTouch = false;
				if (this.currentFrameLabel == "OutDone") {
					this.gotoAndStop(this.tongueOutEndFrame);
				}
			}
		} else {
			if (this.cumOnTongue > 0) {
				++this.swallowTimer;
				if (this.swallowTimer > this.swallowTime) {
					this.startMovingTongue("in");
				}
			}
			if (this.tongueOut) {
				if (this.mouthFull) {
					if (this.mouthFullTime >= 0) {
						if (this.mouthFullTimer < this.mouthFullTime) {
							this.mouthFullTimer += G.her.currentPenisDistance * 0.0025;
						} else {
							this.mouthFullTime = -1;
							this.startMovingTongue("in");
						}
					}
				}
			}
			if (!G.her.passedOut && !G.her.isSpeaking()) {
				if (ASCompat.thisOrDefault(this.checkNearTip(), this.increasedAction > 0)) {
					if (this.nearTimer < this.nearTime) {
						this.wiggleTongue(this.nearTime - this.nearTimer);
						++this.nearTimer;
					} else if (param3 < 10 && param4 < 300) {
						if (!this.tongueOut) {
							this.startMovingTongue("out");
						} else {
							this.performRandomTipAction();
						}
						this.nearTimer = 0;
					}
				} else {
					this.nearTimer = 0;
					if (this.actionTimer < this.nextActionTime) {
						this.wiggleTongue(this.nextActionTime - this.actionTimer);
						++this.actionTimer;
					} else {
						this.performNextAction();
					}
				}
			}
		}
		this.wiggleSpeed *= 0.9;
		if (this.increasedAction > 0) {
			--this.increasedAction;
		}
	}

	public function updatePiercing() {
		var _loc1_:Float = Maths.getAngle(Math.min(25, this.tipPoint.x), this.tipPoint.y);
		this.piercing.x = this.tipPoint.x;
		this.piercing.y = this.tipPoint.y;
		this.piercing.rotation = _loc1_;
		this.piercingBack.x = this.tipPoint.x;
		this.piercingBack.y = this.tipPoint.y;
		this.piercingBack.rotation = _loc1_;
	}

	public function wiggleTongue(param1:Int = 0) {
		var _loc2_:UInt = 0;
		param1 = Std.int(Math.max(0, param1));
		if (this.currentLabel == "TongueOut") {
			_loc2_ = Std.int(Math.max(this.tongueOutEndFrame - 10, this.tongueOutEndFrame - param1));
			this.wiggleSpeed += Math.random() - 0.5;
			if (this.hangingOut) {
				this.wiggleSpeed = Math.max(-2, Math.min(2, this.wiggleSpeed));
			} else {
				this.wiggleSpeed = Math.max(-1.2, Math.min(1.2, this.wiggleSpeed));
			}
			this.gotoAndStop(Math.max(_loc2_, Math.min(this.tongueOutEndFrame, this.currentFrame + Math.fround(this.wiggleSpeed))));
		}
	}

	public function performRandomTipAction() {
		var _loc1_:UInt = 0;
		this.actionTimer = 0;
		if (this.increasedAction > 0) {
			this.nextActionTime = Std.int(Math.ffloor(Math.random() * 15) + 5);
			this.nearTime = Std.int(Math.random() * 10);
		} else {
			this.nextActionTime = Std.int(Math.ffloor(Math.random() * 60) + 15);
			this.nearTime = Std.int(Math.fceil(Math.random() * 40) + 5);
		}
		if (this.increasedAction > 0 && !this.tongueOut) {
			this.nextAction = this.startMovingTongueOut;
		} else {
			_loc1_ = Math.floor(Math.random() * this.tipActions.length);
			this.nextAction = this.tipActions[_loc1_];
		}
		this.performNextAction();
	}

	public function randomAction() {
		var _loc1_:Array<ASAny> = null;
		var _loc2_:UInt = 0;
		this.actionTimer = 0;
		this.mouthFullTimer = 0;
		if (this.increasedAction > 0) {
			this.nextActionTime = Std.int(Math.ffloor(Math.random() * 15) + 5);
		} else {
			this.nextActionTime = Std.int(Math.ffloor(Math.random() * 60) + 15);
		}
		if (G.her.currentPenisDistance > 0 && this.mouthFull) {
			_loc1_ = this.shaftActions;
		} else {
			_loc1_ = this.offActions;
		}
		if (this.increasedAction > 0) {
			_loc2_ = Std.int(Math.ffloor(Math.random() * (_loc1_.length - 1)) + 1);
		} else {
			_loc2_ = Math.floor(Math.random() * _loc1_.length);
		}
		this.nextAction = _loc1_[_loc2_];
	}

	public function performNextAction() {
		this.actionTime = 0;
		this.nearTip = this.checkNearTip();
		this.startedOff = this.checkOff();
		this.currentAction = this.nextAction;
		this.playingAction = true;
		this.nextAction();
		this.randomAction();
	}

	public function checkNearTip():Bool {
		if (G.her.currentPenisDistance > -60 && (G.her.currentPenisDistance < 30 || G.penisOut)) {
			return true;
		}
		return false;
	}

	public function checkOff():Bool {
		if (G.her.currentPenisDistance < 0) {
			return true;
		}
		return false;
	}

	public function startMovingTongueIn() {
		if (this.tongueOut) {
			this.startMovingTongue("in");
		} else {
			this.playingAction = false;
		}
	}

	public function startMovingTongueOut() {
		if (!this.tongueOut) {
			this.startMovingTongue("out");
		} else {
			this.playingAction = false;
		}
	}

	public function moveTongueIn() {
		this.playingAction = true;
		if (this.currentLabel == "OutDone") {
			this.gotoAndStop(this.tongueOutEndFrame);
		} else {
			if (this.fastIn) {
				this.gotoAndStop(Math.max(this.tongueOutStartFrame, this.currentFrame - 4));
			} else {
				this.gotoAndStop(Math.max(this.tongueOutStartFrame, this.currentFrame - 2));
			}
			if ((this.currentFrame : UInt) == this.tongueOutStartFrame) {
				this.swallowTime = Std.int(Math.fceil(Math.random() * 60) + 15);
				this.waitingForIn = false;
				this.fastIn = false;
				this.cumOnTongue = 0;
				this.gotoAndStop("InDone");
			}
			if (this.hangingOut) {
				this.fastIn = false;
				this.waitingForIn = false;
				this.startMovingTongue("out");
			}
			this.tongueOut = false;
		}
	}

	public function moveTongueOut() {
		this.playingAction = true;
		if (this.currentLabel == "InDone") {
			this.gotoAndStop(this.tongueOutStartFrame);
		} else {
			this.gotoAndStop(Math.min(this.tongueOutEndFrame, this.currentFrame + 2));
			if ((this.currentFrame : UInt) == this.tongueOutEndFrame) {
				this.waitingForOut = false;
				this.tongueOut = true;
				this.gotoAndStop("OutDone");
			}
		}
	}

	public function doNothing() {
		this.playingAction = false;
	}

	public function lick() {
		if (this.tongueOut) {
			this.gotoAndPlay("Lick");
			this.tongueOut = false;
			if (this.increasedAction > 0 || Math.random() > 0.5) {
				this.startMovingTongue("out");
			}
			this.waitingToTouch = true;
		}
	}

	public function longLick() {
		if (this.tongueOut) {
			this.gotoAndPlay("LongLick");
			this.tongueOut = false;
			if (this.increasedAction > 0 || Math.random() > 0.5) {
				this.startMovingTongue("out");
			}
			this.waitingToTouch = true;
		}
	}

	public function smallLick() {
		if (this.tongueOut) {
			this.gotoAndPlay("SmallLick");
			this.waitingToTouch = true;
		}
	}

	public function tinyLick() {
		if (this.tongueOut) {
			this.gotoAndPlay("TinyLick");
			this.waitingToTouch = true;
		}
	}

	public function quickLick() {
		if (this.tongueOut) {
			this.gotoAndPlay("QuickLick");
			this.waitingToTouch = true;
		}
	}

	public function shaftLick() {
		if (this.tongueOut) {
			this.gotoAndPlay("ShaftLick");
			this.waitingToTouch = true;
		}
	}

	@:allow(obj.her) function frame76() {
		gotoAndStop("InDone");
	}

	@:allow(obj.her) function frame115() {
		gotoAndStop("InDone");
	}

	@:allow(obj.her) function frame139() {
		gotoAndStop("OutDone");
	}

	@:allow(obj.her) function frame165() {
		gotoAndStop("OutDone");
	}

	@:allow(obj.her) function frame189() {
		gotoAndStop("OutDone");
	}

	@:allow(obj.her) function frame206() {
		gotoAndStop("OutDone");
	}
}
