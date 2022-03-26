package obj.dialogue;

import obj.AudioMod;
import obj.Her;
import openfl.Vector;

private typedef DialogueLib = ASDictionary<String, Array<DialogueLine>>;

class DialogueLibrary {
	public static var DEFAULT_NAME:String = "Default";
	public static var allDialogueTypes:Array<String>;

	public var dialogueLibraryName:String = "Default";

	public var normalLibrary:DialogueLib;
	public var happyLibrary:DialogueLib;
	public var angryLibrary:DialogueLib;
	public var ahegaoLibrary:DialogueLib;
	public var finishes:DialogueLib;
	public var customLibrary:DialogueLib;
	public var customFinishes:DialogueLib;

	public var OTHER_FINISH:String = "Other";

	// public var initialSettingsObject:ASObject;
	public var customAudio:ASDictionary<String, AudioMod>;
	public var customClears:ASDictionary<String, Bool>;
	public var allCleared:Bool = false;
	public var finishesCleared:Bool = false;
	public var dialogueTypes:Array<String>;
	public var dialogueTypesPattern:EReg;

	public function new() {
		this.prepareLibraries();
		this.prepareTypeArray();
		for (dialogueType in this.dialogueTypes) {
			this.checkMissingDialogue(this.normalLibrary, dialogueType);
			this.checkMissingDialogue(this.happyLibrary, dialogueType);
			this.checkMissingDialogue(this.angryLibrary, dialogueType);
			this.checkMissingDialogue(this.ahegaoLibrary, dialogueType);
		}
		this.customLibrary = new DialogueLib();
		this.customClears = new ASDictionary<String, Bool>();
		this.customAudio = new ASDictionary<String, AudioMod>();
	}

	public function checkMissingDialogue(param1:DialogueLib, param2:String) {
		if (param1[param2] == null) {
			param1[param2] = [];
		}
	}

	@:flash.property public var libraryName(get, never):String;

	function get_libraryName():String {
		return this.dialogueLibraryName;
	}

	public function setLibraryName(param1:String) {
		this.dialogueLibraryName = param1;
		G.inGameMenu.setDialogueLibraryName(this.dialogueLibraryName);
	}

	public function getMoodLibrary():DialogueLib {
		switch (G.her.mood) {
			case Her.ANGRY_MOOD:
				return this.angryLibrary;
			case Her.HAPPY_MOOD:
				return this.happyLibrary;
			case Her.AHEGAO_MOOD:
				return this.ahegaoLibrary;

			default:
		}
		return this.normalLibrary;
	}

	public function getCurrentDialogue(): DialogueLib {
		var result = new DialogueLib();
		for (id in this.dialogueTypes) {
			if (this.customLibrary[id] != null) {
				result[id] = this.customLibrary[id];
			} else if (!this.allCleared) {
				result[id] = this.getMoodLibrary()[id];
			}
		}
		for (id in this.customLibrary.keys()) {
			if (this.getMoodLibrary()[id] == null) {
				result[id] = this.customLibrary[id];
			}
		}
		return result;
	}

	public function getCurrentFinishes():DialogueLib {
		var result = new DialogueLib();
		if (this.finishesCleared) {
			for (id in this.customFinishes.keys()) {
				result[id] = this.customFinishes[id];
			}
		} else {
			for (id in this.finishes.keys()) {
				result[id] = this.finishes[id];
			}
		}
		return result;
	}

	public function getPhrases(param1:String):Array<DialogueLine> {
		if (this.customClears.exists(param1) || this.allCleared || !this.getMoodLibrary().exists(param1)) {
			return if (this.customLibrary.exists(param1)) this.customLibrary[param1] else [];
		}
        var mood = this.getMoodLibrary()[param1];
        var custom = if (this.customLibrary.exists(param1)) this.customLibrary[param1] else [];
		return ASCompat.thisOrDefault(mood, []).concat(custom);
	}

	public function getFinishes(finishes:UInt):Array<DialogueLine> {
        var id = Std.string(finishes);
		if (this.finishesCleared) {
			if (this.customFinishes.exists(id)) {
				return this.customFinishes[id];
			}
			return this.customFinishes.exists(this.OTHER_FINISH) ? this.customFinishes[this.OTHER_FINISH] : [];
		}
		if (this.customFinishes.exists(id)) {
			return this.customFinishes[id];
		}
		if (this.finishes.exists(id) || this.customFinishes.exists(id)) {
            var finishes = if (this.finishes.exists(id)) this.finishes[id] else [];
            var customFinishes = if (this.customFinishes.exists(id)) this.customFinishes[id] else [];
			return finishes.concat(customFinishes);
		}

        var finishes = if (this.finishes.exists(this.OTHER_FINISH)) this.finishes[this.OTHER_FINISH] else [];
        var customFinishes = if (this.customFinishes.exists(this.OTHER_FINISH)) this.customFinishes[this.OTHER_FINISH] else [];
		return finishes.concat(customFinishes);
	}

	public function playAudio(id:String):AudioMod {
		var audio:AudioMod = this.customAudio[id];
		if (audio != null) {
			G.soundControl.playDialogue(audio);
			return audio;
		}
		return null;
	}

	public function playInterruptAudio(id:String):AudioMod {
		var audio:AudioMod = this.customAudio[id];
		if (audio != null) {
			G.soundControl.playDialogueInterrupt(audio);
			return audio;
		}
		return null;
	}

	public function resetCustomDialogue() {
		this.customLibrary = new DialogueLib();
		this.customClears = new ASDictionary<String, Bool>();
		this.customFinishes = new DialogueLib();
		this.customAudio = new ASDictionary<String, AudioMod>();
		this.allCleared = false;
		this.finishesCleared = false;
		this.setLibraryName(DEFAULT_NAME);
		G.soundControl.resetAudioMods();
	}

	public function setDialogueLibraryName(param1:String) {
		this.dialogueLibraryName = param1;
	}

	public function setupDialogueMod(param1:String, param2:Bool) {
		this.setLibraryName(param1);
		if (param2) {
			this.resetCustomDialogue();
			this.allCleared = true;
		}
	}

	public function loadDialogueMod(param1:DialogueMod) {
		var lineType = param1.lineType;
		var dialogueLine = param1.dialogueLine;
		if (!this.customLibrary.exists(lineType)) {
			this.customLibrary[lineType] = new Array<DialogueLine>();
		}
		this.customLibrary[lineType].push(new DialogueLine(dialogueLine));
		if (param1.audio != null && !Math.isNaN(param1.volume)) {
			var audio = new AudioMod(param1.audio, param1.volume);
			this.customAudio[dialogueLine] = audio;
			if (lineType == "cough") {
				G.soundControl.loadAudioMod("cough", audio);
			}
		}
	}

	public function loadFromDialogueEditor(lines:Vector<DialogueEditorLine>) {
		var finishes = new DialogueLib();
		this.allCleared = true;
		for (line in lines) {
			if (line.finish) {
				var trigger = StringTools.replace(line.trigger, "finish", "");
				if (finishes[trigger] == null) {
					finishes[trigger] = new Array<DialogueLine>();
				}
				finishes[trigger].push(line.getDialogueLine());
			} else {
				if (this.customLibrary[line.trigger] == null) {
					this.customLibrary[line.trigger] = new Array<DialogueLine>();
				}
				this.customLibrary[line.trigger].push(line.getDialogueLine());
			}
		}
		this.finishesCleared = true;
		this.customFinishes = finishes;
	}

	public function loadCustomDialogue(param1:String) {
		/*
		 * Decompilation error
		 * Code may be obfuscated
		 * Tip: You can try enabling "Automatic deobfuscation" in Settings
		 * Error type: NullPointerException (null)
		 */
        // TODO
	}

	public function customLibraryPopulator():String {
		/*
		 * Decompilation error
		 * Code may be obfuscated
		 * Tip: You can try enabling "Automatic deobfuscation" in Settings
		 * Error type: NullPointerException (null)
		 */
        // TODO
        return "";
	}

	public function customFinishPopulator():String {
		// var _loc2_ = Math.NaN;
		// if (/*TODO*/ arguments.length - 3 == 2) {
		// 	_loc2_ = ASCompat.toNumber((/*TODO*/ arguments : ASAny)[1]);
		// 	if (!Math.isNaN(_loc2_)) {
		// 		if (!this.customFinishes[_loc2_]) {
		// 			this.customFinishes[_loc2_] = new Array<ASAny>();
		// 		}
		// 		this.finishesCleared = true;
		// 		this.customFinishes[_loc2_].push(new DialogueLine((/*TODO*/ arguments : ASAny)[2]));
		// 	} else if ((/*TODO*/ arguments : ASAny)[1] == this.OTHER_FINISH) {
		// 		if (!this.customFinishes[this.OTHER_FINISH]) {
		// 			this.customFinishes[this.OTHER_FINISH] = new Array<ASAny>();
		// 		}
		// 		this.finishesCleared = true;
		// 		this.customFinishes[this.OTHER_FINISH].push(new DialogueLine((/*TODO*/ arguments : ASAny)[2]));
		// 	}
		// }
        // TODO
		return "";
	}

	public function exportLibrary():String {
		/*
		 * Decompilation error
		 * Code may be obfuscated
		 * Tip: You can try enabling "Automatic deobfuscation" in Settings
		 * Error type: NullPointerException (null)
		 */
        // TODO
        return "";
	}

	public function appendLibrary(param1:String, param2:Array<DialogueLine>, param3:String):String {
		for (line in param2) {
			param1 += param3 + ":\"" + line.phrase + "\"\n";
		}
		return param1;
	}

	// public function customEscape(param1:String):String {
	// 	param1 = new compat.RegExp("\\\\", "g").replace(param1, "%22");
	// 	param1 = new compat.RegExp("\\*", "g").replace(param1, "%2A");
	// 	return new compat.RegExp(":", "g").replace(param1, "%3A");
	// }

	public function outputLog(param1:String) {
		// G.dialogueEditor.appendLog(param1);
	}

	public function prepareLibraries() {
		var dGeneral = new Array<DialogueLine>();
		var dIntro = new Array<DialogueLine>();
		var dNormalResistance = new Array<DialogueLine>();
		dNormalResistance.push(new DialogueLine("I can\'t take it any deeper!"));
		dNormalResistance.push(new DialogueLine("I can\'t go any deeper."));
		dNormalResistance.push(new DialogueLine("I don\'t think I can take any more."));
		dNormalResistance.push(new DialogueLine("Stop pushing me down* YOU*!"));
		dNormalResistance.push(new DialogueLine("Stop pushing me so far down!"));
		dNormalResistance.push(new DialogueLine("That\'s deep enough* YOU*!"));
		var dHappyResistance:Array<DialogueLine>;
		(dHappyResistance = new Array<DialogueLine>()).push(new DialogueLine("I can take it deeper, keep going."));
		dHappyResistance.push(new DialogueLine("That\'s it* YOU*, push it in!"));
		dHappyResistance.push(new DialogueLine("Do you want to go deeper* YOU*?"));
		dHappyResistance.push(new DialogueLine("I got a bit further that time* YOU*."));
		dHappyResistance.push(new DialogueLine("Don\'t worry* YOU*, I can take it."));
		var dAngryResistance:Array<DialogueLine>;
		(dAngryResistance = new Array<DialogueLine>()).push(new DialogueLine("What do you think you\'re doing?!"));
		dAngryResistance.push(new DialogueLine("Quit trying to force it in!"));
		dAngryResistance.push(new DialogueLine("Stop pushing me down* YOU*!"));
		dAngryResistance.push(new DialogueLine("Stop pushing me so far down!"));
		dAngryResistance.push(new DialogueLine("That\'s deep enough* YOU*!"));
		var dNormalFirstThroat:Array<DialogueLine>;
		(dNormalFirstThroat = new Array<DialogueLine>()).push(new DialogueLine("I can\'t take any more than that!"));
		dNormalFirstThroat.push(new DialogueLine("I can\'t take it all!"));
		dNormalFirstThroat.push(new DialogueLine("That\'s as deep as I can take it!"));
		dNormalFirstThroat.push(new DialogueLine("Please* YOU*, stop!"));
		dNormalFirstThroat.push(new DialogueLine("That\'s too deep!"));
		dNormalFirstThroat.push(new DialogueLine("Too deep!"));
		dNormalFirstThroat.push(new DialogueLine("You\'re making me gag* YOU*!"));
		dNormalFirstThroat.push(new DialogueLine("You\'re making me choke* YOU*!"));
		dNormalFirstThroat.push(new DialogueLine("I\'ll choke!"));
		dNormalFirstThroat.push(new DialogueLine("You\'re choking me!"));
		dNormalFirstThroat.push(new DialogueLine("You can\'t push it any deeper!"));
		dNormalFirstThroat.push(new DialogueLine("That\'s my throat!"));
		dNormalFirstThroat.push(new DialogueLine("Stop!"));
		var dHappyFirstThroat:Array<DialogueLine>;
		(dHappyFirstThroat = new Array<DialogueLine>()).push(new DialogueLine("Nearly... I think I can take it all now."));
		dHappyFirstThroat.push(new DialogueLine("Come on, push it all the way in."));
		dHappyFirstThroat.push(new DialogueLine("You\'re nearly in my throat."));
		var dAngryFirstThroat:Array<DialogueLine>;
		(dAngryFirstThroat = new Array<DialogueLine>()).push(new DialogueLine("Are you trying to force it all down my throat?!"));
		dAngryFirstThroat.push(new DialogueLine("Hey! You\'re hitting my throat!"));
		dAngryFirstThroat.push(new DialogueLine("That\'s my throat, stop trying to push it deeper!"));
		dAngryFirstThroat.push(new DialogueLine("That\'s my throat!"));
		dAngryFirstThroat.push(new DialogueLine("You can\'t force it any deeper!"));
		var dNormalFirstDt:Array<DialogueLine>;
		(dNormalFirstDt = new Array<DialogueLine>()).push(new DialogueLine("I can\'t believe you made me take it all*, YOU*."));
		dNormalFirstDt.push(new DialogueLine("You forced it into my throat!"));
		dNormalFirstDt.push(new DialogueLine("My throat!"));
		dNormalFirstDt.push(new DialogueLine("That\'s my throat*, YOU*!"));
		dNormalFirstDt.push(new DialogueLine("You pushed it all the way in..."));
		var dHappyFirstDt:Array<DialogueLine>;
		(dHappyFirstDt = new Array<DialogueLine>()).push(new DialogueLine("I swallowed it all! It made my throat feel so full."));
		dHappyFirstDt.push(new DialogueLine("I can\'t believe I took it all!"));
		dHappyFirstDt.push(new DialogueLine("I can\'t believe I swallowed it all!"));
		dHappyFirstDt.push(new DialogueLine("Ahh... push it all the way in again."));
		dHappyFirstDt.push(new DialogueLine("That was amazing, push it into my throat again!"));
		var dAngryFirstDt:Array<DialogueLine>;
		(dAngryFirstDt = new Array<DialogueLine>()).push(new DialogueLine("I can\'t believe you!"));
		dAngryFirstDt.push(new DialogueLine("That\'s enough! Don\'t push it into my throat again."));
		dAngryFirstDt.push(new DialogueLine("That\'s enough! Don\'t do that again."));
		var dNormalPullOff:Array<DialogueLine>;
		(dNormalPullOff = new Array<DialogueLine>()).push(new DialogueLine("That\'s too deep!"));
		dNormalPullOff.push(new DialogueLine("Stop pushing me down!"));
		dNormalPullOff.push(new DialogueLine("Stop forcing me down!"));
		dNormalPullOff.push(new DialogueLine("Stop making me take it so deep!"));
		dNormalPullOff.push(new DialogueLine("Stop making me take it all!"));
		dNormalPullOff.push(new DialogueLine("Stop pushing it in so deep!"));
		dNormalPullOff.push(new DialogueLine("I can\'t breathe!"));
		dNormalPullOff.push(new DialogueLine("Don\'t push me down!"));
		dNormalPullOff.push(new DialogueLine("Let me off!"));
		dNormalPullOff.push(new DialogueLine("Let me breathe!"));
		var dHappyPullOff:Array<DialogueLine>;
		(dHappyPullOff = new Array<DialogueLine>()).push(new DialogueLine("Ahh! My throat feels so full."));
		dHappyPullOff.push(new DialogueLine("Do you like my throat?"));
		dHappyPullOff.push(new DialogueLine("Do you like it?"));
		dHappyPullOff.push(new DialogueLine("Push it in again, I can take it."));
		var dAngryPullOff:Array<DialogueLine>;
		(dAngryPullOff = new Array<DialogueLine>()).push(new DialogueLine("Let me off!"));
		dAngryPullOff.push(new DialogueLine("Let me breathe!"));
		dAngryPullOff.push(new DialogueLine("Stop pushing me down!"));
		dAngryPullOff.push(new DialogueLine("Stop forcing me down!"));
		var dNormalHeld:Array<DialogueLine>;
		(dNormalHeld = new Array<DialogueLine>()).push(new DialogueLine("Wait... let me catch my breath."));
		dNormalHeld.push(new DialogueLine("Can\'t... breathe!"));
		dNormalHeld.push(new DialogueLine("Let me breathe* YOU*!"));
		dNormalHeld.push(new DialogueLine("I can\'t breathe!"));
		dNormalHeld.push(new DialogueLine("I\'m going to pass out!"));
		dNormalHeld.push(new DialogueLine("I\'m going to faint!"));
		dNormalHeld.push(new DialogueLine("I can\'t take it for so long!"));
		dNormalHeld.push(new DialogueLine("Don\'t hold me down for so long*, YOU*!"));
		var dHappyHeld:Array<DialogueLine>;
		(dHappyHeld = new Array<DialogueLine>()).push(new DialogueLine("You\'re making my head spin!"));
		dHappyHeld.push(new DialogueLine("You\'re making me so dizzy!"));
		dHappyHeld.push(new DialogueLine("I can take it, just let me catch my breath."));
		dHappyHeld.push(new DialogueLine("Don\'t worry* YOU*, I can take it."));
		dHappyHeld.push(new DialogueLine("My throat feels so full."));
		var dAngryHeld:Array<DialogueLine>;
		(dAngryHeld = new Array<DialogueLine>()).push(new DialogueLine("Let me off!"));
		dAngryHeld.push(new DialogueLine("Let me breathe!"));
		dAngryHeld.push(new DialogueLine("What are you trying to do?!"));
		dAngryHeld.push(new DialogueLine("Get off me!"));
		dAngryHeld.push(new DialogueLine("Stop holding me down!"));
		var dWake:Array<DialogueLine>;
		(dWake = new Array<DialogueLine>()).push(new DialogueLine("Wh- where..."));
		dWake.push(new DialogueLine("What happened?"));
		dWake.push(new DialogueLine("Wha-?"));
		dWake.push(new DialogueLine("*YOU, *... you made me faint!"));
		dWake.push(new DialogueLine("*YOU, *... you made me pass out!"));
		var dAngryWake:Array<DialogueLine>;
		(dAngryWake = new Array<DialogueLine>()).push(new DialogueLine("I told you to let me breathe!"));
		dAngryWake.push(new DialogueLine("What were you thinking?! I need to breathe!"));
		dAngryWake.push(new DialogueLine("I can\'t believe you, you made me pass out!"));
		var dNormalVigorous:Array<DialogueLine>;
		(dNormalVigorous = new Array<DialogueLine>()).push(new DialogueLine("Slow down* YOU*!"));
		dNormalVigorous.push(new DialogueLine("Wait! Slow down!"));
		dNormalVigorous.push(new DialogueLine("You\'re too rough!"));
		dNormalVigorous.push(new DialogueLine("You\'re being too rough!"));
		dNormalVigorous.push(new DialogueLine("Stop being so rough!"));
		dNormalVigorous.push(new DialogueLine("It\'s too rough!"));
		dNormalVigorous.push(new DialogueLine("You\'re tearing my throat!"));
		dNormalVigorous.push(new DialogueLine("My throat!"));
		dNormalVigorous.push(new DialogueLine("You\'re going to tear my throat!"));
		dNormalVigorous.push(new DialogueLine("Wait! You\'re being too rough!"));
		dNormalVigorous.push(new DialogueLine("I can\'t take any more* YOU*!"));
		var dHappyVigorous:Array<DialogueLine>;
		(dHappyVigorous = new Array<DialogueLine>()).push(new DialogueLine("Keep going* YOU*!"));
		dHappyVigorous.push(new DialogueLine("Yes! Fuck my throat* YOU*!"));
		dHappyVigorous.push(new DialogueLine("Use my mouth like a pussy* YOU*!"));
		dHappyVigorous.push(new DialogueLine("I can take it, don\'t stop!"));
		dHappyVigorous.push(new DialogueLine("You\'re making my head spin."));
		var dAngryVigorous:Array<DialogueLine>;
		(dAngryVigorous = new Array<DialogueLine>()).push(new DialogueLine("What do you think you\'re doing?!"));
		dAngryVigorous.push(new DialogueLine("Stop!"));
		var dNormalPreCum:Array<DialogueLine>;
		(dNormalPreCum = new Array<DialogueLine>()).push(new DialogueLine("Are you almost there?"));
		dNormalPreCum.push(new DialogueLine("Are you nearly there?"));
		var dHappyPreCum:Array<DialogueLine>;
		(dHappyPreCum = new Array<DialogueLine>()).push(new DialogueLine("Come on* YOU*, give me your cum!"));
		dHappyPreCum.push(new DialogueLine("Cum for me* YOU*!"));
		dHappyPreCum.push(new DialogueLine("Cum on my face* YOU*!"));
		dHappyPreCum.push(new DialogueLine("Give it to me* YOU*!"));
		var dAngryPreCum:Array<DialogueLine>;
		(dAngryPreCum = new Array<DialogueLine>()).push(new DialogueLine("Are you done yet?"));
		dAngryPreCum.push(new DialogueLine("Hurry up and finish!"));
		var dNormalCumOnFace:Array<DialogueLine>;
		(dNormalCumOnFace = new Array<DialogueLine>()).push(new DialogueLine("Ugh... you didn\'t have to shoot all over my face."));
		dNormalCumOnFace.push(new DialogueLine("You came all over my face."));
		dNormalCumOnFace.push(new DialogueLine("You came all over me."));
		dNormalCumOnFace.push(new DialogueLine("Ugh... it\'s everywhere."));
		dNormalCumOnFace.push(new DialogueLine("*YOUR cum... *It\'s all over my face."));
		dNormalCumOnFace.push(new DialogueLine("*YOUR cum... *It\'s everywhere."));
		dNormalCumOnFace.push(new DialogueLine("It\'s so hot."));
		var dHappyCumOnFace:Array<DialogueLine>;
		(dHappyCumOnFace = new Array<DialogueLine>()).push(new DialogueLine("You came so much!"));
		dHappyCumOnFace.push(new DialogueLine("You came all over me."));
		dHappyCumOnFace.push(new DialogueLine("*YOUR cum... *It\'s all over my face."));
		dHappyCumOnFace.push(new DialogueLine("*YOUR cum... *It\'s everywhere."));
		dHappyCumOnFace.push(new DialogueLine("It\'s so warm."));
		var dAngryCumOnFace:Array<DialogueLine>;
		(dAngryCumOnFace = new Array<DialogueLine>()).push(new DialogueLine("Did you have to shoot all over my face?!"));
		dAngryCumOnFace.push(new DialogueLine("Ugh! You\'ve covered me in it!"));
		var dNormalCumInMouth:Array<DialogueLine>;
		(dNormalCumInMouth = new Array<DialogueLine>()).push(new DialogueLine("Swallow it?"));
		dNormalCumInMouth.push(new DialogueLine("Swallow?"));
		dNormalCumInMouth.push(new DialogueLine("Drink it?"));
		dNormalCumInMouth.push(new DialogueLine("You want me to swallow it?"));
		var dHappyCumInMouth:Array<DialogueLine>;
		(dHappyCumInMouth = dNormalCumInMouth.copy()).push(new DialogueLine("Can I swallow it?"));
		dHappyCumInMouth.push(new DialogueLine("Can I drink it?"));
		dHappyCumInMouth.push(new DialogueLine("So much..."));
		var dAngryCumInMouth:Array<DialogueLine>;
		(dAngryCumInMouth = new Array<DialogueLine>()).push(new DialogueLine("You expect me to swallow this?"));
		dAngryCumInMouth.push(new DialogueLine("Ugh... what were you thinking?!"));
		dAngryCumInMouth.push(new DialogueLine("You want me to swallow this?"));
		var dCumInThroat:Array<DialogueLine>;
		(dCumInThroat = new Array<DialogueLine>()).push(new DialogueLine("I\'m so full."));
		dCumInThroat.push(new DialogueLine("I can feel it all inside me."));
		dCumInThroat.push(new DialogueLine("I can feel it inside me."));
		dCumInThroat.push(new DialogueLine("You came right down my throat..."));
		dCumInThroat.push(new DialogueLine("You came straight into my stomach."));
		var dAngryCumInThroat:Array<DialogueLine>;
		(dAngryCumInThroat = new Array<DialogueLine>()).push(new DialogueLine("Ugh, you came right down my throat!"));
		dAngryCumInThroat.push(new DialogueLine("At least I didn\'t have to taste it."));
		dAngryCumInThroat.push(new DialogueLine("Ugh, I can feel it all down my throat."));
		var dCumInEye:Array<DialogueLine>;
		(dCumInEye = new Array<DialogueLine>()).push(new DialogueLine("My eyes!"));
		dCumInEye.push(new DialogueLine("I can\'t see!"));
		dCumInEye.push(new DialogueLine("Ow!"));
		var dCumInNose = new Array<DialogueLine>();
		var dNormalSwallow:Array<DialogueLine>;
		(dNormalSwallow = new Array<DialogueLine>()).push(new DialogueLine("I\'m so full."));
		dNormalSwallow.push(new DialogueLine("I can\'t believe you made me drink it all*, YOU*."));
		dNormalSwallow.push(new DialogueLine("I can\'t believe you made me swallow it all*, YOU*."));
		dNormalSwallow.push(new DialogueLine("I can still taste it."));
		dNormalSwallow.push(new DialogueLine("I can feel it all inside me."));
		dNormalSwallow.push(new DialogueLine("So much..."));
		var dHappySwallow:Array<DialogueLine>;
		(dHappySwallow = new Array<DialogueLine>()).push(new DialogueLine("Mm, I can still taste it."));
		dHappySwallow.push(new DialogueLine("I can feel it all inside me."));
		dHappySwallow.push(new DialogueLine("So much..."));
		var dAngrySwallow:Array<DialogueLine>;
		(dAngrySwallow = new Array<DialogueLine>()).push(new DialogueLine("Ugh, it tastes horrible."));
		dAngrySwallow.push(new DialogueLine("I can\'t believe you made me drink it all*, YOU*."));
		dAngrySwallow.push(new DialogueLine("I can\'t believe you made me swallow it all*, YOU*."));
		var dNormalDrool:Array<DialogueLine>;
		(dNormalDrool = new Array<DialogueLine>()).push(new DialogueLine("I couldn\'t swallow it all* YOU*."));
		dNormalDrool.push(new DialogueLine("I couldn\'t drink it all."));
		dNormalDrool.push(new DialogueLine("It tastes bitter"));
		var dHappyDrool:Array<DialogueLine>;
		(dHappyDrool = new Array<DialogueLine>()).push(new DialogueLine("I couldn\'t swallow it all."));
		dHappyDrool.push(new DialogueLine("I didn\'t mean to spill it* YOU*. Give me more?"));
		var dAngryDrool:Array<DialogueLine>;
		(dAngryDrool = new Array<DialogueLine>()).push(new DialogueLine("I\'m not swallowing that!"));
		dAngryDrool.push(new DialogueLine("I\'m not going to drink that!"));
		dAngryDrool.push(new DialogueLine("Ugh, I can still taste it."));
		var dNormalRestart:Array<DialogueLine>;
		(dNormalRestart = new Array<DialogueLine>()).push(new DialogueLine("W-wait... you still want more?!"));
		dNormalRestart.push(new DialogueLine("W-wait... you want more?!"));
		dNormalRestart.push(new DialogueLine("Again?!"));
		dNormalRestart.push(new DialogueLine("You\'re still hard?!"));
		dNormalRestart.push(new DialogueLine("H-hey, you\'re still going?!"));
		dNormalRestart.push(new DialogueLine("Isn\'t *FINISHES* enough?!"));
		var dHappyRestart:Array<DialogueLine>;
		(dHappyRestart = new Array<DialogueLine>()).push(new DialogueLine("You want more?"));
		dHappyRestart.push(new DialogueLine("I can go more than *FINISHES* if you can."));
		dHappyRestart.push(new DialogueLine("*FINISHES* isn\'t enough right? Keep going."));
		var dAngryRestart:Array<DialogueLine>;
		(dAngryRestart = new Array<DialogueLine>()).push(new DialogueLine("Aren\'t you done?!"));
		dAngryRestart.push(new DialogueLine("Again?!"));
		dAngryRestart.push(new DialogueLine("Isn\'t *FINISHES* enough?!"));
		var dInterrupt:Array<DialogueLine>;
		(dInterrupt = new Array<DialogueLine>()).push(new DialogueLine("-mphh!"));
		dInterrupt.push(new DialogueLine("-mph!"));
		dInterrupt.push(new DialogueLine("-!"));
		dInterrupt.push(new DialogueLine("-ghmph!"));
		dInterrupt.push(new DialogueLine("-mmbh!"));
		dInterrupt.push(new DialogueLine("-nngh!"));
		dInterrupt.push(new DialogueLine("-mmn!"));
		dInterrupt.push(new DialogueLine("-ghch!"));
		dInterrupt.push(new DialogueLine("-mmb!"));
		dInterrupt.push(new DialogueLine("-mmbh!"));
		dInterrupt.push(new DialogueLine("-mnh!"));
		dInterrupt.push(new DialogueLine("-ng!"));
		var dCough:Array<DialogueLine>;
		(dCough = new Array<DialogueLine>()).push(new DialogueLine("-aghck"));
		dCough.push(new DialogueLine("-ack"));
		dCough.push(new DialogueLine("-ackph"));
		dCough.push(new DialogueLine("-agph"));
		dCough.push(new DialogueLine("-achf"));
		this.normalLibrary = new DialogueLib();
		this.normalLibrary[Dialogue.INTRO] = dIntro;
		this.normalLibrary[Dialogue.RESISTANCE] = dNormalResistance;
		this.normalLibrary[Dialogue.GENERAL] = dGeneral;
		this.normalLibrary[Dialogue.INTERRUPT] = dInterrupt;
		this.normalLibrary[Dialogue.COUGH] = dCough;
		this.normalLibrary[Dialogue.FIRST_THROAT] = dNormalFirstThroat;
		this.normalLibrary[Dialogue.FIRST_DT] = dNormalFirstDt;
		this.normalLibrary[Dialogue.PULL_OFF] = dNormalPullOff;
		this.normalLibrary[Dialogue.HELD] = dNormalHeld;
		this.normalLibrary[Dialogue.WAKE] = dWake;
		this.normalLibrary[Dialogue.VIGOROUS] = dNormalVigorous;
		this.normalLibrary[Dialogue.PRE_CUM] = dNormalPreCum;
		this.normalLibrary[Dialogue.CUM_ON_FACE] = dNormalCumOnFace;
		this.normalLibrary[Dialogue.CUM_IN_MOUTH] = dNormalCumInMouth;
		this.normalLibrary[Dialogue.CUM_IN_THROAT] = dCumInThroat;
		this.normalLibrary[Dialogue.CUM_IN_EYE] = dCumInEye;
		this.normalLibrary[Dialogue.CUM_IN_NOSE] = dCumInNose;
		this.normalLibrary[Dialogue.SWALLOW] = dNormalSwallow;
		this.normalLibrary[Dialogue.DROOL] = dNormalDrool;
		this.normalLibrary[Dialogue.RESTART] = dNormalRestart;
		this.happyLibrary = new DialogueLib();
		this.happyLibrary[Dialogue.INTRO] = dIntro;
		this.happyLibrary[Dialogue.RESISTANCE] = dHappyResistance;
		this.happyLibrary[Dialogue.GENERAL] = dGeneral;
		this.happyLibrary[Dialogue.INTERRUPT] = dInterrupt;
		this.happyLibrary[Dialogue.COUGH] = dCough;
		this.happyLibrary[Dialogue.FIRST_THROAT] = dHappyFirstThroat;
		this.happyLibrary[Dialogue.FIRST_DT] = dHappyFirstDt;
		this.happyLibrary[Dialogue.PULL_OFF] = dHappyPullOff;
		this.happyLibrary[Dialogue.HELD] = dHappyHeld;
		this.happyLibrary[Dialogue.WAKE] = dWake;
		this.happyLibrary[Dialogue.VIGOROUS] = dHappyVigorous;
		this.happyLibrary[Dialogue.PRE_CUM] = dHappyPreCum;
		this.happyLibrary[Dialogue.CUM_ON_FACE] = dHappyCumOnFace;
		this.happyLibrary[Dialogue.CUM_IN_MOUTH] = dHappyCumInMouth;
		this.happyLibrary[Dialogue.CUM_IN_THROAT] = dCumInThroat;
		this.happyLibrary[Dialogue.CUM_IN_EYE] = dCumInEye;
		this.happyLibrary[Dialogue.CUM_IN_NOSE] = dCumInNose;
		this.happyLibrary[Dialogue.SWALLOW] = dHappySwallow;
		this.happyLibrary[Dialogue.DROOL] = dHappyDrool;
		this.happyLibrary[Dialogue.RESTART] = dHappyRestart;
		this.angryLibrary = new DialogueLib();
		this.angryLibrary[Dialogue.INTRO] = dIntro;
		this.angryLibrary[Dialogue.RESISTANCE] = dAngryResistance;
		this.angryLibrary[Dialogue.GENERAL] = dGeneral;
		this.angryLibrary[Dialogue.INTERRUPT] = dInterrupt;
		this.angryLibrary[Dialogue.COUGH] = dCough;
		this.angryLibrary[Dialogue.FIRST_THROAT] = dAngryFirstThroat;
		this.angryLibrary[Dialogue.FIRST_DT] = dAngryFirstDt;
		this.angryLibrary[Dialogue.PULL_OFF] = dAngryPullOff;
		this.angryLibrary[Dialogue.HELD] = dAngryHeld;
		this.angryLibrary[Dialogue.WAKE] = dAngryWake;
		this.angryLibrary[Dialogue.VIGOROUS] = dAngryVigorous;
		this.angryLibrary[Dialogue.PRE_CUM] = dAngryPreCum;
		this.angryLibrary[Dialogue.CUM_ON_FACE] = dAngryCumOnFace;
		this.angryLibrary[Dialogue.CUM_IN_MOUTH] = dAngryCumInMouth;
		this.angryLibrary[Dialogue.CUM_IN_THROAT] = dAngryCumInThroat;
		this.angryLibrary[Dialogue.CUM_IN_EYE] = dCumInEye;
		this.angryLibrary[Dialogue.CUM_IN_NOSE] = dCumInNose;
		this.angryLibrary[Dialogue.SWALLOW] = dAngrySwallow;
		this.angryLibrary[Dialogue.DROOL] = dAngryDrool;
		this.angryLibrary[Dialogue.RESTART] = dAngryRestart;
		this.ahegaoLibrary = new DialogueLib();
		this.finishes = new DialogueLib();
		this.finishes["1"] = [new DialogueLine("once")];
		this.finishes["2"] = [new DialogueLine("twice")];
		this.finishes["3"] = [new DialogueLine("three times")];
		this.finishes["4"] = [new DialogueLine("four times")];
		this.finishes["5"] = [new DialogueLine("five times")];
		this.finishes["6"] = [new DialogueLine("six times")];
		this.finishes["7"] = [new DialogueLine("seven times")];
		this.finishes["8"] = [new DialogueLine("eight times")];
		this.finishes["9"] = [new DialogueLine("nine times")];
		this.finishes["10"] = [new DialogueLine("ten times")];
		this.finishes[this.OTHER_FINISH] = [new DialogueLine("that many times")];
	}

	public function prepareTypeArray() {
		this.dialogueTypes = new Array<String>();
		this.dialogueTypes.push(Dialogue.INTRO);
		this.dialogueTypes.push(Dialogue.HEAD_GRABBED);
		this.dialogueTypes.push(Dialogue.PULLED_UP);
		this.dialogueTypes.push(Dialogue.PULLED_DOWN);
		this.dialogueTypes.push(Dialogue.RESISTANCE);
		this.dialogueTypes.push(Dialogue.GENERAL);
		this.dialogueTypes.push(Dialogue.INTERRUPT);
		this.dialogueTypes.push(Dialogue.COUGH);
		this.dialogueTypes.push(Dialogue.FIRST_THROAT);
		this.dialogueTypes.push(Dialogue.FIRST_DT);
		this.dialogueTypes.push(Dialogue.PULL_OFF);
		this.dialogueTypes.push(Dialogue.HELD);
		this.dialogueTypes.push(Dialogue.WAKE);
		this.dialogueTypes.push(Dialogue.LICK_PENIS);
		this.dialogueTypes.push(Dialogue.LICK_BALLS);
		this.dialogueTypes.push(Dialogue.VIGOROUS);
		this.dialogueTypes.push(Dialogue.HAND_JOB_STROKE);
		this.dialogueTypes.push(Dialogue.PRE_CUM);
		this.dialogueTypes.push(Dialogue.CUM_ON_FACE);
		this.dialogueTypes.push(Dialogue.CUM_IN_MOUTH);
		this.dialogueTypes.push(Dialogue.CUM_IN_THROAT);
		this.dialogueTypes.push(Dialogue.CUM_IN_EYE);
		this.dialogueTypes.push(Dialogue.CUM_IN_NOSE);
		this.dialogueTypes.push(Dialogue.SWALLOW);
		this.dialogueTypes.push(Dialogue.DROOL);
		this.dialogueTypes.push(Dialogue.RESTART);
		DialogueLibrary.allDialogueTypes = this.dialogueTypes;
		this.dialogueTypesPattern = new EReg("(" + this.dialogueTypes.join("|") + "):[ \t]?\"(.+?)\"", "g");
	}
}
