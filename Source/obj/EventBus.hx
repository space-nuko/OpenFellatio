package obj;

class EventBus {
	public static var events:ASDictionary<String, Array<ASFunction>> = new ASDictionary();

	public static function addListener(param1:String, param2:ASFunction) {
		if (!events[param1]) {
			events[param1] = new Array<ASAny>();
		}
		events[param1].push(param2);
	}

	public static function removeListener(param1:String, param2:ASFunction) {
		var _loc3_:Array<ASAny> = null;
		var _loc4_ = 0;
		if (events[param1]) {
			_loc3_ = events[param1];
			if ((_loc4_ = _loc3_.indexOf(param2)) != -1) {
				_loc3_.splice(_loc4_, 1);
			}
		}
	}

	public static function dispatch(param1:String):ASAny {
		var _loc2_:Array<ASAny> = null;
		var _loc3_:ASFunction = null;
		if (events[param1]) {
			_loc2_ = events[param1];
			for (_tmp_ in _loc2_) {
				_loc3_ = _tmp_;
				_loc3_();
			}
		}
	}
}
