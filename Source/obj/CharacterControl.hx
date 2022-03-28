package obj;

import sdtmods.ModTypes;
import chars.Character;
// import chars.Android18;
// import chars.Asuka;
// import chars.ChunLi;
// import chars.HatsuneMiku;
// import chars.Ino;
// import chars.JillValentine;
// import chars.Mari;
// import chars.Misato;
// import chars.Misty;
// import chars.Morrigan;
// import chars.Nami;
// import chars.Noel;
// import chars.Peach;
// import chars.Rei;
// import chars.Rikku;
// import chars.SDChan;
// import chars.SDChan2;
// import chars.Samus;
// import chars.Seras;
// import chars.TifaLockhart;
// import chars.ZeldaSS;
// import chars.ZeldaTP;
import openfl.display.DisplayObjectContainer;
import openfl.display.FrameLabel;
import openfl.display.MovieClip;
import openfl.events.Event;
import openfl.filters.ColorMatrixFilter;
import openfl.geom.ColorTransform;
import openfl.geom.Point;
import openfl.Assets;
import openfl.utils.AssetType;
import obj.dialogue.Dialogue;
import obj.her.SkinPalette;
import obj.Maths;

class CharacterControl {
	public static var noseTypeList:Array<String> = ["Normal", "Pointed", "Wedge"];
	public static var earTypeList:Array<String> = ["Normal", "Elf", "Small"];
	public static var eyebrowsTypeList:Array<String> = ["Normal", "Crescent", "Lines"];

	public var characters:Array<Character>;
	public var currentChar:UInt = 0;
	public var defaultCharOrder:Array<UInt> = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 15, 18, 19, 20, 21];
	public var currentName:String = "";
	public var currentHair:UInt = 0;
	public var currentIris:UInt = 0;
	public var currentSkin:UInt = 0;
	public var currentNose:UInt = 0;
	public var currentEar:UInt = 0;
	public var currentEyebrows:UInt = 0;
	public var irisRGB:AlphaRGBObject = new AlphaRGBObject(0, 0, 0, 0);
	public var lipstickRGB:AlphaRGBObject = new AlphaRGBObject(0, 0, 0, 0);
	public var eyebrowFillRGB:AlphaRGBObject = new AlphaRGBObject(0, 0, 0, 0);
	public var eyebrowLineRGB:AlphaRGBObject = new AlphaRGBObject(0, 0, 0, 0);
	public var eyeShadowRGB:AlphaRGBObject = new AlphaRGBObject(0, 0, 0, 0);
	public var scleraRGB:AlphaRGBObject = new AlphaRGBObject(0, 0, 0, 0);
	public var blushRGB:AlphaRGBObject = new AlphaRGBObject(0, 0, 0, 0);
	public var frecklesRGB:AlphaRGBObject = new AlphaRGBObject(0, 0, 0, 0);
	public var mascaraRGB:AlphaRGBObject = new AlphaRGBObject(0, 0, 0, 0);
	public var nailPolishRGB:AlphaRGBObject = new AlphaRGBObject(0, 0, 0, 0);
	public var breastSize:UInt = 0;

	public var collarControl:CharacterElementHelper;
	public var gagControl:CharacterElementHelper;
	public var cuffsControl:CharacterElementHelper;
	public var ankleCuffsControl:CharacterElementHelper;
	public var eyewearControl:CharacterElementHelper;
	public var pantiesControl:CharacterElementHelper;
	public var armwearControl:CharacterElementHelper;
	public var legwearControl:CharacterElementHelper;
	public var legwearBControl:CharacterElementHelper;
	public var bottomsControl:CharacterElementHelper;
	public var footwearControl:CharacterElementHelper;
	public var topControl:CharacterElementHelper;
	public var braControl:CharacterElementHelper;
	public var tonguePiercingControl:CharacterElementHelper;
	public var nipplePiercingControl:CharacterElementHelper;
	public var bellyPiercingControl:CharacterElementHelper;
	public var earringControl:CharacterElementHelper;
	public var headwearControl:CharacterElementHelper;

	public var blankHSL:ColorHsl = new ColorHsl(0, 1, 1, 1);
	public var hairHSL:ColorHsl;
	public var skinHSL:ColorHsl;
	public var hisSkinHSL:ColorHsl;
	public var skinNameList:Array<String> = [
		SkinPalette.LIGHT_SKIN,
		SkinPalette.PALE_SKIN,
		SkinPalette.TAN_SKIN,
		SkinPalette.DARK_SKIN
	];
	public var skinPalettes:ASDictionary<String, SkinPalette>;
	public var scalpFills:Array<AlphaRGBObject> = [
		new AlphaRGBObject(0, 227, 189, 168),
		new AlphaRGBObject(0, 222, 202, 191),
		new AlphaRGBObject(0, 241, 182, 138),
		new AlphaRGBObject(0, 118, 79, 52),
	];

	public var breastOffset:Array<UInt> = [2, 152, 302, 452, 602];
	public var currentBreastOffset:Float = Math.NaN;
	public var browOffsets:Array<UInt> = [0, 199, 399, 599];
	public var lipOffsets:Array<UInt> = [2, 82, 162, 242];

	public var currentSkinType:String;
	public var currentElements:Array<CostumeElement> = [];
	public var currentElementsStatus:Array<String> = [];

	public var customHairLoaded:Bool = false;
	public var customBGLoaded:Bool = false;
	public var componentsRegistered:Bool = false;

	public var braChangeListeners:Array<ASFunction> = [];
	public var breastSizeChangeListeners:Array<ASFunction> = [];
	public var waitingToSetHeadwearPosition:Bool = false;

	public var collarNameList:Array<String> = ["None", "Leather", "Tie", "Gem Choker"];
	public var gagNameList:Array<String> = ["None", "Ring", "Dental", "Tube"];
	public var cuffsNameList:Array<String> = ["None", "Leather", "Shirt"];
	public var ankleCuffsNameList:Array<String> = [
		"None",
		"Leather",
		"Panties",
		"Left Ribbon",
		"Right Ribbon",
		"Left Anklet",
		"Right Anklet"
	];
	public var pantiesNameList:Array<String> = ["None", "Briefs", "Bikini", "Thong", "Side Tie", "High Leg"];
	public var armwearNameList:Array<String> = ["None", "Wrist Glove", "Elbow Glove"];
	public var legwearNameList:Array<String> = [
		"None", "Short Sock", "Sock", "Kneehigh", "Overknee", "Thighhigh", "Pantyhose", "Striped Short Sock", "Striped Sock", "Striped Kneehigh",
		"Striped Overknee", "Striped Thighhigh", "Latex Thighhigh", "Garter Belt", "Left Garter", "Right Garter"
	];
	public var bottomsNameList:Array<String> = ["None", "Skirt", "Bike Shorts", "Boyshorts", "Jeans", "Jean Shorts", "Miniskirt"];
	public var footwearNameList:Array<String> = ["None", "Highheel", "School"];
	public var eyewearNameList:Array<String> = ["None", "Mari", "Pince Nez", "Blindfold", "Leather"];
	public var topNameList:Array<String> = ["None", "T-Shirt", "Tank", "Cropped", "Cropped Tank", "Shirt"];
	public var braNameList:Array<String> = ["None", "Bra", "Bikini"];
	public var tonguePiercingNameList:Array<String> = ["None", "Barbell", "Double", "Ring"];
	public var nipplePiercingNameList:Array<String> = ["None", "Barbell", "Ring", "Large Ring", "Weight"];
	public var bellyPiercingNameList:Array<String> = ["None", "Stud", "Ring", "Gem"];
	public var earringNameList:Array<String> = ["None", "Stud", "Ring", "Ball", "Teardrop", "Feather"];
	public var headwearNameList:Array<String> = [
		"None",
		"Cat Ears",
		"Bat Wings",
		"Band",
		"Ox Horns",
		"Peach\'s Crown",
		"Noel\'s Cap",
		"Zelda\'s Circlet"
	];
	public var irisTypeList:Array<String> = ["Normal", "Bright", "Solid", "Blank", "Wide", "Sharp", "Flat", "Cat", "Swirl"];

	public function new() {
		this.currentHair = this.currentChar;
		this.hairHSL = this.blankHSL;
		this.skinHSL = this.blankHSL;
		this.hisSkinHSL = this.blankHSL;
		this.currentBreastOffset = this.breastOffset[0];
		this.currentSkinType = G.dataName(this.skinNameList[0]);
		this.characters = new Array<Character>();

        var regex = new EReg(".*/chars/.*\\.yml$", "g");
        for (path in Assets.list(AssetType.TEXT)) {
            if (regex.match(path)) {
                this.characters.push(Character.loadFromYaml(path));
            }
        }

        this.characters.sort(function(a, b) { return Std.int(b.ordering - a.ordering); });
		G.baseCharNum = this.characters.length;
		this.skinPalettes = new ASDictionary<String, SkinPalette>();
		this.skinPalettes[SkinPalette.LIGHT_SKIN] = new SkinPalette(16178890, 14925224, 13541515, 11306097, 13014407, 10974573);
		this.skinPalettes[SkinPalette.PALE_SKIN] = new SkinPalette(16050399, 14600895, 13151647, 10126976, 11509658, 9994117, 0.6);
		this.skinPalettes[SkinPalette.TAN_SKIN] = new SkinPalette(15916214, 15840906, 14000248, 11962728, 15383719, 14781802);
		this.skinPalettes[SkinPalette.DARK_SKIN] = new SkinPalette(10053953, 7753524, 5519398, 4467227, 5451558, 4465690, 0.6);
		this.collarControl = new CharacterElementHelper(this.collarNameList, this.setCollar, this.setCollarFill, this.findCollar);
		this.collarControl.setDefaultRGB("Gem Choker", null, new AlphaRGBObject(1, 255, 255, 255));
		this.collarControl.setDefaultRGB("Tie", null, new AlphaRGBObject(1, 232, 240, 255));
		this.gagControl = new CharacterElementHelper(this.gagNameList, this.setGag, this.setGagFill);
		this.cuffsControl = new CharacterElementHelper(this.cuffsNameList, this.setCuffs, this.setCuffsFill);
		this.cuffsControl.setDefaultRGB("Shirt", null, new AlphaRGBObject(1, 171, 177, 185));
		this.ankleCuffsControl = new CharacterElementHelper(this.ankleCuffsNameList);
		this.eyewearControl = new CharacterElementHelper(this.eyewearNameList, this.setEyewear, this.setEyewearFill);
		this.pantiesControl = new CharacterElementHelper(this.pantiesNameList, this.setPanties, this.setPantiesFill);
		this.armwearControl = new CharacterElementHelper(this.armwearNameList, this.setArmwear, this.setArmwearFill);
		this.legwearControl = new CharacterElementHelper(this.legwearNameList, this.setLegwearA, this.setLegwearFillA);
		this.legwearBControl = new CharacterElementHelper(this.legwearNameList, this.setLegwearB, this.setLegwearFillB);
		this.bottomsControl = new CharacterElementHelper(this.bottomsNameList, this.setBottoms, this.setBottomsFill);
		this.topControl = new CharacterElementHelper(this.topNameList, this.setTop, this.setTopFill);
		this.footwearControl = new CharacterElementHelper(this.footwearNameList, this.setFootwear, this.setFootwearFill);
		this.footwearControl.setDefaultRGB("School", null, new AlphaRGBObject(1, 254, 248, 238));
		this.footwearControl.setDefaultRGB("Highheel", null, new AlphaRGBObject(1, 0, 0, 0));
		this.braControl = new CharacterElementHelper(this.braNameList, this.setBra, this.setBraFill);
		this.tonguePiercingControl = new CharacterElementHelper(this.tonguePiercingNameList);
		this.tonguePiercingControl.setStartRGB(new AlphaRGBObject(1, 183, 187, 195));
		this.nipplePiercingControl = new CharacterElementHelper(this.nipplePiercingNameList);
		this.nipplePiercingControl.setStartRGB(new AlphaRGBObject(1, 183, 187, 195));
		this.bellyPiercingControl = new CharacterElementHelper(this.bellyPiercingNameList);
		this.bellyPiercingControl.setStartRGB(new AlphaRGBObject(1, 183, 187, 195));
		this.earringControl = new CharacterElementHelper(this.earringNameList);
		this.headwearControl = new CharacterElementHelper(this.headwearNameList);
		this.headwearControl.setDefaultRGB("Cat Ears", null, new AlphaRGBObject(1, 255, 255, 255));
		this.headwearControl.setDefaultRGB("Bat Wings", new AlphaRGBObject(1, 24, 24, 24), new AlphaRGBObject(1, 139, 42, 95));
		this.headwearControl.setDefaultRGB("Zelda\'s Circlet", new AlphaRGBObject(1, 179, 124, 55), new AlphaRGBObject(1, 62, 142, 193));
		this.headwearControl.setDefaultRGB("Noel\'s Cap", new AlphaRGBObject(1, 47, 56, 221), new AlphaRGBObject(1, 49, 100, 106));
		this.headwearControl.setDefaultRGB("Peach\'s Crown", new AlphaRGBObject(1, 255, 208, 25));
		this.headwearControl.setDefaultRGB("Ox Horns", new AlphaRGBObject(1, 239, 255, 248), new AlphaRGBObject(1, 254, 210, 26));
		this.headwearControl.registerListener(this.waitToSetHeadwearPosition);
	}

	public static function findName(param1:String, param2:Array<String>, param3:ASFunction) {
		var _loc4_:UInt = param2.length;
		var _loc5_:UInt = 0;
		while (_loc5_ < _loc4_) {
			if (G.dataName(param2[_loc5_]) == G.dataName(param1)) {
				param3(_loc5_);
				break;
			}
			_loc5_++;
		}
	}

	public static function tryToSetFrame(param1:MovieClip, param2:Float) {
		if (param1 != null) {
			param1.gotoAndStop(param2);
		}
	}

	public static function tryToSetFrameLabel(param1:MovieClip, labelName:String) {
		if (param1 != null) {
			var labels = param1.currentLabels;
			for (label in labels) {
				if (label.name == labelName) {
					param1.gotoAndStop(labelName);
					return;
				}
			}
			param1.gotoAndStop("None");
		}
	}

	public static function tryToSetFill(param1:MovieClip, param2:String, param3:ColorTransform) {
		if (param1 != null) {
			tryToSetFillChildren(param1, param2, param3);
		}
	}

	public static function tryToSetFillChildren(param1:MovieClip, param2:String, param3:ColorTransform) {
		var _loc4_:Float = param1.numChildren;
		var _loc5_:UInt = 0;
		while (_loc5_ < _loc4_) {
			if (param1.getChildAt(_loc5_).name == param2) {
				param1.getChildAt(_loc5_).transform.colorTransform = param3;
			} else if (Std.isOfType(param1.getChildAt(_loc5_), DisplayObjectContainer)) {
				tryToSetFillChildren(Std.downcast(param1.getChildAt(_loc5_), MovieClip), param2, param3);
			}
			_loc5_++;
		}
	}

	public function registerComponents() {
		if (!this.componentsRegistered) {
			this.collarControl.registerComponents([G.her.collarContainer.collar]);
			this.gagControl.registerComponents([G.her.gagFront, G.her.gagBack]);
			this.cuffsControl.registerComponents([
				G.her.torso.cuffs,
				G.her.rightForeArmContainer.upperArmCostume.foreArmCostume.cuff,
				G.her.leftArmContainer.upperArmCostume.foreArmCostume.cuff
			]);
			this.ankleCuffsControl.registerComponents([G.her.torso.rightCalfContainer.cuffs, G.her.leftLegContainer.leg.cuffs]);
			this.eyewearControl.registerComponents([G.her.eyewear]);
			this.pantiesControl.registerComponents([
				G.her.torso.rightThighCostume.panties,
				G.her.leftLegContainer.leg.leftThighCostume.panties,
				G.her.torso.backUnderCostume.panties,
				G.her.torso.chestUnderCostume.panties,
				G.her.torsoBackCostume.backsideCostume.panties
			]);
			this.armwearControl.registerComponents([
				G.her.torso.leftGlove,
				G.her.torso.rightGlove,
				G.her.rightForeArmContainer.upperArmCostume.foreArmCostume.glove,
				G.her.leftArmContainer.upperArmCostume.foreArmCostume.glove,
				G.her.rightForeArmContainer.upperArmCostume.foreArmCostume.handCostume.glove,
				G.her.leftArmContainer.upperArmCostume.foreArmCostume.handCostume.glove,
				G.her.rightArmContainer.upperArmCostume.glove,
				G.her.leftArmContainer.upperArmCostume.glove,
				G.her.leftHandOver.hand.glove
			]);
			this.legwearControl.registerComponents([
				G.her.torso.rightThighStocking,
				G.her.torso.rightCalfContainer.calfStocking,
				G.her.leftLegContainer.leg.stocking,
				G.her.leftLegContainer.leg.calfStocking,
				G.her.torsoBackCostume.backsideCostume.stocking
			]);
			this.legwearBControl.registerComponents([
				G.her.torso.rightThighStockingB,
				G.her.torso.rightCalfContainer.calfStockingB,
				G.her.leftLegContainer.leg.stockingB,
				G.her.leftLegContainer.leg.calfStockingB,
				G.her.torsoBackCostume.backsideCostume.stockingB
			]);
			this.bottomsControl.registerComponents([
				G.her.torso.rightThighBottoms,
				G.her.torso.rightThighBottomsOver,
				G.her.torso.rightCalfContainer.bottoms,
				G.her.torso.chestCostume.bottoms,
				G.her.torso.backCostume.bottoms,
				G.her.leftLegContainer.leg.leftThighBottoms,
				G.her.leftLegContainer.leg.leftCalfBottoms,
				G.her.torsoBackCostume.backsideCostume.bottoms
			], ModTypes.BOTTOMS);
			this.footwearControl.registerComponents([G.her.torso.rightCalfContainer.footwear, G.her.leftLegContainer.leg.footwear], ModTypes.FOOTWEAR);
			this.topControl.registerComponents([
				G.her.torso.topContainer.breastTop,
				G.her.torso.topContainer.chestTop,
				G.her.torso.topContainer.backTop,
				G.her.torso.topContainer.topStrap,
				G.her.torsoBackCostume.breastCostume.top,
				G.her.torsoUnderCostume.top,
				G.her.rightArmContainer.upperArmCostume.top,
				G.her.leftArmContainer.upperArmCostume.top
			], ModTypes.TOP);
			this.braControl.registerComponents([
				G.her.torso.breastCostume.bra,
				G.her.torso.braStrap,
				G.her.torso.shoulderStrap,
				G.her.torso.upperChestCostume.bra,
				G.her.torsoBackCostume.breastCostume.bra
			]);
			this.headwearControl.registerComponents([G.hairCostumeOver.headwear, G.hairCostumeBack.headwear], ModTypes.HEADWEAR);
			this.tonguePiercingControl.registerComponents([
				G.her.tongueContainer.tongue.piercing,
				G.her.tongueContainer.tongue.piercingBack,
				G.her.topLipTongue.piercing,
				G.her.topLipTongue.piercingBack
			], ModTypes.TONGUE_PIERCING);
			this.nipplePiercingControl.registerComponents([G.her.torso.nipplePiercing, G.her.torso.leftNipplePiercing], ModTypes.NIPPLE_PIERCING);
			this.bellyPiercingControl.registerComponents([G.her.torso.chestCostume.bellyPiercing], ModTypes.BELLY_PIERCING);
			this.earringControl.registerComponents([G.her.earrings], ModTypes.EAR_PIERCING);
			this.componentsRegistered = true;
		}
	}

	public function tick() {
		if (this.waitingToSetHeadwearPosition) {
			G.characterControl.tryToLandHeadwear();
			this.waitingToSetHeadwearPosition = false;
		}
	}

	public function addBraChangeListener(param1:ASFunction) {
		this.braChangeListeners.push(param1);
	}

	public function addBreastSizeChangeListener(param1:ASFunction) {
		this.breastSizeChangeListeners.push(param1);
	}

	public function getCurrentSkinType():String {
		return this.currentSkinType;
	}

	public function setChar(param1:UInt, param2:Bool = true) {
		this.currentChar = param1;
		this.initChar(param2);
	}

	public function initChar(param1:Bool = true) {
		var _loc3_:UInt = 0;
		var _loc4_:UInt = 0;
		var chara:Character = this.characters[this.currentChar];
		// G.customElementLoader.clearInstancedMods();
		if (!G.inGameMenu.onlyLoadingCostume) {
			this.breastSize = chara.breastSize;
			this.currentName = chara.charShortName;
			if (chara.dialogue != null) {
				G.dialogueControl.loadCustomDialogue(Dialogue.DIALOGUE_NAME_KEY + ":\"" + chara.charShortName + "\"\n" + chara.dialogue, param1);
			} else {
				G.dialogueControl.resetCustomDialogue(param1);
			}
			G.her.setBodyScale(chara.bodyScale);
			G.her.setMood(chara.mood);
			G.inGameMenu.updateBodySlider();
			G.inGameMenu.updateArmsList();
			this.setSkin(chara.skinType);
			this.setNose(chara.noseType);
			this.setEyebrows(chara.eyebrowType);
			this.findEar(chara.earType);
			this.findIris(chara.iris);
			this.setIrisFill(chara.irisFill);
			this.setHair(this.currentChar);
		}
		this.setLipstick(chara.lipstickFill);
		this.setEyeShadow(chara.eyeShadow);
		this.setSclera(chara.sclera);
		this.setBlush(chara.blush);
		this.setFreckles(chara.freckles);
		this.setFreckleAmount(chara.freckleAmount);
		this.setMascara(chara.mascara);
		this.gagControl.findName(chara.gag);
		this.collarControl.select(chara.collar);
		this.collarControl.setFill(chara.collarFill, "rgbFill");
		if (chara.collarFill2 != null) {
			this.collarControl.setFill(chara.collarFill2, "rgbFill2");
		}
		this.cuffsControl.select(chara.cuffs);
		this.cuffsControl.setFill(chara.cuffsFill, "rgbFill");
		this.ankleCuffsControl.findName("None");
		this.armwearControl.findName(chara.armwear);
		this.armwearControl.setFill(chara.armwearFill, "rgbFill");
		this.bottomsControl.findName("None");
		this.legwearControl.findName(chara.legwear);
		this.legwearControl.setFill(chara.legwearFill, "rgbFill");
		this.legwearBControl.findName("None");
		this.eyewearControl.findName(chara.eyewear);
		this.eyewearControl.setFill(chara.eyewearFill, "rgbFill");
		this.footwearControl.findName(chara.footwear);
		this.footwearControl.setFill(chara.footwearFill, "rgbFill");
		this.pantiesControl.findName(chara.panties);
		this.pantiesControl.setFill(chara.pantiesFill, "rgbFill");
		this.braControl.findName(chara.bra);
		this.braControl.setFill(chara.braFill, "rgbFill");
		this.topControl.findName("None");
		this.headwearControl.findName(chara.headwear);
		this.headwearControl.setFill(chara.headwearFill, "rgbFill");
		this.headwearControl.setFill(chara.headwearFill2, "rgbFill2");
		this.earringControl.findName(chara.earring);
		this.earringControl.setFill(chara.earringFill, "rgbFill");
		this.setNailPolish(new AlphaRGBObject(0, 0, 0, 0));
		this.tonguePiercingControl.findName("None");
		this.nipplePiercingControl.findName("None");
		this.bellyPiercingControl.findName("None");
		G.her.tan.setTan(0);
		G.mascaraAmount = 20;
		G.inGameMenu.updateMascaraSlider();
		G.inGameMenu.updateFrecklesSlider();
		if (!G.inGameMenu.onlyLoadingCostume) {
			G.her.setThroatResistance(G.defaultThroatResistance);
			G.inGameMenu.updateThroatResistanceSlider();
			this.removeHairHSL();
			this.removeSkinHSL();
			this.removeHisSkinHSL();
			this.setBackground(chara.bg);
			_loc3_ = this.irisTypeList.length;
			_loc4_ = 0;
			while (_loc4_ < _loc3_) {
				if (G.dataName(this.irisTypeList[_loc4_]) == G.dataName(chara.iris)) {
					this.currentIris = _loc4_;
					break;
				}
				_loc4_++;
			}
			// if (this.customBGLoaded) {
			// 	G.customElementLoader.clearCustomBackground();
			// 	this.customBGLoaded = false;
			// }
			if (G.resetIntroOnNewChar) {
				G.resetIntro();
			}
			G.inGameMenu.updateCharMenu(this.currentChar);
			G.inGameMenu.updateMoods();
			G.inGameMenu.setBGCheckboxes();
			G.inGameMenu.updateHairList();
			G.inGameMenu.updateIrisList();
			G.inGameMenu.updateNoseList();
			G.inGameMenu.updateEyebrowsList();
			G.inGameMenu.updateEarList();
			G.inGameMenu.updateBreastSlider();
			G.inGameMenu.updateSkinList();
		}
		G.inGameMenu.closeRGBPicker();
		G.inGameMenu.closeHSLPicker();
		if (param1) {
			G.saveData.saveCharData(true, this.currentChar);
		}
	}

	public function loadStoredChar(param1:UInt) {
		// this.currentChar = param1 + G.baseCharNum;
		// G.inGameMenu.loadData(G.storedChars[param1].charData, true, true, G.storedChars[param1]);
		// this.currentName = G.storedChars[param1].charName;
		// G.dialogueControl.loadCustomDialogue(G.storedChars[param1].dialogue);
		// G.inGameMenu.updateCharMenu(param1, false, true);
	}

	public function setBackground(param1:UInt) {
		// G.customElementLoader.clearModTypes([ModTypes.BACKGROUND]);
		G.bg.gotoAndStop(param1);
		G.bgID = param1;
	}

	public function initHim() {
		G.him.initBodies();
		G.him.setBody(G.him.currentBodyID);
		G.him.penisControl.select(G.him.currentPenisID);
	}

	public function clearElements() {
		for (elem in this.currentElements) {
			elem.removeEventListener("toggled", this.currentElementToggled);
			elem.kill();
		}
		this.currentElements = [];
		G.strandControl.checkCostumeAnchors();
		G.costumeHitElements = new Array<CostumeElement>();
	}

	public function tryToSetChar(param1:Int, param2:Bool = true):Bool {
		if (param1 >= 0 && param1 < this.characters.length) {
			this.setChar(param1, param2);
			return true;
		}
		return false;
	}

	public function resetSkin() {
		this.setSkin(this.currentSkin, false);
	}

	public function prepForBodyMod() {
		this.setBreasts();
		this.setArmSkin();
		G.her.torso.leg.highlights.visible = false;
		G.her.torso.backHighlight.visible = false;
		G.her.torso.backside.visible = false;
		G.her.rightArmContainer.upperArmMask.visible = false;
		if (G.her.rightForeArmContainer.upperArm.foreArm.hand.grip != null) {
			G.her.rightForeArmContainer.upperArm.foreArm.hand.grip.visible = false;
		}
		G.her.tan.hideForMods();
	}

	public function setSkin(param1:UInt, param2:Bool = true) {
		if (param2) {
			// G.customElementLoader.clearModTypes([ModTypes.BODY]);
		}
		this.currentSkinType = G.dataName(this.skinNameList[param1]);
		this.currentSkin = param1;
		this.currentBreastOffset = this.breastOffset[this.currentSkin];
		G.her.ear.gotoAndStop(this.currentSkinType + earTypeList[this.currentEar]);
		G.her.head.face.skull.gotoAndStop(this.currentSkinType);
		G.her.head.face.nose.gotoAndStop(this.currentSkinType + noseTypeList[this.currentNose]);
		G.her.head.cheekSuck.gotoAndStop(this.currentSkinType);
		G.her.head.cheekBulge.gotoAndStop(this.currentSkinType);
		G.her.head.neck.setSkin(this.skinPalettes[this.skinNameList[this.currentSkin]]);
		G.her.updateNeck();
		var scalpColor = new ColorTransform(1, 1, 1, 1, this.scalpFills[param1].r, this.scalpFills[param1].g, this.scalpFills[param1].b);
		G.her.head.scalpHair.transform.colorTransform = scalpColor;
		this.setArmSkin(param2);
		G.her.torso.midLayer.leftArm.gotoAndStop(this.currentSkinType);
		G.her.torso.behindBackRightArm.gotoAndStop(this.currentSkinType);
		G.her.leftHandOver.hand.grip.gotoAndStop(this.currentSkinType + "Grip");
		G.her.torso.back.gotoAndStop(this.currentSkinType);
		G.her.torsoBack.chestBack.gotoAndStop(this.currentSkinType);
		G.her.torsoBack.leftShoulder.gotoAndStop(this.currentSkinType);
		G.her.torso.leg.thigh.gotoAndStop(this.currentSkinType);
		G.her.torso.rightCalfContainer.calf.gotoAndStop(this.currentSkinType);
		G.her.leftLegContainer.leg.thigh.gotoAndStop(this.currentSkinType);
		G.her.leftLegContainer.leg.calf.gotoAndStop(this.currentSkinType);
		G.her.torsoBack.backside.gotoAndStop(this.currentSkinType);
		G.her.torso.backside.gotoAndStop(this.currentSkinType);
		G.her.torso.leg.highlights.visible = true;
		G.her.torso.backHighlight.visible = true;
		G.her.torso.backside.visible = true;
		G.her.rightArmContainer.upperArmMask.visible = true;
		this.setBreasts(this.breastSize);
		G.her.setLipSkinOffset(this.lipOffsets[param1]);
		this.setLipFills();
		G.her.eye.eyebrowUnderMask.gotoAndStop(this.currentSkinType);
		G.her.updateEyes();
		G.her.updateLips();
		G.her.updateJawBulge();
		G.her.tan.updateSkin(this.skinNameList[param1]);
		G.her.penisControl.updatePenis();
		G.strandControl.checkElementAnchors(G.her.torso.midLayer.rightBreast);
	}

	public function setLipFills() {
		var _loc1_:SkinPalette = this.skinPalettes[this.skinNameList[this.currentSkin]];
		var _loc2_ = new ColorTransform(1, 1, 1, 1, _loc1_.shade1.r, _loc1_.shade1.g, _loc1_.shade1.b);
		G.her.head.face.lipFill.transform.colorTransform = _loc2_;
		G.her.head.face.lipShading.alpha = _loc1_.lipAlpha;
	}

	public function setArmSkin(force:Bool = false) {
		this.setArmFrame(G.her.rightArmContainer.upperArm, G.her.isRightArmFree(), force);
		this.setArmFrame(G.her.rightForeArmContainer.upperArm.foreArm, G.her.isRightArmFree(), force);
		this.setArmFrame(G.her.rightForeArmContainer.upperArm.foreArm.hand, G.her.isRightArmFree(), force, G.rightHandJobMode);
		if (G.her.rightForeArmContainer.upperArm.foreArm.hand.grip != null) {
			G.her.rightForeArmContainer.upperArm.foreArm.hand.grip.visible = true;
			G.her.rightForeArmContainer.upperArm.foreArm.hand.grip.gotoAndStop(this.currentSkinType);
		}
		this.setArmFrame(G.her.leftArmContainer.upperArm, G.her.isLeftArmFree(), force);
		this.setArmFrame(G.her.leftArmContainer.upperArm.foreArm, G.her.isLeftArmFree(), force);
		this.setArmFrame(G.her.leftArmContainer.upperArm.foreArm.hand, G.her.isLeftArmFree(), force, G.leftHandJobMode);
		this.armwearControl.resetElement();
	}

	public function setArmFrame(param1:MovieClip, isArmFree:Bool, force:Bool = false, isArmHandJob:Bool = false) {
		var label = if (param1.currentFrameLabel != null) param1.currentFrameLabel else this.currentSkinType;
		if (label != "None" || force) {
			label = this.currentSkinType;
		}
		if (isArmHandJob) {
			label += "Grip";
		} else {
			label += isArmFree ? "Free" : "";
		}
		param1.gotoAndStop(label);
	}

	public function findHair(param1:String, param2:Bool = true):Bool {
		var _loc3_:UInt = 0;
		var _loc4_:UInt = 0;
		if (param2 || !this.customHairLoaded) {
			_loc3_ = this.characters.length;
			_loc4_ = 0;
			while (_loc4_ < _loc3_) {
				if (G.dataName(param1) == G.dataName(this.characters[_loc4_].charShortName)) {
					this.setHair(_loc4_);
					return true;
				}
				_loc4_++;
			}
			return false;
		}
		return false;
	}

	public function setHair(param1:UInt, param2:Bool = true) {
		// if (this.customHairLoaded) {
		// 	G.customElementLoader.clearCustomHair(false);
		// 	this.customHairLoaded = false;
		// }
		// G.customElementLoader.clearModTypes([ModTypes.HAIR, ModTypes.DYNAMIC_HAIR, ModTypes.HAIR_COSTUME]);
		this.clearElements();
		var chara:Character = this.characters[param1];
		G.her.hairTop.gotoAndStop(chara.hairTop);
		G.her.hairMidContainer.hairUnder.gotoAndStop(chara.hairUnder);
		G.her.hairMidContainer.hairBottom.gotoAndStop(chara.hairBottom);
		G.her.hairBackContainer.hairBack.gotoAndStop(chara.hairBack);
		if (param2) {
			this.setEyebrowFill(chara.eyebrowFill);
			this.setEyebrowLine(chara.eyebrowLine);
		}
		this.currentElements = chara.generateElements();
		for (elem in this.currentElements) {
			elem.addEventListener("toggled", this.currentElementToggled, false, 0, true);
		}
		this.updateCurrentElementsStatus();
		this.waitToSetHeadwearPosition();
		this.currentHair = param1;
	}

	public function currentElementToggled(param1:Event) {
		this.updateCurrentElementsStatus();
		G.saveData.saveCharData();
	}

	public function updateCurrentElementsStatus() {
		this.currentElementsStatus = new Array<String>();
		var _loc1_:UInt = this.currentElements.length;
		var _loc2_:UInt = 0;
		while (_loc2_ < _loc1_) {
			this.currentElementsStatus[_loc2_] = this.currentElements[_loc2_].showingString();
			_loc2_++;
		}
	}

	public function setCurrentElements(param1:Array<String>) {
		var _loc2_:UInt = 0;
		var _loc3_:UInt = 0;
		if (!this.customHairLoaded) {
			_loc2_ = param1.length;
			if (_loc2_ == (this.currentElements.length : UInt)) {
				_loc3_ = 0;
				while (_loc3_ < _loc2_) {
					if (param1[_loc3_] == "0") {
						this.currentElements[_loc3_].tryToHide();
					}
					_loc3_++;
				}
			}
		}
		this.updateCurrentElementsStatus();
	}

	public function randomCurrentElements() {
		var _loc1_:UInt = this.currentElements.length;
		var _loc2_:UInt = 0;
		while (_loc2_ < _loc1_) {
			if (Math.random() < 0.5) {
				this.currentElements[_loc2_].tryToHide();
			}
			_loc2_++;
		}
		this.updateCurrentElementsStatus();
	}

	public function setEyebrowFill(param1:AlphaRGBObject, param2:String = "rgbFill") {
		var color = new ColorTransform(1, 1, 1, param1.a, param1.r, param1.g, param1.b);
		G.her.rightEyebrow.rightEyebrowFill.transform.colorTransform = color;
		G.her.leftEyebrow.leftEyebrowFill.transform.colorTransform = color;
		this.eyebrowFillRGB = param1;
	}

	public function setEyebrowLine(param1:AlphaRGBObject, param2:String = "rgbFill") {
		var color = new ColorTransform(1, 1, 1, param1.a, param1.r, param1.g, param1.b);
		G.her.rightEyebrow.rightEyebrowLine.transform.colorTransform = color;
		G.her.leftEyebrow.leftEyebrowLine.transform.colorTransform = color;
		this.eyebrowLineRGB = param1;
	}

	public function findNose(param1:String) {
		findName(param1, noseTypeList, this.setNose);
	}

	public function setNose(param1:UInt) {
		G.her.head.face.nose.gotoAndStop(this.currentSkinType + noseTypeList[param1]);
		G.her.head.headTan.face.nose.gotoAndStop(this.currentSkinType + noseTypeList[param1]);
		this.currentNose = param1;
	}

	public function findEyebrows(param1:String) {
		findName(param1, eyebrowsTypeList, this.setEyebrows);
	}

	public function setEyebrows(param1:UInt) {
		G.her.rightEyebrow.gotoAndStop(eyebrowsTypeList[param1]);
		G.her.leftEyebrow.gotoAndStop(eyebrowsTypeList[param1]);
		this.setEyebrowFill(this.eyebrowFillRGB);
		this.setEyebrowLine(this.eyebrowLineRGB);
		G.her.updateEyes();
		this.currentEyebrows = param1;
	}

	public function findEar(param1:String) {
		findName(param1, earTypeList, this.setEar);
	}

	public function setEar(param1:UInt) {
		G.her.ear.gotoAndStop(this.currentSkinType + earTypeList[param1]);
		G.her.ear.tan.gotoAndStop(earTypeList[param1]);
		this.currentEar = param1;
	}

	public function findIris(param1:String):Bool {
		var _loc2_:UInt = this.irisTypeList.length;
		var _loc3_:UInt = 0;
		while (_loc3_ < _loc2_) {
			if (G.dataName(param1) == G.dataName(this.irisTypeList[_loc3_])) {
				this.setIris(_loc3_);
				return true;
			}
			_loc3_++;
		}
		return false;
	}

	public function setIris(param1:UInt) {
		if (G.dataName(this.irisTypeList[param1]) == "blank") {
			G.her.blankEyed = true;
		} else {
			G.her.blankEyed = false;
		}
		G.her.eye.ball.irisContainer.iris.gotoAndStop(G.dataName(this.irisTypeList[param1]));
		G.her.eye.ball.irisContainer.iris.irisFill.gotoAndStop(G.dataName(this.irisTypeList[param1]));
		this.currentIris = param1;
		if (param1 == 3) {
			G.her.eye.ball.highlights.visible = false;
		} else {
			G.her.eye.ball.highlights.visible = true;
		}
	}

	public function setEyeShadow(param1:AlphaRGBObject, param2:String = "rgbFill") {
		var color = new ColorTransform(1, 1, 1, param1.a, param1.r, param1.g, param1.b);
		G.her.eye.upperEyelid.eyeshadow.transform.colorTransform = color;
		this.eyeShadowRGB = param1;
	}

	public function setSclera(param1:AlphaRGBObject, param2:String = "rgbFill") {
		var color = new ColorTransform(1, 1, 1, param1.a, param1.r, param1.g, param1.b);
		G.her.eye.ball.sclera.overlay.transform.colorTransform = color;
		this.scleraRGB = param1;
	}

	public function setBlush(param1:AlphaRGBObject, param2:String = "rgbFill") {
		var color = new ColorTransform(1, 1, 1, param1.a, param1.r, param1.g, param1.b);
		G.her.blush.transform.colorTransform = color;
		this.blushRGB = param1;
	}

	public function setFreckles(param1:AlphaRGBObject, param2:String = "rgbFill") {
		var color = new ColorTransform(1, 1, 1, param1.a, param1.r, param1.g, param1.b);
		G.her.freckles.transform.colorTransform = color;
		this.frecklesRGB = param1;
	}

	public function setFreckleAmount(param1:Float) {
		param1 = Math.fround(Maths.clampf(param1, 0, 100));
		if (param1 != G.frecklesAmount) {
			G.frecklesAmount = param1;
			G.her.setFreckleAmount(G.frecklesAmount);
		}
	}

	public function setMascara(param1:AlphaRGBObject, param2:String = "rgbFill") {
		var _loc3_ = new ColorTransform(1, 1, 1, param1.a, param1.r, param1.g, param1.b);
		G.her.eye.upperEyelid.mascara.transform.colorTransform = _loc3_;
		G.her.eye.lowerEyelid.mascara.transform.colorTransform = _loc3_;
		G.her.tears.setMascaraRGB(param1);
		this.mascaraRGB = param1;
	}

	public function findSkin(param1:String):Bool {
		var _loc2_:UInt = this.skinNameList.length;
		var _loc3_:UInt = 0;
		while (_loc3_ < _loc2_) {
			if (G.dataName(param1) == G.dataName(this.skinNameList[_loc3_])) {
				this.setSkin(_loc3_);
				return true;
			}
			_loc3_++;
		}
		return false;
	}

	public function setBreasts(param1:Int = -1) {
		var _loc2_:ASFunction = null;
		if (param1 == -1) {
			param1 = this.breastSize;
		}
		this.breastSize = param1;
		this.setBreastFrame(G.her.torso.midLayer.chest);
		this.setBreastFrame(G.her.torsoBack.leftBreast);
		this.setBreastFrame(G.her.torso.midLayer.rightBreast);
		if (G.her.torsoBack.leftBreast.nipple.leftNipple != null) {
			G.her.torsoBack.leftBreast.nipple.gotoAndStop("None");
		} else {
			G.her.torsoBack.leftBreast.nipple.gotoAndStop(this.currentSkinType);
		}
		if (G.her.torso.midLayer.rightBreast.nipple.rightNipple != null) {
			G.her.torso.midLayer.rightBreast.nipple.gotoAndStop("None");
		} else {
			G.her.torso.midLayer.rightBreast.nipple.gotoAndStop(this.currentSkinType);
		}
		this.setBreastCostumeSize();
		for (cb in this.breastSizeChangeListeners) {
			cb();
		}
	}

	public function setBreastFrame(param1:MovieClip) {
		if (param1.getChildByName(param1.name) != null) {
			param1.gotoAndStop(this.breastOffset[4]);
			try {
				this.setChildrenFrame(Std.downcast(param1.getChildByName(param1.name), MovieClip), 2 + this.breastSize);
			} catch (e) {}
		} else {
			this.setChildrenFrame(param1, 2 + this.breastSize);
			param1.gotoAndStop(this.currentBreastOffset + this.breastSize);
		}
	}

	public function setBreastCostumeSize() {
		this.setChildrenFrame(G.her.torso.breastCostume.bra, 2 + this.breastSize);
		this.setChildrenFrame(G.her.torso.braStrap, 2 + this.breastSize);
		this.setChildrenFrame(G.her.torso.upperChestCostume.bra, 2 + this.breastSize);
		this.setChildrenFrame(G.her.torsoBackCostume.breastCostume.bra, 2 + this.breastSize);
		this.setChildrenFrame(G.her.torso.topContainer.breastTop, 2 + this.breastSize);
		this.setChildrenFrame(G.her.torso.topContainer.chestTop, 2 + this.breastSize);
		this.setChildrenFrame(G.her.torsoBackCostume.breastCostume.top, 2 + this.breastSize);
	}

	public function setChildrenFrame(target:DisplayObjectContainer, frameNumber:UInt) {
		var numChildren:UInt = target.numChildren;
		var i:UInt = 0;
		while (i < numChildren) {
            var child = target.getChildAt(i);
			if (Std.isOfType(child, MovieClip)) {
				var childContainer = Std.downcast(child, MovieClip);

				try {
					childContainer.gotoAndStop(frameNumber);
				} catch (e) {}

				this.setChildrenFrame(childContainer, frameNumber);
			}
			i++;
		}
	}

	public function setIrisFill(param1:AlphaRGBObject, param2:String = "rgbFill") {
		var _loc3_ = new ColorTransform(1, 1, 1, 1, param1.r, param1.g, param1.b);
		G.her.eye.ball.irisContainer.iris.irisFill.transform.colorTransform = _loc3_;
		G.her.eye.ball.irisContainer.iris.alpha = param1.a;
		this.irisRGB = param1;
	}

	public function setLipstick(param1:AlphaRGBObject, param2:String = "rgbFill") {
		var _loc3_ = new ColorTransform(1, 1, 1, param1.a, param1.r, param1.g, param1.b);
		G.her.bottomLipstick.transform.colorTransform = _loc3_;
		G.her.topLipstickContainer.transform.colorTransform = _loc3_;
		G.him.lipstickRGB = _loc3_;
		this.lipstickRGB = param1;
	}

	public function setNailPolish(param1:AlphaRGBObject, param2:String = "rgbFill") {
		var _loc3_ = new ColorTransform(1, 1, 1, param1.a, param1.r, param1.g, param1.b);
		G.her.torso.nailPolish.transform.colorTransform = _loc3_;
		G.her.leftArmContainer.upperArmCostume.foreArmCostume.handCostume.nailPolish.transform.colorTransform = _loc3_;
		G.her.rightForeArmContainer.upperArmCostume.foreArmCostume.handCostume.nailPolish.transform.colorTransform = _loc3_;
		G.her.leftHandOver.hand.nailPolish.transform.colorTransform = _loc3_;
		this.nailPolishRGB = param1;
	}

	public function findCollar(param1:String) {
		if (param1 == "Red Tie") {
			param1 = "Tie";
		}
		var _loc2_ = Std.int(Math.ffloor(Std.parseFloat(param1)));
		if (!Math.isNaN(_loc2_)) {
			if (_loc2_ >= 0 && _loc2_ < this.collarNameList.length) {
				this.setCollar(_loc2_);
			}
		} else {
			findName(param1, this.collarNameList, this.collarControl.select);
		}
	}

	public function setCollar(param1:UInt) {
		// G.customElementLoader.clearModTypes([ModTypes.COLLAR]);
		G.her.collarContainer.collar.gotoAndStop(this.collarNameList[param1]);
	}

	public function setCollarFill(param1:AlphaRGBObject, param2:String = "rgbFill") {
		var _loc3_ = new ColorTransform(1, 1, 1, param1.a, param1.r, param1.g, param1.b);
		tryToSetFill(G.her.collarContainer.collar, param2, _loc3_);
	}

	public function setGag(param1:UInt) {
		// G.customElementLoader.clearModTypes([ModTypes.GAG]);
		G.her.gagFront.gotoAndStop(this.gagNameList[param1]);
		G.her.gagBack.gotoAndStop(this.gagNameList[param1]);
		if (param1 == 0) {
			G.her.setGagged(false);
		} else {
			G.her.setGagged(true);
		}
	}

	public function setGagFill(param1:AlphaRGBObject, param2:String = "rgbFill") {
		var _loc3_ = new ColorTransform(1, 1, 1, param1.a, param1.r, param1.g, param1.b);
		tryToSetFill(G.her.gagFront, param2, _loc3_);
		tryToSetFill(G.her.gagBack, param2, _loc3_);
	}

	public function setCuffs(param1:UInt) {
		G.her.torso.cuffs.gotoAndStop(this.cuffsNameList[param1]);
		G.her.rightForeArmContainer.upperArmCostume.foreArmCostume.cuff.gotoAndStop(this.cuffsNameList[param1]);
		G.her.leftArmContainer.upperArmCostume.foreArmCostume.cuff.gotoAndStop(this.cuffsNameList[param1]);
	}

	public function setCuffsFill(param1:AlphaRGBObject, param2:String = "rgbFill") {
		var _loc3_ = new ColorTransform(1, 1, 1, param1.a, param1.r, param1.g, param1.b);
		tryToSetFill(G.her.torso.cuffs, param2, _loc3_);
		tryToSetFill(G.her.rightForeArmContainer.upperArmCostume.foreArmCostume.cuff, param2, _loc3_);
		tryToSetFill(G.her.leftArmContainer.upperArmCostume.foreArmCostume.cuff, param2, _loc3_);
	}

	public function setFootwear(param1:UInt) {
		G.her.torso.rightCalfContainer.footwear.gotoAndStop(this.footwearNameList[param1]);
		G.her.leftLegContainer.leg.footwear.gotoAndStop(this.footwearNameList[param1]);
	}

	public function setFootwearFill(param1:AlphaRGBObject, param2:String = "rgbFill") {
		var _loc3_ = new ColorTransform(1, 1, 1, param1.a, param1.r, param1.g, param1.b);
		tryToSetFill(G.her.torso.rightCalfContainer.footwear, param2, _loc3_);
		tryToSetFill(G.her.leftLegContainer.leg.footwear, param2, _loc3_);
	}

	public function setEyewear(param1:UInt) {
		// G.customElementLoader.clearModTypes([ModTypes.EYEWEAR]);
		G.her.eyewear.gotoAndStop(this.eyewearNameList[this.eyewearControl.selection]);
		G.strandControl.checkElementAnchors(G.her.eyewear);
	}

	public function setEyewearFill(param1:AlphaRGBObject, param2:String = "rgbFill") {
		var _loc3_ = new ColorTransform(1, 1, 1, param1.a, param1.r, param1.g, param1.b);
		tryToSetFill(G.her.eyewear, param2, _loc3_);
	}

	public function setPanties(param1:UInt) {
		G.her.torso.rightThighCostume.panties.gotoAndStop(this.pantiesNameList[this.pantiesControl.selection]);
		G.her.leftLegContainer.leg.leftThighCostume.panties.gotoAndStop(this.pantiesNameList[this.pantiesControl.selection]);
		G.her.torso.backUnderCostume.panties.gotoAndStop(this.pantiesNameList[this.pantiesControl.selection]);
		G.her.torso.chestUnderCostume.panties.gotoAndStop(this.pantiesNameList[this.pantiesControl.selection]);
		G.her.torsoBackCostume.backsideCostume.panties.gotoAndStop(this.pantiesNameList[this.pantiesControl.selection]);
	}

	public function setPantiesFill(param1:AlphaRGBObject, param2:String = "rgbFill") {
		var _loc3_ = new ColorTransform(1, 1, 1, param1.a, param1.r, param1.g, param1.b);
		tryToSetFill(G.her.torso.rightThighCostume.panties, param2, _loc3_);
		tryToSetFill(G.her.leftLegContainer.leg.leftThighCostume.panties, param2, _loc3_);
		tryToSetFill(G.her.torso.backUnderCostume.panties, param2, _loc3_);
		tryToSetFill(G.her.torso.chestUnderCostume.panties, param2, _loc3_);
		tryToSetFill(G.her.torsoBackCostume.backsideCostume.panties, param2, _loc3_);
	}

	public function setBra(param1:UInt) {
		var _loc2_:ASFunction = null;
		G.her.torso.breastCostume.bra.gotoAndStop(this.braNameList[this.braControl.selection]);
		G.her.torso.braStrap.gotoAndStop(this.braNameList[this.braControl.selection]);
		G.her.torso.shoulderStrap.gotoAndStop(this.braNameList[this.braControl.selection]);
		G.her.torso.upperChestCostume.bra.gotoAndStop(this.braNameList[this.braControl.selection]);
		G.her.torsoBackCostume.breastCostume.bra.gotoAndStop(this.braNameList[this.braControl.selection]);
		this.setBreastCostumeSize();
		for (_tmp_ in this.braChangeListeners) {
			_loc2_ = _tmp_;
			_loc2_(this.braNameList[this.braControl.selection]);
		}
	}

	public function setTop(param1:UInt) {
		tryToSetFrameLabel(G.her.torso.topContainer.breastTop, this.topControl.selectedName);
		tryToSetFrameLabel(G.her.torso.topContainer.chestTop, this.topControl.selectedName);
		tryToSetFrameLabel(G.her.torso.topContainer.backTop, this.topControl.selectedName);
		tryToSetFrameLabel(G.her.torso.topContainer.topStrap, this.topControl.selectedName);
		tryToSetFrameLabel(G.her.torsoBackCostume.breastCostume.top, this.topControl.selectedName);
		tryToSetFrameLabel(G.her.torsoUnderCostume.top, this.topControl.selectedName);
		var _loc2_:String = this.topControl.selectedName + (!!G.her.isLeftArmFree() ? "Free" : "");
		var _loc3_:String = this.topControl.selectedName + (!!G.her.isRightArmFree() ? "Free" : "");
		tryToSetFrameLabel(G.her.rightArmContainer.upperArmCostume.top, _loc3_);
		tryToSetFrameLabel(G.her.rightArmEraseContainer.upperArmCostume.top, _loc3_);
		tryToSetFrameLabel(G.her.leftArmContainer.upperArmCostume.top, _loc2_);
		this.setBreastCostumeSize();
	}

	public function setTopFill(param1:AlphaRGBObject, param2:String = "rgbFill") {
		var _loc3_ = new ColorTransform(1, 1, 1, param1.a, param1.r, param1.g, param1.b);
		var _loc4_ = new ColorTransform(1, 1, 1, 1, param1.r, param1.g, param1.b);
		var _loc5_ = new ColorMatrixFilter([1, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, param1.a, 0]);
		G.her.torso.topContainer.filters = [_loc5_];
		G.her.torsoBackCostume.breastCostume.top.filters = [_loc5_];
		tryToSetFill(G.her.torso.topContainer.breastTop, param2, _loc4_);
		tryToSetFill(G.her.torso.topContainer.chestTop, param2, _loc4_);
		tryToSetFill(G.her.torso.topContainer.backTop, param2, _loc4_);
		tryToSetFill(G.her.torso.topContainer.topStrap, param2, _loc4_);
		tryToSetFill(G.her.torsoBackCostume.breastCostume.top, param2, _loc3_);
		tryToSetFill(G.her.torsoUnderCostume.top, param2, _loc3_);
		tryToSetFill(G.her.rightArmContainer.upperArmCostume.top, param2, _loc3_);
		tryToSetFill(G.her.leftArmContainer.upperArmCostume.top, param2, _loc3_);
		var _loc6_ = new ColorTransform(1, 1, 1, 1, param1.r * 0.5, param1.g * 0.5, param1.b * 0.5);
		tryToSetFill(G.her.torso.topContainer.breastTop, "outline", _loc6_);
		tryToSetFill(G.her.torsoBackCostume.breastCostume.top, "outline", _loc6_);
	}

	public function setBraFill(param1:AlphaRGBObject, param2:String = "rgbFill") {
		var _loc3_ = new ColorTransform(1, 1, 1, param1.a, param1.r, param1.g, param1.b);
		tryToSetFill(G.her.torso.breastCostume.bra, param2, _loc3_);
		tryToSetFill(G.her.torso.braStrap, param2, _loc3_);
		tryToSetFill(G.her.torso.shoulderStrap, param2, _loc3_);
		tryToSetFill(G.her.torso.upperChestCostume.bra, param2, _loc3_);
		tryToSetFill(G.her.torsoBackCostume.breastCostume.bra, param2, _loc3_);
	}

	public function setArmwear(param1:UInt) {
		var _loc2_:String = this.armwearNameList[param1];
		tryToSetFrameLabel(G.her.rightForeArmContainer.upperArmCostume.foreArmCostume.handCostume, G.rightHandJobMode ? "Grip" : "Free");
		tryToSetFrameLabel(G.her.leftArmContainer.upperArmCostume.foreArmCostume.handCostume, G.leftHandJobMode ? "Grip" : "Free");
		tryToSetFrameLabel(G.her.rightForeArmContainer.upperArmCostume.foreArmCostume.glove, _loc2_);
		tryToSetFrameLabel(G.her.leftArmContainer.upperArmCostume.foreArmCostume.glove, _loc2_);
		tryToSetFrameLabel(G.her.rightForeArmContainer.upperArmCostume.foreArmCostume.handCostume.glove, _loc2_);
		tryToSetFrameLabel(G.her.leftArmContainer.upperArmCostume.foreArmCostume.handCostume.glove, _loc2_);
		tryToSetFrameLabel(G.her.torso.leftGlove, _loc2_);
		tryToSetFrameLabel(G.her.torso.rightGlove, _loc2_);
		tryToSetFrameLabel(G.her.leftHandOver.hand.glove, _loc2_);
		var _loc3_:String = _loc2_ + (G.her.isLeftArmFree() ? "Free" : "");
		var _loc4_:String = _loc2_ + (G.her.isRightArmFree() ? "Free" : "");
		tryToSetFrameLabel(G.her.rightArmContainer.upperArmCostume.glove, _loc4_);
		tryToSetFrameLabel(G.her.rightArmEraseContainer.upperArmCostume.glove, _loc4_);
		tryToSetFrameLabel(G.her.leftArmContainer.upperArmCostume.glove, _loc3_);
	}

	public function setArmwearFill(param1:AlphaRGBObject, param2:String = "rgbFill") {
		var _loc3_ = new ColorTransform(1, 1, 1, param1.a, param1.r, param1.g, param1.b);
		tryToSetFill(G.her.torso.leftGlove, param2, _loc3_);
		tryToSetFill(G.her.torso.rightGlove, param2, _loc3_);
		tryToSetFill(G.her.rightForeArmContainer.upperArmCostume.foreArmCostume.glove, param2, _loc3_);
		tryToSetFill(G.her.leftArmContainer.upperArmCostume.foreArmCostume.glove, param2, _loc3_);
		tryToSetFill(G.her.rightForeArmContainer.upperArmCostume.foreArmCostume.handCostume.glove, param2, _loc3_);
		tryToSetFill(G.her.leftArmContainer.upperArmCostume.foreArmCostume.handCostume.glove, param2, _loc3_);
		tryToSetFill(G.her.rightArmContainer.upperArmCostume.glove, param2, _loc3_);
		tryToSetFill(G.her.leftArmContainer.upperArmCostume.glove, param2, _loc3_);
		tryToSetFill(G.her.leftHandOver.hand.glove, param2, _loc3_);
	}

	public function setBottoms(param1:UInt) {
		tryToSetFrameLabel(G.her.torso.rightThighBottoms, this.bottomsControl.selectedName);
		tryToSetFrameLabel(G.her.torso.rightThighBottomsOver, this.bottomsControl.selectedName);
		tryToSetFrameLabel(G.her.torso.rightCalfContainer.bottoms, this.bottomsControl.selectedName);
		tryToSetFrameLabel(G.her.torso.chestCostume.bottoms, this.bottomsControl.selectedName);
		tryToSetFrameLabel(G.her.torso.backCostume.bottoms, this.bottomsControl.selectedName);
		tryToSetFrameLabel(G.her.leftLegContainer.leg.leftThighBottoms, this.bottomsControl.selectedName);
		tryToSetFrameLabel(G.her.leftLegContainer.leg.leftCalfBottoms, this.bottomsControl.selectedName);
		tryToSetFrameLabel(G.her.torsoBackCostume.backsideCostume.bottoms, this.bottomsControl.selectedName);
	}

	public function setBottomsFill(param1:AlphaRGBObject, param2:String = "rgbFill") {
		var _loc3_ = new ColorTransform(1, 1, 1, param1.a, param1.r, param1.g, param1.b);
		tryToSetFill(G.her.torso.rightThighBottoms, param2, _loc3_);
		tryToSetFill(G.her.torso.rightThighBottomsOver, param2, _loc3_);
		tryToSetFill(G.her.torso.rightCalfContainer.bottoms, param2, _loc3_);
		tryToSetFill(G.her.torso.chestCostume.bottoms, param2, _loc3_);
		tryToSetFill(G.her.torso.backCostume.bottoms, param2, _loc3_);
		tryToSetFill(G.her.leftLegContainer.leg.leftThighBottoms, param2, _loc3_);
		tryToSetFill(G.her.leftLegContainer.leg.leftCalfBottoms, param2, _loc3_);
		tryToSetFill(G.her.torsoBackCostume.backsideCostume.bottoms, param2, _loc3_);
	}

	public function setLegwearFillA(param1:AlphaRGBObject, param2:String = "rgbFill") {
		this.setLegwearFill(this.legwearControl, false, param1, param2);
	}

	public function setLegwearFillB(param1:AlphaRGBObject, param2:String = "rgbFill") {
		this.setLegwearFill(this.legwearBControl, true, param1, param2);
	}

	public function setLegwearA(param1:UInt) {
		this.setLegwear(this.legwearControl, param1, false);
	}

	public function setLegwearB(param1:UInt) {
		this.setLegwear(this.legwearBControl, param1, true);
	}

	public function setLegwear(param1:CharacterElementHelper, param2:UInt, isB:Bool) {
        var rightThighStocking:obj.Her.HerRightThighStocking;
        var rightCalfStocking:MovieClip;
        var leftStocking:MovieClip;
        var leftCalfStocking:MovieClip;
        var backsideStocking:MovieClip;

        if (isB) {
            rightThighStocking = G.her.torso.rightThighStockingB;
            rightCalfStocking = G.her.torso.rightCalfContainer.calfStockingB;
            leftCalfStocking = G.her.leftLegContainer.leg.calfStockingB;
            leftStocking = G.her.leftLegContainer.leg.stockingB;
            backsideStocking = G.her.torsoBackCostume.backsideCostume.stockingB;
        } else {
            rightThighStocking = G.her.torso.rightThighStocking;
            rightCalfStocking = G.her.torso.rightCalfContainer.calfStocking;
            leftCalfStocking = G.her.leftLegContainer.leg.calfStocking;
            leftStocking = G.her.leftLegContainer.leg.stocking;
            backsideStocking = G.her.torsoBackCostume.backsideCostume.stocking;
        }

		tryToSetFrameLabel(rightThighStocking.stocking, this.legwearNameList[param1.selection]);
		tryToSetFrameLabel(rightThighStocking.stocking.hipLayer.backStocking, this.legwearNameList[param1.selection]);
		tryToSetFrameLabel(rightThighStocking.stocking.hipLayer.chestStocking, this.legwearNameList[param1.selection]);
		tryToSetFrameLabel(rightThighStocking.stocking.hipOverLayer.backStocking, this.legwearNameList[param1.selection]);
		tryToSetFrameLabel(rightThighStocking.stocking.hipOverLayer.chestStocking, this.legwearNameList[param1.selection]);
		tryToSetFrameLabel(rightThighStocking.stocking2, this.legwearNameList[param1.selection]);
		tryToSetFrameLabel(rightThighStocking.stocking2.hipLayer.backStocking, this.legwearNameList[param1.selection]);
		tryToSetFrameLabel(rightThighStocking.stocking2.hipLayer.chestStocking, this.legwearNameList[param1.selection]);
		tryToSetFrameLabel(rightCalfStocking, this.legwearNameList[param1.selection]);
		tryToSetFrameLabel(leftStocking, this.legwearNameList[param1.selection]);
		tryToSetFrameLabel(leftCalfStocking, this.legwearNameList[param1.selection]);
		tryToSetFrameLabel(backsideStocking, this.legwearNameList[param1.selection]);
	}

	public function setLegwearFill(param1:CharacterElementHelper, isB:Bool, param3:AlphaRGBObject, param4:String = "rgbFill") {
        var rightThighStocking:obj.Her.HerRightThighStocking;
        var rightCalfStocking:MovieClip;
        var leftStocking:MovieClip;
        var leftCalfStocking:MovieClip;
        var backsideStocking:MovieClip;

        if (isB) {
            rightThighStocking = G.her.torso.rightThighStockingB;
            rightCalfStocking = G.her.torso.rightCalfContainer.calfStockingB;
            leftCalfStocking = G.her.leftLegContainer.leg.calfStockingB;
            leftStocking = G.her.leftLegContainer.leg.stockingB;
            backsideStocking = G.her.torsoBackCostume.backsideCostume.stockingB;
        } else {
            rightThighStocking = G.her.torso.rightThighStocking;
            rightCalfStocking = G.her.torso.rightCalfContainer.calfStocking;
            leftCalfStocking = G.her.leftLegContainer.leg.calfStocking;
            leftStocking = G.her.leftLegContainer.leg.stocking;
            backsideStocking = G.her.torsoBackCostume.backsideCostume.stocking;
        }

		var _loc5_:ColorTransform;
		var _loc6_ = _loc5_ = new ColorTransform(1, 1, 1, param3.a, param3.r, param3.g, param3.b);
		var _loc7_ = new ColorMatrixFilter([1, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, param3.a, 0]);
		if (param4 == "rgbFill") {
			if (param1.selectedName == "Pantyhose" || param1.selectedName == "Garter Belt") {
				_loc6_ = new ColorTransform(1, 1, 1, 1, param3.r, param3.g, param3.b);
				rightThighStocking.stocking.filters = [_loc7_];
				rightThighStocking.stocking2.filters = [_loc7_];
			} else {
				rightThighStocking.stocking.filters = [];
				rightThighStocking.stocking2.filters = [];
			}
		}
		tryToSetFill(rightThighStocking.stocking, param4, _loc6_);
		tryToSetFill(rightThighStocking.stocking.hipLayer.backStocking, param4, _loc6_);
		tryToSetFill(rightThighStocking.stocking.hipLayer.chestStocking, param4, _loc6_);
		tryToSetFill(rightThighStocking.stocking.hipOverLayer.backStocking, param4, _loc6_);
		tryToSetFill(rightThighStocking.stocking.hipOverLayer.chestStocking, param4, _loc6_);
		tryToSetFill(rightThighStocking.stocking2, param4, _loc6_);
		tryToSetFill(rightThighStocking.stocking2.hipLayer.backStocking, param4, _loc6_);
		tryToSetFill(rightThighStocking.stocking2.hipLayer.chestStocking, param4, _loc6_);
		tryToSetFill(rightCalfStocking, param4, _loc5_);
		tryToSetFill(leftStocking, param4, _loc5_);
		tryToSetFill(leftCalfStocking, param4, _loc5_);
		tryToSetFill(backsideStocking, param4, _loc5_);
	}

	public function findTonguePiercing(param1:String) {
		findName(param1, this.tonguePiercingNameList, this.tonguePiercingControl.select);
	}

	public function waitToSetHeadwearPosition(param1:String = null) {
		this.waitingToSetHeadwearPosition = true;
	}

	public function tryToLandHeadwear() {
		var _loc1_:Point = null;
		var _loc2_:Point = null;
		var _loc3_ = false;
		var _loc4_ = false;
		var _loc5_:UInt = 0;
		var _loc6_ = false;
		var _loc7_ = Math.NaN;
		G.hairCostumeOver.headwear.y = 0;
		G.hairCostumeBack.headwear.y = 0;
		if (!this.customHairLoaded) {
			_loc3_ = false;
			_loc4_ = false;
			_loc5_ = 0;
			_loc6_ = false;
			_loc7_ = 10;
            var landingPoint = G.hairCostumeOver.headwear.landingPoint;
			if (landingPoint != null) {
				_loc1_ = new Point(landingPoint.x, landingPoint.y);
				do {
					_loc2_ = G.hairCostumeOver.headwear.localToGlobal(_loc1_);
					_loc3_ = _loc4_;
					_loc4_ = (_loc4_ = (_loc4_ = (_loc4_ = false) || G.hairOverLayer.hitTestPoint(_loc2_.x, _loc2_.y, true))
						|| G.hairTop.hitTestPoint(_loc2_.x, _loc2_.y, true))
						|| G.her.hairMidContainer.hitTestPoint(_loc2_.x, _loc2_.y, true);
					G.hairCostumeOver.headwear.y += _loc7_;
					G.hairCostumeBack.headwear.y += _loc7_;
					if (_loc4_ != _loc3_) {
						_loc7_ *= -0.5;
						if (Math.abs(_loc7_) < 1) {
							_loc6_ = true;
						}
					}
					_loc5_++;
				} while (!_loc6_ && _loc5_ < 50);

				if (G.hairCostumeOver.headwear.y > 50) {
					G.hairCostumeOver.headwear.y = 0;
					G.hairCostumeBack.headwear.y = 0;
				}
			}
		}
	}

	public function applyHairHSL(param1:ColorHsl) {
		var _loc2_ = new ColorMatrixFilter(Maths.getCMFMatrix(param1.h, param1.s, param1.l, param1.c));
		G.her.hairMidContainer.filters = [_loc2_];
		G.her.hairBackContainer.filters = [_loc2_];
		G.hairOverContainer.filters = [_loc2_];
		G.hairBetweenLayer.filters = [_loc2_];
		this.hairHSL = param1;
	}

	public function removeHairHSL() {
		G.her.hairMidContainer.filters = [];
		G.her.hairBackContainer.filters = [];
		G.hairOverContainer.filters = [];
		G.hairBetweenLayer.filters = [];
		this.hairHSL = this.blankHSL;
	}

	public function applySkinHSL(param1:ColorHsl) {
		var _loc2_ = new ColorMatrixFilter(Maths.getCMFMatrix(param1.h, param1.s, param1.l, param1.c));
		G.her.head.filters = [_loc2_];
		G.her.ear.filters = [_loc2_];
		G.her.eye.eyebrowUnderMask.filters = [_loc2_];
		G.her.torsoBack.filters = [_loc2_];
		G.her.backModContainer.filters = [_loc2_];
		G.her.leftLegContainer.leg.thigh.filters = [_loc2_];
		G.her.leftLegContainer.leg.calf.filters = [_loc2_];
		G.her.leftArmContainer.upperArm.filters = [_loc2_];
		G.her.rightArmContainer.upperArm.filters = [_loc2_];
		G.her.rightForeArmContainer.upperArm.filters = [_loc2_];
		G.her.leftHandOver.hand.grip.filters = [_loc2_];
		G.her.torso.backside.filters = [_loc2_];
		G.her.torso.midLayer.filters = [_loc2_];
		G.her.torso.behindBackRightArm.filters = [_loc2_];
		G.her.torso.back.filters = [_loc2_];
		G.her.torso.leg.thigh.filters = [_loc2_];
		G.her.torso.rightCalfContainer.calf.filters = [_loc2_];
		G.her.torso.penisContainer.filters = [_loc2_];
		this.skinHSL = param1;
	}

	public function removeSkinHSL() {
		G.her.head.filters = [];
		G.her.ear.filters = [];
		G.her.eye.eyebrowUnderMask.filters = [];
		G.her.torsoBack.filters = [];
		G.her.backModContainer.filters = [];
		G.her.leftLegContainer.leg.thigh.filters = [];
		G.her.leftLegContainer.leg.calf.filters = [];
		G.her.leftArmContainer.upperArm.filters = [];
		G.her.rightArmContainer.upperArm.filters = [];
		G.her.rightForeArmContainer.upperArm.filters = [];
		G.her.leftHandOver.hand.grip.filters = [];
		G.her.torso.backside.filters = [];
		G.her.torso.midLayer.filters = [];
		G.her.torso.behindBackRightArm.filters = [];
		G.her.torso.back.filters = [];
		G.her.torso.leg.thigh.filters = [];
		G.her.torso.rightCalfContainer.calf.filters = [];
		G.her.torso.penisContainer.filters = [];
		this.skinHSL = this.blankHSL;
	}

	public function updateSkinHSL() {
		if (this.skinHSL == this.blankHSL) {
			this.removeSkinHSL();
		} else {
			this.applySkinHSL(this.skinHSL);
		}
	}

	public function applyHisSkinHSL(param1:ColorHsl) {
		var _loc2_ = new ColorMatrixFilter(Maths.getCMFMatrix(param1.h, param1.s, param1.l, param1.c));
		G.him.penis.filters = !!G.him.hslShiftPenis ? [_loc2_] : [];
		G.him.armContainer.filters = [_loc2_];
		G.him.leftArmContainer.filters = [_loc2_];
		G.him.balls.filters = [_loc2_];
		G.him.torsoLayer.filters = [_loc2_];
		G.him.leftLeg.filters = [_loc2_];
		G.him.rightLeg.filters = [_loc2_];
		this.hisSkinHSL = param1;
	}

	public function removeHisSkinHSL() {
		G.him.penis.filters = [];
		G.him.armContainer.filters = [];
		G.him.leftArmContainer.filters = [];
		G.him.balls.filters = [];
		G.him.torsoLayer.filters = [];
		G.him.leftLeg.filters = [];
		G.him.rightLeg.filters = [];
		this.hisSkinHSL = this.blankHSL;
	}

	public function updateHisSkinHSL() {
		if (this.hisSkinHSL == this.blankHSL) {
			this.removeHisSkinHSL();
		} else {
			this.applyHisSkinHSL(this.hisSkinHSL);
		}
	}

	public function getCharacterList():Array<String> {
		var charaNames = new Array<String>();
		var i = 0;
		while (i < this.characters.length) {
			charaNames.push(this.characters[i].charShortName);
			i++;
		}
		return charaNames;
	}

	public function getIrisList():Array<String> {
		return this.irisTypeList;
	}

	public function getSkinList():Array<String> {
		return this.skinNameList;
	}

	public function nextCharacter() {
        // TODO
		// G.inGameMenu.characterMenu.selectNextCharacter();
        tryToSetChar(currentChar - 1);
	}

	public function prevCharacter() {
        // TODO
		// G.inGameMenu.characterMenu.selectPrevCharacter();
        tryToSetChar(currentChar + 1);
    }

    public function toggleBackground() {
		if (G.bgID == G.bgNum) {
			G.bgID = 1;
		} else {
			++G.bgID;
		}
		G.bg.gotoAndStop(G.bgID);
		G.inGameMenu.setBGCheckboxes();
	}

	public function toggleHim() {
		G.him.toggleBodySettings();
	}

	public function toggleSkin() {
		if (this.currentSkin == (this.skinNameList.length - 1:UInt)) {
			this.currentSkin = 0;
		} else {
			++this.currentSkin;
		}
		this.setSkin(this.currentSkin);
		G.inGameMenu.updateSkinList();
	}

	public function toggleBreasts() {
		var _loc1_:UInt = 0;
		if (this.breastSize == 149) {
			_loc1_ = 0;
		} else {
			_loc1_ = Std.int(Math.ffloor((1 + this.breastSize) / 25) * 25 + 24);
		}
		this.setBreasts(_loc1_);
		G.inGameMenu.updateBreastSlider();
		G.strandControl.checkElementAnchors(G.her.torso.midLayer.rightBreast);
	}

	public function clearHair() {
		this.clearElements();
		G.her.hairTop.gotoAndStop("None");
		G.her.hairMidContainer.hairUnder.gotoAndStop("None");
		G.her.hairMidContainer.hairBottom.gotoAndStop("None");
		G.her.hairBackContainer.hairBack.gotoAndStop("None");
	}

	public function resetHair() {
		this.setHair(this.currentHair, false);
		G.saveData.saveCharData();
	}

	public function resetBackground() {
		G.bg.gotoAndStop(G.bgID);
	}

	public function setCustomHairLoaded() {
		this.customHairLoaded = true;
	}

	public function setCustomBGLoaded() {
		this.customBGLoaded = true;
	}

	@:flash.property public var currentSkinPalette(get, never):SkinPalette;

	function get_currentSkinPalette():SkinPalette {
		return this.skinPalettes[this.skinNameList[this.currentSkin]];
	}

	@:flash.property public var skinType(get, never):String;

	function get_skinType():String {
		return this.currentSkinType;
	}

	public function getCharName(param1:UInt):String {
		return param1 < (this.characters.length:UInt) ? this.characters[param1].charName : "";
	}
}
