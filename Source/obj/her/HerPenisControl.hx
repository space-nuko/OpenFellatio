package obj.her;

import openfl.display.MovieClip;
import openfl.events.Event;
import openfl.events.MouseEvent;
import obj.AlphaRGBObject;
import obj.CharacterElementHelper;
import obj.Her.HerPenisContainer;
import obj.him.Penis;

class HerPenisControl {
	public static var DEFAULT_PENIS_SIZE:Float = 0.85;
	public static var MIN_PENIS_SIZE:Float = 0.7;
	public static var MAX_PENIS_SIZE:Float = 1.2;
	public static var SCALING_RANGE:Float = 0.5;
	public static var MIN_PENIS_ANGLE:Float = -24;

	public var currentPenisLengthScale:Float = 0.85;
	public var currentPenisWidthScale:Float = 0.85;
	public var weightScaling:Float = 1;
	public var penisNameList:Array<String> = ["None", "Strapon", "Penis A", "Penis B"];
	public var penisControl:CharacterElementHelper;
	// public var characterMenu:MovieClip;
	// public var penisMenu:MovieClip;
	public var penisContainer:HerPenisContainer;
	public var penis:Penis;
	public var angSpeed:Float = 0;
	public var torsoAngle:Float = 0;
	public var lastTorsoAngle:Float = 0;
	public var wearingNone:Bool = false;

	public function new() {
		this.penisContainer = G.her.torso.penisContainer;
		this.penis = this.penisContainer.penis;
		this.penis.stop();
		this.penisControl = new CharacterElementHelper(this.penisNameList, this.setPenis);
		this.penisControl.setStartRGB(new AlphaRGBObject(1, 204, 94, 147));
		this.penisControl.registerComponents([this.penis], "", false);
		this.torsoAngle = G.her.rotation + G.her.torso.rotation;
		this.lastTorsoAngle = this.torsoAngle;
		G.characterControl.bottomsControl.registerListener(this.clothingChanged);
		G.characterControl.pantiesControl.registerListener(this.clothingChanged);
		G.characterControl.legwearControl.registerListener(this.clothingChanged);
		G.characterControl.legwearBControl.registerListener(this.clothingChanged);
		this.updateScaling();
	}

	public function setMenu(param1:MovieClip, param2:Array<ASAny>) {
		// this.characterMenu = param1;
		// this.penisMenu = this.characterMenu.penisMenu;
		// this.penisControl.registerMenuList(param1.mlPenis);
		// this.penisControl.registerRGBButton(param1.rgbPenis,param2,489,false);
		// this.penisMenu.penisLengthSlider.setRangeEnd(98);
		// this.penisMenu.penisLengthSlider.addEventListener("handleReleased",this.penisLengthSliderReleased);
		// this.penisMenu.penisLengthSlider.addEventListener("sliderChanged",this.penisLengthSliderChanged);
		// this.penisMenu.mbDefaultPenisLength.addEventListener(MouseEvent.CLICK,this.mbDefaultPenisLengthClicked);
		// this.penisMenu.penisWidthSlider.setRangeEnd(98);
		// this.penisMenu.penisWidthSlider.addEventListener("handleReleased",this.penisWidthSliderReleased);
		// this.penisMenu.penisWidthSlider.addEventListener("sliderChanged",this.penisWidthSliderChanged);
		// this.penisMenu.mbDefaultPenisWidth.addEventListener(MouseEvent.CLICK,this.mbDefaultPenisWidthClicked);
		this.updatePenisWidthSlider();
		this.updatePenisLengthSlider();
		// this.penisMenu.visible = false;
		// this.penisMenu.scaleY = 0;
		// this.penisControl.select(0);
	}

	public function getDataString():String {
		var _loc1_:String = null;
		if (this.currentPenisID == 0) {
			return "";
		}
		_loc1_ = "herPenis:" + this.currentPenisID + "," + this.penisLengthScale + "," + this.penisWidthScale;
		return ";" + _loc1_;
	}

	public function loadDataPairs(param1:Array<Array<String>>) {
		var _loc3_:Array<String> = null;
		var _loc4_:Array<String> = null;
		var _loc2_ = false;
		for (_tmp_ in param1) {
			_loc3_ = _tmp_;
			switch (_loc3_[0]) {
				case "herPenis":
					_loc4_ = _loc3_[1].split(",");
					this.penisControl.select(Std.parseInt(_loc4_[0]));
					if (_loc4_.length == 3) {
						this.loadPenisScales(Std.parseFloat(_loc4_[1]), Std.parseFloat(_loc4_[2]));
					}
					_loc2_ = true;
			}
		}
		if (!_loc2_) {
			this.penisControl.select(0);
		}
	}

	public function clothingChanged(param1:String = "") {
		this.wearingNone = G.characterControl.bottomsControl.selection == 0 && G.characterControl.pantiesControl.selection == 0;
		this.wearingNone = this.wearingNone && G.characterControl.legwearControl.selectedName != "Pantyhose";
		this.wearingNone = this.wearingNone && G.characterControl.legwearBControl.selectedName != "Pantyhose";
		if (!this.wearingNone) {
			this.penisContainer.rotation = HerPenisControl.MIN_PENIS_ANGLE;
		}
		this.updateCostumeVisibility();
		this.updateScaling();
	}

	public function updateCostumeVisibility() {
		// G.her.torso.chestCostume.bottoms.penisCostumeContainer.visible = this.currentPenisID != 0;
		// G.her.torso.rightThighStocking.stocking.hipLayer.chestStocking.penisCostumeContainer.visible = this.currentPenisID != 0;
		// G.her.torso.rightThighStockingB.stocking.hipLayer.chestStocking.penisCostumeContainer.visible = this.currentPenisID != 0;
		// G.her.torso.chestUnderCostume.panties.penisCostumeContainer.visible = this.currentPenisID != 0;
	}

	public function update() {
		if (this.currentPenisID != 0) {
			if (this.wearingNone) {
				this.torsoAngle = G.her.rotation + G.her.torso.rotation;
				this.angSpeed -= (this.torsoAngle - this.lastTorsoAngle) * 0.1;
				this.angSpeed -= this.penisContainer.rotation * 0.1;
				this.angSpeed *= 0.8 + 0.1;
				this.penisContainer.rotation += this.angSpeed;
				if (this.penisContainer.rotation < HerPenisControl.MIN_PENIS_ANGLE) {
					this.penisContainer.rotation = HerPenisControl.MIN_PENIS_ANGLE;
					this.angSpeed *= -0.7;
				}
				this.lastTorsoAngle = this.torsoAngle;
			} else {
				this.penisContainer.rotation = HerPenisControl.MIN_PENIS_ANGLE - 1 * G.her.breathingAnimationAmount;
				// this.updatePenisCostumeRotation(G.her.torso.chestCostume.bottoms.penisCostumeContainer);
				// this.updatePenisCostumeRotation(G.her.torso.rightThighStocking.stocking.hipLayer.chestStocking.penisCostumeContainer);
				// this.updatePenisCostumeRotation(G.her.torso.rightThighStockingB.stocking.hipLayer.chestStocking.penisCostumeContainer);
				// this.updatePenisCostumeRotation(G.her.torso.chestUnderCostume.panties.penisCostumeContainer);
			}
		}
	}

	public function updatePenisCostumeRotation(param1:MovieClip) {
		var _loc2_:UInt = param1.numChildren;
		var _loc3_:UInt = 0;
		while (_loc3_ < _loc2_) {
			if (param1.getChildAt(_loc3_).name == "penisCostume") {
				param1.getChildAt(_loc3_).rotation = this.penisContainer.rotation - 27.6;
			}
			_loc3_++;
		}
	}

	@:flash.property public var penisLengthScale(get, never):Float;

	function get_penisLengthScale():Float {
		return this.currentPenisLengthScale;
	}

	@:flash.property public var penisWidthScale(get, never):Float;

	function get_penisWidthScale():Float {
		return this.currentPenisWidthScale;
	}

	@:flash.property public var penisLengthSlider(get, never):Float;

	function get_penisLengthSlider():Float {
		return (this.currentPenisLengthScale - HerPenisControl.MIN_PENIS_SIZE) / (HerPenisControl.MAX_PENIS_SIZE - HerPenisControl.MIN_PENIS_SIZE);
	}

	@:flash.property public var penisWidthSlider(get, never):Float;

	function get_penisWidthSlider():Float {
		return (this.currentPenisWidthScale - HerPenisControl.MIN_PENIS_SIZE) / (HerPenisControl.MAX_PENIS_SIZE - HerPenisControl.MIN_PENIS_SIZE);
	}

	@:flash.property public var hslShiftPenis(get, never):Bool;

	function get_hslShiftPenis():Bool {
		if (this.currentPenisID == (this.penisNameList.indexOf("Strapon") : UInt)) {
			return false;
		}
		return true;
	}

	public function setPenis(param1:UInt) {
		this.updatePenis();
		if (this.currentPenisID == (this.penisNameList.indexOf("Strapon") : UInt)) {
			// this.characterMenu.rgbPenis.visible = true;
			this.penisControl.resetFills();
		} else {
			// this.characterMenu.rgbPenis.visible = false;
		}
		G.characterControl.updateSkinHSL();
	}

	public function updatePenis() {
		if (this.currentPenisID == 0) {
			this.penis.visible = false;
			// if (this.penisMenu.visible) {
			// 	this.penisMenu.visible = false;
			// 	this.penisMenu.scaleY = 0;
			// 	G.inGameMenu.updateCostumeMenuContent();
			// }
			G.strandControl.checkElementAnchors(this.penisContainer);
		} else {
			// if (!this.penisMenu.visible) {
			// 	this.penisMenu.visible = true;
			// 	this.penisMenu.scaleY = 1;
			// 	G.inGameMenu.updateCostumeMenuContent();
			// }
			if (this.currentPenisID == (this.penisNameList.indexOf("Strapon") : UInt)) {
				this.penis.visible = true;
				this.penis.gotoAndStop(this.penisNameList[this.currentPenisID]);
			} else {
				this.penis.visible = true;
				this.penis.gotoAndStop("Female" + this.capitalise(G.characterControl.skinType) + this.penisNameList[this.currentPenisID]);
			}
			this.penis.wet.gotoAndStop(this.penisNameList[this.currentPenisID]);
			this.penis.lipstickElements.lipstickMask.gotoAndStop(this.penisNameList[this.currentPenisID]);
		}
		this.updateCostumeVisibility();
	}

	public function capitalise(param1:String):String {
		return param1.charAt(0).toUpperCase() + param1.substring(1);
	}

	public function loadPenisScales(param1:Float, param2:Float) {
		this.currentPenisLengthScale = Math.max(HerPenisControl.MIN_PENIS_SIZE, Math.min(HerPenisControl.MAX_PENIS_SIZE, param1));
		this.currentPenisWidthScale = Math.max(HerPenisControl.MIN_PENIS_SIZE, Math.min(HerPenisControl.MAX_PENIS_SIZE, param2));
		this.updatePenisWidthSlider();
		this.updatePenisLengthSlider();
		this.updateScaling();
	}

	public function setPenisLength(param1:Float) {
		var _loc2_ = this.currentPenisWidthScale / this.currentPenisLengthScale;
		this.currentPenisLengthScale = HerPenisControl.MIN_PENIS_SIZE + (HerPenisControl.MAX_PENIS_SIZE - HerPenisControl.MIN_PENIS_SIZE) * param1;
		this.currentPenisWidthScale = Math.max(HerPenisControl.MIN_PENIS_SIZE, Math.min(HerPenisControl.MAX_PENIS_SIZE, _loc2_ * this.currentPenisLengthScale));
		this.updateScaling();
	}

	public function setPenisWidth(param1:Float) {
		this.currentPenisWidthScale = HerPenisControl.MIN_PENIS_SIZE + (HerPenisControl.MAX_PENIS_SIZE - HerPenisControl.MIN_PENIS_SIZE) * param1;
		this.updateScaling();
	}

	public function updateScaling() {
		this.penisContainer.scaleX = this.currentPenisLengthScale;
		this.penisContainer.scaleY = this.currentPenisWidthScale;
		this.weightScaling = (this.currentPenisLengthScale - HerPenisControl.MIN_PENIS_SIZE) / HerPenisControl.SCALING_RANGE * ((this.currentPenisWidthScale - HerPenisControl.MIN_PENIS_SIZE) / HerPenisControl.SCALING_RANGE);
		this.updatePenisCostumeScaling(G.her.torso.chestCostume.bottoms.penisCostumeContainer);
		this.updatePenisCostumeScaling(G.her.torso.rightThighStocking.stocking.hipLayer.chestStocking.penisCostumeContainer);
		this.updatePenisCostumeScaling(G.her.torso.rightThighStockingB.stocking.hipLayer.chestStocking.penisCostumeContainer);
		this.updatePenisCostumeScaling(G.her.torso.chestUnderCostume.panties.penisCostumeContainer);
	}

	public function updatePenisCostumeScaling(param1:MovieClip) {
		var _loc2_:UInt = param1.numChildren;
		var _loc3_:UInt = 0;
		while (_loc3_ < _loc2_) {
			if (param1.getChildAt(_loc3_).name == "penisCostume") {
				param1.getChildAt(_loc3_).scaleX = this.currentPenisLengthScale;
				param1.getChildAt(_loc3_).scaleY = this.currentPenisWidthScale;
			}
			_loc3_++;
		}
	}

	public function penisLengthSliderReleased(param1:Event) {
		G.saveData.saveCharData();
	}

	public function penisLengthSliderChanged(param1:Event) {
		// this.setPenisLength(this.penisMenu.penisLengthSlider.currentValue(100) * 0.01);
		this.updatePenisWidthSlider();
	}

	public function updatePenisLengthSlider() {
		// this.penisMenu.penisLengthSlider.setPos(this.penisLengthSlider);
	}

	public function mbDefaultPenisLengthClicked(param1:MouseEvent) {
		this.loadPenisScales(DEFAULT_PENIS_SIZE, this.penisWidthScale);
		G.saveData.saveCharData();
	}

	public function penisWidthSliderReleased(param1:Event) {
		G.saveData.saveCharData();
	}

	public function penisWidthSliderChanged(param1:Event) {
		// this.setPenisWidth(this.penisMenu.penisWidthSlider.currentValue(100) * 0.01);
	}

	public function updatePenisWidthSlider() {
		// this.penisMenu.penisWidthSlider.setPos(this.penisWidthSlider);
	}

	public function mbDefaultPenisWidthClicked(param1:MouseEvent) {
		this.loadPenisScales(this.penisLengthScale, this.penisLengthScale);
		this.updatePenisWidthSlider();
		G.saveData.saveCharData();
	}

	@:flash.property public var currentPenisID(get, never):UInt;

	function get_currentPenisID():UInt {
		return this.penisControl.selection;
    }
}
