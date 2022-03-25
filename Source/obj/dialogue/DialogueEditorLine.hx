package obj.dialogue;

import openfl.display.MovieClip;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.text.TextField;
import openfl.text.TextFieldAutoSize;

@:rtti
@:access(swf.exporters.animate)
class DialogueEditorLine extends openfl.display.MovieClip {
	public static var _totalLineCount:Int = 1;

	public var _lineID:UInt = 0;
	public var _selected:Bool = false;
	public var _clickCallback:ASFunction;
	public var _changeCallback:ASFunction;
	public var _trigger:Null<String>;
	public var _style:Null<String>;
	public var _mood:Null<String>;
	public var _nextLine:Null<String>;
	public var _held:Null<String>;
	public var _sourceLine:DialogueLine;
	public var _wildcard:Bool = false;
	public var _finish:Bool = false;
	public var _lastCaret:Int = -1;
	public var showing:Bool = true;
	public var _lineCount:Int = 1;

	@:keep @:noCompletion @:dox(hide) public var background(default, null):openfl.display.MovieClip;
	@:keep @:noCompletion @:dox(hide) public var spot(default, null):openfl.display.MovieClip;
	// @:keep @:noCompletion @:dox(hide) public var mbPreview(default, null):MenuArrowH;
	@:keep @:noCompletion @:dox(hide) public var lineWindow(default, null):openfl.display.MovieClip;
	@:keep @:noCompletion @:dox(hide) public var triggerLabel(default, null):openfl.text.TextField;
	@:keep @:noCompletion @:dox(hide) public var moodIcon(default, null):openfl.display.MovieClip;
	@:keep @:noCompletion @:dox(hide) public var dialogueLine(default, null):openfl.text.TextField;
	@:keep @:noCompletion @:dox(hide) public var hitbox(default, null):openfl.display.MovieClip;

	public function new(param1:DialogueLine, param2:String, param3:ASFunction, param4:ASFunction, param5:Bool = false) {
		var library = swf.exporters.animate.AnimateLibrary.get("FYA8BqNO2PenTmHMYgDK");
		var symbol = library.symbols.get(2946);
		symbol.__init(library);

		super();

		this.background.gotoAndStop("normal");
		this.spot.gotoAndStop("speaking");
		this.moodIcon.gotoAndStop("none");
		this.dialogueLine.autoSize = TextFieldAutoSize.LEFT;
		this.dialogueLine.wordWrap = true;
		if (param1 == null) {
			this._sourceLine = new DialogueLine("");
			this.dialogueLine.text = "";
		} else {
			this._sourceLine = param1;
			this.dialogueLine.text = param1.phrase;
			this.style = param1.style;
			this.mood = param1.mood;
			this.held = param1.held;
			this.nextLine = param1.nextLine;
		}
		this._wildcard = param5;
		this.trigger = param2;
		this._clickCallback = param3;
		this._changeCallback = param4;
		this._lineID = DialogueEditorLine._totalLineCount;
		++DialogueEditorLine._totalLineCount;
		// this.mbPreview.visible = !this._wildcard;
		this._lineCount = this.dialogueLine.numLines;
		this.updateHeight();
		addEventListener(MouseEvent.CLICK, this.clicked);
		this.hitbox.addEventListener(MouseEvent.MOUSE_DOWN, this.pressed);
		this.hitbox.addEventListener(MouseEvent.MOUSE_UP, this.released);
		this.hitbox.addEventListener(MouseEvent.ROLL_OVER, this.rolledOver);
		this.hitbox.addEventListener(MouseEvent.ROLL_OUT, this.rolledOut);
		this.dialogueLine.addEventListener(KeyboardEvent.KEY_UP, this.typed);
		this.dialogueLine.addEventListener(MouseEvent.CLICK, this.lineClicked);
	}

	public function typed(param1:KeyboardEvent) {
		this.lineChanged();
	}

	public function lineClicked(param1:MouseEvent) {
		if (this.dialogueLine.caretIndex != this._lastCaret) {
			this._lastCaret = this.dialogueLine.caretIndex;
			this.checkSelection();
		}
	}

	public function checkSelection() {
		var _loc1_:Null<String> = null;
		var _loc2_:Null<String> = null;
		var _loc3_:UInt = 0;
		var _loc4_:UInt = 0;
		var _loc5_ = false;
		var _loc6_ = false;
		if (this._lastCaret != -1) {
			_loc3_ = this._lastCaret;
			_loc4_ = this._lastCaret;
			_loc5_ = true;
			_loc6_ = true;
			while (_loc5_ || _loc6_) {
				if (_loc5_) {
					if (_loc3_ < (this.dialogueLine.length - 1:UInt)) {
						_loc3_++;
						if (this.dialogueLine.text.charAt(_loc3_) == "]") {
							_loc1_ = "]";
							_loc5_ = false;
						} else if (this.dialogueLine.text.charAt(_loc3_) == "[") {
							_loc5_ = false;
						}
					} else {
						_loc5_ = false;
					}
				}
				if (_loc6_) {
					if (_loc4_ > 0) {
						_loc4_--;
						if (this.dialogueLine.text.charAt(_loc4_) == "[") {
							_loc2_ = "[";
							_loc6_ = false;
						} else if (this.dialogueLine.text.charAt(_loc4_) == "]") {
							_loc6_ = false;
						}
					} else {
						_loc6_ = false;
					}
				}
			}
			if (_loc1_ != null && _loc2_ != null) {
				this.dialogueLine.setSelection(_loc4_, _loc3_ + 1);
			}
		}
	}

	public function lineChanged() {
		var _loc1_ = this.dialogueLine.numLines;
		if (_loc1_ != this._lineCount) {
			this._lineCount = _loc1_;
			this.updateHeight();
			this._changeCallback(this);
		}
	}

	public function updateHeight() {
		this.background.height = 20 + 13 * (this._lineCount - 1);
		this.hitbox.height = this.background.height;
		this.lineWindow.height = 20 + 13 * (this._lineCount - 1) - 2;
		this.lineWindow.y = Math.fceil(this.lineWindow.height * 0.5) + 1;
	}

	@:flash.property public var lineHeight(get, never):Float;

	function get_lineHeight():Float {
		return 20 + 13 * (this._lineCount - 1) + 1;
	}

	public function matchesFilter(param1:String):Bool {
		var filterRegex = new EReg(param1, "i");
		if (this.phrase != null && filterRegex.match(this.phrase)) {
			return true;
		}
		if (this.trigger != null && filterRegex.match(this.trigger)) {
			return true;
		}
		if (this._style != null && filterRegex.match(this._style)) {
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
		if (new EReg("finish", "i").match(this._trigger)) {
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
		if (this._style != null) {
			_loc1_["style"] = this._style;
		}
		if (this._mood != null) {
			_loc1_["mood"] = this._mood;
		}
		if (this._nextLine != null) {
			_loc1_["next"] = this._nextLine;
		}
		if (this._held != null) {
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

	public function pressed(param1:MouseEvent) {
		this.background.gotoAndStop("down");
	}

	public function released(param1:MouseEvent) {
		if (this._selected) {
			this.background.gotoAndStop("down");
		} else {
			this.background.gotoAndStop("normal");
		}
	}

	public function rolledOver(param1:MouseEvent) {
		this.background.gotoAndStop("over");
	}

	public function rolledOut(param1:MouseEvent) {
		if (this._selected) {
			this.background.gotoAndStop("down");
		} else {
			this.background.gotoAndStop("normal");
		}
	}

	public function clicked(param1:MouseEvent) {
		this._clickCallback(this);
	}

	public function traceOut():String {
		return this.trigger
			+ ": \""
			+ this.phrase
			+ "\" "
			+ (this._style != null ? "style: " + this._style : "")
			+ (this._mood != null ? ", mood: " + this._mood : "")
			+ (this._nextLine != null ? ", nextLine: " + this._nextLine : "")
			+ (this._held != null ? ", held: " + this._held : "");
	}
}
