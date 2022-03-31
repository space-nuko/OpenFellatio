/*
 * Originally from: https://github.com/Nootna8/SDTButtplug
 */

package mod.oflbuttplug;

import haxe.net.WebSocket;
import haxe.Timer;
import haxe.Json;
import sdtmods.Mod;
import obj.dialogue.Dialogue;
import obj.Him;
import obj.Her;
import obj.Maths;

class Settings {
	public var socketUrl:String = "ws://localhost:12345/buttplug";
	public var debug:Bool = false;
	public var hjTwist:Bool = false;
	public var updateInterval:Float = /*0*/ 0.1;
	public var minimumMove:Float = 0.03;
	public var minimumDuration:Float = 0.2;
	public var positionMin:Float = 0.1;
	public var positionMax:Float = 0.9;
	public var smoothing:Float = /*1.0*/ 20.0;
	public var vibrationSpeed:Float = 0.85;
	public var vibrationDecay:Float = 0.7;
	public var spurtDelay:Float = 100;
	public var spurtIntensity:Float = 0.2;
	public var spurtVariance:Float = 1.0;
	public var reconnectKey:UInt = 186; // Semicolon

	public function new() {}
}

class OFLButtPlug extends Mod {
	public function new() {}

	var settings:Settings;

	var websocket:WebSocket;
	var devices:Array<Dynamic> = [];

	var lastPosition:Float = 0;
	var lastAngle:Float = 0;
	var lastVibration:Float = 0;
    var timePassed:Float = 0;

	var lastState:Map<String, Float> = [Dialogue.CUM_IN_MOUTH => 0, Dialogue.CUM_IN_THROAT => 0];

	var lastSpurting:Bool = false;
	var lastFlashing:Bool = false;

	var offsetPos:Float = 0;
	var offsetUntil:Float = 0;

	var defaultSettings:Settings = new Settings();

    var him: Him;
    var her: Her;

	var connected:Bool = false;

	public override function init() {
		// if (Security.sandboxType != Security.LOCAL_TRUSTED) {
		// 	failedLoading("Sandbox is not trusted");
		// 	return;
		// }

        this.her = G.her;
        this.him = G.him;

		// var modSettingsLoader:ASAny = (loader.eDOM.getDefinition("Modules.modSettingsLoader") : Class<Dynamic>);
		// var msl:ASAny = Type.createInstance(modSettingsLoader, ["OFLButtplug", settingsLoaded]);
		// msl.addEventListener("settingsNotFound", settingsNotFound);
		settings = defaultSettings;
		connectIntiface();
	}

	// @:allow(flash) function continueLoad():ASAny {
	// 	// loader.addEnterFramePersist(doUpdate);
	// 	// loader.registerFunctionPersist(connectIntiface, settings['reconnectKey']);
	// 	// connectIntiface();
	// }
	// @:allow(flash) function settingsNotFound(e:ASAny):ASAny {
	// 	// loader.updateStatusCol("OFLButtplug: settings not found, defaults loaded", "#0000FF");
	// 	// settings = defaultSettings;
	// 	// continueLoad();
	// }
	// @:allow(flash) function checkSettings():ASAny {
	// 	for (k in defaultSettings.___keys()) {
	// 		if (settings[k] == null) {
	// 			return false;
	// 		}
	// 	}
	// 	settings['positionMin'] = Std.parseFloat(settings['positionMin']);
	// 	settings['positionMax'] = Std.parseFloat(settings['positionMax']);
	// 	settings['vibrationSpeed'] = Std.parseFloat(settings['vibrationSpeed']);
	// 	settings['vibrationDecay'] = Std.parseFloat(settings['vibrationDecay']);
	// 	settings['spurtIntensity'] = Std.parseFloat(settings['spurtIntensity']);
	// 	settings['spurtDelay'] = Std.parseFloat(settings['spurtDelay']);
	// 	settings['spurtVariance'] = Std.parseFloat(settings['spurtVariance']);
	// 	return true;
	// }
	// @:allow(flash) function settingsLoaded(e:ASAny):ASAny {
	// 	settings = e.settings;
	// 	if (checkSettings() != true) {
	// 		loader.updateStatusCol("OFLButtplug: invalid config, defaults loaded", "#0000FF");
	// 		settings = defaultSettings;
	// 	} else {
	// 		loader.updateStatusCol("OFLButtplug: config file loaded", "#0000FF");
	// 	}
	// 	continueLoad();
	// }

	private static inline function mapValue(value:Float, inMin:Float, inMax:Float, outMin:Float, outMax:Float):Float {
		return (value - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;
	}

	private function detectSpurting(currentTime:Float, pos:Float) {
		if (currentTime < (offsetUntil + 50)) {
			return;
		}

		var spurtIntensity = settings.spurtIntensity;
		var spurtVariance = settings.spurtVariance;
		var spurtDelay = settings.spurtDelay;

		var spurtMod = 1.0 - (him.twitchFactor * spurtVariance);
		var spurtDist = spurtIntensity * spurtMod;

		for (k in lastState.keys()) {
			var v = lastState[k];
			var newv = G.dialogueControl.states[k]._buildLevel;

			if (newv > v) {
				if (pos > 0.5) {
					offsetPos = -spurtDist;
				} else {
					offsetPos = spurtDist;
				}

				offsetUntil = currentTime + spurtDelay;
			}

			lastState[k] = newv;
		}

		if (him.spurting) {
			if (pos > 0.5) {
				offsetPos = -spurtDist;
			} else {
				offsetPos = spurtDist;
			}

			offsetUntil = currentTime + spurtDelay;
		}

		lastSpurting = him.spurting;
	}

	public override function tick(f:Float) {
		var pos:Float = 0;
		var twist:Float = 0;
		var currentTime:Float = Timer.stamp();

		if (G.handJobMode) {
			if (settings.hjTwist) {
				twist = G.currentHandJobPos.x;
				pos = her.pos;
			} else {
				pos = G.currentHandJobPos.x;
			}
		} else if (her.isInMouth() && her.penisInMouthDist > 0) {
			pos = her.penisInMouthDist / him.currentPenisLength;
		}

		detectSpurting(currentTime, pos);

		if (offsetUntil > currentTime) {
			pos += offsetPos;
		}

		var angle:Float = mapValue(him.penis.rotation, -4, 20, 0, 1);
		pos = mapValue(pos, 0, 1, settings.positionMax, settings.positionMin);

		sendPosition(f, pos, angle, twist);
	}

	private function connectIntiface() {
		// loader.updateStatusCol("OFLButtplug: connecting ...", "#00FF00");
		trace("OFLButtplug: connecting ...");

		if (websocket != null) {
			websocket.close();
		}

		websocket = WebSocket.create(settings.socketUrl, [], false);

		websocket.onopen = function() {
            var request:Array<Dynamic> = [{"RequestServerInfo": {"Id": 1, "ClientName": "OFL", "MessageVersion": 1}}];
            websocket.sendString(Json.stringify(request));
        };
        websocket.onclose = function() {
            trace("disconnected");
            connected = false;
        };
        websocket.onmessageString = function(s:String)
        {
	 		var response = cast(Json.parse(s), Array<Dynamic>);
	 		if(response[0] == null) {
	 			return;
	 		}

	 		var resp: Dynamic = response[0];

	 		if(resp.ServerInfo != null) {
	 			connected = true;
	 			// loader.updateStatusCol("OFLButtplug: connected", "#00FF00");
	 			trace("OFLButtplug: connected");
	 			var request:Array<Dynamic> = [ {StartScanning: {Id: 2}} ];
	 			websocket.sendString(Json.stringify(request));
	 			request = [ {"RequestDeviceList": {"Id": 3}} ];
	 			websocket.sendString(Json.stringify(request));
	 		}

	 		if(resp.DeviceList != null) {
	 			devices = resp.DeviceList.Devices;
	 			// loader.updateStatusCol("OFLButtplug: device update", "#00FF00");
	 			trace("OFLButtplug: device update");
	 		}

	 		if(resp.DeviceAdded != null || resp.DeviceRemoved != null) {
	 			var request:Array<Dynamic> = [ {RequestDeviceList: {Id: 3}} ];
	 			websocket.sendString(Json.stringify(request));
	 		}
        };
    }

	private function sendPosition(deltaTime:Float, position:Float, angle:Float, twist:Float) {
		if (!connected) {
			return;
		}

        timePassed += deltaTime;

		var positionChange:Float = Math.abs(lastPosition - position);

		if (timePassed < settings.updateInterval) {
			return;
		}

        timePassed -= settings.updateInterval;

		for (device in devices) {
			var request:Array<Dynamic> = [];

			if (positionChange >= settings.minimumMove) {
				var dur:Int = Std.int(Math.max(timePassed * settings.smoothing, settings.minimumDuration) * 1000);

				if (device.DeviceMessages.LinearCmd) {
					var linear:Dynamic = {
						LinearCmd: {
							Id: 4,
							DeviceIndex: device.DeviceIndex,
							Vectors: [
								{
									Index: 0,
									Duration: dur,
									Position: Maths.clampf(position, 0, 1)
								}
							]
						}
					};

					if (device.DeviceMessages.LinearCmd.FeatureCount > 12) {
						linear.LinearCmd.Vectors.push({
							Index: 10,
							Duration: dur,
							Position: Maths.clampf(twist, 0, 1)
						});

						linear.LinearCmd.Vectors.push({
							Index: 12,
							Duration: dur,
							Position: Maths.clampf(angle, 0, 1)
						});
					}

					request.push(linear);
				}
			}

			if (device.DeviceMessages.VibrateCmd != null) {
				var vibrate:Float = mapValue(positionChange, 0, 1 - settings.vibrationSpeed, 0, 1);
				if (vibrate < lastVibration) {
					var vibrationDecay:Float = mapValue(timePassed, 0, 200, 0, settings.vibrationDecay);
					vibrate = Maths.clampf(lastVibration - vibrationDecay, 0, 1);
					lastVibration = vibrate;
				}
				lastVibration = vibrate;

				request.push({
					VibrateCmd: {
						Id: 5,
						DeviceIndex: device.DeviceIndex,
						Speeds: [
							{
								Index: 0,
								Speed: vibrate
							}
						]
					}
				});
			}

			if (request.length > 0) {
				websocket.sendString(Json.stringify(request));
			}
		}

		lastPosition = position;
		lastAngle = angle;
	}
}
