package;

import com.kircode.debug.FPS_Mem;
import obj.Her;
import obj.SceneLayer;
import obj.ScreenEffects;
import obj.animation.AnimationControl;
import openfl.Assets;
import openfl.display.BlendMode;
import openfl.display.MovieClip;
import openfl.display.Sprite;
import openfl.display.StageQuality;
import openfl.display.StageScaleMode;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;
import openfl.filters.DropShadowFilter;
import openfl.geom.Point;
import openfl.ui.Keyboard;
import openfl.ui.Mouse;
import openfl.utils.AssetLibrary;
// import openfl.utils.ByteArray;
// import obj.CustomElementLoader;
// import obj.ui.IMouseWheelScrollable;

class Main extends Sprite {
	// public var preloaderBG:MenuBackground;
	// public var preloadDisplay:PreloadDisplay;
	// public var customElementLoader:CustomElementLoader;
	public var bgLayer:Sprite;
	public var strandBackLayer:Sprite;
	public var strandBackMask:ScreenMask;
	public var sceneLayer:SceneLayer;
	public var strandFrontLayer:Sprite;
	public var strandFrontMask:ScreenMask;
	public var cumLayer:Sprite;
	public var cumLayerMask:ScreenMask;
	public var screenEffects:ScreenEffects;
	public var uiLayer:Sprite;
	public var menuLayer:Sprite;
	public var sceneMask:ScreenMask;
	// public var menuBG:MenuBackground;
	// public var mainMenu:Menu;
	public var fadingBG:Bool = false;
	// public var clickPrompt:ClickPrompt;
	public var currentMousePos:Point = new Point();
	public var mouseScrollDeltas:Array<Float> = new Array<Float>();
	// public var debug:TextField;
	// public var debugBar:DebugBar;
	// public var debugAnimationMode:UInt = 0;
	// public var HighlightFilter:Class<Dynamic>;

	var arrowKeyUp:Bool;
	var arrowKeyDown:Bool;
	var container:Sprite;

	public function new() {
		super();

        @:privateAccess openfl.Lib.current.stage.__renderer.__roundPixels = true;
        @:privateAccess openfl.Lib.current.stage.__renderer.__allowSmoothing = true;
        stage.quality = StageQuality.BEST;
        stage.scaleMode = StageScaleMode.NO_BORDER;
        stage.frameRate = 180;
        stage.addEventListener(Event.RESIZE, resizeDisplay);

		Assets.loadLibrary("sdt").onComplete(onLoaded);
	}

	public function onLoaded(library: AssetLibrary) {
		trace("SWF library loaded");

		initGame();

		// this.preloaderBG = new MenuBackground();
		// addChild(this.preloaderBG);
		// this.preloadDisplay = new PreloadDisplay();
		// this.preloadDisplay.bar.scaleX = 0;
		// this.preloadDisplay.x = 350;
		// this.preloadDisplay.y = 300;
		// addChild(this.preloadDisplay);
		// this.loaderInfo.addEventListener(ProgressEvent.PROGRESS, this.updatePreloader);
		// this.loaderInfo.addEventListener(Event.COMPLETE, this.completePreloader);
		// G.highlightShader = new Shader(new this.HighlightFilter() as ByteArray);
		// G.highlight = new ShaderFilter(G.highlightShader);
		// G.highlightShader.data.trans.value = [0.275];
		// G.highlightShader.data.totMult.value = [0.2];
		// G.cumHighlightShader = new Shader(new this.HighlightFilter() as ByteArray);
		// G.cumHighlight = new ShaderFilter(G.cumHighlightShader);
		// G.cumHighlightShader.data.trans.value = [1.1];
		// G.cumHighlightShader.data.totMult.value = [0.5];
		// try {
		// 	this.initContextMenu();
		// } catch (e) {}
	}

	function go(lib:MovieClip) {
		lib.stop();
		var length = lib.numChildren;
		var i = 0;
		while (i < length) {
			var value = lib.getChildAt(i);
			if (Std.isOfType(value, MovieClip)) {
				trace(i + " " + value);
				go(cast(value, MovieClip));
			}
			i += 1;
		}
	}

      public function initGame()
      {
         G.stageRef = this;

         G.container = new Sprite();
         addChild(G.container);

         G.animationControl = new AnimationControl();
         G.getStrandControl();
         G.getSoundControl();
         G.getCharacterControl();
         G.getAutomaticControl();
         G.getDialogue();

         G.bg = new Background();
         this.sceneLayer = G.newSceneLayer(G.defaultZoom);
         G.newHim();
         G.newHer();

         // this.customElementLoader = G.getCustomElementLoader();
         G.shadow = new DropShadowFilter(1,-90,13288100,1,5,5,1.5,1,true);

//         G.spitShaders = [G.highlight];
//         G.cumShaders = [G.cumHighlight,G.shadow];
//
         this.bgLayer = new Sprite();
         G.container.addChild(this.bgLayer);
         this.bgLayer.addChild(G.bg);

         G.backLayer = new Sprite();
         G.container.addChild(G.backLayer);
         var _loc1_= new ScreenMask();
         G.container.addChild(_loc1_);
         G.backLayer.mask = _loc1_;

         G.mistLayer = new Sprite();
         G.container.addChild(G.mistLayer);

         this.strandBackLayer = new Sprite();
         G.strandBackLayer = this.strandBackLayer;
         G.container.addChild(this.strandBackLayer);
         this.strandBackMask = new ScreenMask();
         G.container.addChild(this.strandBackMask);
         this.strandBackLayer.mask = this.strandBackMask;
//         this.strandBackLayer.filters = G.spitShaders;

         this.sceneLayer.aimCamera(200,50);
         G.container.addChild(this.sceneLayer);

         this.sceneMask = new ScreenMask();
         G.container.addChild(this.sceneMask);
         this.sceneLayer.mask = this.sceneMask;

         var _loc2_= new HimArmContainer();
         G.backLayer.addChild(_loc2_);

         var _loc3_= new HairBackContainer();
         G.backLayer.addChild(_loc3_);
         G.hairBackContainer = _loc3_;
         G.hairBackLayer = _loc3_.hairBackLayer;
         G.hairBack = _loc3_.hairBack;

         var _loc4_= new HerLeftArmContainer();
         this.sceneLayer.addChild(_loc4_);

         G.hairCostumeBack = new HairCostumeBack();
         this.sceneLayer.addChild(G.hairCostumeBack);
         this.sceneLayer.addChild(G.him);
         this.sceneLayer.addChild(G.her);
         G.her.giveHairBackContainer(_loc3_);

         G.himOverLayer = new HimOverLayer();
         G.him.giveOverLayer(G.himOverLayer);

         var _loc5_= new HimLeftArmContainer();
         G.himOverLayer.addChild(_loc5_);
         G.him.giveHimLeftArm(_loc5_);
         G.him.giveHimArm(_loc2_);

         this.strandFrontLayer = new Sprite();
         this.strandFrontLayer.mouseEnabled = false;
         this.strandFrontLayer.mouseChildren = false;
         G.strandFrontLayer = this.strandFrontLayer;
         G.container.addChild(this.strandFrontLayer);

         this.strandFrontMask = new ScreenMask();
         G.container.addChild(this.strandFrontMask);
         this.strandFrontLayer.mask = this.strandFrontMask;
//         this.strandFrontLayer.filters = G.spitShaders;

         this.cumLayer = new Sprite();
         this.cumLayer.mouseEnabled = false;
         this.cumLayer.mouseChildren = false;
         G.cumLayer = this.cumLayer;
         G.container.addChild(this.cumLayer);

         this.cumLayerMask = new ScreenMask();
         G.container.addChild(this.cumLayerMask);
         this.cumLayer.mask = this.cumLayerMask;
//         this.cumLayer.filters = G.cumShaders;

         G.frontLayer = new Sprite();
         G.container.addChild(G.frontLayer);

         var _loc6_= new HerRightArmContainer();
         var _loc7_= new HerRightArmEraseContainer();
         var _loc8_= new HerRightForeArmContainer();
         var _loc9_= new LeftHandOver();
         G.hairCostumeUnderOver = new Sprite();
         G.hairOverLayer = new Sprite();
         G.hairOverContainer = new Sprite();
         G.hairCostumeOver = new HairCostumeOver();
         G.hairTop = G.her.hairTop;
         G.her.removeChild(G.hairTop);
         G.frontLayer.addChild(_loc6_);
         G.hairOverContainer.addChild(G.hairTop);
         G.hairOverContainer.addChild(G.hairOverLayer);
         G.frontLayer.addChild(G.hairCostumeUnderOver);
         G.frontLayer.addChild(G.hairOverContainer);
         G.frontLayer.addChild(G.hairCostumeOver);
         G.frontLayer.addChild(_loc8_);
         G.frontLayer.addChild(_loc9_);
         G.frontLayer.addChild(G.himOverLayer);
         G.him.addChild(_loc7_);
         _loc7_.blendMode = BlendMode.ERASE;
         G.him.blendMode = BlendMode.LAYER;
         G.her.giveArmContainers(_loc4_,_loc6_,_loc8_,_loc7_,_loc9_);

         G.her.setupTan();

         this.sceneLayer.giveExternalLayer(G.backLayer);
         this.sceneLayer.giveExternalLayer(G.frontLayer);
         this.sceneLayer.giveExternalLayer(this.strandBackLayer);
         this.sceneLayer.giveExternalLayer(this.strandFrontLayer);
         this.sceneLayer.giveExternalLayer(this.cumLayer);

         var _loc10_= new ScreenMask();
         G.container.addChild(_loc10_);
         G.frontLayer.mask = _loc10_;

         this.screenEffects = new ScreenEffects();
         this.screenEffects.mouseEnabled = false;
         this.screenEffects.mouseChildren = false;
         G.screenEffects = this.screenEffects;
         G.container.addChild(this.screenEffects);

         G.getEraseItems(G.container);

         this.menuLayer = new Sprite();
         G.container.addChild(this.menuLayer);

         // this.menuBG = new MenuBackground();
         // this.menuBG.mouseEnabled = false;
         // this.menuLayer.addChild(this.menuBG);
         // this.mainMenu = new Menu();
         // this.menuLayer.addChild(this.mainMenu);

         this.uiLayer = new Sprite();
         G.container.addChild(this.uiLayer);

         // this.clickPrompt = new ClickPrompt();
         // this.clickPrompt.x = 675;
         // this.clickPrompt.y = 590;
         // G.clickPrompt = this.clickPrompt;
         // this.uiLayer.addChild(this.clickPrompt);

         // G.container.addChild(G.dialogueControl);

         G.newInGameMenu();
         // this.customElementLoader.addListeners();
         G.container.addChild(G.inGameMenu);
         // this.customElementLoader.prepareModTargetElementsDictionary();

         G.characterControl.registerComponents();

         // G.dialogueEditor = new DialogueEditor();
         // G.container.addChild(G.dialogueEditor);

         var fps_mem = new com.kircode.debug.FPS_Mem(10, 10, 0x0000FF);
         G.container.addChild(fps_mem);

         this.addEventListener(Event.ENTER_FRAME,this.tick);
         this.addEventListener(MouseEvent.MOUSE_DOWN,this.mousePressed);
         this.addEventListener(MouseEvent.MOUSE_UP,this.mouseReleased);
         this.addEventListener(MouseEvent.MOUSE_MOVE,this.mouseMoved);
         this.addEventListener(MouseEvent.MOUSE_WHEEL,this.mouseWheel);

         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyPressed);
         stage.addEventListener(KeyboardEvent.KEY_UP,this.keyReleased);
         stage.addEventListener(Event.MOUSE_LEAVE,this.mouseLeft);

         // this.mainMenu.buttonPlay.addEventListener(MouseEvent.CLICK,this.playClicked);
         // this.mainMenu.buttonOptions.addEventListener(MouseEvent.CLICK,this.optionsClicked);

         G.newSaveData();

         if(G.saveData.saveExists())
         {
            G.characterControl.initChar(false);
            G.characterControl.initHim();
            G.saveData.loadCurrentData();
         }
         else
         {
            G.characterControl.initChar();
            G.characterControl.initHim();
            G.saveData.saveOptionsData();
            G.saveData.saveCharOptionsData();
            // G.inGameMenu.characterMenu.updateCharOrder(G.characterControl.defaultCharOrder);
         }

         G.saveData.updatePlayCounter();
         this.openMainMenu();

         G.her.initialise();

         // ----------------------------------------

         // TEMP
         G.her.tan.setTan(1);

         // Disable some expensive features
         // Hopefully these can be moved to shaders
         G.strandControl.maxStrands = 1;
         G.tears = false;
         G.mascara = false;
         G.sweat = false;

         // Setup masking for her eye
         // Uses GL masking this time
         var eyeMask = new Sprite();
         eyeMask.name = "eyeMask";
         eyeMask.addChild(G.her.eye.ball.lowerEyelidMask);
         eyeMask.addChild(G.her.eye.ball.upperEyelidMask);
         G.her.eye.ball.addChild(eyeMask);
         G.her.eye.eyebrowUnderMask.mask = G.her.eye.eyebrowMask;
         G.her.eye.ball.mask = eyeMask;
         G.her.eye.ball.maskInverted = true;
         G.her.eye.ball.irisContainer.iris.mask = eyeMask;
         G.her.eye.ball.irisContainer.iris.maskInverted = true;

         // Disable bitmap caching for her back
         // I don't know why but only her back glitches out after a while
         G.her.torso.back.cacheAsBitmap = false;
         G.her.torso.backMask.cacheAsBitmap = false;
         G.her.head.cacheAsBitmap = false;
         G.her.head.neck.cacheAsBitmap = true;

#if js
         untyped js.Browser.console.log($hxClasses);
         js.Browser.console.log(this);
#end

         startGame();
      }

      public function startGame()
      {
         if(!G.showMouse)
         {
            Mouse.hide();
         }
         G.soundControl.startBreathing();
         this.currentMousePos = new Point(700,0);
         G.gameRunning = true;
      }

      public function tick(param1:Event)
      {
         var cursorX: Float = 0;
         // if(this.fadingBG)
         // {
         //    this.menuBG.alpha -= 0.025;
         //    if(this.menuBG.alpha <= 0)
         //    {
         //       this.menuBG.alpha = 0;
         //       this.menuBG.visible = false;
         //       this.fadingBG = false;
         //    }
         // }
         if(G.gameRunning)
         {
            if(!G.gamePaused)
            {
               if(!G.controlLocked)
               {
                  var isFF = G.animationControl.currentAnimationName == AnimationControl.FACE_FUCK;
                  if((G.mirrored || G.invertControls) && !(G.mirrored && G.invertControls))
                  {
                     cursorX = G.screenSize.x - this.currentMousePos.x;
                  }
                  else
                  {
                     cursorX = this.currentMousePos.x;
                  }
                  cursorX = (cursorX - 100) / 500;
                  G.currentMousePos.x = Math.min(1.2,cursorX);
                  G.currentMousePos.y = Math.max(-1,Math.min(1,(this.currentMousePos.y - 100) / 200 - 1));
                  if(G.autoModeOn)
                  {
                     G.currentPos = G.automaticControl.getPos().clone();
                  }
                  else
                  {
                     G.currentPos = G.currentMousePos.clone();
                  }
               }
               G.animationControl.stepAnimation();
               G.dialogueControl.update();
            }
            G.soundControl.tick();
            G.characterControl.tick();
         }
      }

      public function playClicked(param1:MouseEvent)
      {
         this.closeMainMenu();
         this.startGame();
      }

      public function optionsClicked(param1:MouseEvent)
      {
         G.inGameMenu.openMenu(true);
      }

      public function mousePressed(param1:MouseEvent)
      {
         if(G.gameRunning && !G.gamePaused)
         {
            G.her.mousePressed(param1);
            G.her.activeHold();
            if(G.bukkakeMode)
            {
               G.him.startBMSpurt();
            }
         }
      }

      public function mouseReleased(param1:MouseEvent)
      {
         if(G.gameRunning && !G.gamePaused)
         {
            G.her.mouseReleased(param1);
            G.him.stopBMSpurt();
         }
         G.inGameMenu.mouseReleased(param1);
      }

      public function mouseMoved(param1:MouseEvent)
      {
         if(!G.shiftDown && !G.controlLocked)
         {
            this.currentMousePos.x = mouseX;
            this.currentMousePos.y = mouseY;
         }
         G.inGameMenu.mouseMoved(mouseX,mouseY);
      }

      public function mouseLeft(param1:Event)
      {
         if(!G.shiftDown && !G.controlLocked)
         {
            if(this.currentMousePos.x > G.screenSize.x / 2 + 200)
            {
               this.currentMousePos.x = G.screenSize.x;
            }
            else if(this.currentMousePos.x < G.screenSize.x / 2 - 200)
            {
               this.currentMousePos.x = 0;
            }
         }
      }

      public function mouseWheel(param1:MouseEvent)
      {
         var _loc2_= param1.delta > 0.5 ? 8 : (param1.delta < -0.5 ? -8 : 0);
         // if(G.overScrollArea != null)
         // {
         //    G.overScrollArea.mouseWheelScroll(_loc2_);
         // }
         /*else*/ if(_loc2_ > 0)
         {
            G.sceneLayer.zoomIn(0.05);
            G.saveData.saveOptionsData();
         }
         else if(_loc2_ < 0)
         {
            G.sceneLayer.zoomOut(0.05);
            G.saveData.saveOptionsData();
         }
      }

      public function keyReleased(param1:KeyboardEvent)
      {
         switch(param1.keyCode)
         {
            case 16:
               if(!G.controlLocked)
               {
                  this.currentMousePos.x = mouseX;
                  this.currentMousePos.y = mouseY;
               }
               G.shiftDown = false;

            case 17:
               G.ctrlDown = false;
         }
      }

      public function keyPressed(param1:KeyboardEvent)
      {
         switch(param1.keyCode)
         {
            case Keyboard.SHIFT:
               G.shiftDown = true;

            case Keyboard.CONTROL:
               G.ctrlDown = true;
         }
         if(!G.inTextField && !G.controlLocked)
         {
            switch(param1.keyCode)
            {
               case Keyboard.SLASH:
                  if(G.shiftDown)
                  {
                     G.inGameMenu.shuffle();
                  }
                  else
                  {
                     G.takeScreenShot();
                  }

               case Keyboard.SPACE:
                  G.her.activeHold();

               case Keyboard.A:
                  G.toggleAutoMode();
                  G.inGameMenu.setCBAuto();

               case Keyboard.P:
                  G.inGameMenu.toggleMenu(true,5);

               case Keyboard.O:
                  G.inGameMenu.toggleMenu(true,4);

               case Keyboard.I:
                  G.inGameMenu.toggleMenu(true,3);

               case Keyboard.U:
                  G.inGameMenu.toggleMenu(true,2);

               case Keyboard.Y:
                  G.inGameMenu.toggleMenu(true,1);

               case Keyboard.C:
                  G.characterControl.nextCharacter();

               case Keyboard.X:
                  G.characterControl.prevCharacter();

               case Keyboard.B:
                  G.characterControl.toggleBackground();
                  G.saveData.saveCharData();

               case Keyboard.H:
                  G.characterControl.toggleHim();
                  G.saveData.saveCharData();

               case Keyboard.K:
                  G.her.swallow();

               case Keyboard.T:
                  G.characterControl.toggleBreasts();
                  G.saveData.saveCharData();

               case Keyboard.S:
                  G.characterControl.toggleSkin();
                  G.saveData.saveCharData();

               case Keyboard.J:
                  G.him.ejaculate();

               case Keyboard.MINUS
                  | Keyboard.NUMPAD_SUBTRACT:
                  G.sceneLayer.zoomOut();
                  G.saveData.saveOptionsData();

               case Keyboard.EQUAL
                  | Keyboard.NUMPAD_ADD:
                  G.sceneLayer.zoomIn();
                  G.saveData.saveOptionsData();

               case Keyboard.COMMA:
                  G.soundControl.decreaseVolume();
                  G.saveData.saveOptionsData();

               case Keyboard.PERIOD:
                  G.soundControl.increaseVolume();
                  G.saveData.saveOptionsData();

               case Keyboard.M:
                  G.soundControl.toggleMute();
                  G.saveData.saveOptionsData();

               case Keyboard.Q:
                  G.toggleQuality();
                  G.saveData.saveOptionsData();
            }
         }
      }

      public function closeMainMenu()
      {
         // this.fadingBG = true;
         // this.mainMenu.visible = false;
         // this.mainMenu.enabled = false;
      }

      public function openMainMenu()
      {
         if(G.introSound)
         {
            G.soundControl.playIntro();
         }
         // this.mainMenu.visible = true;
         // this.mainMenu.enabled = true;
      }

      // public function initContextMenu()
      // {
      //    G.defaultCM = new ContextMenu();
      //    G.defaultCM.hideBuiltInItems();
      //    G.defaultCM.builtInItems.quality = true;
      //    G.defaultCM.builtInItems.print = true;
      //    var _loc1_= new ContextMenuItem("Kona ~ Modguy",false,false);
      //    G.defaultCM.customItems.push(_loc1_);
      //    var _loc2_= new ContextMenuItem(G.ver,false,false);
      //    G.defaultCM.customItems.push(_loc2_);
      //    this.contextMenu = G.defaultCM;
      // }

      // public function updatePreloader(param1:ProgressEvent)
      // {
      //    var _loc2_= param1.bytesLoaded / param1.bytesTotal;
      //    this.preloadDisplay.bar.scaleX = _loc2_;
      // }

      // public function completePreloader(param1:Event)
      // {
      //    removeChild(this.preloadDisplay);
      //    this.loaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.updatePreloader);
      //    this.loaderInfo.removeEventListener(Event.COMPLETE,this.completePreloader);
      //    var _loc2_= new Timer(1000,1);
      //    _loc2_.addEventListener(TimerEvent.TIMER_COMPLETE,this.loadDelayDone);
      //    _loc2_.start();
      //    // gotoAndStop(1,"Main");
      //    this.initGame();
      // }

      // public function loadDelayDone(param1:TimerEvent)
      // {
      //    this.saveData.loadCustomChars();
      //    param1.target.stop();
      //    param1.target.removeEventListener(TimerEvent.TIMER_COMPLETE,this.loadDelayDone);
      // }
    private function resizeDisplay(event:Event) {
        // var stageScaleX:Float = stage.stageWidth / G.screenSize.x;
        // var stageScaleY:Float = stage.stageHeight / G.screenSize.y;

        // var stageScale:Float = Math.min(stageScaleX, stageScaleY);

        // openfl.Lib.current.x = 0;
        // openfl.Lib.current.y = 0;
        // openfl.Lib.current.scaleX = stageScale;
        // openfl.Lib.current.scaleY = stageScale;

        // if (stageScaleX > stageScaleY) {
        //     openfl.Lib.current.x = (stage.stageWidth - G.screenSize.x * stageScale) / 2;
        // } else {
        //     openfl.Lib.current.y = (stage.stageHeight - G.screenSize.y * stageScale) / 2;
        // }
    }
}
