package obj.him.bodies;

import openfl.display.DisplayObjectContainer;
import openfl.display.MovieClip;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.geom.ColorTransform;
import openfl.geom.Point;
import obj.AlphaRGBObject;
import obj.animation.IKController;
import obj.CharacterElementHelper;
import obj.Him;
import obj.animation.BreastController;
import obj.graphics.PaletteUtils;

class HimFemaleBody extends HimMaleBody {
	public var breastSize:UInt = 130;
	public var breastOffset:Array<Float> = [2, 152, 302, 452, 602];
	public var currentBreastOffset:Float = Math.NaN;
	public var leftBreastController:Null<BreastController>;
	public var rightBreastController:Null<BreastController>;
	public var herSwatch:Array<AlphaRGBObject>;

	public function new(param1:Him) {
		super(param1);
		footwearNameList = ["None", "Highheel"];
		skinNameList = G.characterControl.skinNameList;
	}

	override public function loadDataPairs(param1:Array<Array<String>>) {
		for (_loc2_ in param1) {
			switch (_loc2_[0]) {
				case "hisSkin":
					this.setSkinx(Std.parseInt(_loc2_[1]));

				case "hisBreasts":
					this.setBreasts(Std.int(Math.max(1, Math.min(149, Std.parseInt(_loc2_[1])))));
					this.updateBreastSlider();

				case "hisFootwear":
					this.footwearControl.loadDataString(_loc2_[1]);
			}
		}
	}

	override public function getDataString():String {
		var _loc1_ = "hisSkin:" + currentSkinID;
		var _loc2_ = "hisBreasts:" + this.breastSize;
		var _loc3_ = "hisFootwear:" + this.footwearControl.getDataString();
		return _loc1_ + ";" + _loc2_ + ";" + _loc3_;
	}

	override public function move(param1:Float, param2:Float, param3:Float) {
		super.move(param1, param2, param3);
		this.leftBreastController.update(xMovement * 0.001);
		this.rightBreastController.update(xMovement * 0.001);
	}

	override public function initElements() {
		rightLegIK = new IKController(_him, _him.rightLeg, _him.rightLeg.calf, _him.rightLeg.calf.foot);
		rightLegIK.newTarget(G.animationControl.getHisRightFootTarget(), G.sceneLayer, true);
		rightLegIK.rescale(0.9);
		leftLegIK = new IKController(_him, _him.leftLeg, _him.leftLeg.calf, _him.leftLeg.calf.foot);
		leftLegIK.newTarget(G.animationControl.getHisLeftFootTarget(), G.sceneLayer, true);
		rightArmIK = new IKController(_him, _him.armContainer.arm, _him.armContainer.arm.upperArm, _him.armContainer.arm.upperArm.shoulderPoint);
		rightArmIK.newTarget(shoulderPoint, _him, true);
		leftArmIK = new IKController(_him, _him.leftArmContainer.arm, _him.leftArmContainer.arm.foreArm, _him.leftArmContainer.arm.foreArm.hand, true);
		leftArmIK.newTarget(leftArmTarget, _him, true);
		this.footwearControl = new CharacterElementHelper(this.footwearNameList, this.setFootwearx, this.setFootwearxFill);
		this.footwearControl.setStartRGB(new AlphaRGBObject(1, 0, 0, 0));
	}

	override public function initMenu() {
		// _bodyMenu = new HimFemaleBodyMenu();
		this.herSwatch = new Array<AlphaRGBObject>();
		this.herSwatch[0] = new AlphaRGBObject(1.0, 22, 8, 0);
		this.herSwatch[1] = new AlphaRGBObject(1.0, 82, 0, 6);
		this.herSwatch[2] = new AlphaRGBObject(1.0, 255, 126, 167);
		this.herSwatch[3] = new AlphaRGBObject(1.0, 0, 26, 114);
		this.herSwatch[4] = new AlphaRGBObject(1.0, 63, 118, 162);
		this.herSwatch[5] = new AlphaRGBObject(1.0, 238, 242, 245);
		this.herSwatch[6] = new AlphaRGBObject(1.0, 27, 29, 29);
		this.herSwatch[7] = new AlphaRGBObject(1.0, 0, 0, 0);
		this.herSwatch[8] = new AlphaRGBObject(1.0, 255, 255, 255);
		// _bodyMenu.breastSlider.setRangeEnd(100);
		// _bodyMenu.breastSlider.addEventListener("handleReleased", this.breastSliderReleased);
		// _bodyMenu.breastSlider.addEventListener("sliderChanged", this.breastSliderChanged);
		// _bodyMenu.mlSkin.leftArrow.addEventListener(MouseEvent.CLICK, this.hisSkinLeftClickedx);
		// _bodyMenu.mlSkin.rightArrow.addEventListener(MouseEvent.CLICK, this.hisSkinRightClickedx);
		this.updateSkinListx();
		// this.footwearControl.registerMenuList(_bodyMenu.mlFootwear);
		// this.footwearControl.registerRGBButton(_bodyMenu.rgbFootwear, this.herSwatch, 489, false);
	}

	override public function animationChanged() {
		var _loc1_:Point = G.animationControl.getHisRightFootTarget();
		var _loc2_:Point = G.animationControl.getHisLeftFootTarget();
		if (this.footwearControl.selectedName == "Highheel") {
			_loc1_.y -= 60;
			_loc1_.x -= 140;
			_loc2_.y -= 60;
			_loc2_.x += 100;
		}
		rightLegIK.newTarget(_loc1_, G.sceneLayer, true);
		leftLegIK.newTarget(_loc2_, G.sceneLayer, true);
		updateLegs();
	}

	override public function toggleBodySettings() {
		if (G.him.currentPenisID == 2) {
			if (currentSkinID == (skinNameList.length - 1:UInt)) {
				G.him.penisControl.select(0);
				this.setSkinx(0);
			} else {
				this.setSkinx(currentSkinID + 1);
			}
		} else if (currentSkinID == (skinNameList.length - 1:UInt)) {
			G.him.penisControl.select(G.him.currentPenisID + 1);
			this.setSkinx(0);
		} else {
			this.setSkinx(currentSkinID + 1);
		}
	}

	override public function shuffle() {
		var _loc1_:UInt = Math.floor(Math.random() * 3);
		G.him.penisControl.select(_loc1_);
		var _loc2_:AlphaRGBObject = PaletteUtils.getHue(Math.random() * 360,
                                                        PaletteUtils.midRandom(),
                                                        Math.random() > 0.6 ? PaletteUtils.midRandom() : Math.NaN);
		G.him.penisControl.setFill(_loc2_, "rgbFill");
		var _loc3_:UInt = Math.floor(Math.random() * skinNameList.length);
		this.setSkinx(_loc3_);
	}

	override public function setupElements() {
		if (this.leftBreastController == null) {
			this.leftBreastController = new BreastController(_him.torsoLayer.leftBreastContainer.leftBreast);
			this.rightBreastController = new BreastController(_him.torsoLayer.rightBreastContainer.rightBreast);
		}
		this.setSkinx(currentSkinID);
		this.setBreasts(this.breastSize);
		this.updateBreastSlider();
		_him.torsoLayer.leftBreastContainer.leftBreast.tan.visible = false;
		_him.torsoLayer.rightBreastContainer.rightBreast.tan.visible = false;
		_him.torsoLayer.leftBreastContainer.leftBreast.nipple.tan.visible = false;
		_him.torsoLayer.rightBreastContainer.rightBreast.nipple.tan.visible = false;
		CharacterControl.tryToSetFrameLabel(G.him.topBack, "None");
		CharacterControl.tryToSetFrameLabel(G.him.overLayer.torso.costume, "None");
		CharacterControl.tryToSetFrameLabel(G.him.rightLegCostume, "None");
		CharacterControl.tryToSetFrameLabel(G.him.rightLegCostume.calf, "None");
		CharacterControl.tryToSetFrameLabel(G.him.leftLegCostume, "None");
		CharacterControl.tryToSetFrameLabel(G.him.leftLegCostume.calf, "None");
		CharacterControl.tryToSetFrameLabel(G.him.midLayer.hips, "None");
	}

	override public function setupAnimation() {
		rightLegIK.newSegments(_him.rightLeg, _him.rightLeg.calf, _him.rightLeg.calf.foot);
		leftLegIK.newSegments(_him.leftLeg, _him.leftLeg.calf, _him.leftLeg.calf.foot);
		rightArmIK.newSegments(_him.armContainer.arm, _him.armContainer.arm.upperArm, _him.armContainer.arm.upperArm.shoulderPoint);
		leftArmIK.newSegments(_him.leftArmContainer.arm, _him.leftArmContainer.arm.foreArm, _him.leftArmContainer.arm.foreArm.hand);
		this.footwearControl.resetElement();
	}

	override public function setupMenu() {}

	override public function breakdownBody() {}

	public function hisSkinLeftClickedx(param1:MouseEvent) {
		var _loc2_:UInt = Std.int(Math.max(0, Math.min(skinNameList.length - 1, currentSkinID - 1)));
		this.setSkinx(_loc2_);
		G.saveData.saveCharData();
	}

	public function hisSkinRightClickedx(param1:MouseEvent) {
		var _loc2_:UInt = Std.int(Math.max(0, Math.min(skinNameList.length - 1, currentSkinID + 1)));
		this.setSkinx(_loc2_);
		G.saveData.saveCharData();
	}

	public function updateSkinListx() {
		// _bodyMenu.mlSkin.itemLabel.text = skinNameList[currentSkinID];
	}

	public function breastSliderReleased(param1:Event) {
		G.saveData.saveCharData();
	}

	public function breastSliderChanged(param1:Event) {
		// this.setBreasts(_bodyMenu.breastSlider.currentValue(149));
	}

	public function updateBreastSlider() {
		// _bodyMenu.breastSlider.setPos(this.breastSize / 149);
	}

	public function setFootwearx(param1:UInt) {
		CharacterControl.tryToSetFrameLabel(G.him.rightLegCostume.calf.foot, this.footwearControl.selectedName);
		CharacterControl.tryToSetFrameLabel(G.him.leftLegCostume.calf.foot, this.footwearControl.selectedName);
		this.animationChanged();
		this.setFeet();
	}

	public function setFootwearxFill(param1:ASObject, param2:String = "rgbFill") {
		var _loc3_ = new ColorTransform(1, 1, 1, param1.a, param1.r, param1.g, param1.b);
		CharacterControl.tryToSetFill(G.him.rightLegCostume.calf.foot, param2, _loc3_);
		CharacterControl.tryToSetFill(G.him.leftLegCostume.calf.foot, param2, _loc3_);
	}

	public function setBreasts(param1:Int = -1) {
		if (param1 == -1) {
			param1 = this.breastSize;
		}
		this.breastSize = param1;
		this.setBreastFrame(_him.torsoLayer.leftBreastContainer.leftBreast);
		this.setBreastFrame(_him.torsoLayer.rightBreastContainer.rightBreast);
		if (_him.torsoLayer.leftBreastContainer.leftBreast.nipple.leftNipple != null) {
			_him.torsoLayer.leftBreastContainer.leftBreast.nipple.gotoAndStop("None");
		} else {
			_him.torsoLayer.leftBreastContainer.leftBreast.nipple.gotoAndStop(skinNameList[currentSkinID].toLowerCase());
		}
		if (_him.torsoLayer.rightBreastContainer.rightBreast.nipple.rightNipple != null) {
			_him.torsoLayer.rightBreastContainer.rightBreast.nipple.gotoAndStop("None");
		} else {
			_him.torsoLayer.rightBreastContainer.rightBreast.nipple.gotoAndStop(skinNameList[currentSkinID].toLowerCase());
		}
		if (this.leftBreastController != null) {
			this.leftBreastController.updateFirmness(param1);
			this.rightBreastController.updateFirmness(param1);
		}
		_him.torsoLayer.leftBreastContainer.leftBreast.nipple.tan.visible = false;
		_him.torsoLayer.rightBreastContainer.rightBreast.nipple.tan.visible = false;
	}

	public function setBreastFrame(param1:MovieClip) {
		if (param1.getChildByName(param1.name) != null) {
			param1.gotoAndStop(this.breastOffset[4]);
			try {
				this.setChildrenFrame(cast(param1.getChildByName(param1.name), MovieClip), 2 + this.breastSize);
			} catch (e) {}
		} else {
			this.setChildrenFrame(param1, 2 + this.breastSize);
			param1.gotoAndStop(this.currentBreastOffset + this.breastSize);
		}
	}

	public function setChildrenFrame(param1:DisplayObjectContainer, param2:UInt) {
		var childContainer:MovieClip = null;
		var target = param1;
		var frameNumber = param2;
		var numChildren:UInt = target.numChildren;
		var i:UInt = 0;
		while (i < numChildren) {
			if (Std.isOfType(target.getChildAt(i), MovieClip)) {
				childContainer = Std.downcast(target.getChildAt(i), MovieClip);
				try {
					childContainer.gotoAndStop(frameNumber);
				} catch (e) {}
				this.setChildrenFrame(childContainer, frameNumber);
			}
			i++;
		}
	}

	public function setSkinx(param1:UInt) {
		currentSkinID = param1;
		this.currentBreastOffset = this.breastOffset[currentSkinID];
		G.himSkinType = "Female" + skinNameList[currentSkinID];
		this.setBreasts();
		G.him.updatePenis();
		G.him.balls.setSkin(G.himSkinType);
		G.him.updateArm();
		G.him.torsoLayer.torso.gotoAndStop(G.himSkinType);
		G.him.leftLeg.gotoAndStop(G.himSkinType);
		G.him.leftLeg.calf.gotoAndStop(G.himSkinType);
		G.him.rightLeg.gotoAndStop(G.himSkinType);
		G.him.rightLeg.calf.gotoAndStop(G.himSkinType);
		this.setFeet();
		this.updateSkinListx();
	}

	public function setFeet() {
		G.him.leftLeg.calf.foot.gotoAndStop(G.himSkinType + (this.footwearControl.selectedName == "Highheel" ? "Highheel" : ""));
		G.him.rightLeg.calf.foot.gotoAndStop(G.himSkinType + (this.footwearControl.selectedName == "Highheel" ? "Highheel" : ""));
	}
}
