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
		var isVowel = false;
		var _loc6_:UInt = 0;
		// super();
		this.word = param1;
		this.phonemes = new Array<Phoneme>();
		this.wordLength = this.word.length;
		if (~/\[.*?\]/.match(param1)) {
			this.actionWord = true;
		} else {
			_loc2_ = 0;
			_loc3_ = "";
            var wordRegex = ~/[A-Z]*[a-z]/i;
			if (wordRegex.match(this.word)) {
                var result = wordRegex.matched(0);

				isVowel = (~/[^aeiouy]/).match(result);
				_loc6_ = 0;
				while (_loc6_ < this.wordLength) {
                    var consonant = ~/[^bcdfghjklmnpqrstvwxz]/i;
					if (isVowel) {
						if (consonant.match(this.word.charAt(_loc6_))) {
							isVowel = false;
							this.phonemes[_loc6_] = this.findPhonemes(_loc3_);
							_loc3_ = "";
						}
					} else if (consonant.match(this.word.charAt(_loc6_))) {
						isVowel = true;
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
		return (~/[A-Z]/gi).replace(this.word, "");
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
			if ((~/f|ph/i).match(param1)) {
				_loc2_ = Her.MouthShapeFF;
			} else if ((~/m|p|b/i).match(param1)) {
				_loc2_ = Her.MouthShapeMM;
			} else if ((~/a|^a$/).match(param1)) {
				_loc2_ = Her.MouthShapeAH;
			} else if ((~/^i$|ee|ea|oe|ou|^y$/i).match(param1)) {
				_loc2_ = Her.MouthShapeEE;
			} else if ((~/^e$|^u$|ou/i).match(param1)) {
				_loc2_ = Her.MouthShapeUH;
			} else if ((~/^o$|oa/i).match(param1)) {
				_loc2_ = Her.MouthShapeOH;
			} else if ((~/oo|w/i).match(param1)) {
				_loc2_ = Her.MouthShapeOO;
			} else {
				_loc2_ = Her.MouthShapeUH;
			}
			if ((~/l/i).match(param1)) {
				_loc3_ = true;
			}
		}
		if (_loc2_ != null) {
			return new Phoneme(_loc2_, _loc3_);
		}
		return null;
	}
}
