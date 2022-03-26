package obj.dialogue ;

import openfl.display.MovieClip;
import openfl.events.TimerEvent;
import openfl.media.Sound;
import openfl.text.Font;
import openfl.text.TextFormat;
import openfl.Vector;
import obj.animation.AnimationControl;
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

	// public var tfContainer:MovieClip;
	public var library:DialogueLibrary;
	// public var advancedController:AdvancedDialogueController;
	// public var originalTextFormat:TextFormat;
	// public var originalFont:String;
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
	public var words:Array<Word>;
	public var sayingState:String;
	public var sayingPhrase:String;
	public var sayingWord:UInt = 0;
	public var sayingChar:Int = 0;
	public var sayingSpace:Bool = false;
	public var sayingSpeakingStyle:Bool = false;
	public var waitingToContinue:Bool = false;
	public var queuedPhrase:String = "";
	public var sayingAudio:Sound;
	public var cumulativeMovement:Float = 0;
	public var postEjaculation:Bool = false;
	public var firstThroatSpoken:Bool = false;
	public var states:ASDictionary<String, DialogueState>;
	public var debugMode:Bool = false;
	public var debugBars:ASDictionary<String, DebugBar> = new ASDictionary<String, DebugBar>();

	public function new() {
		super();
		this.x = 0;
		this.y = G.screenSize.y;
		// this.originalTextFormat = this.tfContainer.dialogueField.defaultTextFormat;
		// this.originalFont = this.originalTextFormat.font;
		gotoAndStop("speaking");
		mouseEnabled = false;
		mouseChildren = false;
		this.library = new DialogueLibrary();
		// this.advancedController = new AdvancedDialogueController();
		// DialogueLine.advancedController = this.advancedController;
		this.states = new ASDictionary<String, DialogueState>();
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
			var i = 0;
			var sortedKeys = new Array<String>();
			for (key in this.states.keys()) {
				sortedKeys.push(key);
			}
			sortedKeys.sort(Reflect.compare);
			for (key in sortedKeys) {
                var bar = new DebugBar();
				bar.scaleX = this.states[key].max / MAX_BUILD;
				bar.x = 100;
				bar.y = i * 12 - 550;
				bar.labelField.text = key;
				this.addChild(bar);
				this.debugBars[key] = bar;
				i++;
			}
		}
	}

	public function setDefaultFont() {
		// this.originalTextFormat.font = this.originalFont;
		// this.tfContainer.dialogueField.embedFonts = true;
		// this.tfContainer.dialogueField.defaultTextFormat = this.originalTextFormat;
		// this.tfContainer.dialogueField.setTextFormat(this.originalTextFormat);
	}

	public function setCustomFont(fontName:String) {
		var fonts = new Array<String>();
		for (font in Font.enumerateFonts(true)) {
			fonts.push(font.fontName);
		}
		if (fonts.indexOf(fontName) != -1) {
			this.applyCustomFont(fontName);
		} else {
			for (font in fonts) {
				if (new EReg(fontName, "i").match(font)) {
					this.applyCustomFont(font);
					break;
				}
			}
		}
	}

	public function applyCustomFont(param1:String) {
		// this.originalTextFormat.font = param1;
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

	public function getCurrentDialogue():ASDictionary<String, Array<DialogueLine>> {
		return this.library.getCurrentDialogue();
	}

	public function getCurrentFinishes():ASDictionary<String, Array<DialogueLine>> {
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

	public function loadDialogueMod(param1:DialogueMod) {
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
		for (key in this.states.keys()) {
			this.states[key].clearBuild();
		}
		this.firstThroatSpoken = false;
	}

	public function buildState(param1:String, param2:UInt) {
		if (this.states.exists(param1)) {
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
		if (this.states.exists(param1)) {
			this.states[param1].maxBuild();
		}
	}

	public function interrupt() {
		this.nextLineTimer = 0;
		if (this.sayingSpeakingStyle) {
			G.her.setSpeaking(false);
			if (this.speaking) {
				var charsLeft = this.words[this.sayingWord] != null ? Std.int(this.words[this.sayingWord].length - 1 - this.sayingChar) : 0;
				if (charsLeft < 3) {
					if (this.sayingSpace) {
						this.sayingSpace = false;
						this.currentText += " ";
					}
					var i = 0;
					while (i <= charsLeft) {
						this.currentText += this.nextChar();
						i++;
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
		if (this.speaking && this.sayingSpeakingStyle && this.words[this.sayingWord] != null) {
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
				var stateName = ZERO_STATE;
				var _loc2_ = new Array<String>();
				var _loc3_ = 0;
				for (_tmp_ in this.states.keys()) {
					var _loc4_ = _tmp_;
					if (this.states[_loc4_].build > STATE_THRESHOLD) {
						if (this.states[_loc4_].priority > _loc3_) {
							_loc2_ = new Array<String>();
							_loc3_ = this.states[_loc4_].priority;
						}
						_loc2_.push(_loc4_);
					}
				}
				var _loc5_ = false;
				for (_tmp_ in _loc2_) {
					var _loc4_ = _tmp_;
					if (this.states[_loc4_].build > this.states[stateName].build) {
						stateName = _loc4_;
						if (this.states[stateName].build > 0) {
							_loc5_ = true;
						}
					}
				}
				if (G.her.intro) {
					if (this.states[stateName].build < STATE_THRESHOLD) {
						stateName = INTRO;
						_loc5_ = true;
					}
				}
				if (_loc5_) {
					if (stateName == QUEUED) {
						this.states[QUEUED].clearBuild();
						this.sayRandomPhrase(this.queuedPhrase);
					} else {
						this.sayRandomPhrase(stateName, true);
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
		var lines:Array<DialogueLine> = this.library.getPhrases(param1).copy();

		var canPlayLines = new Array<DialogueLine>();
		for (phrase in lines) {
			if (phrase.canPlay) {
				canPlayLines.push(phrase);
			}
		}

		if (G.dialogue && canPlayLines.length > 0) {
			if (!this.states.exists(param1)) {
				this.states[param1] = new DialogueState(0, 0);
			}
			this.states[param1].clearBuild();
			this.states[param1].delayBuild();
			var idx = this.states[param1].randomPhrase(canPlayLines);
            var phrase = canPlayLines[idx];
			if (phrase != null) {
				if (param1 == FIRST_THROAT && phrase.style == DialogueLine.SPEAKING_STYLE) {
					this.firstThroatSpoken = true;
				}
				if (param2) {
					this.reduceStates();
				}
				this.startSpeakingPhrase(phrase);
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
		for (key in this.states.keys()) {
			this.states[key].reduce();
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
			for (key in this.states.keys()) {
				if (this.debugBars[key] != null) {
					this.debugBars[key].bar.scaleX = this.states[key].build / this.states[key].max;
				}
			}
		}
		var i:UInt = 0;
		while (i < this.dialogueTicks) {
			if (this.speaking) {
				if (this.coughDelay == 0) {
					this.typingDelay = 0;
					if (this.sayingSpace) {
						this.sayingSpace = false;
						var phoneme = new obj.dialogue.Word.Phoneme(
							Her.allMouthShapes[Math.floor(Math.random() * Her.allMouthShapes.length)],
							false
						);
						G.her.setTargetPhoneme(phoneme, 2);
						this.currentText += " ";
						this.updateTextField();
					} else if (this.words[this.sayingWord] != null) {
						if (this.sayingSpeakingStyle) {
                            var targetPhoneme = this.words[this.sayingWord].phoneme(this.sayingChar);
							if (targetPhoneme != null) {
								var idx = Std.int(Math.min(5,
									Math.max(1, this.words[this.sayingWord].phonemeLength(this.sayingChar) * (this.typingSpeed + 1))));
								G.her.setTargetPhoneme(targetPhoneme, idx);
							}
						}
						this.currentText += this.nextChar();
						this.updateTextField();
					} else {
						this.stopSpeaking();
					}
				}
			}
			i++;
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
        var action: ASFunction = null;
        var extraDelay: UInt = 0;
        var queuedName: String = null;

        switch (this.words[this.sayingWord].action) {
            case"SWALLOW":
                action = function() { G.her.swallow(); } // ???
            case"DROOL":
                action = function() { G.her.randomSpitDrool(); } // ???
            case"COUGH":
                action = G.her.cough;
                extraDelay = Std.int(Math.random() * 15) + 5;
            case"CLENCH_TEETH":
                action = G.her.startClenchingTeeth;
                extraDelay = Std.int(Math.random() * 30) + 30;
            case"ARMS_BACK":
                action = function() { G.her.setArmPosition(0); }
            case"ARMS_LEGS":
                action = function() { G.her.setArmPosition(1); }
            case"ARMS_HIS_LEGS":
                action = function() { G.her.setArmPosition(2); }
            case"ARMS_HAND_JOB":
                action = function() { G.her.setArmPosition(3); }
            case"ARMS_LOOSE":
                action = function() { G.her.setArmPosition(4); }
            case"LEFT_ARM_BACK":
                action = function() { G.her.setRightArmPosition(0); }
            case"LEFT_ARM_LEGS":
                action = function() { G.her.setRightArmPosition(1); }
            case"LEFT_ARM_HIS_LEGS":
                action = function() { G.her.setRightArmPosition(2); }
            case"LEFT_ARM_HAND_JOB":
                action = function() { G.her.setRightArmPosition(3); }
            case"LEFT_ARM_LOOSE":
                action = function() { G.her.setRightArmPosition(4); }
            case"RIGHT_ARM_BACK":
                action = function() { G.her.setRightArmPosition(0); }
            case"RIGHT_ARM_LEGS":
                action = function() { G.her.setRightArmPosition(1); }
            case"RIGHT_ARM_HIS_LEGS":
                action = function() { G.her.setRightArmPosition(2); }
            case"RIGHT_ARM_HAND_JOB":
                action = function() { G.her.setRightArmPosition(3); }
            case"RIGHT_ARM_LOOSE":
                action = function() { G.her.setRightArmPosition(4); }
            case"HOLD":
                action = G.her.activeHold; // ???
            case"RELEASE":
                action = G.her.setHandsFree; // ???
            case"SHOCK":
                action = function() { G.her.shock(50); }; // ???
            case"WINCE":
                action = G.her.wince;
            case"CLOSE_EYES":
                action = G.her.closeEye;
            case"OPEN_EYES":
                action = G.her.openEye;
            case"BLINK":
                action = G.her.blink;
            case"LOOK_UP":
                action = G.her.lookUp;
            case"LOOK_DOWN":
                action = G.her.lookDown;
            case"TAP_HANDS":
                action = G.her.tapHands;
            case"NORMAL_MOOD":
                action = function() { G.her.setMood(Her.NORMAL_MOOD); };
            case"HAPPY_MOOD":
                action = function() { G.her.setMood(Her.HAPPY_MOOD); };
            case"ANGRY_MOOD":
                action = function() { G.her.setMood(Her.ANGRY_MOOD); };
            case"AHEGAO_MOOD":
                action = function() { G.her.setMood(Her.AHEGAO_MOOD); };
            case"NORMAL_STYLE":
                action = function() { G.animationControl.setAnimation(AnimationControl.DEFAULT); };
            case"FACE_FUCK_STYLE":
                action = function() { G.animationControl.setAnimation(AnimationControl.FACE_FUCK); };
            case"EJACULATE":
                action = G.him.ejaculate;
            case"ADD_TEARS":
                action = G.her.tears.addTears;
            default:
        }

        if (action == null) {
            this.queuedPhrase = this.words[this.sayingWord].action;
            this.states[QUEUED].maxBuild();
            this.nextWord();
        } else {
            this.pauseSpeakingForAction(extraDelay);
            this.nextWord();
            action();
        }
    }

    public function pauseSpeakingForAction(extraDelay:UInt = 0) {
		G.her.setSpeaking(false);
		if (this.speaking && this.sayingSpeakingStyle) {
			this.sayingChar = -1;
			this.continueDelay = Std.int(Math.ffloor(Math.random() * 5) + 3 + extraDelay);
			this.interruptTimer = Std.int(Math.ffloor(Math.random() * 50) + 60 + extraDelay);
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
		if (param1.nextLine != null) {
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
		this.words = new Array<Word>();
		_loc2_ = (~/([^ \t])\[/gi).replace(_loc2_, "$1 [");
		_loc2_ = (~/\]([^ \t])/gi).replace(_loc2_, "] $1");
		var _loc5_:Array<String> = _loc2_.split(" ");
		for (word in _loc5_) {
			this.words.push(new Word(word));
		}
		(~/\[.*?\]/gi).replace(_loc2_, "");
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
		var _loc4_ = new EReg("\\*([^\\*]*?)" + param2 + "([^\\*]*?)\\*", "g");
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
		return G.customName != null ? G.customName : "";
	}

	public function partnerPosessive():String {
		if (G.customName != null) {
			if (G.customName.charAt(G.customName.length - 1) == "s") {
				return G.customName + "\'";
			}
			return G.customName + "\'s";
		}
		return "";
	}

	public function herName():String {
		return G.characterControl.currentName != null ? G.characterControl.currentName : "";
	}

	public function herPosessive():String {
		if (G.characterControl.currentName != null) {
			if (G.characterControl.currentName.charAt(G.characterControl.currentName.length - 1) == "s") {
				return G.characterControl.currentName + "\'";
			}
			return G.characterControl.currentName + "\'s";
		}
		return "";
	}

	public function finishes():String {
		var _loc1_:Array<DialogueLine> = this.library.getFinishes(G.totalFinishes);
		return _loc1_.length > 0 ? _loc1_[Math.floor(Math.random() * _loc1_.length)].phrase : "";
	}

	public function chooseRandomPhrase(param1:Array<DialogueLine>):DialogueLine {
		return param1.length > 0 ? param1[Math.floor(Math.random() * param1.length)] : new DialogueLine("");
	}

	public function outputLog(param1:String) {
		// G.dialogueEditor.appendLog(param1);
	}
}
