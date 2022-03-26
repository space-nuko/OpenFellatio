package obj.dialogue;

import obj.Him;

class Settings
{
    public var style: Null<String>;
    public var mood: Null<String>;
    public var held: Null<String>;
    public var next: Null<String>;
    public var set: Null<String>;
    public var check: Null<String>;

    public function new() {}
}

class DialogueLine {
	public static var SPEAKING_STYLE:String = "Speak";
	public static var THOUGHT_STYLE:String = "Thought";
	public static var HIM_STYLE:String = "Him";
	// public static var advancedController:AdvancedDialogueController;

	public var _settings:Settings;
	public var _style:Null<String>;
	public var _mood:Null<String>;
	public var _held:Null<String>;
	public var _nextLine:Null<String>;
	public var _phrase:Null<String>;

	public function new(param1:String, param2:Settings = null) {
		this._phrase = param1;
		if (param2 != null) {
			this._settings = param2;
			if (param2.style != null) {
				this._style = param2.style;
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
			if (param2.mood != null) {
				this._mood = param2.mood;
			}
			if (param2.held != null) {
				this._held = param2.held;
			}
			if (param2.next != null) {
				this._nextLine = param2.next;
			}
		} else {
			this._settings = new Settings();
		}
	}

	@:flash.property public var phrase(get, never):String;

	function get_phrase():String {
		return this._phrase;
	}

	@:flash.property public var settings(get, never):Settings;

	function get_settings():Settings {
		return this._settings;
	}

	@:flash.property public var style(get, never):String;

	function get_style():String {
		return this._style != null ? this._style : SPEAKING_STYLE;
	}

	@:flash.property public var mood(get, never):String;

	function get_mood():String {
		return this._mood != null ? this._mood : "";
	}

	@:flash.property public var held(get, never):String;

	function get_held():String {
		return this._held != null? this._held : "";
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
		if (G.her.passedOut && this._style == THOUGHT_STYLE) {
			return false;
		}
		if ((this._style != null || this._style == SPEAKING_STYLE) && !G.her.canSpeak()) {
			return false;
		}
		if (this._mood != null && G.her.mood != this._mood) {
			return false;
		}
		if (this._held != null) {
			if (this._held == "true" && Him.armPositions[G.him.currentArmPosition] != "Holding") {
				return false;
			}
			if (this._held == "false" && Him.armPositions[G.him.currentArmPosition] != "Free") {
				return false;
			}
		}
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
