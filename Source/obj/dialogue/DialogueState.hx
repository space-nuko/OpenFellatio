package obj.dialogue;
class DialogueState {
	public var _buildLevel:Float = 0;
	public var _maxBuild:Float = 0;
	public var _priority:UInt = 0;
	public var _prevPhrases:ASDictionary<ASAny, ASAny>;
	public var _prevPhrasesLength:UInt = 0;
	public var _lastUsed:UInt = 0;
	public var _defaultReduceSpeed:Float = 1;
	public var _noBuildDelay:UInt = 0;

	public function new(param1:Float, param2:UInt, param3:Float = 1) {
		this._prevPhrases = new ASDictionary<ASAny, ASAny>();
		// super();
		this._maxBuild = param1;
		this._priority = param2;
		this._defaultReduceSpeed = param3;
	}

	public function buildState(param1:Float) {
		if (this._noBuildDelay == 0) {
			this._buildLevel = Math.min(this._maxBuild, this._buildLevel + param1);
		}
	}

	public function reduce(param1:Float = -1) {
		if (param1 == -1) {
			param1 = this._defaultReduceSpeed;
		}
		if (this._noBuildDelay > 0) {
			--this._noBuildDelay;
		}
		this._buildLevel = Math.max(0, this._buildLevel - param1);
	}

	public function clearBuild() {
		this._buildLevel = 0;
	}

	public function delayBuild(param1:UInt = 120) {
		this._noBuildDelay = param1;
	}

	public function maxBuild() {
		this._buildLevel = this._maxBuild;
	}

	public function randomPhrase(param1:Array<ASAny>):UInt {
		var _loc5_:UInt = 0;
		var _loc6_:UInt = 0;
		var _loc2_:UInt = param1.length;
		if (this._prevPhrasesLength >= _loc2_) {
			this._prevPhrases = new ASDictionary<ASAny, ASAny>();
			this._prevPhrases[this._lastUsed] = true;
			this._prevPhrasesLength = 1;
		}
		var _loc3_ = new Array<ASAny>();
		var _loc4_:UInt = 0;
		while (_loc4_ < _loc2_) {
			if (!this._prevPhrases[_loc4_]) {
				_loc3_.push(_loc4_);
			}
			_loc4_++;
		}
		if (_loc3_.length == 0) {
			this.clearPrevPhrases();
			return 0;
		}
		_loc5_ = Math.floor(Math.random() * _loc3_.length);
		_loc6_ = _loc3_[_loc5_];
		this._prevPhrases[_loc6_] = true;
		++this._prevPhrasesLength;
		this._lastUsed = _loc6_;
		return _loc6_;
	}

	public function clearPrevPhrases() {
		this._prevPhrases = new ASDictionary<ASAny, ASAny>();
		this._prevPhrasesLength = 0;
	}

	@:flash.property public var build(get, never):Float;

	function get_build():Float {
		return this._buildLevel;
	}

	@:flash.property public var max(get, never):Float;

	function get_max():Float {
		return this._maxBuild;
	}

	@:flash.property public var priority(get, never):UInt;

	function get_priority():UInt {
		return this._priority;
	}
}
