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
	public var lastRandomGrab:UInt = 0;
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
	public var rubSC:SoundChannel;
	public var rubST:SoundTransform;

	public var soundSet(default, null):SoundSet;
	public var soundSetIndex(default, null):UInt;
	public var soundSets:Array<SoundSet> = [];

	public function new() {
		// super();
		this.currentBreathST = new SoundTransform(0, 0);
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

	private static inline function pickRandom(sounds:Array<Dynamic>, lastRandom:UInt):UInt {
        if (sounds.length <= 1) {
            return 0;
        }

		var i = 0;
		do {
			i = Math.floor(Math.random() * sounds.length);
		} while (i == lastRandom);
		return i;
	}

	public function playIntro() {
		var _loc2_:SoundTransform = null;
		var _loc1_ = this.soundSet.intro.play();
		if (_loc1_ != null) {
			_loc2_ = new SoundTransform(1);
			_loc1_.soundTransform = _loc2_;
		}
	}

	public function playTouch() {
		var sound:UInt = pickRandom(this.soundSet.touch, this.lastRandomTouch);
		this.lastRandomTouch = sound;
		var _loc2_:SoundChannel = this.soundSet.touch[sound].play();
		if (_loc2_ != null) {
			var transform = new SoundTransform(0.5, this.leftPan);
			_loc2_.soundTransform = transform;
		}
	}

	public function playDown(param1:Float, param2:Float) {
		var sound:UInt = pickRandom(this.soundSet.down, this.lastRandomDown);
		var _loc3_ = Math.min(1, param2 / 40);
		this.lastRandomDown = sound;
		var _loc5_:SoundChannel = this.soundSet.down[sound].play();
		if (_loc5_ != null) {
			var transform = new SoundTransform(_loc3_, Math.max(this.leftPan, Math.min(this.rightPan, param1 * 2 - 1)));
			_loc5_.soundTransform = transform;
		}
	}

	public function playUp(param1:Float, param2:Float) {
		var sound:UInt = pickRandom(this.soundSet.suck, this.lastRandomSuck);
		var _loc3_ = Math.min(1, param2 / 40);
		this.lastRandomSuck = sound;
		var _loc5_:SoundChannel;
		if ((_loc5_ = this.soundSet.suck[sound].play()) != null) {
			var _loc6_ = new SoundTransform(_loc3_, Math.max(this.leftPan, Math.min(this.rightPan, param1 * 2 - 1)));
			_loc5_.soundTransform = _loc6_;
		}
	}

	public function playGag(param1:Float) {
		var _loc5_:SoundTransform = null;
		var _loc2_ = 0.5 + Math.random() * 0.2;
		var sound:UInt = pickRandom(this.soundSet.gag, this.lastRandomGag);
		this.lastRandomGag = sound;
		var _loc4_:SoundChannel;
		if ((_loc4_ = this.soundSet.gag[sound].play()) != null) {
			_loc5_ = new SoundTransform(_loc2_, Math.max(this.leftPan, Math.min(this.rightPan, param1 * 2 - 1)));
			_loc4_.soundTransform = _loc5_;
		}
	}

	public function playCough() {
		var _loc3_:SoundTransform = null;
		var sound:UInt = pickRandom(this.soundSet.cough, this.lastRandomCough);
		this.lastRandomCough = sound;
		var _loc2_:SoundChannel = this.soundSet.cough[sound].play();
		if (_loc2_ != null) {
			_loc3_ = new SoundTransform(1, this.rightPan);
			_loc2_.soundTransform = _loc3_;
		}
	}

	public function playSplat() {
		var _loc3_:SoundTransform = null;
		var sound:UInt = pickRandom(this.soundSet.splat, this.lastRandomSplat);
		this.lastRandomSplat = sound;
		var _loc2_:SoundChannel = this.soundSet.splat[sound].play();
		if (_loc2_ != null) {
			_loc3_ = new SoundTransform(1, this.rightPan);
			_loc2_.soundTransform = _loc3_;
		}
	}

	public function playPassOut(param1:Float = 0) {
		var _loc4_:SoundTransform = null;
		var sound:UInt = pickRandom(this.soundSet.passOut, this.lastRandomPassOut);
		this.lastRandomPassOut = sound;
		var _loc3_:SoundChannel = this.soundSet.passOut[sound].play();
		if (_loc3_ != null) {
			_loc4_ = new SoundTransform(1, Math.max(this.leftPan, Math.min(this.rightPan, param1 * 2 - 1)));
			_loc3_.soundTransform = _loc4_;
		}
	}

	public function playGrab(param1:Float = 0, param2:Float = 1) {
		var _loc4_:SoundTransform = null;
		var sound:UInt = pickRandom(this.soundSet.grab, this.lastRandomGrab);
		this.lastRandomGrab = sound;
		var _loc3_ = this.soundSet.grab[sound].play();
		if (_loc3_ != null) {
			_loc4_ = new SoundTransform(0.5 * param2, Math.max(this.leftPan, Math.min(this.rightPan, param1 * 2 - 1)));
			_loc3_.soundTransform = _loc4_;
		}
	}

	public function playSwallow(param1:Float = 0) {
		var _loc4_:SoundTransform = null;
		var sound:UInt = pickRandom(this.soundSet.swallow, this.lastRandomSwallow);
		this.lastRandomSwallow = sound;
		var _loc3_:SoundChannel = this.soundSet.swallow[sound].play();
		if (_loc3_ != null) {
			_loc4_ = new SoundTransform(1, Math.max(this.leftPan, Math.min(this.rightPan, param1 * 2 - 1)));
			_loc3_.soundTransform = _loc4_;
		}
	}

	public function playLick(param1:Float = 0) {
		var _loc4_:SoundTransform = null;
		var sound:UInt = pickRandom(this.soundSet.lick, this.lastRandomLick);
		this.lastRandomLick = sound;
		var _loc3_:SoundChannel = this.soundSet.lick[sound].play();
		if (_loc3_ != null) {
			_loc4_ = new SoundTransform(0.4, Math.max(this.leftPan, Math.min(this.rightPan, param1 * 2 - 1)));
			_loc3_.soundTransform = _loc4_;
		}
	}

	public function startRub() {
		if (this.rubSC == null) {
			this.rubSC = this.soundSet.rub.play();
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
		this.cumPlaying = Math.floor(Math.random() * this.soundSet.cum.length);
		if (param1) {
			this.currentCum = this.soundSet.cumInside[this.cumPlaying].play();
		} else {
			this.currentCum = this.soundSet.cum[this.cumPlaying].play();
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
			this.currentCum = this.soundSet.cumInside[this.cumPlaying].play(_loc1_);
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
			this.currentCum = this.soundSet.cum[this.cumPlaying].play(_loc1_);
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
		var _loc2_:SoundTransform = null;
		var sound:UInt = pickRandom(this.soundSet.held, this.lastRandomHold);
		this.lastRandomHold = sound;
		this.currentHoldSound = this.soundSet.held[sound].play();
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
		var sound:UInt = 0;
		if (G.breathing) {
			this.consecutiveCoughs = 0;
			this.playingInBreath = false;
			this.justStartedBreath = true;
			if (G.breathLevel > G.outOfBreathPoint && !G.her.passedOut) {
				sound = pickRandom(this.soundSet.fastBreath, this.lastBreath);
				this.lastBreath = sound;
				this.currentBreathSound = this.soundSet.fastBreath[sound];
				this.currentBreath = this.currentBreathSound.play();
				G.addBreath(-2);
			} else if (G.breathLevel < this.quietBreathingLevel) {
				sound = pickRandom(this.soundSet.quietBreath, this.lastBreath);
				this.lastBreath = sound;
				this.currentBreathSound = this.soundSet.quietBreath[sound];
				this.currentBreath = this.currentBreathSound.play();
				G.addBreath(-0.5);
			} else {
				sound = pickRandom(this.soundSet.normalBreath, this.lastBreath);
				this.lastBreath = sound;
				this.currentBreathSound = this.soundSet.normalBreath[sound];
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
		this.consecutiveCoughs = 0;
		this.playingInBreath = true;
		var sound:UInt = pickRandom(this.soundSet.breatheIn, this.lastInBreath);
		this.lastInBreath = sound;
		this.currentBreathSound = this.soundSet.breatheIn[sound];
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
		this.consecutiveCoughs = 0;
		this.playingInBreath = true;
		var sound:UInt = pickRandom(this.soundSet.suddenBreath, this.lastSuddenBreath);
		this.lastSuddenBreath = sound;
		this.currentBreathSound = this.soundSet.suddenBreath[sound];
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
		var sound:UInt = 0;
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
				sound = pickRandom(this.customCoughs, this.lastRandomOpenCough);
			} else {
				sound = 0;
			}
			this.lastRandomOpenCough = sound;
			this.currentOpenCough = this.customCoughs[sound].audio.play();
			_loc1_ = this.customCoughs[sound].volume;
		} else {
			sound = pickRandom(this.soundSet.openCough, this.lastRandomOpenCough);
			this.lastRandomOpenCough = sound;
			this.currentOpenCough = this.soundSet.openCough[sound].play();
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
        // TODO: config
		setSoundSetByName("Base");
	}

	public function setSoundSetByName(name: String) {
        var i = 0;
        for (soundSet in this.soundSets) {
            if (soundSet.name == name) {
                setSoundSet(i);
                return;
            }
            i++;
        }
    }

    public function setSoundSet(idx:UInt) {
        this.soundSetIndex = idx;
		this.soundSet = this.soundSets[this.soundSetIndex];
		this.cumPlaying = 0;
		this.lastBreath = 0;
		this.lastInBreath = 0;
		this.lastSuddenBreath = 0;
		this.lastRandomGag = 0;
		this.lastRandomHold = 0;
		this.lastRandomCough = 0;
		this.lastRandomOpenCough = 0;
		this.lastRandomDown = 0;
		this.lastRandomSuck = 0;
		this.lastRandomTouch = 0;
		this.lastRandomSplat = 0;
		this.lastRandomPassOut = 0;
		this.lastRandomSwallow = 0;
		this.lastRandomLick = 0;
		this.lastRandomGrab = 0;
		if (this.currentBreath != null) {
			this.currentBreath.stop();
			this.currentBreath = null;
		}
		if (this.currentOpenCough != null) {
			this.currentOpenCough.stop();
			this.currentOpenCough = null;
		}
		if (this.currentHoldSound != null) {
			this.currentHoldSound.stop();
			this.currentHoldSound = null;
		}
		if (this.currentCum != null) {
			this.currentCum.stop();
			this.currentCum = null;
		}
		this.stopRub();
	}
}
