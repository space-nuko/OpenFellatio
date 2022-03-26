package obj;

import openfl.events.Event;
import openfl.events.TimerEvent;
import openfl.media.Sound;
import openfl.media.SoundChannel;
import openfl.media.SoundMixer;
import openfl.media.SoundTransform;
import openfl.utils.Timer;
import openfl.Assets;

class SoundControl {
	public var globalVol:Float = 1.0;
	public var breathing:Bool = false;
	public var fadingBreath:Bool = false;
	public var beingHeld:Bool = false;
	public var playingInBreath:Bool = false;
	public var justStartedBreath:Bool = false;
	public var startOnInBreath:Bool = false;
	public var openCoughing:Bool = false;
	public var waitingToBreathe:Bool = false;
	public var cumPlaying:UInt = 0;
	public var queuedCoughs:UInt = 0;
	public var consecutiveCoughs:UInt = 0;
	public var maxConsecutiveCoughs:UInt = 1;
	public var quietBreathingLevel:Float = 1;
	public var lastBreath:UInt = 0;
	public var lastInBreath:UInt = 0;
	public var lastSuddenBreath:UInt = 0;
	public var lastRandomGag:UInt = 0;
	public var lastRandomHold:UInt = 0;
	public var lastRandomCough:UInt = 0;
	public var lastRandomOpenCough:UInt = 0;
	public var lastRandomDown:UInt = 0;
	public var lastRandomSuck:UInt = 0;
	public var lastRandomTouch:UInt = 0;
	public var lastRandomSplat:UInt = 0;
	public var lastRandomPassOut:UInt = 0;
	public var lastRandomSwallow:UInt = 0;
	public var lastRandomLick:UInt = 0;
	public var breathStartTime:Int = 0;
	public var leftPan:Float = -0.4;
	public var rightPan:Float = 0.4;
	public var currentBreath:SoundChannel;
	public var currentBreathST:SoundTransform;
	public var currentOpenCough:SoundChannel;
	public var currentBreathVolume:Float = Math.NaN;
	public var currentHoldSound:SoundChannel;
	public var currentCum:SoundChannel;
	public var currentCumVolume:Float = Math.NaN;
	public var dialogueSound:Sound;
	public var dialogueVol:Float = Math.NaN;
	public var dialogueChannel:SoundChannel;
	public var playingDialogue:Bool = false;
	public var dialogueStartTime:Int = 0;
	public var dialogueResumeTime:Int = 0;
	public var currentBreathSound:Sound;
	public var customCoughs:Array<AudioMod>;
	public var normalBreath:Array<Sound>;
	public var breatheIn:Array<Sound>;
	public var fastBreath:Array<Sound>;
	public var suddenBreath:Array<Sound>;
	public var quietBreath:Array<Sound>;
	public var down:Array<Sound>;
	public var gag:Array<Sound>;
	public var suck:Array<Sound>;
	public var touch:Array<Sound>;
	public var splat:Array<Sound>;
	public var cough:Array<Sound>;
	public var openCough:Array<Sound>;
	public var held:Array<Sound>;
	public var passOut:Array<Sound>;
	public var swallow:Array<Sound>;
	public var lick:Array<Sound>;
	public var cum:Array<Sound>;
	public var cumInside:Array<Sound>;
	public var grab:Sound;
	public var rub:Sound;
	public var rubSC:SoundChannel;
	public var rubST:SoundTransform;
	public var intro:Sound;
	public var moan1:Sound;
	public var moan2:Sound;
	public var moanSuck1:Sound;
	public var moanSuck2:Sound;
	public var wretch1:Sound;
	public var wretch2:Sound;
	public var wretch3:Sound;

	public function new() {
		// super();
		this.currentBreathST = new SoundTransform(0, 0);
		this.initSoundEffects();
	}

	public function loadAudioMod(param1:String, param2:AudioMod) {
		if (this.customCoughs == null) {
			this.customCoughs = new Array<AudioMod>();
		}
		if (param1 == "cough" && param2 != null) {
			this.customCoughs.push(param2);
		}
	}

	public function resetAudioMods() {
		this.customCoughs = null;
	}

	public function changeVolume(param1:Float) {
		this.globalVol = param1;
		if (G.mute) {
			G.mute = false;
		}
		var _loc2_ = new SoundTransform(this.globalVol, 0);
		SoundMixer.soundTransform = _loc2_;
	}

	public function increaseVolume() {
		this.globalVol = Math.min(1, Math.fround(this.globalVol * 10 + 1) / 10);
		this.changeVolume(this.globalVol);
		G.inGameMenu.updateVolumeSlider(this.globalVol);
	}

	public function decreaseVolume() {
		this.globalVol = Math.max(0, Math.fround(this.globalVol * 10 - 1) / 10);
		this.changeVolume(this.globalVol);
		G.inGameMenu.updateVolumeSlider(this.globalVol);
	}

	public function toggleMute() {
		var _loc1_:SoundTransform = null;
		if (!G.mute) {
			this.muteSound();
		} else {
			G.mute = false;
			_loc1_ = new SoundTransform(this.globalVol, 0);
			SoundMixer.soundTransform = _loc1_;
			G.inGameMenu.updateVolumeSlider(this.globalVol);
		}
	}

	public function muteSound() {
		G.mute = true;
		var _loc1_ = new SoundTransform(0, 0);
		SoundMixer.soundTransform = _loc1_;
		G.inGameMenu.updateVolumeSlider(0);
	}

	public function startBreathingWithCough():Bool {
		if (G.breathing) {
			this.playOpenCough();
			this.startBreathing();
		}
		return this.breathing;
	}

	public function startBreathing(param1:Bool = false):Bool {
		if (G.breathing && !this.playingDialogue) {
			if (param1) {
				this.stopBreathing(true);
				this.openCoughing = false;
			}
			if (this.openCoughing) {
				this.waitingToBreathe = true;
			} else {
				this.playStartBreath(param1);
				this.waitingToBreathe = false;
			}
			this.breathing = true;
			this.fadingBreath = false;
		}
		return this.breathing;
	}

	public function playStartBreath(param1:Bool = false) {
		if (G.breathLevel > G.outOfBreathPoint && !G.her.passedOut) {
			this.newSuddenBreath();
		} else if (this.startOnInBreath || param1) {
			this.newInBreath();
		} else if (this.queuedCoughs > 0 && this.consecutiveCoughs < this.maxConsecutiveCoughs) {
			this.playOpenCough();
		} else {
			this.newRandomBreath();
		}
	}

	public function stopBreathing(param1:Bool = false):Bool {
		var _loc2_ = Math.NaN;
		if (this.breathing) {
			_loc2_ = this.breathPosition();
			if (param1) {
				if (this.currentBreath != null) {
					this.currentBreath.stop();
				}
				if (this.openCoughing) {
					this.stopOpenCough();
				}
			} else {
				this.fadingBreath = true;
			}
			this.breathing = false;
			this.waitingToBreathe = false;
			if (G.breathLevel >= this.quietBreathingLevel && _loc2_ > 0.1 && _loc2_ < 0.6) {
				this.startOnInBreath = true;
			} else {
				this.startOnInBreath = false;
			}
		}
		return this.breathing;
	}

	public function tick() {
		if (this.fadingBreath) {
			this.currentBreathVolume = Math.max(0, this.currentBreathVolume - 0.25);
			if (this.currentBreathVolume <= 0) {
				if (this.currentBreath != null) {
					this.currentBreath.stop();
				}
				this.fadingBreath = false;
			}
		}
		if (this.currentBreath != null) {
			this.currentBreathST.volume = this.currentBreathVolume * Math.max(0.4, G.herMouthOpeness);
			this.currentBreathST.pan = this.leftPan;
			this.currentBreath.soundTransform = this.currentBreathST;
		}
	}

	public function breathPosition():Float {
		var _loc1_ = 0;
		if (this.breathing && !this.openCoughing) {
			_loc1_ = flash.Lib.getTimer();
			if (this.playingInBreath) {
				return (_loc1_ - this.breathStartTime) / this.currentBreathSound.length / 2 + 0.5;
			}
			return (_loc1_ - this.breathStartTime) / this.currentBreathSound.length;
		}
		return 0;
	}

	public function justBreathedOut():Bool {
		if (this.justStartedBreath) {
			this.justStartedBreath = false;
			return true;
		}
		return false;
	}

	public function startHolding() {
		if (!this.beingHeld) {
			this.newRandomHoldSound();
			this.beingHeld = true;
		}
	}

	public function stopHolding() {
		if (this.beingHeld) {
			if (this.currentHoldSound != null) {
				this.currentHoldSound.stop();
			}
			this.beingHeld = false;
		}
	}

	public function queueOpenCough() {
		this.queuedCoughs = Std.int(Math.min(5, this.queuedCoughs + 1));
	}

	public function playIntro() {
		var _loc2_:SoundTransform = null;
		var _loc1_ = this.intro.play();
		if (_loc1_ != null) {
			_loc2_ = new SoundTransform(1);
			_loc1_.soundTransform = _loc2_;
		}
	}

	public function playTouch() {
		var _loc1_:UInt = 0;
		var _loc3_:SoundTransform = null;
		do {
			_loc1_ = Math.floor(Math.random() * this.touch.length);
		} while (_loc1_ == this.lastRandomTouch);

		this.lastRandomTouch = _loc1_;
		var _loc2_:SoundChannel = this.touch[_loc1_].play();
		if (_loc2_ != null) {
			_loc3_ = new SoundTransform(0.5, this.leftPan);
			_loc2_.soundTransform = _loc3_;
		}
	}

	public function playDown(param1:Float, param2:Float) {
		var _loc4_:UInt = 0;
		var _loc6_:SoundTransform = null;
		var _loc3_ = Math.min(1, param2 / 40);
		while ((_loc4_ = Math.floor(Math.random() * this.down.length)) == this.lastRandomDown) {}
		this.lastRandomDown = _loc4_;
		var _loc5_:SoundChannel;
		if ((_loc5_ = this.down[_loc4_].play()) != null) {
			_loc6_ = new SoundTransform(_loc3_, Math.max(this.leftPan, Math.min(this.rightPan, param1 * 2 - 1)));
			_loc5_.soundTransform = _loc6_;
		}
	}

	public function playUp(param1:Float, param2:Float) {
		var _loc4_:UInt = 0;
		var _loc6_:SoundTransform = null;
		var _loc3_ = Math.min(1, param2 / 40);
		while ((_loc4_ = Math.floor(Math.random() * this.suck.length)) == this.lastRandomSuck) {}
		this.lastRandomSuck = _loc4_;
		var _loc5_:SoundChannel;
		if ((_loc5_ = this.suck[_loc4_].play()) != null) {
			_loc6_ = new SoundTransform(_loc3_, Math.max(this.leftPan, Math.min(this.rightPan, param1 * 2 - 1)));
			_loc5_.soundTransform = _loc6_;
		}
	}

	public function playGag(param1:Float) {
		var _loc3_:UInt = 0;
		var _loc5_:SoundTransform = null;
		var _loc2_ = 0.5 + Math.random() * 0.2;
		do {
			_loc3_ = Math.floor(Math.random() * this.gag.length);
		} while (_loc3_ == this.lastRandomGag);

		this.lastRandomGag = _loc3_;
		var _loc4_:SoundChannel;
		if ((_loc4_ = this.gag[_loc3_].play()) != null) {
			_loc5_ = new SoundTransform(_loc2_, Math.max(this.leftPan, Math.min(this.rightPan, param1 * 2 - 1)));
			_loc4_.soundTransform = _loc5_;
		}
	}

	public function playCough() {
		var _loc1_:UInt = 0;
		var _loc3_:SoundTransform = null;
		do {
			_loc1_ = Math.floor(Math.random() * this.cough.length);
		} while (_loc1_ == this.lastRandomCough);

		this.lastRandomCough = _loc1_;
		var _loc2_:SoundChannel = this.cough[_loc1_].play();
		if (_loc2_ != null) {
			_loc3_ = new SoundTransform(1, this.rightPan);
			_loc2_.soundTransform = _loc3_;
		}
	}

	public function playSplat() {
		var _loc1_:UInt = 0;
		var _loc3_:SoundTransform = null;
		do {
			_loc1_ = Math.floor(Math.random() * this.splat.length);
		} while (_loc1_ == this.lastRandomSplat);

		this.lastRandomSplat = _loc1_;
		var _loc2_:SoundChannel = this.splat[_loc1_].play();
		if (_loc2_ != null) {
			_loc3_ = new SoundTransform(1, this.rightPan);
			_loc2_.soundTransform = _loc3_;
		}
	}

	public function playPassOut(param1:Float = 0) {
		var _loc2_:UInt = 0;
		var _loc4_:SoundTransform = null;
		do {
			_loc2_ = Math.floor(Math.random() * this.passOut.length);
		} while (_loc2_ == this.lastRandomPassOut);

		this.lastRandomPassOut = _loc2_;
		var _loc3_:SoundChannel = this.passOut[_loc2_].play();
		if (_loc3_ != null) {
			_loc4_ = new SoundTransform(1, Math.max(this.leftPan, Math.min(this.rightPan, param1 * 2 - 1)));
			_loc3_.soundTransform = _loc4_;
		}
	}

	public function playGrab(param1:Float = 0, param2:Float = 1) {
		var _loc4_:SoundTransform = null;
		var _loc3_ = this.grab.play();
		if (_loc3_ != null) {
			_loc4_ = new SoundTransform(0.5 * param2, Math.max(this.leftPan, Math.min(this.rightPan, param1 * 2 - 1)));
			_loc3_.soundTransform = _loc4_;
		}
	}

	public function playSwallow(param1:Float = 0) {
		var _loc2_:UInt = 0;
		var _loc4_:SoundTransform = null;
		do {
			_loc2_ = Math.floor(Math.random() * this.swallow.length);
		} while (_loc2_ == this.lastRandomSwallow);

		this.lastRandomSwallow = _loc2_;
		var _loc3_:SoundChannel = this.swallow[_loc2_].play();
		if (_loc3_ != null) {
			_loc4_ = new SoundTransform(1, Math.max(this.leftPan, Math.min(this.rightPan, param1 * 2 - 1)));
			_loc3_.soundTransform = _loc4_;
		}
	}

	public function playLick(param1:Float = 0) {
		var _loc2_:UInt = 0;
		var _loc4_:SoundTransform = null;
		do {
			_loc2_ = Math.floor(Math.random() * this.lick.length);
		} while (_loc2_ == this.lastRandomLick);

		this.lastRandomLick = _loc2_;
		var _loc3_:SoundChannel = this.lick[_loc2_].play();
		if (_loc3_ != null) {
			_loc4_ = new SoundTransform(0.4, Math.max(this.leftPan, Math.min(this.rightPan, param1 * 2 - 1)));
			_loc3_.soundTransform = _loc4_;
		}
	}

	public function startRub() {
		if (this.rubSC == null) {
			this.rubSC = this.rub.play();
			this.rubSC.addEventListener(Event.SOUND_COMPLETE, this.rubFinished);
			this.updateRub();
		}
	}

	public function stopRub() {
		this.rubFinished();
	}

	public function updateRub(param1:Float = 0, param2:Float = 0) {
		if (this.rubSC != null) {
			if (this.rubST == null) {
				this.rubST = new SoundTransform(0, 0);
				this.rubSC.soundTransform = this.rubST;
			}
			this.rubST.volume += (param1 - this.rubST.volume) * 0.3;
			this.rubST.pan = Math.max(this.leftPan, Math.min(this.rightPan, param2 * 2 - 1));
			this.rubSC.soundTransform = this.rubST;
		}
	}

	public function rubFinished(param1:Event = null) {
		if (this.rubSC != null) {
			this.rubSC.stop();
			this.rubSC.removeEventListener(Event.SOUND_COMPLETE, this.rubFinished);
			this.rubSC = null;
			this.startRub();
		}
	}

	public function playCum(param1:Bool = false) {
		var _loc2_:SoundTransform = null;
		this.cumPlaying = Math.floor(Math.random() * this.cum.length);
		if (param1) {
			this.currentCum = this.cumInside[this.cumPlaying].play();
		} else {
			this.currentCum = this.cum[this.cumPlaying].play();
		}
		this.currentCumVolume = 0.8;
		if (this.currentCum != null) {
			_loc2_ = new SoundTransform(this.currentCumVolume, this.leftPan);
			this.currentCum.soundTransform = _loc2_;
		}
	}

	public function switchCumInside() {
		var _loc1_ = Math.NaN;
		var _loc2_:SoundTransform = null;
		if (this.currentCum != null) {
			_loc1_ = this.currentCum.position;
			this.currentCum.stop();
			this.currentCum = this.cumInside[this.cumPlaying].play(_loc1_);
			if (this.currentCum != null) {
				_loc2_ = new SoundTransform(this.currentCumVolume, this.leftPan);
				this.currentCum.soundTransform = _loc2_;
			}
		}
	}

	public function switchCumOutside() {
		var _loc1_ = Math.NaN;
		var _loc2_:SoundTransform = null;
		if (this.currentCum != null) {
			_loc1_ = this.currentCum.position;
			this.currentCum.stop();
			this.currentCum = this.cum[this.cumPlaying].play(_loc1_);
			if (this.currentCum != null) {
				_loc2_ = new SoundTransform(this.currentCumVolume, this.leftPan);
				this.currentCum.soundTransform = _loc2_;
			}
		}
	}

	public function adjustCumVolume(param1:Float, param2:Float) {
		var _loc3_:SoundTransform = null;
		this.currentCumVolume = param1 * 0.5 + param2;
		if (this.currentCum != null) {
			_loc3_ = new SoundTransform(this.currentCumVolume, this.leftPan);
			this.currentCum.soundTransform = _loc3_;
		}
	}

	public function fadeCumVolume(param1:Float = 0.05):Bool {
		var _loc2_:SoundTransform = null;
		this.currentCumVolume = Math.max(0, this.currentCumVolume - param1);
		if (this.currentCum != null) {
			_loc2_ = new SoundTransform(this.currentCumVolume, this.leftPan);
			this.currentCum.soundTransform = _loc2_;
		}
		if (this.currentCumVolume > 0) {
			return true;
		}
		return false;
	}

	public function newRandomHoldSound() {
		var _loc1_:UInt = 0;
		var _loc2_:SoundTransform = null;
		do {
			_loc1_ = Math.floor(Math.random() * this.held.length);
		} while (_loc1_ == this.lastRandomHold);

		this.lastRandomHold = _loc1_;
		this.currentHoldSound = this.held[_loc1_].play();
		if (this.currentHoldSound != null) {
			_loc2_ = new SoundTransform(1, this.rightPan);
			this.currentHoldSound.soundTransform = _loc2_;
			this.currentHoldSound.addEventListener(Event.SOUND_COMPLETE, this.holdFinished);
		}
	}

	public function holdFinished(param1:Event) {
		if (this.beingHeld) {
			this.newRandomHoldSound();
		}
	}

	public function newRandomBreath() {
		var _loc1_:UInt = 0;
		if (G.breathing) {
			this.consecutiveCoughs = 0;
			this.playingInBreath = false;
			this.justStartedBreath = true;
			if (G.breathLevel > G.outOfBreathPoint && !G.her.passedOut) {
				do {
					_loc1_ = Math.floor(Math.random() * this.fastBreath.length);
				} while (_loc1_ == this.lastBreath);

				this.lastBreath = _loc1_;
				this.currentBreathSound = this.fastBreath[_loc1_];
				this.currentBreath = this.currentBreathSound.play();
				G.addBreath(-2);
			} else if (G.breathLevel < this.quietBreathingLevel) {
				do {
					_loc1_ = Math.floor(Math.random() * this.quietBreath.length);
				} while (_loc1_ == this.lastBreath);

				this.lastBreath = _loc1_;
				this.currentBreathSound = this.quietBreath[_loc1_];
				this.currentBreath = this.currentBreathSound.play();
				G.addBreath(-0.5);
			} else {
				do {
					_loc1_ = Math.floor(Math.random() * this.normalBreath.length);
				} while (_loc1_ == this.lastBreath);

				this.lastBreath = _loc1_;
				this.currentBreathSound = this.normalBreath[_loc1_];
				this.currentBreath = this.currentBreathSound.play();
				G.addBreath(-1);
			}
			if (G.her.passedOut) {
				this.currentBreathVolume = 0.15 * Math.max(0.4, G.herMouthOpeness);
				this.currentBreathST.volume = this.currentBreathVolume;
				this.currentBreathST.pan = this.leftPan;
			} else {
				this.currentBreathVolume = Math.min(1, G.breathLevel / G.outOfBreathPoint + 0.15) * Math.max(0.4, G.herMouthOpeness);
				this.currentBreathST.volume = this.currentBreathVolume;
				this.currentBreathST.pan = this.leftPan;
			}
			if (this.currentBreath != null) {
				this.currentBreath.soundTransform = this.currentBreathST;
				this.breathStartTime = flash.Lib.getTimer();
				this.currentBreath.addEventListener(Event.SOUND_COMPLETE, this.breathFinished);
			}
		}
	}

	public function newInBreath() {
		var _loc1_:UInt = 0;
		this.consecutiveCoughs = 0;
		this.playingInBreath = true;
		do {
			_loc1_ = Math.floor(Math.random() * this.breatheIn.length);
		} while (this.lastInBreath == _loc1_);

		this.lastInBreath = _loc1_;
		this.currentBreathSound = this.breatheIn[_loc1_];
		this.currentBreath = this.currentBreathSound.play();
		if (this.currentBreath != null) {
			this.currentBreathVolume = Math.min(1, G.breathLevel / 20 + 0.5);
			this.currentBreathST.volume = this.currentBreathVolume;
			this.currentBreathST.pan = this.leftPan;
			this.currentBreath.soundTransform = this.currentBreathST;
			this.breathStartTime = flash.Lib.getTimer();
			this.currentBreath.addEventListener(Event.SOUND_COMPLETE, this.breathFinished);
		}
	}

	public function newSuddenBreath() {
		var _loc1_:UInt = 0;
		this.consecutiveCoughs = 0;
		this.playingInBreath = true;
		do {
			_loc1_ = Math.floor(Math.random() * this.suddenBreath.length);
		} while (this.lastSuddenBreath == _loc1_);

		this.lastSuddenBreath = _loc1_;
		this.currentBreathSound = this.suddenBreath[_loc1_];
		this.currentBreath = this.currentBreathSound.play();
		if (this.currentBreath != null) {
			this.currentBreathVolume = Math.min(1, G.breathLevel / 20 + 0.5);
			this.currentBreathST.volume = this.currentBreathVolume;
			this.currentBreathST.pan = this.leftPan;
			this.currentBreath.soundTransform = this.currentBreathST;
			this.breathStartTime = flash.Lib.getTimer();
			this.currentBreath.addEventListener(Event.SOUND_COMPLETE, this.breathFinished);
		}
	}

	public function playOpenCough() {
		var _loc2_:UInt = 0;
		if (this.consecutiveCoughs == 0) {
			this.maxConsecutiveCoughs = Std.int(Math.min(Math.max(1, this.queuedCoughs), Math.fceil(Math.random() * 2) + 1));
		}
		++this.consecutiveCoughs;
		if (this.queuedCoughs > 0) {
			--this.queuedCoughs;
		}
		var _loc1_ = 0.4;
		var _loc3_:AudioMod = G.dialogueControl.cough();
		if (_loc3_ != null) {
			this.currentOpenCough = _loc3_.audio.play();
			_loc1_ = _loc3_.volume;
		} else if (this.customCoughs != null) {
			if (this.customCoughs.length > 1) {
				do {
					_loc2_ = Math.floor(Math.random() * this.customCoughs.length);
				} while (this.lastRandomOpenCough == _loc2_);
			} else {
				_loc2_ = 0;
			}
			this.lastRandomOpenCough = _loc2_;
			this.currentOpenCough = this.customCoughs[_loc2_].audio.play();
			_loc1_ = this.customCoughs[_loc2_].volume;
		} else {
			do {
				_loc2_ = Math.floor(Math.random() * this.openCough.length);
			} while (this.lastRandomOpenCough == _loc2_);

			this.lastRandomOpenCough = _loc2_;
			this.currentOpenCough = this.openCough[_loc2_].play();
		}
		var _loc4_ = new SoundTransform(_loc1_, this.leftPan);
		if (this.currentOpenCough != null) {
			this.currentOpenCough.soundTransform = _loc4_;
			this.currentOpenCough.addEventListener(Event.SOUND_COMPLETE, this.coughFinished);
			this.openCoughing = true;
			this.startOnInBreath = true;
			this.pauseDialogue();
			G.her.openCough();
		} else {
			this.playStartBreath();
		}
	}

	public function coughFinished(param1:Event) {
		this.resumeDialogue();
		this.currentOpenCough.removeEventListener(Event.SOUND_COMPLETE, this.coughFinished);
		var _loc2_ = new Timer(Math.ffloor(Math.random() * 100), 1);
		_loc2_.addEventListener(TimerEvent.TIMER_COMPLETE, this.delayedCoughFinish);
		_loc2_.start();
	}

	public function stopOpenCough() {
		if (this.currentOpenCough != null) {
			this.currentOpenCough.stop();
		}
		this.openCoughing = false;
		if (this.currentOpenCough.hasEventListener(Event.SOUND_COMPLETE)) {
			this.currentOpenCough.removeEventListener(Event.SOUND_COMPLETE, this.coughFinished);
		}
	}

	public function delayedCoughFinish(param1:TimerEvent) {
		cast(param1.target, Timer).stop();
		cast(param1.target, Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, this.delayedCoughFinish);
		if (this.openCoughing) {
			this.openCoughing = false;
			if (this.breathing) {
				if (this.queuedCoughs > 0 && this.consecutiveCoughs < this.maxConsecutiveCoughs) {
					this.playOpenCough();
				} else {
					this.playStartBreath();
				}
			}
		}
	}

	public function breathFinished(param1:Event) {
		cast(param1.target, SoundChannel).removeEventListener(Event.SOUND_COMPLETE, this.breathFinished);
		if (this.breathing) {
			if (this.queuedCoughs > 0 && this.consecutiveCoughs < this.maxConsecutiveCoughs) {
				this.playOpenCough();
			} else {
				this.newRandomBreath();
			}
		}
	}

	public function playDialogue(param1:AudioMod) {
		var _loc2_:SoundTransform = null;
		if (this.playingDialogue && this.dialogueChannel != null) {
			this.stopDialogue();
		}
		G.her.stopBreathing();
		this.dialogueSound = param1.audio;
		this.dialogueVol = param1.volume;
		this.dialogueChannel = this.dialogueSound.play();
		if (this.dialogueChannel != null) {
			_loc2_ = new SoundTransform(this.dialogueVol, Math.max(this.leftPan, Math.min(this.rightPan, G.herCurrentPos * 2 - 1)));
			this.dialogueChannel.addEventListener(Event.SOUND_COMPLETE, this.dialogueFinished);
			this.dialogueChannel.soundTransform = _loc2_;
			this.dialogueStartTime = flash.Lib.getTimer();
			this.dialogueResumeTime = 0;
			this.playingDialogue = true;
		}
	}

	public function updateDialogue() {
		var _loc1_:SoundTransform = null;
		if (this.dialogueChannel != null) {
			_loc1_ = new SoundTransform(0.9, Math.max(this.leftPan, Math.min(this.rightPan, G.herCurrentPos * 2 - 1)));
			this.dialogueChannel.soundTransform = _loc1_;
		}
	}

	public function playDialogueInterrupt(param1:AudioMod) {
		var _loc3_:SoundTransform = null;
		var _loc2_ = param1.audio.play();
		if (_loc2_ != null) {
			_loc3_ = new SoundTransform(param1.volume, Math.max(this.leftPan, Math.min(this.rightPan, G.currentPos.x * 2 - 1)));
			_loc2_.soundTransform = _loc3_;
		}
	}

	public function dialogueFinished(param1:Event) {
		cast(param1.target, SoundChannel).removeEventListener(Event.SOUND_COMPLETE, this.dialogueFinished);
		this.dialogueSound = null;
		this.dialogueChannel = null;
		this.playingDialogue = false;
		G.her.checkBreathing(true);
	}

	public function pauseDialogue() {
		if (this.playingDialogue && this.dialogueChannel != null) {
			this.stopDialogue();
			this.playingDialogue = true;
			this.dialogueResumeTime = flash.Lib.getTimer() - this.dialogueStartTime;
		}
	}

	public function stopDialogue() {
		if (this.dialogueChannel != null) {
			this.dialogueChannel.removeEventListener(Event.SOUND_COMPLETE, this.dialogueFinished);
			this.dialogueChannel.stop();
			this.dialogueChannel = null;
			this.playingDialogue = false;
		}
	}

	public function resumeDialogue(param1:Int = -1) {
		var _loc2_:SoundTransform = null;
		if (this.playingDialogue && this.dialogueSound != null) {
			if (param1 == -1) {
				param1 = this.dialogueResumeTime;
			}
			if (this.dialogueChannel != null) {
				this.stopDialogue();
			}
			this.dialogueChannel = this.dialogueSound.play(param1);
			if (this.dialogueChannel != null) {
				this.dialogueChannel.addEventListener(Event.SOUND_COMPLETE, this.dialogueFinished);
				_loc2_ = new SoundTransform(this.dialogueVol, Maths.clampf(G.currentPos.x * 2 - 1, this.leftPan, this.rightPan));
				this.dialogueChannel.soundTransform = _loc2_;
				this.dialogueStartTime = flash.Lib.getTimer() - param1;
				this.playingDialogue = true;
			}
		}
	}

	public function initSoundEffects() {
		this.normalBreath = new Array<Sound>();
		this.normalBreath.push(Assets.getSound("audio/sfxBreathe10.mp3"));
		this.normalBreath.push(Assets.getSound("audio/sfxBreathe11.mp3"));
		this.normalBreath.push(Assets.getSound("audio/sfxBreathe12.mp3"));
		this.normalBreath.push(Assets.getSound("audio/sfxBreathe13.mp3"));
		this.normalBreath.push(Assets.getSound("audio/sfxBreathe14.mp3"));
		this.normalBreath.push(Assets.getSound("audio/sfxBreathe15.mp3"));
		this.normalBreath.push(Assets.getSound("audio/sfxBreathe16.mp3"));
		this.normalBreath.push(Assets.getSound("audio/sfxBreathe17.mp3"));
		this.normalBreath.push(Assets.getSound("audio/sfxMoanBreathe8.mp3"));
		this.normalBreath.push(Assets.getSound("audio/sfxMoanBreathe9.mp3"));
		this.normalBreath.push(Assets.getSound("audio/sfxBreathe4.mp3"));
		this.breatheIn = new Array<Sound>();
		this.breatheIn.push(Assets.getSound("audio/sfxBreatheIn2.mp3"));
		this.breatheIn.push(Assets.getSound("audio/sfxBreatheIn3.mp3"));
		this.breatheIn.push(Assets.getSound("audio/sfxBreatheIn4.mp3"));
		this.breatheIn.push(Assets.getSound("audio/sfxBreatheIn5.mp3"));
		this.breatheIn.push(Assets.getSound("audio/sfxBreatheIn6.mp3"));
		this.fastBreath = new Array<Sound>();
		this.fastBreath.push(Assets.getSound("audio/sfxBreathe5.mp3"));
		this.fastBreath.push(Assets.getSound("audio/sfxBreathe6.mp3"));
		this.fastBreath.push(Assets.getSound("audio/sfxBreathe7.mp3"));
		this.fastBreath.push(Assets.getSound("audio/sfxBreathe8.mp3"));
		this.fastBreath.push(Assets.getSound("audio/sfxBreathe9.mp3"));
		this.suddenBreath = new Array<Sound>();
		this.suddenBreath.push(Assets.getSound("audio/sfxCoughBreathe2.mp3"));
		this.suddenBreath.push(Assets.getSound("audio/sfxCoughBreathe6.mp3"));
		this.suddenBreath.push(Assets.getSound("audio/sfxCoughBreathe7.mp3"));
		this.suddenBreath.push(Assets.getSound("audio/sfxCoughBreathe8.mp3"));
		this.suddenBreath.push(Assets.getSound("audio/sfxCoughBreathe10.mp3"));
		this.suddenBreath.push(Assets.getSound("audio/sfxBreatheIn1.mp3"));
		this.suddenBreath.push(Assets.getSound("audio/sfxMoanBreathe6.mp3"));
		this.suddenBreath.push(Assets.getSound("audio/sfxMoanBreathe7.mp3"));
		this.quietBreath = new Array<Sound>();
		this.quietBreath.push(Assets.getSound("audio/sfxQuietBreath1.mp3"));
		this.quietBreath.push(Assets.getSound("audio/sfxQuietBreath2.mp3"));
		this.quietBreath.push(Assets.getSound("audio/sfxQuietBreath3.mp3"));
		this.quietBreath.push(Assets.getSound("audio/sfxQuietBreath4.mp3"));
		this.down = new Array<Sound>();
		this.down.push(Assets.getSound("audio/sfxDown1.mp3"));
		this.down.push(Assets.getSound("audio/sfxDown2.mp3"));
		this.down.push(Assets.getSound("audio/sfxDown3.mp3"));
		this.down.push(Assets.getSound("audio/sfxDown4.mp3"));
		this.down.push(Assets.getSound("audio/sfxDown5.mp3"));
		this.down.push(Assets.getSound("audio/sfxDown6.mp3"));
		this.down.push(Assets.getSound("audio/sfxDown7.mp3"));
		this.down.push(Assets.getSound("audio/sfxDown8.mp3"));
		this.down.push(Assets.getSound("audio/sfxDown9.mp3"));
		this.down.push(Assets.getSound("audio/sfxDown10.mp3"));
		this.touch = new Array<Sound>();
		this.touch.push(Assets.getSound("audio/sfxTouch1.mp3"));
		this.touch.push(Assets.getSound("audio/sfxTouch2.mp3"));
		this.touch.push(Assets.getSound("audio/sfxTouch3.mp3"));
		this.gag = new Array<Sound>();
		this.gag.push(Assets.getSound("audio/sfxGag1.mp3"));
		this.gag.push(Assets.getSound("audio/sfxGag2.mp3"));
		this.gag.push(Assets.getSound("audio/sfxGag3.mp3"));
		this.gag.push(Assets.getSound("audio/sfxGag4.mp3"));
		this.gag.push(Assets.getSound("audio/sfxGag5.mp3"));
		this.gag.push(Assets.getSound("audio/sfxGag6.mp3"));
		this.gag.push(Assets.getSound("audio/sfxGag7.mp3"));
		this.gag.push(Assets.getSound("audio/sfxGag8.mp3"));
		this.gag.push(Assets.getSound("audio/sfxGag9.mp3"));
		this.gag.push(Assets.getSound("audio/sfxGag10.mp3"));
		this.gag.push(Assets.getSound("audio/sfxGag11.mp3"));
		this.gag.push(Assets.getSound("audio/sfxGag12.mp3"));
		this.gag.push(Assets.getSound("audio/sfxGag13.mp3"));
		this.gag.push(Assets.getSound("audio/sfxGag14.mp3"));
		this.gag.push(Assets.getSound("audio/sfxGag15.mp3"));
		this.suck = new Array<Sound>();
		this.suck.push(Assets.getSound("audio/sfxSuck1.mp3"));
		this.suck.push(Assets.getSound("audio/sfxSuck2.mp3"));
		this.suck.push(Assets.getSound("audio/sfxSuck3.mp3"));
		this.suck.push(Assets.getSound("audio/sfxSuck4.mp3"));
		this.suck.push(Assets.getSound("audio/sfxSuck5.mp3"));
		this.suck.push(Assets.getSound("audio/sfxSuck6.mp3"));
		this.suck.push(Assets.getSound("audio/sfxSuck7.mp3"));
		this.suck.push(Assets.getSound("audio/sfxSuck8.mp3"));
		this.suck.push(Assets.getSound("audio/sfxSuck9.mp3"));
		this.suck.push(Assets.getSound("audio/sfxSuck10.mp3"));
		this.suck.push(Assets.getSound("audio/sfxSuck11.mp3"));
		this.suck.push(Assets.getSound("audio/sfxSuck12.mp3"));
		this.suck.push(Assets.getSound("audio/sfxSuck13.mp3"));
		this.suck.push(Assets.getSound("audio/sfxSuck14.mp3"));
		this.suck.push(Assets.getSound("audio/sfxSuck15.mp3"));
		this.suck.push(Assets.getSound("audio/sfxSuck16.mp3"));
		this.suck.push(Assets.getSound("audio/sfxSuck17.mp3"));
		this.suck.push(Assets.getSound("audio/sfxSuck18.mp3"));
		this.suck.push(Assets.getSound("audio/sfxMoanSuck1.mp3"));
		this.suck.push(Assets.getSound("audio/sfxMoanSuck2.mp3"));
		this.cough = new Array<Sound>();
		this.cough.push(Assets.getSound("audio/sfxCough1.mp3"));
		this.cough.push(Assets.getSound("audio/sfxCough2.mp3"));
		this.cough.push(Assets.getSound("audio/sfxCough3.mp3"));
		this.cough.push(Assets.getSound("audio/sfxCough4.mp3"));
		this.cough.push(Assets.getSound("audio/sfxCough5.mp3"));
		this.cough.push(Assets.getSound("audio/sfxCough6.mp3"));
		this.cough.push(Assets.getSound("audio/sfxCough7.mp3"));
		this.openCough = new Array<Sound>();
		this.openCough.push(Assets.getSound("audio/sfxOpenCough1.mp3"));
		this.openCough.push(Assets.getSound("audio/sfxOpenCough2.mp3"));
		this.openCough.push(Assets.getSound("audio/sfxOpenCough3.mp3"));
		this.openCough.push(Assets.getSound("audio/sfxOpenCough4.mp3"));
		this.openCough.push(Assets.getSound("audio/sfxOpenCough5.mp3"));
		this.openCough.push(Assets.getSound("audio/sfxOpenCough6.mp3"));
		this.openCough.push(Assets.getSound("audio/sfxOpenCough7.mp3"));
		this.openCough.push(Assets.getSound("audio/sfxOpenCough8.mp3"));
		this.openCough.push(Assets.getSound("audio/sfxOpenCough9.mp3"));
		this.openCough.push(Assets.getSound("audio/sfxOpenCough10.mp3"));
		this.openCough.push(Assets.getSound("audio/sfxOpenCough11.mp3"));
		this.openCough.push(Assets.getSound("audio/sfxOpenCough12.mp3"));
		this.held = new Array<Sound>();
		this.held.push(Assets.getSound("audio/sfxHeld1.mp3"));
		this.held.push(Assets.getSound("audio/sfxHeld2.mp3"));
		this.held.push(Assets.getSound("audio/sfxHeld3.mp3"));
		this.held.push(Assets.getSound("audio/sfxHeld4.mp3"));
		this.held.push(Assets.getSound("audio/sfxHeld5.mp3"));
		this.held.push(Assets.getSound("audio/sfxHeld6.mp3"));
		this.held.push(Assets.getSound("audio/sfxHeld7.mp3"));
		this.held.push(Assets.getSound("audio/sfxHeld8.mp3"));
		this.held.push(Assets.getSound("audio/sfxHeld9.mp3"));
		this.held.push(Assets.getSound("audio/sfxHeld10.mp3"));
		this.held.push(Assets.getSound("audio/sfxHeld11.mp3"));
		this.held.push(Assets.getSound("audio/sfxHeld12.mp3"));
		this.held.push(Assets.getSound("audio/sfxHeld13.mp3"));
		this.splat = new Array<Sound>();
		this.splat.push(Assets.getSound("audio/sfxSplat1.mp3"));
		this.splat.push(Assets.getSound("audio/sfxSplat2.mp3"));
		this.splat.push(Assets.getSound("audio/sfxSplat3.mp3"));
		this.passOut = new Array<Sound>();
		this.passOut.push(Assets.getSound("audio/sfxPassOut1.mp3"));
		this.passOut.push(Assets.getSound("audio/sfxPassOut2.mp3"));
		this.passOut.push(Assets.getSound("audio/sfxPassOut3.mp3"));
		this.swallow = new Array<Sound>();
		this.swallow.push(Assets.getSound("audio/sfxSwallow1.mp3"));
		this.swallow.push(Assets.getSound("audio/sfxSwallow2.mp3"));
		this.swallow.push(Assets.getSound("audio/sfxSwallow3.mp3"));
		this.swallow.push(Assets.getSound("audio/sfxSwallow4.mp3"));
		this.swallow.push(Assets.getSound("audio/sfxSwallow5.mp3"));
		this.swallow.push(Assets.getSound("audio/sfxSwallow6.mp3"));
		this.swallow.push(Assets.getSound("audio/sfxSwallow7.mp3"));
		this.swallow.push(Assets.getSound("audio/sfxSwallow8.mp3"));
		this.swallow.push(Assets.getSound("audio/sfxSwallow9.mp3"));
		this.swallow.push(Assets.getSound("audio/sfxSwallow10.mp3"));
		this.swallow.push(Assets.getSound("audio/sfxSwallow11.mp3"));
		this.swallow.push(Assets.getSound("audio/sfxSwallow12.mp3"));
		this.lick = new Array<Sound>();
		this.lick.push(Assets.getSound("audio/sfxLick1.mp3"));
		this.lick.push(Assets.getSound("audio/sfxLick2.mp3"));
		this.lick.push(Assets.getSound("audio/sfxLick3.mp3"));
		this.lick.push(Assets.getSound("audio/sfxLick4.mp3"));
		this.lick.push(Assets.getSound("audio/sfxLick5.mp3"));
		this.lick.push(Assets.getSound("audio/sfxLick6.mp3"));
		this.lick.push(Assets.getSound("audio/sfxLick7.mp3"));
		this.lick.push(Assets.getSound("audio/sfxLick8.mp3"));
		this.cum = new Array<Sound>();
		this.cum.push(Assets.getSound("audio/sfxCum1.mp3"));
		this.cum.push(Assets.getSound("audio/sfxCum2.mp3"));
		this.cumInside = new Array<Sound>();
		this.cumInside.push(Assets.getSound("audio/sfxCumInside1.mp3"));
		this.cumInside.push(Assets.getSound("audio/sfxCumInside2.mp3"));
		this.grab = Assets.getSound("audio/sfxGrab.mp3");
		this.rub = Assets.getSound("audio/sfxRub.mp3");
		this.intro = Assets.getSound("audio/sfxIntro.mp3");
	}
}
