package;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.BlendMode;
import openfl.display.MovieClip;
import openfl.display.Sprite;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.filters.BlurFilter;
import openfl.filters.ColorMatrixFilter;
import openfl.geom.Point;
import openfl.geom.Matrix;
import openfl.geom.Rectangle;
import openfl.utils.ByteArray;
import obj.CachedSmudge;
import obj.dialogue.Dialogue;
import obj.animation.AnimationControl;
import obj.AutomaticControl;
import obj.CharacterControl;
import obj.SoundControl;
import obj.ui.InGameMenu;
import obj.Her;
import obj.Him;
import obj.Maths;
import obj.SaveData;
import obj.CostumeElement;
import obj.SceneLayer;
import obj.StrandControl;
import obj.ScreenEffects;

class G {
	public static var ver:String = "v1.21.1b-hx";
	// public static var defaultCM:ContextMenu;
	public static var screenSize:Point = new Point(700, 600);
	public static var NORMAL_MODE:UInt = 1;
	public static var HAND_JOB_MODE:UInt = 2;
	public static var container:Sprite;
	public static var her:Her;
	public static var him:Him;
	public static var himOverLayer:HimOverLayer;
	public static var bg:Background;
	public static var sceneLayer:SceneLayer;
	public static var backLayer:Sprite;
	public static var hairBackContainer:HairBackContainer;
	public static var mistLayer:Sprite;
	public static var strandBackLayer:Sprite;
	public static var strandFrontLayer:Sprite;
	public static var cumLayer:Sprite;
	public static var frontLayer:Sprite;
	public static var screenEffects:ScreenEffects;
	public static var stageRef:MovieClip;
	// public static var clickPrompt:ClickPrompt;
	public static var inGameMenu:InGameMenu;
	public static var animationControl:AnimationControl;
	public static var strandControl:StrandControl;
	public static var soundControl:SoundControl;
	public static var automaticControl:AutomaticControl;
	public static var characterControl:CharacterControl;
	public static var saveData:SaveData;
	// public static var customElementLoader:CustomElementLoader;
	public static var dialogueControl:Dialogue;
	// public static var dialogueEditor:DialogueEditor;
	// public static var highlightShader:Shader;
	// public static var highlight:ShaderFilter;
	// public static var cumHighlightShader:Shader;
	// public static var cumHighlight:ShaderFilter;
	// public static var shadow:DropShadowFilter;
	public static var spitShaders:Array<ASAny>;
	public static var cumShaders:Array<ASAny>;
	public static var hairCM:ColorMatrixFilter;
	public static var skinCM:ColorMatrixFilter;
	public static var gravity:Float = 5.5;
	public static var friction:Float = 1.18;
	public static var spitMass:Float = 0.4;
	public static var massGenerateSpeed:Float = 0.001;
	public static var massFlow:Float = 0.005;
	public static var maxMass:Float = 1.1;
	public static var maxStrandLength:UInt = 18;
	public static var cumRGB:UInt = 16776439;
	public static var currentBreathLevel:Float = 0;
	public static var breathLevelMax:Float = 50;
	public static var outOfBreathPoint:Float = 25;
	public static var strandShaders:Bool = true;
	public static var showMouse:Bool = true;
	public static var qualitySetting:UInt = 2;
	public static var hoverOptions:Bool = true;
	public static var mute:Bool = false;
	public static var mirrored:Bool = false;
	public static var invertControls:Bool = false;
	public static var screenShotScale:Float = 1;
	public static var doubleSizeScreenshot:Bool = false;
	public static var resetIntroOnNewChar:Bool = false;
	public static var introResistance:Float = Math.NaN;
	public static var defaultResistance:Float = 50;
	public static var throatResistance:Float = Math.NaN;
	public static var defaultThroatResistance:Float = 50;
	public static var sceneZoom:Float = 0.85;
	public static var defaultZoom:Float = 0.45;
	public static var smearLipstick:Bool = false;
	public static var spit:Bool = true;
	public static var tears:Bool = true;
	public static var mascara:Bool = true;
	public static var smudging:Bool = true;
	public static var eyeShadow:Bool = true;
	public static var nostrilSpray:Bool = true;
	public static var sweat:Bool = true;
	public static var tongue:Bool = true;
	public static var throatBulgeAmount:Float = 1;
	public static var dialogue:Bool = false;
	public static var introSound:Bool = true;
	public static var breathing:Bool = true;
	public static var gagging:Bool = true;
	public static var coughing:Bool = true;
	public static var mascaraAmount:Float = 20;
	public static var frecklesAmount:Float = 0;
	public static var bgNum:UInt = 4;
	public static var bgID:UInt = 1;
	public static var himSkinType:String = "Light";
	public static var overwriteCharList:Bool = false;
	public static var customName:String = "";
	public static var autoModeOn:Bool = false;
	public static var autoMode:UInt = 0;
	public static var handsOff:Bool = false;
	public static var baseCharNum:UInt = 0;
	public static var storedChars:Array<ASAny> = new Array();
	public static var defaultModFolders:Array<ASAny> = new Array();
	public static var bukkakeMode:Bool = false;
	public static var hairOverContainer:Sprite;
	public static var hairTop:MovieClip;
	public static var hairUnder:MovieClip;
	public static var hairBottom:MovieClip;
	public static var hairBack:MovieClip;
	public static var hairOverLayer:Sprite;
	public static var hairBetweenLayer:Sprite;
	public static var hairUnderLayer:Sprite;
	public static var hairBackLayer:Sprite;
	public static var hairCostumeOver:HairCostumeOver;
	public static var hairCostumeUnderOver:Sprite;
	public static var hairCostumeUnder:Sprite;
	public static var hairCostumeBack:HairCostumeBack;
	public static var costumeHitElements:Array<CostumeElement> = new Array();
	public static var currentMousePos:Point = new Point();
	public static var currentPos:Point = new Point(0, 0);
	public static var currentHandJobPos:Point = new Point(0, 0);
	public static var targetHandJobPos:Point = new Point(0, 0);
	public static var herCurrentPos:Float = 0;
	public static var shiftDown:Bool = false;
	public static var ctrlDown:Bool = false;
	public static var herMouthOpeness:Float = 0;
	public static var penisOut:Bool = false;
	public static var leftHandJobMode:Bool = false;
	public static var rightHandJobMode:Bool = false;
	public static var currentModeID:UInt = 1;
	public static var gameRunning:Bool = false;
	public static var gamePaused:Bool = false;
	public static var controlLocked:Bool = false;
	public static var inTextField:Bool = false;
	// public static var overScrollArea:IMouseWheelScrollable;
	public static var smudgeCache:ASDictionary<DisplayObject, CachedSmudge> = new ASDictionary();
	public static var eyedropperScreenshot:BitmapData;
	public static var screenFreezeData:BitmapData;
	public static var screenFreeze:Bitmap;
	public static var totalFinishes:UInt = 0;
	public static var capCount:UInt = 0;
	public static var screenshotNum:UInt = 1;
	public static var eraseParents:Array<DisplayObjectContainer> = new Array();

	public function new() {}

	public static function initGlobals() {
		sceneLayer = new SceneLayer(G.defaultZoom);
		automaticControl = new AutomaticControl();
		animationControl = new AnimationControl();
		soundControl = new SoundControl();
		strandControl = new StrandControl();
		characterControl = new CharacterControl();
		her = new Her();
		him = new Him();
		inGameMenu = new InGameMenu();
		saveData = new SaveData();
		screenEffects = new ScreenEffects();
		hairBackContainer = new HairBackContainer();
	}

	public static function showError(param1:String) {}

	@:flash.property public static var handJobMode(get, never):Bool;

	static function get_handJobMode():Bool {
		return leftHandJobMode || rightHandJobMode;
	}

	public static function resetIntro() {
		her.startIntro();
		him.resetSpit();
	}

	public static function changeLayer(param1:DisplayObject, param2:DisplayObjectContainer, param3:DisplayObject = null, param4:Bool = false) {
		param1.parent.removeChild(param1);
		if (param4) {
			param2.addChildAt(param1, 0);
		} else if (param3 != null) {
			param2.addChildAt(param1, param2.getChildIndex(param3) + 1);
		} else {
			param2.addChild(param1);
		}
	}

	public static function clearSmudgeCache() {
		var _loc1_:ASObject = null;
		for (_tmp_ in smudgeCache) {
			_loc1_ = _tmp_;
			_loc1_.updated = false;
			_loc1_.lastPoint = _loc1_.localPoint;
		}
	}

	public static function setPenisOut(param1:Bool = true) {
		if (param1 && !penisOut) {
			frontLayer.addChildAt(sceneLayer.removeChild(him), frontLayer.getChildIndex(her.rightForeArmContainer));
			frontLayer.addChildAt(her.leftHandOver, frontLayer.getChildIndex(himOverLayer));
			penisOut = true;
		} else if (penisOut) {
			sceneLayer.addChildAt(frontLayer.removeChild(him), 0);
			her.leftHandOverContainer.addChild(frontLayer.removeChild(her.leftHandOver));
			penisOut = false;
		}
	}

	public static function setAuto(param1:UInt) {
		autoMode = param1;
		automaticControl.startAuto(currentPos);
	}

	public static function toggleAutoMode() {
		autoModeOn = !autoModeOn;
		automaticControl.startAuto(currentPos);
	}

	public static function toggleQuality() {
		if (qualitySetting == 2) {
			qualitySetting = 0;
		} else {
			++qualitySetting;
		}
		inGameMenu.setQualityTo(qualitySetting);
		inGameMenu.setQualityCBs();
	}

	@:flash.property public static var breathLevel(get, never):Float;

	static function get_breathLevel():Float {
		return currentBreathLevel;
	}

	public static function addBreath(param1:Float) {
		if (breathing) {
			currentBreathLevel = Maths.clampf(currentBreathLevel + param1, 0, breathLevelMax);
		}
	}

	public static function setBreathTo(param1:Float) {
		if (breathing) {
			currentBreathLevel = Maths.clampf(param1, 0, breathLevelMax);
		}
	}

	public static function randomSpitMass():Float {
		return Math.random() * 0.2 - 0.1 + spitMass;
	}

	public static function randomCumMass():Float {
		return 0.3 + Math.random() * 0.4;
	}

	public static function dataName(param1:String):String {
		var _loc2_ = param1.toLowerCase();
		var _loc3_ = new compat.RegExp("\\W", "g");
		return _loc3_.replace(_loc2_, "");
	}

	public static function getEraseItems(param1:DisplayObjectContainer) {
		var _loc3_:DisplayObject = null;
		var _loc2_:UInt = param1.numChildren;
		var _loc4_:UInt = 0;
		while (_loc4_ < _loc2_) {
			_loc3_ = param1.getChildAt(_loc4_);
			if (_loc3_.blendMode == BlendMode.ERASE) {
				if (eraseParents.indexOf(param1) == -1) {
					eraseParents.push(param1);
				}
			}
			if (Std.is(_loc3_, DisplayObjectContainer)) {
				getEraseItems(Std.downcast(_loc3_, DisplayObjectContainer));
			}
			_loc4_++;
		}
	}

	public static function setEraseContainersForRendering(param1:Bool) {
		for (parent in eraseParents) {
			parent.cacheAsBitmap = param1;
		}
	}

	public static function freezeScreen() {
		screenFreezeData = new BitmapData(Std.int(screenSize.x), Std.int(screenSize.y));
		var _loc1_ = new BitmapData(Std.int(screenSize.x), Std.int(screenSize.y));
		setEraseContainersForRendering(true);
		_loc1_.draw(container);
		setEraseContainersForRendering(false);
		var _loc2_ = new BlurFilter();
		screenFreezeData.applyFilter(_loc1_, new Rectangle(0, 0, screenSize.x, screenSize.y), new Point(), _loc2_);
		screenFreeze = new Bitmap(screenFreezeData);
		screenFreeze.smoothing = true;
		sceneLayer.parent.addChildAt(screenFreeze, sceneLayer.parent.getChildIndex(sceneLayer));
		sceneLayer.setSceneVisible(false);
	}

	public static function thawScreen() {
		if (screenFreeze != null) {
			screenFreeze.parent.removeChild(screenFreeze);
			screenFreeze = null;
			screenFreezeData.dispose();
			screenFreezeData = null;
		}
		sceneLayer.setSceneVisible(true);
	}

	public static function startEyedropper() {
		eyedropperScreenshot = new BitmapData(Std.int(screenSize.x), Std.int(screenSize.y));
		setEraseContainersForRendering(true);
		eyedropperScreenshot.draw(container);
		setEraseContainersForRendering(false);
	}

	public static function getEyedropperPoint(param1:Float, param2:Float):UInt {
		if (eyedropperScreenshot != null) {
			return eyedropperScreenshot.getPixel(Std.int(param1), Std.int(param2));
		}
		return 0;
	}

	public static function stopEyedropper() {
		eyedropperScreenshot.dispose();
	}

	public static function takeScreenShot() {
		// var oldQuality = qualitySetting;
		// inGameMenu.setQualityTo(3);
		// var screenShotData = new BitmapData(Std.int(700 * screenShotScale), Std.int(600 * screenShotScale), false, 0);
		// var m = new Matrix();
		// m.scale(screenShotScale, screenShotScale);
		// setEraseContainersForRendering(true);
		// screenShotData.draw(container, m);
		// setEraseContainersForRendering(false);
		// var screenShotPng:ByteArray = PNGEncoder.encode(screenShotData);
		// var screenshotID = Std.string(screenshotNum);
		// while (screenshotID.length < 4) {
		// 	screenshotID = "0" + screenshotID;
		// }
		// var saveFile = new FileReference();
		// try {
		// 	saveFile.save(screenShotPng, "screenshot" + screenshotID + ".png");
		// 	++screenshotNum;
		// } catch (e:Error) {}
		// inGameMenu.setQualityTo(oldQuality);
	}

	public static function renderCharacterShot(param1:Float = 0.2):Bitmap {
		var _loc2_ = new Bitmap(generateCharacterShot(param1));
		var _loc3_ = capCount % 5;
		_loc2_.x = _loc3_ * 140 - 0.5;
		_loc2_.y = (capCount - _loc3_) * 24 - 0.5;
		++capCount;
		return _loc2_;
	}

	public static function generateCharacterShot(param1:Float = 0.1):BitmapData {
		var _loc3_:Matrix = null;
		var _loc2_ = new BitmapData(Std.int(700 * param1), Std.int(600 * param1), false, 0xFFFFFFFF);
		var _loc4_:ASObject = characterControl.hairHSL;
		var _loc5_ = new ColorMatrixFilter(Maths.getCMFMatrix(_loc4_.h, _loc4_.s, _loc4_.l, _loc4_.c));
		hairBack.filters = [_loc5_];
		hairBackLayer.filters = [_loc5_];
		hairTop.filters = [_loc5_];
		hairOverLayer.filters = [_loc5_];
		var _loc6_ = her.rightArmContainer.upperArmMask.visible;
		her.rightArmContainer.upperArmMask.visible = false;
		setEraseContainersForRendering(true);
		_loc3_ = new Matrix();
		_loc3_.scale(param1, param1);
		_loc2_.draw(bg, _loc3_);
		_loc3_ = new Matrix();
		_loc3_.rotate(-15 / 180 * Math.PI);
		_loc3_.scale(0.85 * param1, 0.85 * param1);
		_loc3_.translate(700 * param1 * 0.5, 600 * param1 * 0.5);
		var _loc7_:Matrix;
		(_loc7_ = new Matrix()).translate(-her.x, -her.y);
		_loc7_.rotate(-her.rotation / 180 * Math.PI);
		_loc7_.rotate(-15 / 180 * Math.PI);
		_loc7_.scale(0.85 * param1, 0.85 * param1);
		_loc7_.translate(700 * param1 * 0.5, 600 * param1 * 0.5);
		var _loc8_:Matrix;
		(_loc8_ = new Matrix()).rotate(her.torso.rotation / 180 * Math.PI);
		_loc8_.translate(her.torso.x, her.torso.y);
		_loc8_.concat(_loc3_);
		_loc2_.draw(hairBack, _loc3_);
		_loc2_.draw(hairBackLayer, _loc7_);
		_loc2_.draw(hairCostumeBack, _loc3_);
		_loc2_.draw(her.leftArmContainer, _loc8_);
		_loc2_.draw(her, _loc3_);
		_loc2_.draw(her.rightArmContainer, _loc8_);
		_loc2_.draw(her.rightForeArmContainer, _loc8_);
		_loc2_.draw(hairCostumeUnderOver, _loc3_);
		_loc2_.draw(hairTop, _loc3_);
		_loc2_.draw(hairOverLayer, _loc7_);
		_loc2_.draw(hairCostumeOver, _loc3_);
		setEraseContainersForRendering(false);
		hairBack.filters = [];
		hairBackLayer.filters = [];
		hairTop.filters = [];
		hairOverLayer.filters = [];
		her.rightArmContainer.upperArmMask.visible = _loc6_;
		return _loc2_;
	}

	public static function getCMFMatrix(param1:Float, param2:Float, param3:Float, param4:Float):Array<ASAny> {
		var _loc5_ = param3 * param2 * Math.cos(param1 * Math.PI / 180);
		var _loc6_ = param3 * param2 * Math.sin(param1 * Math.PI / 180);
		var _loc7_ = (0.299 * param3 + 0.701 * _loc5_ + 0.168 * _loc6_) * param4;
		var _loc8_ = (0.587 * param3 - 0.587 * _loc5_ + 0.33 * _loc6_) * param4;
		var _loc9_ = (0.114 * param3 - 0.114 * _loc5_ - 0.497 * _loc6_) * param4;
		var _loc10_ = (0.299 * param3 - 0.299 * _loc5_ - 0.328 * _loc6_) * param4;
		var _loc11_ = (0.587 * param3 + 0.413 * _loc5_ + 0.035 * _loc6_) * param4;
		var _loc12_ = (0.114 * param3 - 0.114 * _loc5_ + 0.292 * _loc6_) * param4;
		var _loc13_ = (0.299 * param3 - 0.3 * _loc5_ + 1.25 * _loc6_) * param4;
		var _loc14_ = (0.587 * param3 - 0.588 * _loc5_ - 1.05 * _loc6_) * param4;
		var _loc15_ = (0.114 * param3 + 0.886 * _loc5_ - 0.203 * _loc6_) * param4;
		var _loc16_:Array<ASAny>;
		(_loc16_ = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0])[0] = [_loc7_];
		_loc16_[1] = [_loc8_];
		_loc16_[2] = [_loc9_];
		_loc16_[5] = [_loc10_];
		_loc16_[6] = [_loc11_];
		_loc16_[7] = [_loc12_];
		_loc16_[10] = [_loc13_];
		_loc16_[11] = [_loc14_];
		_loc16_[12] = [_loc15_];
		var _loc17_ = 128 - param4 * 128;
		_loc16_[4] = _loc17_;
		_loc16_[9] = _loc17_;
		_loc16_[14] = _loc17_;
		return _loc16_;
	}

	public static function getUnitVector(param1:Float):Point {
		return new Point(Math.sin(param1), -Math.cos(param1));
	}

	public static function getAngle(param1:Float, param2:Float):Float {
		return radToDeg(Math.atan2(param2, param1)) + 90;
	}

	public static function getRadAngle(param1:Float, param2:Float):Float {
		return Math.atan2(param2, param1) + Math.PI * 0.5;
	}

	public static function getVector(param1:Float, param2:Float):Point {
		return new Point(Math.sin(param2) * param1, -Math.cos(param2) * param1);
	}

	public static function getDist(param1:Float, param2:Float):Float {
		return Math.sqrt(param1 * param1 + param2 * param2);
	}

	public static function degToRad(param1:Float):Float {
		return param1 / 180 * Math.PI;
	}

	public static function radToDeg(param1:Float):Float {
		return param1 / Math.PI * 180;
	}

	public static function sigRound(param1:UInt, param2:Float):Float {
		param2 *= Math.pow(10, param1);
		param2 = Math.fround(param2);
		return param2 / Math.pow(10, param1);
	}

	public static function rotateMatrix(param1:Matrix, param2:Float) {
		var _loc3_ = Math.asin(param1.b);
		param2 += _loc3_;
		var _loc4_ = Math.sin(param2);
		var _loc5_ = Math.cos(param2);
		param1.a = _loc5_;
		param1.b = _loc4_;
		param1.c = -_loc4_;
		param1.d = _loc5_;
	}
}
