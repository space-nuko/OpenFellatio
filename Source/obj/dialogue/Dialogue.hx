package obj.dialogue ;

import flash.display.MovieClip;
import flash.events.TimerEvent;
import flash.media.Sound;
import flash.text.Font;
import flash.text.TextFormat;
import openfl.Vector;
import obj.AudioMod;
import obj.Her;

class Dialogue extends MovieClip
{
	public static var ZERO_STATE:String = "zero_state";
	public static var RESISTANCE:String = "resistance";
	public static var FIRST_THROAT:String = "first_throat";
	public static var FIRST_DT:String = "first_dt";
	public static var PULL_OFF:String = "pull_off";
	public static var HELD:String = "held";
	public static var WAKE:String = "wake";
	public static var VIGOROUS:String = "vigorous";
	public static var LICK_PENIS:String = "lick_penis";
	public static var LICK_BALLS:String = "lick_balls";
	public static var PRE_CUM:String = "pre_cum";
	public static var CUM_ON_FACE:String = "cum_on_face";
	public static var CUM_IN_MOUTH:String = "cum_in_mouth";
	public static var CUM_IN_THROAT:String = "cum_in_throat";
	public static var CUM_IN_EYE:String = "cum_in_eye";
	public static var CUM_IN_NOSE:String = "cum_in_nose";
	public static var SWALLOW:String = "swallow";
	public static var DROOL:String = "drool";
	public static var HEAD_GRABBED:String = "head_grabbed";
	public static var PULLED_UP:String = "pulled_up";
	public static var PULLED_DOWN:String = "pulled_down";
	public static var HAND_JOB_STROKE:String = "hand_job_stroke";
	public static var QUEUED:String = "queued";
	public static var INTRO:String = "intro";
	public static var GENERAL:String = "general";
	public static var RESTART:String = "restart";
	public static var COUGH:String = "cough";
	public static var INTERRUPT:String = "interrupt";

	public static var ONE_OFF_BUILD:UInt = 120;
	public static var FRAME_BUILD:UInt = 4;
	public static var TICK_BUILD:UInt = 16;
	public static var MAX_BUILD:UInt = 320;
	public static var STATE_THRESHOLD:UInt = 20;
	public static var DIALOGUE_NAME_KEY:String = "dialogue_name";

	public var tfContainer:MovieClip;
	public var library:DialogueLibrary;
	// public var advancedController:AdvancedDialogueController;
	public var originalTextFormat:TextFormat;
	public var originalFont:String;
	public var GENERAL_PHRASE_FREQ:Float = 0.8;
	public var SPEAK_DELAY:UInt = 20;
	public var DEFAULT_TYPING_SPEED:UInt = 55;
	public var typingSpeed:UInt = 55;
	public var typingDelay:UInt = 0;
	public var coughDelay:UInt = 0;
	public var continueDelay:UInt = 0;
	public var lastFrameTime:UInt = 0;
	public var currentTime:UInt = 0;
	public var frameTime:UInt = 0;
	public var dialogueTicks:UInt = 0;
	public var clearTime:UInt = 60;
	public var clearDelay:UInt = 0;
	public var nextLineTimer:Float = 0;
	public var speaking:Bool = false;
	public var interruptTimer:UInt = 0;
	public var showingText:Bool = false;
	public var fadingOut:Bool = false;
	public var fadingIn:Bool = false;
	public var currentText:String;
	public var words:Array<ASAny>;
	public var sayingState:String;
	public var sayingPhrase:String;
	public var sayingWord:UInt = 0;
	public var sayingChar:Int = 0;
	public var sayingSpace:Bool = false;
	public var sayingSpeakingStyle:Bool = false;
	public var waitingToContinue:Bool = false;
	public var queuedPhrase:String = "";
	public var sayingAudio:Sound;
	public var audioCues:Array<ASAny>;
	public var cumulativeMovement:Float = 0;
	public var postEjaculation:Bool = false;
	public var firstThroatSpoken:Bool = false;
	public var states:ASDictionary<ASAny, ASAny>;
	public var debugMode:Bool = false;
	public var debugBars:ASDictionary<ASAny, ASAny>;

	public function new() {
		var _loc1_:UInt = 0;
		var _loc2_:Array<ASAny> = null;
		var _loc3_:ASAny = null;
		var _loc4_:DebugBar = null;
		this.debugBars = new ASDictionary<ASAny, ASAny>();
		super();
		this.x = 0;
		this.y = G.screenSize.y;
		// this.originalTextFormat = this.tfContainer.dialogueField.defaultTextFormat;
		this.originalFont = this.originalTextFormat.font;
		gotoAndStop("speaking");
		mouseEnabled = false;
		mouseChildren = false;
		this.library = new DialogueLibrary();
		// this.advancedController = new AdvancedDialogueController();
		// DialogueLine.advancedController = this.advancedController;
		this.states = new ASDictionary<ASAny, ASAny>();
		this.states[ZERO_STATE] = new DialogueState(0, 0);
		this.states[HEAD_GRABBED] = new DialogueState(MAX_BUILD, 1);
		this.states[PULLED_UP] = new DialogueState(MAX_BUILD, 0);
		this.states[PULLED_DOWN] = new DialogueState(MAX_BUILD, 0);
		this.states[RESISTANCE] = new DialogueState(MAX_BUILD, 0);
		this.states[FIRST_THROAT] = new DialogueState(MAX_BUILD + 80, 1);
		this.states[FIRST_DT] = new DialogueState(MAX_BUILD + 80, 2);
		this.states[PULL_OFF] = new DialogueState(MAX_BUILD, 0);
		this.states[HELD] = new DialogueState(MAX_BUILD + 160, 0);
		this.states[WAKE] = new DialogueState(MAX_BUILD + 80, 4);
		this.states[LICK_PENIS] = new DialogueState(MAX_BUILD, 1);
		this.states[LICK_BALLS] = new DialogueState(MAX_BUILD, 1);
		this.states[VIGOROUS] = new DialogueState(MAX_BUILD + 100, 0);
		this.states[PRE_CUM] = new DialogueState(MAX_BUILD, 2);
		this.states[CUM_ON_FACE] = new DialogueState(MAX_BUILD + 240, 3, 0.1);
		this.states[CUM_IN_MOUTH] = new DialogueState(MAX_BUILD + 240, 3, 0.1);
		this.states[CUM_IN_THROAT] = new DialogueState(MAX_BUILD + 240, 3, 0.1);
		this.states[CUM_IN_NOSE] = new DialogueState(MAX_BUILD + 240, 4, 0.1);
		this.states[SWALLOW] = new DialogueState(MAX_BUILD + 80, 0);
		this.states[DROOL] = new DialogueState(MAX_BUILD + 80, 1);
		this.states[RESTART] = new DialogueState(MAX_BUILD + 160, 2);
		this.states[HAND_JOB_STROKE] = new DialogueState(MAX_BUILD + 100, 0);
		this.states[QUEUED] = new DialogueState(MAX_BUILD + 300, 5, 0.1);
		this.states[INTRO] = new DialogueState(0, 0);
		this.states[GENERAL] = new DialogueState(0, 0);
		this.states[CUM_IN_EYE] = new DialogueState(0, 0);
		if (!this.debugMode) {
			this.alpha = 0;
		}
		this.readyToSpeak();
		if (this.debugMode) {
			_loc1_ = 0;
			_loc2_ = new Array<ASAny>();
			for (_tmp_ in this.states.keys()) {
				_loc3_ = _tmp_;
				_loc2_.push(_loc3_);
			}
			_loc2_.sort(Reflect.compare);
			for (_tmp_ in _loc2_) {
				_loc3_ = _tmp_;
				(_loc4_ = new DebugBar()).scaleX = this.states[_loc3_].max / MAX_BUILD;
				_loc4_.x = 100;
				_loc4_.y = _loc1_ * 12 - 550;
				_loc4_.labelField.text = _loc3_;
				this.addChild(_loc4_);
				this.debugBars[_loc3_] = _loc4_;
				_loc1_++;
			}
		}
	}

	public function setDefaultFont() {
		this.originalTextFormat.font = this.originalFont;
		// this.tfContainer.dialogueField.embedFonts = true;
		// this.tfContainer.dialogueField.defaultTextFormat = this.originalTextFormat;
		// this.tfContainer.dialogueField.setTextFormat(this.originalTextFormat);
	}

	public function setCustomFont(param1:String) {
		var _loc4_:Font = null;
		var _loc5_:String = null;
		var _loc2_ = Font.enumerateFonts(true);
		var _loc3_ = new Array<ASAny>();
		for (_tmp_ in _loc2_) {
			_loc4_ = _tmp_;
			_loc3_.push(_loc4_.fontName);
		}
		if (_loc3_.indexOf(param1) != -1) {
			this.applyCustomFont(param1);
		} else {
			for (_tmp_ in _loc3_) {
				_loc5_ = _tmp_;
				if (new compat.RegExp(param1, "i").match(_loc5_) != null) {
					this.applyCustomFont(_loc5_);
					break;
				}
			}
		}
	}

	public function applyCustomFont(param1:String) {
		this.originalTextFormat.font = param1;
		// this.tfContainer.dialogueField.embedFonts = false;
		// this.tfContainer.dialogueField.defaultTextFormat = this.originalTextFormat;
		// this.tfContainer.dialogueField.setTextFormat(this.originalTextFormat);
	}

	public function resetCustomDialogue(param1:Bool = true) {
		var _loc2_:DialogueState = null;
		this.library.resetCustomDialogue();
		for (_tmp_ in this.states) {
			_loc2_ = _tmp_;
			_loc2_.clearPrevPhrases();
		}
		if (param1) {
			G.saveData.clearCustomDialogue();
		}
		this.setDefaultFont();
	}

	public function getCurrentDialogue():ASDictionary<ASAny, ASAny> {
		return this.library.getCurrentDialogue();
	}

	public function getCurrentFinishes():ASDictionary<ASAny, ASAny> {
		return this.library.getCurrentFinishes();
	}

	public function getCurrentLibraryName():String {
		return this.library.libraryName;
	}

	public function loadFromDialogueEditor(param1:Vector<DialogueEditorLine>, param2:Bool = true) {
		this.library.loadFromDialogueEditor(param1);
		if (param2) {
			G.saveData.saveCustomDialogue(this.library.exportLibrary());
		}
	}

	public function loadDialogueMod(param1:ASAny) {
		this.library.loadDialogueMod(param1);
	}

	public function setupDialogueMod(param1:String, param2:Bool) {
		this.library.setupDialogueMod(param1, param2);
	}

	public function loadCustomDialogue(param1:String, param2:Bool = true) {
		var _loc3_:DialogueState = null;
		if (param1 != "") {
			this.library.loadCustomDialogue(param1);
			for (_tmp_ in this.states) {
				_loc3_ = _tmp_;
				_loc3_.clearPrevPhrases();
			}
		}
		if (param2) {
			G.saveData.saveCustomDialogue(this.library.exportLibrary());
		}
	}

	public function exportDialogue():String {
		return this.library.exportLibrary();
	}

	public function setDialogueLibraryName(param1:String) {
		this.library.setDialogueLibraryName(param1);
	}

	public function dialogueToggled() {
		if (!G.dialogue && this.speaking) {
			this.stopSpeaking();
			this.clearDelay = this.clearTime;
		}
	}

	public function instantStop() {
		if (this.speaking) {
			this.stopSpeaking();
		}
		this.alpha = 0;
		this.fadingIn = false;
		this.fadingOut = false;
		this.sayingSpace = false;
	}

	public function reset() {
		this.clearStates();
		this.postEjaculation = false;
		if (this.speaking) {
			this.stopSpeaking();
		}
		this.sayingSpace = false;
	}

	public function triggerState(param1:String) {
		this.sayRandomPhrase(param1);
	}

	public function readyToSpeak() {
		this.nextLineTimer = 0;
	}

	public function movement(param1:Float) {
		if (this.postEjaculation) {
			this.cumulativeMovement += param1 > 0 ? param1 : -param1;
			if (this.cumulativeMovement > 100) {
				this.buildState(RESTART, MAX_BUILD);
				this.postEjaculation = false;
			}
		}
	}

	public function doneEjaculating() {
		this.cumulativeMovement = 0;
		this.postEjaculation = true;
	}

	public function clearStates() {
		var _loc1_:ASAny = null;
		for (_tmp_ in this.states.keys()) {
			_loc1_ = _tmp_;
			this.states[_loc1_].clearBuild();
		}
		this.firstThroatSpoken = false;
	}

	public function buildState(param1:String, param2:UInt) {
		if (this.states[param1]) {
			if (param1 == FIRST_THROAT && this.firstThroatSpoken) {
				return;
			}
			this.states[param1].buildState(param2);
			if (this.speaking
				&& this.sayingSpeakingStyle
				&& (param1 == CUM_ON_FACE || param1 == CUM_IN_MOUTH || param1 == CUM_IN_THROAT || param1 == CUM_IN_EYE)
				&& (this.sayingState != CUM_ON_FACE && this.sayingState != CUM_IN_MOUTH && this.sayingState != CUM_IN_THROAT && this.sayingState != CUM_IN_EYE)) {
				this.currentText += "-";
				this.updateTextField();
				this.stopSpeaking();
			}
		}
	}

	public function maxState(param1:String) {
		if (this.states[param1]) {
			this.states[param1].maxBuild();
		}
	}

	public function interrupt() {
		var _loc1_:UInt = 0;
		var _loc2_:UInt = 0;
		this.nextLineTimer = 0;
		if (this.sayingSpeakingStyle) {
			G.her.setSpeaking(false);
			if (this.speaking) {
				_loc1_ = this.words[this.sayingWord] ? Std.int(this.words[this.sayingWord].length - 1 - this.sayingChar) : 0;
				if (_loc1_ < 3) {
					if (this.sayingSpace) {
						this.sayingSpace = false;
						this.currentText += " ";
					}
					_loc2_ = 0;
					while (_loc2_ <= _loc1_) {
						this.currentText += this.nextChar();
						_loc2_++;
					}
				} else {
					this.sayingChar = 0;
				}
				this.currentText += this.randomInterrupt();
				this.sayingSpace = true;
				this.updateTextField();
				if (this.interruptTimer == 0) {
					this.interruptTimer = Std.int(Math.ffloor(Math.random() * 50) + 60);
				}
				this.continueDelay = Std.int(Math.ffloor(Math.random() * 5) + 3);
				G.soundControl.pauseDialogue();
				this.speaking = false;
				this.waitingToContinue = true;
				this.clearDelay = 0;
			}
		}
	}

	public function cough():AudioMod {
		var _loc1_:UInt = 0;
		var _loc2_:String = null;
		var _loc3_:UInt = 0;
		if (this.speaking && this.sayingSpeakingStyle && this.words[this.sayingWord]) {
			_loc1_ = this.words[this.sayingWord].length - 1 - this.sayingChar;
			if (_loc1_ < 3) {
				if (this.sayingSpace) {
					this.sayingSpace = false;
					this.currentText += " ";
				}
				_loc3_ = 0;
				while (_loc3_ <= _loc1_) {
					this.currentText += this.nextChar();
					_loc3_++;
				}
			} else {
				this.sayingChar = 0;
			}
			_loc2_ = this.randomCough();
			this.currentText += this.randomCough();
			this.sayingSpace = true;
			this.updateTextField();
			this.coughDelay = 20;
			this.clearDelay = 0;
			return this.library.playInterruptAudio(_loc2_);
		}
		return null;
	}

	public function checkForSpeechStart() {
		var _loc1_:String = null;
		var _loc2_:Array<ASAny> = null;
		var _loc3_:UInt = 0;
		var _loc4_:ASAny = null;
		var _loc5_ = false;
		if (G.dialogue) {
			if (this.interruptTimer > 0) {
				if (this.waitingToContinue) {
					if (G.her.canSpeak()) {
						if (this.continueDelay > 0) {
							--this.continueDelay;
						} else {
							this.continueSpeaking();
						}
					}
				} else if (this.continueDelay > 0) {
					--this.continueDelay;
				} else {
					this.continueSpeaking();
				}
			}
			this.nextLineTimer += Math.max(Math.random() * 0.2, this.speechUrgency());
			if (this.nextLineTimer > this.SPEAK_DELAY && !this.speaking && !this.waitingToContinue) {
				_loc1_ = ZERO_STATE;
				_loc2_ = new Array<ASAny>();
				_loc3_ = 0;
				for (_tmp_ in this.states.keys()) {
					_loc4_ = _tmp_;
					if (this.states[_loc4_].build > STATE_THRESHOLD) {
						if (this.states[_loc4_].priority > _loc3_) {
							_loc2_ = new Array<ASAny>();
							_loc3_ = this.states[_loc4_].priority;
						}
						_loc2_.push(_loc4_);
					}
				}
				_loc5_ = false;
				for (_tmp_ in _loc2_) {
					_loc4_ = _tmp_;
					if (this.states[_loc4_].build > this.states[_loc1_].build) {
						_loc1_ = _loc4_;
						if (this.states[_loc1_].build > 0) {
							_loc5_ = true;
						}
					}
				}
				if (G.her.intro) {
					if (this.states[_loc1_].build < STATE_THRESHOLD) {
						_loc1_ = INTRO;
						_loc5_ = true;
					}
				}
				if (_loc5_) {
					if (_loc1_ == QUEUED) {
						this.states[QUEUED].clearBuild();
						this.sayRandomPhrase(this.queuedPhrase);
					} else {
						this.sayRandomPhrase(_loc1_, true);
					}
				} else if (Math.random() < this.GENERAL_PHRASE_FREQ) {
					this.sayRandomPhrase(GENERAL);
				} else {
					this.nextLineTimer = 0;
				}
			}
		}
	}

	public function reduceStates() {
		var _loc1_:DialogueState = null;
		for (_tmp_ in this.states) {
			_loc1_ = _tmp_;
			_loc1_.reduce(ONE_OFF_BUILD * 2);
		}
	}

	public function speechUrgency():Float {
		var _loc3_:DialogueState = null;
		var _loc1_:UInt = 0;
		var _loc2_:UInt = 0;
		for (_tmp_ in this.states) {
			_loc3_ = _tmp_;
			_loc1_ += Std.int(_loc3_.build);
			_loc2_++;
		}
		return _loc1_ / MAX_BUILD;
	}

	public function sayRandomPhrase(param1:String, param2:Bool = false) {
		var _loc5_:DialogueLine = null;
		var _loc6_:UInt = 0;
		var _loc7_:DialogueLine = null;
		var _loc3_:Array<ASAny> = this.library.getPhrases(param1).copy();
		var _loc4_ = new Array<ASAny>();
		for (_tmp_ in _loc3_) {
			_loc5_ = _tmp_;
			if (_loc5_.canPlay) {
				_loc4_.push(_loc5_);
			}
		}
		if (G.dialogue && _loc4_.length > 0) {
			if (!this.states[param1]) {
				this.states[param1] = new DialogueState(0, 0);
			}
			this.states[param1].clearBuild();
			this.states[param1].delayBuild();
			_loc6_ = this.states[param1].randomPhrase(_loc4_);
			if ((_loc7_ = _loc4_[_loc6_]) != null) {
				if (param1 == FIRST_THROAT && _loc7_.style == DialogueLine.SPEAKING_STYLE) {
					this.firstThroatSpoken = true;
				}
				if (param2) {
					this.reduceStates();
				}
				this.startSpeakingPhrase(_loc7_);
				this.sayingState = param1;
				this.nextLineTimer = 0;
			}
		} else {
			this.nextLineTimer = 0;
		}
	}

	public function tick(param1:TimerEvent) {
		this.update();
	}

	public function update() {
		var _loc1_:ASAny = null;
		var _loc3_:ASAny = null;
		var _loc4_:ASObject = null;
		var _loc5_:ASObject = null;
		var _loc6_:UInt = 0;
		for (_tmp_ in this.states.keys()) {
			_loc1_ = _tmp_;
			this.states[_loc1_].reduce();
		}
		if (this.interruptTimer > 0) {
			--this.interruptTimer;
			if (this.interruptTimer == 0 && !this.speaking) {
				this.stopSpeaking();
				G.soundControl.stopDialogue();
			}
		}
		if (this.coughDelay > 0) {
			--this.coughDelay;
		}
		this.currentTime = Std.int(Date.now().getTime());
		if (this.lastFrameTime == 0) {
			this.lastFrameTime = this.currentTime;
		}
		this.frameTime = this.currentTime - this.lastFrameTime;
		this.lastFrameTime = this.currentTime;
		this.dialogueTicks = Math.floor(this.frameTime / this.typingSpeed);
		this.lastFrameTime -= this.frameTime % this.typingSpeed;
		G.soundControl.updateDialogue();
		if (this.debugMode) {
			for (_tmp_ in this.states.keys()) {
				_loc3_ = _tmp_;
				if (this.debugBars[_loc3_]) {
					this.debugBars[_loc3_].bar.scaleX = this.states[_loc3_].build / this.states[_loc3_].max;
				}
			}
		}
		var _loc2_:UInt = 0;
		while (_loc2_ < this.dialogueTicks) {
			if (this.speaking) {
				if (this.coughDelay == 0) {
					this.typingDelay = 0;
					if (this.sayingSpace) {
						this.sayingSpace = false;
						_loc4_ = {
							"phoneme": Her.allMouthShapes[Math.floor(Math.random() * Her.allMouthShapes.length)],
							"sayL": false
						};
						G.her.setTargetPhoneme(_loc4_, 2);
						this.currentText += " ";
						this.updateTextField();
					} else if (this.words[this.sayingWord]) {
						if (this.sayingSpeakingStyle) {
							if (_loc5_ = this.words[this.sayingWord].phoneme(this.sayingChar)) {
								_loc6_ = Std.int(Math.min(5,
									Math.max(1, this.words[this.sayingWord].phonemeLength(this.sayingChar) * (this.typingSpeed + 1))));
								G.her.setTargetPhoneme(_loc5_, _loc6_);
							}
						}
						this.currentText += this.nextChar();
						this.updateTextField();
					} else {
						this.stopSpeaking();
					}
				}
			}
			_loc2_++;
		}
		if (!this.speaking) {
			if (this.showingText && !this.waitingToContinue) {
				if (this.clearDelay < this.clearTime) {
					++this.clearDelay;
				} else {
					if (!this.debugMode) {
						this.fade(false);
					}
					this.showingText = false;
					this.updateTextField();
				}
			}
			this.checkForSpeechStart();
		}
		if (this.fadingOut) {
			this.alpha = Math.max(0, this.alpha - 0.05);
			if (this.alpha == 0) {
				this.fadingOut = false;
			}
		} else if (this.fadingIn) {
			this.alpha = Math.min(1, this.alpha + 0.15);
			if (this.alpha == 1) {
				this.fadingIn = false;
			}
		}
	}

	public function nextChar():String {
		var _loc1_:String = null;
		if (this.speaking) {
			if (this.sayingWord >= (this.words.length : UInt)) {
				this.stopSpeaking();
				return "";
			}
			_loc1_ = this.words[this.sayingWord].letter(this.sayingChar);
			if (this.sayingChar == 0 && this.words[this.sayingWord].actionWord) {
				this.checkWordAction();
				return "";
			}
			++this.sayingChar;
			if (this.sayingChar >= this.words[this.sayingWord].length && this.sayingWord < (this.words.length - 1:UInt)) {
				this.sayingSpace = true;
			}
			if (this.sayingChar >= this.words[this.sayingWord].length) {
				this.nextWord();
			}
			return _loc1_;
		}
		return "";
	}

	public function nextWord() {
		this.sayingChar = 0;
		++this.sayingWord;
	}

	public function checkWordAction() {
		/*
		 * Decompilation error
		 * Code may be obfuscated
		 * Tip: You can try enabling "Automatic deobfuscation" in Settings
		 * Error type: NullPointerException (null)
		 */
		throw new flash.errors.IllegalOperationError("Not decompiled due to error");
	}

	public function pauseSpeakingForAction(param1:UInt = 0) {
		G.her.setSpeaking(false);
		if (this.speaking && this.sayingSpeakingStyle) {
			this.sayingChar = -1;
			this.continueDelay = Std.int(Math.ffloor(Math.random() * 5) + 3 + param1);
			this.interruptTimer = Std.int(Math.ffloor(Math.random() * 50) + 60 + param1);
			G.soundControl.pauseDialogue();
			this.speaking = false;
			this.clearDelay = 0;
			this.waitingToContinue = true;
		}
	}

	public function continueSpeaking() {
		this.waitingToContinue = false;
		if (this.sayingSpeakingStyle) {
			G.her.setSpeaking(true);
		}
		G.soundControl.resumeDialogue();
		this.speaking = true;
	}

	public function startSpeakingPhrase(param1:DialogueLine) {
		var _loc4_:Sound = null;
		var _loc6_:String = null;
		var _loc2_ = param1.phrase;
		this.outputLog("Playing line \"" + _loc2_ + "\"");
		if (param1.style == DialogueLine.SPEAKING_STYLE) {
			G.her.setSpeaking(true);
			this.sayingSpeakingStyle = true;
		} else {
			this.sayingSpeakingStyle = false;
		}
		switch (param1.style) {
			case(_ == DialogueLine.SPEAKING_STYLE => true) | (_ == DialogueLine.THOUGHT_STYLE => true):
				gotoAndStop("thought");

			case(_ == DialogueLine.HIM_STYLE => true):
				gotoAndStop("him");

			default:
				gotoAndStop("speaking");
		}
		this.waitingToContinue = false;
		if (ASCompat.stringAsBool(param1.nextLine)) {
			this.queuedPhrase = param1.nextLine;
			this.states[QUEUED].maxBuild();
		}
		// this.advancedController.readAdvancedLineSettings(param1);
		var _loc3_:AudioMod = this.library.playAudio(_loc2_);
		if (_loc3_ != null) {
			_loc4_ = _loc3_.audio;
			this.sayingAudio = _loc4_;
		}
		// _loc2_ = unescape(_loc2_);
		this.sayingPhrase = _loc2_;
		_loc2_ = this.replaceTokens(this.sayingPhrase);
		this.currentText = "";
		this.showingText = true;
		this.updateTextField();
		this.fade(true);
		this.sayingWord = 0;
		this.sayingChar = 0;
		this.words = new Array<ASAny>();
		_loc2_ = new compat.RegExp("(\\S)\\[", "gi").replace(_loc2_, "$1 [");
		_loc2_ = new compat.RegExp("\\](\\S)", "gi").replace(_loc2_, "] $1");
		var _loc5_:Array<ASAny> = (cast _loc2_.split(" "));
		for (_tmp_ in _loc5_) {
			_loc6_ = _tmp_;
			this.words.push(new Word(_loc6_));
		}
		new compat.RegExp("\\[.*?\\]", "gi").replace(_loc2_, "");
		if (_loc4_ != null) {
			this.typingSpeed = Std.int(_loc4_.length / _loc2_.length);
		} else {
			this.typingSpeed = this.DEFAULT_TYPING_SPEED;
		}
		this.nextLineTimer = 0;
		this.typingDelay = 0;
		this.speaking = true;
	}

	public function stopSpeaking() {
		G.her.setSpeaking(false);
		this.waitingToContinue = false;
		this.speaking = false;
		this.sayingState = "";
		this.interruptTimer = 0;
		this.clearDelay = 0;
	}

	public function fade(param1:Bool) {
		this.fadingOut = !param1;
		this.fadingIn = param1;
	}

	public function replaceTokens(param1:String):String {
		param1 = this.smartReplace(param1, "FINISHES", this.finishes);
		param1 = this.smartReplace(param1, "YOUR", this.partnerPosessive);
		param1 = this.smartReplace(param1, "YOU", this.partnerName);
		param1 = this.smartReplace(param1, "ME", this.herName);
		param1 = this.smartReplace(param1, "MY", this.herPosessive);
		// return this.advancedController.replaceValues(param1);
		return param1;
	}

	public function smartReplace(param1:String, param2:String, param3:ASFunction):String {
		var _loc4_ = new compat.RegExp("\\*([^\\*]*?)" + param2 + "([^\\*]*?)\\*", "g");
		if (param3() != "") {
			return _loc4_.replace(param1, "$1" + param3() + "$2");
		}
		return _loc4_.replace(param1, "");
	}

	public function updateTextField() {
		// this.tfContainer.dialogueField.text = this.currentText;
		// this.tfContainer.dialogueField.scrollV = Math.max(0,this.tfContainer.dialogueField.numLines - 1);
	}

	public function randomInterrupt():String {
		var _loc1_:String = this.chooseRandomPhrase(this.library.getPhrases(INTERRUPT)).phrase;
		this.library.playInterruptAudio(_loc1_);
		return _loc1_;
	}

	public function randomCough():String {
		return this.chooseRandomPhrase(this.library.getPhrases(COUGH)).phrase;
	}

	public function partnerName():String {
		return !!ASCompat.stringAsBool(G.customName) ? G.customName : "";
	}

	public function partnerPosessive():String {
		if (ASCompat.stringAsBool(G.customName)) {
			if (G.customName.charAt(G.customName.length - 1) == "s") {
				return G.customName + "\'";
			}
			return G.customName + "\'s";
		}
		return "";
	}

	public function herName():String {
		return !!ASCompat.stringAsBool(G.characterControl.currentName) ? G.characterControl.currentName : "";
	}

	public function herPosessive():String {
		if (ASCompat.stringAsBool(G.characterControl.currentName)) {
			if (G.characterControl.currentName.charAt(G.characterControl.currentName.length - 1) == "s") {
				return G.characterControl.currentName + "\'";
			}
			return G.characterControl.currentName + "\'s";
		}
		return "";
	}

	public function finishes():String {
		var _loc1_:Array<ASAny> = this.library.getFinishes(G.totalFinishes);
		return _loc1_.length > 0 ? _loc1_[Math.floor(Math.random() * _loc1_.length)].phrase : "";
	}

	public function chooseRandomPhrase(param1:Array<ASAny>):DialogueLine {
		return param1.length > 0 ? param1[Math.floor(Math.random() * param1.length)] : new DialogueLine("");
	}

	public function outputLog(param1:String) {
		// G.dialogueEditor.appendLog(param1);
	}
}
