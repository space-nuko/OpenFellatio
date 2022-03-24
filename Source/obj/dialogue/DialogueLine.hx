package obj.dialogue;

// import obj.Him;

class DialogueLine {
	public static var SPEAKING_STYLE:String = "Speak";
	public static var THOUGHT_STYLE:String = "Thought";
	public static var HIM_STYLE:String = "Him";
	// public static var advancedController:AdvancedDialogueController;

	public var _settings:ASObject;
	public var _style:String;
	public var _mood:String;
	public var _held:String;
	public var _nextLine:String;
	public var _phrase:String;

	public function new(param1:String, param2:ASObject = null) {
		this._phrase = param1;
		if (param2) {
			this._settings = param2;
			if (param2["style"]) {
				this._style = param2["style"];
				if (this._style == SPEAKING_STYLE.toLowerCase()) {
					this._style = SPEAKING_STYLE;
				}
				if (this._style == THOUGHT_STYLE.toLowerCase()) {
					this._style = THOUGHT_STYLE;
				}
				if (this._style == HIM_STYLE.toLowerCase()) {
					this._style = HIM_STYLE;
				}
			}
			if (param2["mood"]) {
				this._mood = param2["mood"];
			}
			if (param2["held"]) {
				this._held = param2["held"];
			}
			if (param2["next"]) {
				this._nextLine = param2["next"];
			}
		} else {
			this._settings = {};
		}
	}

	@:flash.property public var phrase(get, never):String;

	function get_phrase():String {
		return this._phrase;
	}

	@:flash.property public var settings(get, never):ASObject;

	function get_settings():ASObject {
		return this._settings;
	}

	@:flash.property public var style(get, never):String;

	function get_style():String {
		return !!ASCompat.stringAsBool(this._style) ? this._style : SPEAKING_STYLE;
	}

	@:flash.property public var mood(get, never):String;

	function get_mood():String {
		return !!ASCompat.stringAsBool(this._mood) ? this._mood : "";
	}

	@:flash.property public var held(get, never):String;

	function get_held():String {
		return !!ASCompat.stringAsBool(this._held) ? this._held : "";
	}

	@:flash.property public var nextLine(get, never):String;

	function get_nextLine():String {
		return this._nextLine;
	}

	@:flash.property public var canPlay(get, never):Bool;

	function get_canPlay():Bool {
		// if (advancedController != null && !advancedController.canPlay(this)) {
		// 	return false;
		// }
		// if (G.her.passedOut && this._style == THOUGHT_STYLE) {
		// 	return false;
		// }
		// if ((!ASCompat.stringAsBool(this._style) || this._style == SPEAKING_STYLE) && !G.her.canSpeak()) {
		// 	return false;
		// }
		// if (ASCompat.stringAsBool(this._mood) && G.her.mood != this._mood) {
		// 	return false;
		// }
		// if (ASCompat.stringAsBool(this._held)) {
		// 	if (this._held == "true" && Him.armPositions[G.him.currentArmPosition] != "Holding") {
		// 		return false;
		// 	}
		// 	if (this._held == "false" && Him.armPositions[G.him.currentArmPosition] != "Free") {
		// 		return false;
		// 	}
		// }
		return true;
	}

	public function export_l():String {
		/*
		 * Decompilation error
		 * Code may be obfuscated
		 * Tip: You can try enabling "Automatic deobfuscation" in Settings
		 * Error type: NullPointerException (null)
		 */
		throw new flash.errors.IllegalOperationError("Not decompiled due to error");
	}
}
