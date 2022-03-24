package obj.dialogue;

@:access(swf.exporters.animate)

class DialogueEditorLine extends #if flash flash.display.MovieClip.MovieClip2 #else openfl.display.MovieClip #end
{
	@:keep @:noCompletion @:dox(hide) public var background(default, null):openfl.display.MovieClip;
	@:keep @:noCompletion @:dox(hide) public var spot(default, null):openfl.display.MovieClip;
	// @:keep @:noCompletion @:dox(hide) public var mbPreview(default, null):MenuArrowH;
	@:keep @:noCompletion @:dox(hide) public var lineWindow(default, null):openfl.display.MovieClip;
	@:keep @:noCompletion @:dox(hide) public var triggerLabel(default, null):openfl.text.TextField;
	@:keep @:noCompletion @:dox(hide) public var moodIcon(default, null):openfl.display.MovieClip;
	@:keep @:noCompletion @:dox(hide) public var dialogueLine(default, null):openfl.text.TextField;
	@:keep @:noCompletion @:dox(hide) public var hitbox(default, null):openfl.display.MovieClip;

	public var _lineID:UInt = 0;
	public var _selected:Bool = false;
	public var _clickCallback:ASFunction;
	public var _changeCallback:ASFunction;
	public var _trigger:String;
	public var _style:String;
	public var _mood:String;
	public var _nextLine:String;
	public var _held:String;
	public var _sourceLine:DialogueLine;
	public var _wildcard:Bool = false;
	public var _finish:Bool = false;
	public var _lineCount:Int = 1;
	public var _lastCaret:Int = -1;
	public var showing:Bool = true;

	public function new() {
		var library = swf.exporters.animate.AnimateLibrary.get("FYA8BqNO2PenTmHMYgDK");
		var symbol = library.symbols.get(2946);
		symbol.__init(library);

		super();
	}

	@:flash.property public var lineHeight(get, never):Float;

	function get_lineHeight():Float {
		return 20 + 13 * (this._lineCount - 1) + 1;
	}

	public function matchesFilter(param1:String):Bool {
		var _loc2_ = new compat.RegExp(param1, "i");
		if (ASCompat.stringAsBool(this.phrase) && _loc2_.match(this.phrase) != null) {
			return true;
		}
		if (ASCompat.stringAsBool(this.trigger) && _loc2_.match(this.trigger) != null) {
			return true;
		}
		if (ASCompat.stringAsBool(this._style) && _loc2_.match(this._style) != null) {
			return true;
		}
		return false;
	}

	public function takeFocus() {
		stage.focus = this.dialogueLine;
		this.dialogueLine.setSelection(this.dialogueLine.caretIndex, this.dialogueLine.caretIndex);
	}

	public function insert(param1:String) {
		this.dialogueLine.replaceText(this.dialogueLine.caretIndex, this.dialogueLine.caretIndex, param1);
		this.lineChanged();
	}

	@:flash.property public var trigger(get, set):String;

	function set_trigger(param1:String):String {
		this._trigger = param1;
		this.triggerLabel.text = this._trigger;
		if (new compat.RegExp("finish", "i").match(this._trigger) != null) {
			this.finish = true;
		}
		return param1;
	}

	function get_trigger():String {
		return this._trigger;
	}

	@:flash.property public var nextLine(get, set):String;

	function set_nextLine(param1:String):String {
		return this._nextLine = param1;
	}

	function get_nextLine():String {
		return this._nextLine;
	}

	@:flash.property public var phrase(get, never):String;

	function get_phrase():String {
		return this.dialogueLine.text;
	}

	@:flash.property public var wildcard(get, never):Bool;

	function get_wildcard():Bool {
		return this._wildcard;
	}

	@:flash.property public var finish(get, set):Bool;

	function set_finish(param1:Bool):Bool {
		return this._finish = param1;
	}

	function get_finish():Bool {
		return this._finish;
	}

	@:flash.property public var style(get, set):String;

	function set_style(param1:String):String {
		this._style = param1;
		switch (this._style) {
			case(_ == DialogueLine.SPEAKING_STYLE => true) | (_ == DialogueLine.THOUGHT_STYLE => true):
				this.spot.gotoAndStop("thought");

			case(_ == DialogueLine.HIM_STYLE => true):
				this.spot.gotoAndStop("him");

			default:
				this.spot.gotoAndStop("speaking");
		}
		return param1;
	}

	function get_style():String {
		return this._style;
	}

	@:flash.property public var mood(get, set):String;

	function set_mood(param1:String):String {
		this._mood = param1;
		if (!ASCompat.stringAsBool(this._mood)) {
			this.moodIcon.gotoAndStop("none");
		} else {
			this.moodIcon.gotoAndStop(this._mood);
		}
		return param1;
	}

	function get_mood():String {
		return this._mood;
	}

	@:flash.property public var held(get, set):String;

	function set_held(param1:String):String {
		return this._held = param1;
	}

	function get_held():String {
		return this._held;
	}

	public function getDialogueLine():DialogueLine {
		var _loc1_:ASObject = {};
		if (ASCompat.stringAsBool(this._style)) {
			_loc1_["style"] = this._style;
		}
		if (ASCompat.stringAsBool(this._mood)) {
			_loc1_["mood"] = this._mood;
		}
		if (ASCompat.stringAsBool(this._nextLine)) {
			_loc1_["next"] = this._nextLine;
		}
		if (ASCompat.stringAsBool(this._held)) {
			_loc1_["held"] = this._held;
		}
		if (this._sourceLine.settings["set"]) {
			_loc1_["set"] = this._sourceLine.settings["set"];
		}
		if (this._sourceLine.settings["check"]) {
			_loc1_["check"] = this._sourceLine.settings["check"];
		}
		return new DialogueLine(this.phrase, _loc1_);
	}

	public function select(param1:Bool = true) {
		this._selected = param1;
		if (this._selected) {
			this.background.gotoAndStop("down");
		} else {
			this.background.gotoAndStop("normal");
		}
	}

	@:flash.property public var selected(get, never):Bool;

	function get_selected():Bool {
		return this._selected;
	}

	@:flash.property public var id(get, never):UInt;

	function get_id():UInt {
		return this._lineID;
	}
}
