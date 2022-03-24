package obj;

import openfl.display.DisplayObjectContainer;
import openfl.display.FrameLabel;
import openfl.display.MovieClip;
import openfl.events.MouseEvent;
import openfl.geom.ColorTransform;

class CharacterElementHelper {
	public var elementNameList:Array<String>;
	public var findFunction:ASFunction;
	public var selectFunction:ASFunction;
	public var fillFunction:ASFunction;
	public var selection:UInt = 0;
	public var nameDictionary:ASDictionary<ASAny, ASAny>;
	public var defaultRGB:ASDictionary<ASAny, ASAny>;
	public var defaultRGB2:ASDictionary<ASAny, ASAny>;
	public var haveMenuList:Bool = false;
	public var menuList:MovieClip;
	public var updateMenuList:ASFunction;
	public var haveRGBFill:Bool = false;
	public var haveRGBFill2:Bool = false;
	public var rgbButton:MovieClip;
	public var rgbButton2:MovieClip;
	public var rgb1:ASObject;
	public var rgb2:ASObject;
	public var rgb1Fills:Array<ASAny>;
	public var rgb2Fills:Array<ASAny>;
	public var selectedFill:Int = 0;
	public var components:Array<ASAny>;
	public var associatedModType:String;
	public var listeners:Array<ASAny>;

	public function new(param1:Array<String>, param2:ASFunction = null, param3:ASFunction = null, param4:ASFunction = null) {
		/*
		 * Decompilation error
		 * Code may be obfuscated
		 * Tip: You can try enabling "Automatic deobfuscation" in Settings
		 * Error type: NullPointerException (null)
		 */
		throw new flash.errors.IllegalOperationError("Not decompiled due to error");
	}

	public function registerComponents(param1:Array<ASAny>, param2:String = "", param3:Bool = true) {
		/*
		 * Decompilation error
		 * Code may be obfuscated
		 * Tip: You can try enabling "Automatic deobfuscation" in Settings
		 * Error type: NullPointerException (null)
		 */
		throw new flash.errors.IllegalOperationError("Not decompiled due to error");
	}

	public function hideAll() {
		var _loc1_:MovieClip = null;
		for (_tmp_ in this.components) {
			_loc1_ = _tmp_;
			_loc1_.visible = false;
		}
	}

	public function showAll() {
		var _loc1_:MovieClip = null;
		for (_tmp_ in this.components) {
			_loc1_ = _tmp_;
			_loc1_.visible = true;
		}
	}

	public function defaultFillFunction(param1:ASObject, param2:String = "rgbFill") {
		var _loc4_:MovieClip = null;
		var _loc3_ = new ColorTransform(1, 1, 1, param1.a, param1.r, param1.g, param1.b);
		for (_tmp_ in this.components) {
			_loc4_ = _tmp_;
			this.tryToSetFill(_loc4_, param2, _loc3_);
		}
	}

	public function shuffle(param1:AlphaRGBObject, param2:AlphaRGBObject, param3:Float = -1) {
		var _loc4_:UInt = Std.int(Math.ffloor(Math.random() * (this.elementNameList.length - 1)) + 1);
		if (param3 != -1 && Math.random() < param3) {
			_loc4_ = 0;
		}
		this.select(_loc4_);
		if (this.haveRGBFill) {
			this.setFill(param1, "rgbFill");
		}
		if (this.haveRGBFill2) {
			this.setFill(param2, "rgbFill2");
		}
	}

	public function componentClicked(param1:MouseEvent) {
		if (G.shiftDown) {
			this.findName("None");
			if (ASCompat.stringAsBool(this.associatedModType)) {
				G.customElementLoader.clearModTypes([this.associatedModType]);
			}
			this.updateMenuList();
			G.saveData.saveCharData();
		}
	}

	public function prepForMod(param1:String, param2:Bool = false) {
		if (param2) {
			this.findName("None");
			if (ASCompat.stringAsBool(this.associatedModType)) {
				G.customElementLoader.clearModTypes([this.associatedModType]);
			}
		}
		this.updateMenuList(param1);
	}

	public function tryToSetFrameLabel(param1:MovieClip, param2:String) {
		var _loc3_:Array<ASAny> = null;
		var _loc4_:FrameLabel = null;
		if (param1 != null) {
			_loc3_ = param1.currentLabels;
			for (_tmp_ in _loc3_) {
				_loc4_ = _tmp_;
				if (_loc4_.name == param2) {
					param1.gotoAndStop(param2);
					return;
				}
			}
			param1.gotoAndStop("None");
		}
	}

	public function tryToSetFill(param1:MovieClip, param2:String, param3:ColorTransform) {
		if (param1 != null) {
			this.tryToSetFillChildren(param1, param2, param3);
		}
	}

	public function tryToSetFillChildren(param1:MovieClip, param2:String, param3:ColorTransform) {
		var _loc4_:Float = param1.numChildren;
		var _loc5_:UInt = 0;
		while (_loc5_ < _loc4_) {
			if (param1.getChildAt(_loc5_).name == param2) {
				param1.getChildAt(_loc5_).transform.colorTransform = param3;
			}
			if (Std.is(param1.getChildAt(_loc5_), DisplayObjectContainer)) {
				this.tryToSetFillChildren(Std.downcast(param1.getChildAt(_loc5_), MovieClip), param2, param3);
			}
			_loc5_++;
		}
	}

	public function registerListener(param1:ASFunction) {
		this.listeners.push(param1);
	}

	public function setStartRGB(param1:AlphaRGBObject) {
		this.rgb1 = param1;
	}

	public function setDefaultRGB(param1:String, param2:AlphaRGBObject = null, param3:AlphaRGBObject = null) {
		if (this.nameDictionary[param1]) {
			this.defaultRGB[G.dataName(param1)] = param2;
			this.defaultRGB2[G.dataName(param1)] = param3;
		}
	}

	public function updateList() {
		if (this.haveMenuList) {
			this.updateMenuList();
		}
	}

	public function beingUsed():Bool {
		return this.selectedName != "None";
	}

	public function getOptionalDataString(param1:String):String {
		if (this.beingUsed()) {
			return ";" + param1 + ":" + this.getDataString();
		}
		return "";
	}

	public function getDataString():String {
		return G.dataName(this.elementNameList[this.selection])
			+ (!!this.haveRGBFill ? ","
				+ this.rgb1["r"]
				+ ","
				+ this.rgb1["g"]
				+ ","
				+ this.rgb1["b"]
				+ ","
				+ G.sigRound(3, this.rgb1["a"]) : "")
			+ (!!this.haveRGBFill2 ? ","
				+ this.rgb2["r"]
				+ ","
				+ this.rgb2["g"]
				+ ","
				+ this.rgb2["b"]
				+ ","
				+ G.sigRound(3, this.rgb2["a"]) : "");
	}

	public function loadDataString(param1:String) {
		var _loc2_:Array<ASAny> = (cast param1.split(","));
		this.findFunction(ASCompat.toString(_loc2_[0]));
		if (_loc2_.length == 5) {
			this.readRGB(_loc2_.slice(1, 5), "rgbFill");
			if (this.haveRGBFill2 && this.getDefaultRGB2()) {
				this.setFill(this.getDefaultRGB2(), "rgbFill2");
			}
		} else if (_loc2_.length == 9) {
			this.readRGB(_loc2_.slice(1, 5), "rgbFill");
			this.readRGB(_loc2_.slice(5), "rgbFill2");
		}
	}

	public function getDefaultRGB():AlphaRGBObject {
		return this.defaultRGB[G.dataName(this.elementNameList[this.selection])];
	}

	public function getDefaultRGB2():AlphaRGBObject {
		return this.defaultRGB2[G.dataName(this.elementNameList[this.selection])];
	}

	public function readRGB(param1:Array<ASAny>, param2:String) {
		param1[0] = Math.fround(Math.max(0, Math.min(255, ASCompat.toNumber(param1[0]))));
		param1[1] = Math.fround(Math.max(0, Math.min(255, ASCompat.toNumber(param1[1]))));
		param1[2] = Math.fround(Math.max(0, Math.min(255, ASCompat.toNumber(param1[2]))));
		param1[3] = Math.max(0, Math.min(1, ASCompat.toNumber(param1[3])));
		if (!Math.isNaN(param1[0]) && !Math.isNaN(param1[1]) && !Math.isNaN(param1[2]) && !Math.isNaN(param1[3])) {
			this.setFill({
				"r": param1[0],
				"g": param1[1],
				"b": param1[2],
				"a": param1[3]
			}, param2);
		}
	}

	public function registerMenuList(param1:MovieClip) {
		/*
		 * Decompilation error
		 * Code may be obfuscated
		 * Tip: You can try enabling "Automatic deobfuscation" in Settings
		 * Error type: NullPointerException (null)
		 */
		throw new flash.errors.IllegalOperationError("Not decompiled due to error");
	}

	public function registerRGBButton(param1:MovieClip, param2:Array<ASAny>, param3:Float, param4:Bool = true) {
		/*
		 * Decompilation error
		 * Code may be obfuscated
		 * Tip: You can try enabling "Automatic deobfuscation" in Settings
		 * Error type: NullPointerException (null)
		 */
		throw new flash.errors.IllegalOperationError("Not decompiled due to error");
	}

	public function registerSecondaryRGBButton(param1:MovieClip, param2:Array<ASAny>, param3:Float, param4:Bool = true) {
		/*
		 * Decompilation error
		 * Code may be obfuscated
		 * Tip: You can try enabling "Automatic deobfuscation" in Settings
		 * Error type: NullPointerException (null)
		 */
		throw new flash.errors.IllegalOperationError("Not decompiled due to error");
	}

	public function select(param1:UInt) {
		var _loc2_:ASFunction = null;
		this.selection = param1;
		this.selectFunction(this.selection);
		if (this.haveRGBFill) {
			if (this.getDefaultRGB()) {
				this.setFill(this.getDefaultRGB(), "rgbFill");
			} else {
				this.setFill(this.rgb1, "rgbFill");
			}
		}
		if (this.haveRGBFill2) {
			if (this.getDefaultRGB2()) {
				this.setFill(this.getDefaultRGB2(), "rgbFill2");
			} else {
				this.setFill(this.rgb2, "rgbFill2");
			}
		}
		if (this.haveMenuList) {
			this.updateMenuList();
		}
		for (_tmp_ in this.listeners) {
			_loc2_ = _tmp_;
			_loc2_(this.elementNameList[this.selection]);
		}
	}

	public function setFill(param1:ASObject, param2:String) {
		if (param1) {
			if (this.fillFunction != null) {
				this.fillFunction(param1, param2);
			}
			if (this.rgbButton == null) {}
			if (param2 == "rgbFill") {
				this.rgb1 = param1;
			} else if (param2 == "rgbFill2") {
				this.rgb2 = param1;
			}
		}
	}

	public function findName(param1:String) {
		this.findFunction(param1);
	}

	public function resetElement() {
		this.select(this.selection);
	}

	public function resetFills() {
		if (this.haveRGBFill) {
			this.setFill(this.rgb1, "rgbFill");
		}
		if (this.haveRGBFill2) {
			this.setFill(this.rgb2, "rgbFill2");
		}
	}

	@:flash.property public var nameList(get, never):Array<String>;

	function get_nameList():Array<String> {
		return this.elementNameList;
	}

	@:flash.property public var selectedName(get, never):String;

	function get_selectedName():String {
		return this.elementNameList[this.selection];
	}
   }
