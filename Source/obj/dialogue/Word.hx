package obj.dialogue;

import obj.Her;

class Phoneme {
    public var phoneme: obj.Her.MouthShape;
    public var sayL: Bool;

    public function new(_phoneme: obj.Her.MouthShape, _sayL: Bool)
    {
        phoneme = _phoneme;
        sayL = _sayL;
    }
}

class Word {
    public var word:String;
	public var wordLength:UInt = 0;
	public var phonemes:Array<Phoneme>;
	public var actionWord:Bool = false;

	public function new(param1:String) {
		var _loc2_:UInt = 0;
		var _loc3_:String = null;
		var _loc4_:Array<String> = null;
		var _loc5_ = false;
		var _loc6_:UInt = 0;
		// super();
		this.word = param1;
		this.phonemes = new Array<Phoneme>();
		this.wordLength = this.word.length;
		if (new compat.RegExp("\\[.*?\\]").match(param1) != null) {
			this.actionWord = true;
		} else {
			_loc2_ = 0;
			_loc3_ = "";
            _loc4_ = new compat.RegExp("\\W*\\w", "i").match(this.word);
			if (_loc4_ != null && _loc4_.length > 0) {
				_loc5_ = new compat.RegExp("[^aeiouy]").test(_loc4_[0]);
				_loc6_ = 0;
				while (_loc6_ < this.wordLength) {
					if (_loc5_) {
						if (new compat.RegExp("[^bcdfghjklmnpqrstvwxz]", "i").match(this.word.charAt(_loc6_)) != null) {
							_loc5_ = false;
							this.phonemes[_loc6_] = this.findPhonemes(_loc3_);
							_loc3_ = "";
						}
					} else if (new compat.RegExp("[bcdfghjklmnpqrstvwxz]", "i").match(this.word.charAt(_loc6_)) != null) {
						_loc5_ = true;
						this.phonemes[_loc6_] = this.findPhonemes(_loc3_);
						_loc3_ = "";
					}
					_loc3_ += this.word.charAt(_loc6_);
					_loc6_++;
				}
				this.phonemes[_loc6_] = this.findPhonemes(_loc3_);
			}
		}
	}

	@:flash.property public var action(get, never):String;

	function get_action():String {
		return new compat.RegExp("\\W", "gi").replace(this.word, "");
	}

	public function letter(param1:UInt):String {
		return this.word.charAt(param1);
	}

	public function phoneme(param1:UInt):Null<Phoneme> {
		return this.phonemes[param1] != null ? this.phonemes[param1] : null;
	}

	public function phonemeLength(param1:UInt):UInt {
		var _loc2_:UInt = 0;
		var _loc3_:Null<Phoneme> = this.phoneme(param1);
		param1++;
		while (param1 < this.wordLength && (this.phoneme(param1) == null || this.phoneme(param1) == _loc3_)) {
			_loc2_++;
			param1++;
		}
		return _loc2_;
	}

	@:flash.property public var length(get, never):UInt;

	function get_length():UInt {
		return this.wordLength;
	}

	public function findPhonemes(param1:Null<String>): Null<Phoneme> {
		var _loc2_:Null<obj.Her.MouthShape> = null;
		var _loc3_ = false;
		if (param1 == "I") {
			_loc2_ = Her.MouthShapeUH;
		} else if (param1 != null) {
			if (new compat.RegExp("f|ph", "i").match(param1) != null) {
				_loc2_ = Her.MouthShapeFF;
			} else if (new compat.RegExp("m|p|b", "i").match(param1) != null) {
				_loc2_ = Her.MouthShapeMM;
			} else if (new compat.RegExp("a|^a$").match(param1) != null) {
				_loc2_ = Her.MouthShapeAH;
			} else if (new compat.RegExp("^i$|ee|ea|oe|ou|^y$", "i").match(param1) != null) {
				_loc2_ = Her.MouthShapeEE;
			} else if (new compat.RegExp("^e$|^u$|ou", "i").match(param1) != null) {
				_loc2_ = Her.MouthShapeUH;
			} else if (new compat.RegExp("^o$|oa", "i").match(param1) != null) {
				_loc2_ = Her.MouthShapeOH;
			} else if (new compat.RegExp("oo|w", "i").match(param1) != null) {
				_loc2_ = Her.MouthShapeOO;
			} else {
				_loc2_ = Her.MouthShapeUH;
			}
			if (new compat.RegExp("l", "i").match(param1) != null) {
				_loc3_ = true;
			}
		}
		if (_loc2_ != null) {
			return new Phoneme(_loc2_, _loc3_);
		}
		return null;
	}
}
