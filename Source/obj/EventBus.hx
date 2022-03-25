package obj;

class EventBus {
	public static var events:ASDictionary<String, Array<ASFunction>> = new ASDictionary();

	public static function addListener(param1:String, param2:ASFunction) {
		if (events.exists(param1)) {
			events[param1] = new Array<ASFunction>();
		}
		events[param1].push(param2);
	}

	public static function removeListener(param1:String, param2:ASFunction) {
		var idx = 0;
		if (events.exists(param1)) {
			var handlers = events[param1];
            idx = handlers.indexOf(param2);
			if (idx != -1) {
				handlers.splice(idx, 1);
			}
		}
	}

	public static function dispatch(param1:String) {
		if (events.exists(param1)) {
			var handlers = events[param1];
			for (handler in handlers) {
				handler();
			}
		}
	}
}
