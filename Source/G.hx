package;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.MovieClip;
import openfl.display.Sprite;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.filters.ColorMatrixFilter;
import openfl.geom.Point;
import openfl.geom.Matrix;
import obj.CachedSmudge;
import obj.dialogue.Dialogue;
import obj.animation.AnimationControl;
import obj.CharacterControl;
import obj.SoundControl;
import obj.ui.InGameMenu;
import obj.Her;
import obj.Him;
import obj.SaveData;
import obj.CostumeElement;

class G {
	public static var ver:String = "v1.21.1b-hx";
	public static var sceneLayer:DisplayObject;
	// public static var defaultCM:ContextMenu;
	public static var screenSize:Point = new Point(700, 600);
	public static var NORMAL_MODE:UInt = 1;
	public static var HAND_JOB_MODE:UInt = 2;
	public static var container:Sprite;
	public static var her:Her;
	public static var him:Him;
	// public static var himOverLayer:HimOverLayer;
	public static var bg:Background;
	// public static var sceneLayer:SceneLayer;
	public static var backLayer:Sprite;
	// public static var hairBackContainer:HairBackContainer;
	public static var mistLayer:Sprite;
	public static var strandBackLayer:Sprite;
	public static var strandFrontLayer:Sprite;
	public static var cumLayer:Sprite;
	public static var frontLayer:Sprite;
	// public static var screenEffects:ScreenEffects;
	// public static var stageRef:MovieClip;
	// public static var clickPrompt:ClickPrompt;
	public static var inGameMenu:InGameMenu;
	public static var animationControl:AnimationControl;
	// public static var strandControl:StrandControl;
	public static var soundControl:SoundControl;
	// public static var automaticControl:AutomaticControl;
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
        her = new Her();
        him = new Him();
		soundControl = new SoundControl();
        animationControl = new AnimationControl();
        inGameMenu = new InGameMenu();
        saveData = new SaveData();
    }

      public static function showError(param1:String)
      {
      }

      @:flash.property public static var handJobMode(get,never):Bool;
static function  get_handJobMode() : Bool
      {
         return leftHandJobMode || rightHandJobMode;
      }

      public static function resetIntro()
      {
      }

      public static function changeLayer(param1:DisplayObject, param2:DisplayObjectContainer, param3:DisplayObject = null, param4:Bool = false)
      {
      }

      public static function clearSmudgeCache()
      {
      }

      public static function setPenisOut(param1:Bool = true)
      {
      }

      public static function setAuto(param1:UInt)
      {
      }

      public static function toggleAutoMode()
      {
      }

      public static function toggleQuality()
      {
      }

      @:flash.property public static var breathLevel(get,never):Float;
static function  get_breathLevel() : Float
      {
         return currentBreathLevel;
      }

      public static function addBreath(param1:Float) : ASAny
      {
      }

      public static function setBreathTo(param1:Float) : ASAny
      {
      }

      public static function randomSpitMass() : Float
      {
      }

      public static function randomCumMass() : Float
      {
      }

      public static function dataName(param1:String) : String
      {
          return "";
      }

      public static function getEraseItems(param1:DisplayObjectContainer)
      {
      }

      public static function setEraseContainersForRendering(param1:Bool)
      {
      }

      public static function freezeScreen()
      {
      }

      public static function thawScreen()
      {
      }

      public static function startEyedropper()
      {
      }

      public static function getEyedropperPoint(param1:Float, param2:Float) : UInt
      {
      }

      public static function stopEyedropper()
      {
      }

      public static function takeScreenShot()
      {
      }

      public static function renderCharacterShot(param1:Float = 0.2) : Bitmap
      {
      }

      public static function generateCharacterShot(param1:Float = 0.1) : BitmapData
      {
      }
}
