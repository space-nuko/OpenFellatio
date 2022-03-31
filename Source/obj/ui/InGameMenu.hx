package obj.ui;

import openfl.display.DisplayObject;
import openfl.display.Loader;
import openfl.display.MovieClip;
import openfl.display.StageQuality;
import openfl.events.Event;
import openfl.events.FocusEvent;
import openfl.events.IOErrorEvent;
import openfl.events.MouseEvent;
import openfl.geom.ColorTransform;
import openfl.net.FileReference;
import openfl.ui.Mouse;
import openfl.utils.ByteArray;
// import obj.animation.AnimationControl;
import obj.dialogue.DialogueLibrary;
// import obj.graphics.PaletteUtils;
// import obj.ui.ScrollingArea;
import feathers.controls.*;
import feathers.layout.*;
import feathers.events.*;

class InGameMenu extends MovieClip {
    public var lipstickSwatch:Array<AlphaRGBObject> = [
        new AlphaRGBObject(0, 0, 0, 0),
        new AlphaRGBObject(1, 84, 0, 6),
        new AlphaRGBObject(1, 197, 64, 109),
        new AlphaRGBObject(1, 255, 167, 188),
        new AlphaRGBObject(1, 232, 188, 242),
        new AlphaRGBObject(1, 105, 39, 178),
        new AlphaRGBObject(1, 63, 118, 162),
        new AlphaRGBObject(1, 0, 0, 0),
        new AlphaRGBObject(1, 255, 255, 255)
    ];
    public var irisSwatch:Array<AlphaRGBObject> = [
        new AlphaRGBObject(0, 0, 0, 0),
        new AlphaRGBObject(1, 56, 100, 137),
        new AlphaRGBObject(1, 66, 90, 120),
        new AlphaRGBObject(1, 46, 111, 100),
        new AlphaRGBObject(1, 23, 57, 102),
        new AlphaRGBObject(1, 71, 18, 28),
        new AlphaRGBObject(1, 62, 39, 29),
        new AlphaRGBObject(1, 70, 100, 37),
        new AlphaRGBObject(1, 0, 0, 0)
    ];
    public var eyebrowSwatch:Array<AlphaRGBObject> = [
        new AlphaRGBObject(0, 0, 0, 0),
        new AlphaRGBObject(1, 89, 67, 51),
        new AlphaRGBObject(1, 189, 142, 61),
        new AlphaRGBObject(1, 87, 53, 32),
        new AlphaRGBObject(1, 105, 121, 137),
        new AlphaRGBObject(1, 33, 33, 51),
        new AlphaRGBObject(1, 50, 34, 33),
        new AlphaRGBObject(1, 0, 0, 0),
        new AlphaRGBObject(1, 255, 255, 255)
    ];
    public var eyeShadowSwatch:Array<AlphaRGBObject> = [
        new AlphaRGBObject(0, 0, 0, 0),
        new AlphaRGBObject(1, 55, 26, 99),
        new AlphaRGBObject(1, 124, 20, 178),
        new AlphaRGBObject(1, 24, 12, 90),
        new AlphaRGBObject(1, 255, 48, 109),
        new AlphaRGBObject(1, 0, 66, 137),
        new AlphaRGBObject(1, 16, 58, 24),
        new AlphaRGBObject(1, 0, 0, 0),
        new AlphaRGBObject(1, 255, 255, 255)
    ];
    public var blushSwatch:Array<AlphaRGBObject> = [new AlphaRGBObject(0.35, 196, 80, 77)];
    public var legwearSwatch:Array<AlphaRGBObject> = [
        new AlphaRGBObject(0, 0, 0, 0),
        new AlphaRGBObject(1, 22, 8, 0),
        new AlphaRGBObject(1, 82, 0, 6),
        new AlphaRGBObject(0.8, 255, 126, 167),
        new AlphaRGBObject(1, 0, 26, 114),
        new AlphaRGBObject(0.9, 74, 20, 126),
        new AlphaRGBObject(1, 63, 118, 162),
        new AlphaRGBObject(1, 0, 0, 0),
        new AlphaRGBObject(0.8, 255, 255, 255)
    ];
    public var underwearSwatch:Array<AlphaRGBObject>;
    public var currentSwatch:Array<AlphaRGBObject>;

    public var irisTypes:Array<String>;
    public var skinTypes:Array<String>;

    public var menuOpen:Bool = false;
    public var menuOver:Bool = false;
    public var overTimer:UInt = 0;
    public var offTimer:Int = 0;
    public var openDelay:UInt = 15;
    public var closeDelay:UInt = 15;
    public var currentTab:UInt = 1;

    public var drawer: Drawer;

    public function new() {
        super();

        this.underwearSwatch = this.lipstickSwatch.slice(1);
        this.underwearSwatch.insert(-2, new AlphaRGBObject(1, 128, 128, 128));

        this.blushSwatch = this.eyeShadowSwatch.copy();
        this.blushSwatch[0] = new AlphaRGBObject(0.35, 196, 80, 77);

        // TODO

        G.her.setMenu(null, null);

        this.drawer = new Drawer();
        G.container.addChild(drawer);

		// var content = new Panel();
		// var contentLayout = new VerticalLayout();
		// contentLayout.paddingTop = 10.0;
		// contentLayout.paddingRight = 10.0;
		// contentLayout.paddingBottom = 10.0;
		// contentLayout.paddingLeft = 10.0;
		// contentLayout.gap = 10.0;
		// contentLayout.horizontalAlign = CENTER;
		// contentLayout.verticalAlign = MIDDLE;
		// content.layout = contentLayout;

		// var header = new Header();
		// header.text = "Drawer";
		// content.header = header;

		// var backButton = new Button();
		// backButton.text = "Back";
		// backButton.layoutData = AnchorLayoutData.middleLeft(0.0, 10.0);
		// header.leftView = backButton;

		// var openButton = new Button();
		// openButton.text = "Open Drawer";
		// openButton.addEventListener(TriggerEvent.TRIGGER, (event) -> { this.drawer.opened = true; });
		// content.addChild(openButton);

        // this.drawer.content = content;

		var drawer = new Panel();
		var drawerLayout = new VerticalLayout();
		drawerLayout.paddingTop = 10.0;
		drawerLayout.paddingRight = 10.0;
		drawerLayout.paddingBottom = 10.0;
		drawerLayout.paddingLeft = 10.0;

		drawerLayout.horizontalAlign = CENTER;
		drawerLayout.verticalAlign = MIDDLE;
		drawer.layout = drawerLayout;

		var closeButton = new Button();
		closeButton.text = "Close Drawer";
		closeButton.addEventListener(TriggerEvent.TRIGGER, (event) -> { this.drawer.closed = true; });
		drawer.addChild(closeButton);

        this.drawer.drawer = drawer;
        this.drawer.pullableEdge = RelativePosition.BOTTOM;

        this.drawer.addEventListener(FeathersEvent.CLOSING, (event) -> { this.closeMenu(); });
        this.drawer.overlaySkin = null;
        this.drawer.swipeOpenEnabled = true;
        this.drawer.swipeCloseEnabled = true;
        this.drawer.simulateTouch = true;

         // var _loc1_:UInt = 0;
         // while(_loc1_ <= 8)
         // {
         //    (this.rgbPicker : ASAny)["swatch" + _loc1_].cross.visible = false;
         //    _loc2_ = this.getSwatchHandler(_loc1_);
         //    (this.rgbPicker : ASAny)["swatch" + _loc1_].addEventListener(MouseEvent.CLICK,_loc2_);
         //    _loc1_++;
         // }
         // this.rgbPicker.visible = false;
         // this.rgbPicker.rSlider.giveLabel(this.rgbPicker.rLabel);
         // this.rgbPicker.gSlider.giveLabel(this.rgbPicker.gLabel);
         // this.rgbPicker.bSlider.giveLabel(this.rgbPicker.bLabel);
         // this.rgbPicker.alphaControls.aSlider.giveLabel(this.rgbPicker.alphaControls.aLabel);
         // this.hslPicker.visible = false;
         // this.hslPicker.swatch0.cross.visible = true;
         // this.hslPicker.swatch0.swatchFill.alpha = 0;
         // this.hslPicker.hSlider.giveLabel(this.hslPicker.hLabel);
         // this.hslPicker.sSlider.giveLabel(this.hslPicker.sLabel);
         // this.hslPicker.lSlider.giveLabel(this.hslPicker.lLabel);
         // this.hslPicker.cSlider.giveLabel(this.hslPicker.cLabel);
         // this.hslPicker.hSlider.setLabelRange(-180,360);
         // this.hslPicker.sSlider.setLabelRange(0,400);
         // this.hslPicker.lSlider.setLabelRange(0,400);
         // this.hslPicker.cSlider.setLabelRange(0,400);
         // this.hslPicker.swatch0.addEventListener(MouseEvent.CLICK,this.hslRemoveClicked);
         // this.tabLabels.mouseEnabled = false;
         // this.tabLabels.mouseChildren = false;
         // this.addEventListener(Event.ENTER_FRAME,this.tick);
         // this.addEventListener(MouseEvent.ROLL_OVER,this.rolledOver);
         // this.addEventListener(MouseEvent.ROLL_OUT,this.rolledOut);
         // this.addEventListener(MouseEvent.CLICK,this.menuClicked);
         // this.menuDrawerLip.arrow.addEventListener(MouseEvent.CLICK,this.drawerArrowClicked);
         // this.tab1.addEventListener(MouseEvent.CLICK,this.tab1Clicked);
         // this.tab2.addEventListener(MouseEvent.CLICK,this.tab2Clicked);
         // this.tab3.addEventListener(MouseEvent.CLICK,this.tab3Clicked);
         // this.tab4.addEventListener(MouseEvent.CLICK,this.tab4Clicked);
         // this.tab5.addEventListener(MouseEvent.CLICK,this.tab5Clicked);
         // this.closeButton.addEventListener(MouseEvent.CLICK,this.closeClicked);
         // this.characterMenu.closeButton.addEventListener(MouseEvent.CLICK,this.characterMenuCloseClicked);
//         // this.characterMenu.giveButton(this.sceneMenu.mbCharacterMenu);
         // this.charNames = g.characterControl.getCharacterList();
         // this.characterMenu.instanceBaseChars(this.charNames);
         // this.characterMenu.visible = false;
//         // this.sceneMenu.mbCharacterMenu.addEventListener(MouseEvent.CLICK,this.mbCharacterMenuClicked);
         // _loc1_ = 1;
         // while(_loc1_ <= g.bgNum)
         // {
         //    _loc3_ = this.getBGHandler(_loc1_);
//         //    this.sceneMenu["cbBG" + _loc1_].addEventListener(MouseEvent.CLICK,_loc3_);
         //    _loc1_++;
         // }
//         // this.sceneMenu.cbStyle1.addEventListener(MouseEvent.CLICK,this.style1Clicked);
//         // this.sceneMenu.cbStyle2.addEventListener(MouseEvent.CLICK,this.style2Clicked);
//         // this.sceneMenu.cbMoodNormal.addEventListener(MouseEvent.CLICK,this.moodNormalClicked);
//         // this.sceneMenu.cbMoodHappy.addEventListener(MouseEvent.CLICK,this.moodHappyClicked);
//         // this.sceneMenu.cbMoodAngry.addEventListener(MouseEvent.CLICK,this.moodAngryClicked);
//         // this.sceneMenu.cbMoodAhegao.addEventListener(MouseEvent.CLICK,this.moodAhegaoClicked);
//         // this.sceneMenu.zoomSlider.setRangeEnd(75);
//         // this.sceneMenu.zoomSlider.addEventListener("handleReleased",this.zoomSliderReleased);
//         // this.sceneMenu.zoomSlider.addEventListener("sliderChanged",this.zoomSliderChanged);
//         // this.sceneMenu.mbDefaultZoom.addEventListener(MouseEvent.CLICK,this.mbDefaultZoomClicked);
////         // this.himMenu = this.sceneMenu.himMenu;
//         // HimBody.bodyMenuContainer = this.himMenu.bodyMenuContainer;
//         // this.himMenuScroller = new ScrollingArea(200,180,this.himMenu,60);
//         // this.himMenuScroller.x = 135;
//         // this.himMenuScroller.y = -91;
////         // this.sceneMenu.addChild(this.himMenuScroller);
//         // g.him.setHimMenu(this.himMenu,this.underwearSwatch);
//         // this.himMenu.penisLengthSlider.setRangeEnd(98);
//         // this.himMenu.penisLengthSlider.addEventListener("handleReleased",this.penisLengthSliderReleased);
//         // this.himMenu.penisLengthSlider.addEventListener("sliderChanged",this.penisLengthSliderChanged);
//         // this.himMenu.mbDefaultPenisLength.addEventListener(MouseEvent.CLICK,this.mbDefaultPenisLengthClicked);
//         // this.himMenu.penisWidthSlider.setRangeEnd(98);
//         // this.himMenu.penisWidthSlider.addEventListener("handleReleased",this.penisWidthSliderReleased);
//         // this.himMenu.penisWidthSlider.addEventListener("sliderChanged",this.penisWidthSliderChanged);
//         // this.himMenu.mbDefaultPenisWidth.addEventListener(MouseEvent.CLICK,this.mbDefaultPenisWidthClicked);
//         // this.himMenu.mlBody.leftArrow.addEventListener(MouseEvent.CLICK,this.hisBodyLeftClicked);
//         // this.himMenu.mlBody.rightArrow.addEventListener(MouseEvent.CLICK,this.hisBodyRightClicked);
//         // this.himMenu.mlHisArm.leftArrow.addEventListener(MouseEvent.CLICK,this.hisArmLeftClicked);
//         // this.himMenu.mlHisArm.rightArrow.addEventListener(MouseEvent.CLICK,this.hisArmRightClicked);
//         // this.himMenu.mlHisLeftArm.leftArrow.addEventListener(MouseEvent.CLICK,this.hisLeftArmLeftClicked);
//         // this.himMenu.mlHisLeftArm.rightArrow.addEventListener(MouseEvent.CLICK,this.hisLeftArmRightClicked);
//         // this.himMenu.mlBalls.leftArrow.addEventListener(MouseEvent.CLICK,this.ballsLeftClicked);
//         // this.himMenu.mlBalls.rightArrow.addEventListener(MouseEvent.CLICK,this.ballsRightClicked);
//         // this.himMenu.ballSizeSlider.setRangeEnd(98);
//         // this.himMenu.ballSizeSlider.addEventListener("handleReleased",this.ballSizeSliderReleased);
//         // this.himMenu.ballSizeSlider.addEventListener("sliderChanged",this.ballSizeSliderChanged);
//         // this.himMenu.mbDefaultBallSize.addEventListener(MouseEvent.CLICK,this.mbDefaultBallSizeClicked);
//         // this.costumeMenu = this.sceneMenu.costumeMenu;
         // this.costumeMenuScroller = new ScrollingArea(220,180,this.costumeMenu,60);
         // this.costumeMenuScroller.x = -98;
         // this.costumeMenuScroller.y = -91;
//         // this.sceneMenu.addChild(this.costumeMenuScroller);
         // g.her.setMenu(this.costumeMenu,this.underwearSwatch);
         // this.costumeMenu.resistanceSlider.setRangeEnd(119);
         // this.costumeMenu.resistanceSlider.addEventListener("handleReleased",this.resistanceSliderReleased);
         // this.costumeMenu.resistanceSlider.addEventListener("sliderChanged",this.resistanceSliderChanged);
         // this.costumeMenu.cbResetResistance.addEventListener(MouseEvent.CLICK,this.cbResetResistanceClicked);
         // this.costumeMenu.mbDefaultResistance.addEventListener(MouseEvent.CLICK,this.mbDefaultResistanceClicked);
         // this.costumeMenu.throatResistanceSlider.setRangeEnd(119);
         // this.costumeMenu.throatResistanceSlider.addEventListener("handleReleased",this.throatResistanceSliderReleased);
         // this.costumeMenu.throatResistanceSlider.addEventListener("sliderChanged",this.throatResistanceSliderChanged);
         // this.costumeMenu.mbDefaultThroatResistance.addEventListener(MouseEvent.CLICK,this.mbDefaultThroatResistanceClicked);
         // this.costumeMenu.mlLeftArm.leftArrow.addEventListener(MouseEvent.CLICK,this.leftArmLeftClicked);
         // this.costumeMenu.mlLeftArm.rightArrow.addEventListener(MouseEvent.CLICK,this.leftArmRightClicked);
         // this.costumeMenu.mlRightArm.leftArrow.addEventListener(MouseEvent.CLICK,this.rightArmLeftClicked);
         // this.costumeMenu.mlRightArm.rightArrow.addEventListener(MouseEvent.CLICK,this.rightArmRightClicked);
         // g.her.tan.registerMenuItems(this.costumeMenu.mlTan,this.costumeMenu.tanAlphaSlider);
         // this.costumeMenu.mbSelectCostume.addEventListener(MouseEvent.CLICK,this.selectCostumeClicked);
         // g.characterControl.collarControl.registerMenuList(this.costumeMenu.mlCollar);
         // g.characterControl.collarControl.registerRGBButton(this.costumeMenu.rgbCollar,this.underwearSwatch,256,false);
         // g.characterControl.collarControl.registerSecondaryRGBButton(this.costumeMenu.rgbCollar2,this.underwearSwatch,256,false);
         // g.characterControl.gagControl.registerMenuList(this.costumeMenu.mlGag);
         // g.characterControl.gagControl.registerRGBButton(this.costumeMenu.rgbGag,this.underwearSwatch,256,false);
         // g.characterControl.cuffsControl.registerMenuList(this.costumeMenu.mlCuffs);
         // g.characterControl.cuffsControl.registerRGBButton(this.costumeMenu.rgbCuffs,this.underwearSwatch,256,false);
         // g.characterControl.cuffsControl.registerSecondaryRGBButton(this.costumeMenu.rgbCuffs2,this.underwearSwatch,256,false);
         // g.characterControl.ankleCuffsControl.registerMenuList(this.costumeMenu.mlAnkleCuffs);
         // g.characterControl.ankleCuffsControl.registerRGBButton(this.costumeMenu.rgbAnkleCuffs,this.underwearSwatch,256,false);
         // g.characterControl.ankleCuffsControl.registerSecondaryRGBButton(this.costumeMenu.rgbAnkleCuffs2,this.underwearSwatch,256,false);
         // g.characterControl.armwearControl.registerMenuList(this.costumeMenu.mlArmwear);
         // g.characterControl.armwearControl.registerRGBButton(this.costumeMenu.rgbArmwear,this.underwearSwatch,256,false);
         // g.characterControl.topControl.registerMenuList(this.costumeMenu.mlTop);
         // g.characterControl.topControl.registerRGBButton(this.costumeMenu.rgbTop,this.underwearSwatch,256);
         // g.characterControl.bottomsControl.registerMenuList(this.costumeMenu.mlBottoms);
         // g.characterControl.bottomsControl.registerRGBButton(this.costumeMenu.rgbBottoms,this.underwearSwatch,256,false);
         // g.characterControl.bottomsControl.registerSecondaryRGBButton(this.costumeMenu.rgbBottoms2,this.underwearSwatch,256,false);
         // g.characterControl.legwearControl.registerMenuList(this.costumeMenu.mlLegwear);
         // g.characterControl.legwearControl.registerRGBButton(this.costumeMenu.rgbLegwear,this.legwearSwatch,256);
         // g.characterControl.legwearControl.registerSecondaryRGBButton(this.costumeMenu.rgbLegwear2,this.legwearSwatch,256);
         // g.characterControl.legwearBControl.registerMenuList(this.costumeMenu.mlLegwearB);
         // g.characterControl.legwearBControl.registerRGBButton(this.costumeMenu.rgbLegwearB,this.legwearSwatch,256);
         // g.characterControl.legwearBControl.registerSecondaryRGBButton(this.costumeMenu.rgbLegwearB2,this.legwearSwatch,256);
         // g.characterControl.footwearControl.registerMenuList(this.costumeMenu.mlFootwear);
         // g.characterControl.footwearControl.registerRGBButton(this.costumeMenu.rgbFootwear,this.underwearSwatch,256,false);
         // g.characterControl.footwearControl.registerSecondaryRGBButton(this.costumeMenu.rgbFootwear2,this.underwearSwatch,256,false);
         // g.characterControl.eyewearControl.registerMenuList(this.costumeMenu.mlEyewear);
         // g.characterControl.eyewearControl.registerRGBButton(this.costumeMenu.rgbEyewear,this.underwearSwatch,256,false);
         // g.characterControl.pantiesControl.registerMenuList(this.costumeMenu.mlPanties);
         // g.characterControl.pantiesControl.registerRGBButton(this.costumeMenu.rgbPanties,this.underwearSwatch,256,false);
         // g.characterControl.braControl.registerMenuList(this.costumeMenu.mlBra);
         // g.characterControl.braControl.registerRGBButton(this.costumeMenu.rgbBra,this.underwearSwatch,256,false);
         // g.characterControl.tonguePiercingControl.registerMenuList(this.costumeMenu.mlTonguePiercing);
         // g.characterControl.tonguePiercingControl.registerRGBButton(this.costumeMenu.rgbTonguePiercing,this.underwearSwatch,256,false);
         // g.characterControl.nipplePiercingControl.registerMenuList(this.costumeMenu.mlNipplePiercing);
         // g.characterControl.nipplePiercingControl.registerRGBButton(this.costumeMenu.rgbNipplePiercing,this.underwearSwatch,256,false);
         // g.characterControl.bellyPiercingControl.registerMenuList(this.costumeMenu.mlBellyPiercing);
         // g.characterControl.bellyPiercingControl.registerRGBButton(this.costumeMenu.rgbBellyPiercing,this.underwearSwatch,256,false);
         // g.characterControl.earringControl.registerMenuList(this.costumeMenu.mlEarring);
         // g.characterControl.earringControl.registerRGBButton(this.costumeMenu.rgbEarring,this.underwearSwatch,256,false);
         // g.characterControl.headwearControl.registerMenuList(this.costumeMenu.mlHeadwear);
         // g.characterControl.headwearControl.registerRGBButton(this.costumeMenu.rgbHeadwear,this.underwearSwatch,256,false);
         // g.characterControl.headwearControl.registerSecondaryRGBButton(this.costumeMenu.rgbHeadwear2,this.underwearSwatch,256,false);
//         // this.sceneMenu.cbAuto.addEventListener(MouseEvent.CLICK,this.cbAutoClicked);
//         // this.sceneMenu.mlAuto.leftArrow.addEventListener(MouseEvent.CLICK,this.autoLeftClicked);
//         // this.sceneMenu.mlAuto.rightArrow.addEventListener(MouseEvent.CLICK,this.autoRightClicked);
//         // this.customMenu.mlHair.leftArrow.addEventListener(MouseEvent.CLICK,this.hairLeftClicked);
//         // this.customMenu.mlHair.rightArrow.addEventListener(MouseEvent.CLICK,this.hairRightClicked);
//         // this.customMenu.mlIris.leftArrow.addEventListener(MouseEvent.CLICK,this.irisLeftClicked);
//         // this.customMenu.mlIris.rightArrow.addEventListener(MouseEvent.CLICK,this.irisRightClicked);
//         // this.customMenu.mlSkin.leftArrow.addEventListener(MouseEvent.CLICK,this.skinLeftClicked);
//         // this.customMenu.mlSkin.rightArrow.addEventListener(MouseEvent.CLICK,this.skinRightClicked);
//         // this.customMenu.mlNose.leftArrow.addEventListener(MouseEvent.CLICK,this.noseLeftClicked);
//         // this.customMenu.mlNose.rightArrow.addEventListener(MouseEvent.CLICK,this.noseRightClicked);
//         // this.customMenu.mlEar.leftArrow.addEventListener(MouseEvent.CLICK,this.earLeftClicked);
//         // this.customMenu.mlEar.rightArrow.addEventListener(MouseEvent.CLICK,this.earRightClicked);
//         // this.customMenu.mlEyebrows.leftArrow.addEventListener(MouseEvent.CLICK,this.eyebrowsLeftClicked);
//         // this.customMenu.mlEyebrows.rightArrow.addEventListener(MouseEvent.CLICK,this.eyebrowsRightClicked);
//         // this.customMenu.breastSlider.setRangeEnd(100);
//         // this.customMenu.breastSlider.addEventListener("handleReleased",this.breastSliderReleased);
//         // this.customMenu.breastSlider.addEventListener("sliderChanged",this.breastSliderChanged);
//         // this.customMenu.bodySlider.setRangeEnd(100);
//         // this.customMenu.bodySlider.addEventListener("handleReleased",this.bodySliderReleased);
//         // this.customMenu.bodySlider.addEventListener("sliderChanged",this.bodySliderChanged);
//         // this.customMenu.mbDefaultBodyScale.addEventListener(MouseEvent.CLICK,this.mbDefaultBodyScaleClicked);
//         // this.customMenu.mascaraSlider.setRangeEnd(70);
//         // this.customMenu.mascaraSlider.addEventListener("handleReleased",this.mascaraSliderReleased);
//         // this.customMenu.mascaraSlider.addEventListener("sliderChanged",this.mascaraSliderChanged);
//         // this.customMenu.mbDefaultMascara.addEventListener(MouseEvent.CLICK,this.defaultMascaraClicked);
//         // this.customMenu.frecklesSlider.setRangeEnd(70);
//         // this.customMenu.frecklesSlider.addEventListener("handleReleased",this.frecklesSliderReleased);
//         // this.customMenu.frecklesSlider.addEventListener("sliderChanged",this.frecklesSliderChanged);
//         // this.customMenu.mbDefaultFreckles.addEventListener(MouseEvent.CLICK,this.defaultFrecklesClicked);
//         // this.customMenu.rgbEyeShadow.addEventListener(MouseEvent.CLICK,this.rgbEyeShadowClicked);
//         // this.customMenu.rgbLipstick.addEventListener(MouseEvent.CLICK,this.rgbLipstickClicked);
//         // this.customMenu.rgbIris.addEventListener(MouseEvent.CLICK,this.rgbIrisClicked);
//         // this.customMenu.rgbEyebrowFill.addEventListener(MouseEvent.CLICK,this.rgbEyebrowFillClicked);
//         // this.customMenu.rgbEyebrowLine.addEventListener(MouseEvent.CLICK,this.rgbEyebrowLineClicked);
//         // this.customMenu.rgbSclera.addEventListener(MouseEvent.CLICK,this.rgbScleraClicked);
//         // this.customMenu.rgbBlush.addEventListener(MouseEvent.CLICK,this.rgbBlushClicked);
//         // this.customMenu.rgbMascara.addEventListener(MouseEvent.CLICK,this.rgbMascaraClicked);
//         // this.customMenu.rgbFreckles.addEventListener(MouseEvent.CLICK,this.rgbFrecklesClicked);
//         // this.customMenu.rgbNailPolish.addEventListener(MouseEvent.CLICK,this.rgbNailPolishClicked);
//         // this.customMenu.dialogueNameTF.addEventListener(Event.CHANGE,this.dialogueNameChanged);
//         // this.customMenu.dialogueNameTF.addEventListener(FocusEvent.FOCUS_IN,this.textFieldFocusIn);
//         // this.customMenu.dialogueNameTF.addEventListener(FocusEvent.FOCUS_OUT,this.textFieldFocusOut);
//         // this.customMenu.mbClearDialogueName.addEventListener(MouseEvent.CLICK,this.mbClearDialogueNameClicked);
//         // this.customMenu.hslHerSkin.addEventListener(MouseEvent.CLICK,this.hslHerSkinClicked);
//         // this.customMenu.hslHerHair.addEventListener(MouseEvent.CLICK,this.hslHerHairClicked);
//         // this.customMenu.hslHisSkin.addEventListener(MouseEvent.CLICK,this.hslHisSkinClicked);
//         // this.customMenu.mbClearTints.addEventListener(MouseEvent.CLICK,this.clearTintsClicked);
         // this.rgbPicker.closeButton.addEventListener(MouseEvent.CLICK,this.rgbPickerCloseClicked);
         // this.rgbPicker.rSlider.addEventListener("handleReleased",this.rgbPickerReleased);
         // this.rgbPicker.gSlider.addEventListener("handleReleased",this.rgbPickerReleased);
         // this.rgbPicker.bSlider.addEventListener("handleReleased",this.rgbPickerReleased);
         // this.rgbPicker.alphaControls.aSlider.addEventListener("handleReleased",this.rgbPickerReleased);
         // this.rgbPicker.rSlider.addEventListener("sliderChanged",this.rgbPickerChanged);
         // this.rgbPicker.gSlider.addEventListener("sliderChanged",this.rgbPickerChanged);
         // this.rgbPicker.bSlider.addEventListener("sliderChanged",this.rgbPickerChanged);
         // this.rgbPicker.alphaControls.aSlider.addEventListener("sliderChanged",this.rgbPickerChanged);
         // this.rgbPicker.rLabel.addEventListener(Event.CHANGE,this.rgbPickerLabelChanged);
         // this.rgbPicker.gLabel.addEventListener(Event.CHANGE,this.rgbPickerLabelChanged);
         // this.rgbPicker.bLabel.addEventListener(Event.CHANGE,this.rgbPickerLabelChanged);
         // this.rgbPicker.alphaControls.aLabel.addEventListener(Event.CHANGE,this.rgbPickerLabelChanged);
//         // this.rgbPicker.mbCopySwatch.addEventListener(MouseEvent.CLICK,this.copyRGBSwatchClicked);
//         // this.rgbPicker.mbPasteSwatch.addEventListener(MouseEvent.CLICK,this.pasteRGBSwatchClicked);
         // this.rgbPicker.mbEyedropper.addEventListener(MouseEvent.CLICK,this.eyedropperClicked);
         // this.hslPicker.closeButton.addEventListener(MouseEvent.CLICK,this.hslPickerCloseClicked);
         // this.hslPicker.hSlider.addEventListener("handleReleased",this.hslPickerReleased);
         // this.hslPicker.sSlider.addEventListener("handleReleased",this.hslPickerReleased);
         // this.hslPicker.lSlider.addEventListener("handleReleased",this.hslPickerReleased);
         // this.hslPicker.cSlider.addEventListener("handleReleased",this.hslPickerReleased);
         // this.hslPicker.hSlider.addEventListener("sliderChanged",this.hslPickerChanged);
         // this.hslPicker.sSlider.addEventListener("sliderChanged",this.hslPickerChanged);
         // this.hslPicker.lSlider.addEventListener("sliderChanged",this.hslPickerChanged);
         // this.hslPicker.cSlider.addEventListener("sliderChanged",this.hslPickerChanged);
         // this.hslPicker.hLabel.addEventListener(Event.CHANGE,this.hslPickerLabelChanged);
         // this.hslPicker.sLabel.addEventListener(Event.CHANGE,this.hslPickerLabelChanged);
         // this.hslPicker.lLabel.addEventListener(Event.CHANGE,this.hslPickerLabelChanged);
         // this.hslPicker.cLabel.addEventListener(Event.CHANGE,this.hslPickerLabelChanged);
//         // this.customMenu.cbLipstickSmearing.addEventListener(MouseEvent.CLICK,this.lipstickSmearingClicked);
//         // this.customMenu.mbShuffle.addEventListener(MouseEvent.CLICK,this.shuffleClicked);
//         // this.moddingMenu.mbGenerate.addEventListener(MouseEvent.CLICK,this.generateClicked);
//         // this.moddingMenu.mbLoad.addEventListener(MouseEvent.CLICK,this.loadClicked);
//         // this.moddingMenu.mbSaveDialogue.addEventListener(MouseEvent.CLICK,this.saveDialogueClicked);
//         // this.moddingMenu.mbLoadDialogue.addEventListener(MouseEvent.CLICK,this.loadDialogueClicked);
//         // this.moddingMenu.mbResetDefaultDialogue.addEventListener(MouseEvent.CLICK,this.resetDefaultDialogueClicked);
//         // this.moddingMenu.mbEditDialogue.addEventListener(MouseEvent.CLICK,this.editDialogueClicked);
//         // this.moddingMenu.mbStoreChar.addEventListener(MouseEvent.CLICK,this.storeCharClicked);
//         // this.moddingMenu.mbSaveBackup.addEventListener(MouseEvent.CLICK,this.saveBackupClicked);
//         // this.moddingMenu.mbLoadBackup.addEventListener(MouseEvent.CLICK,this.loadBackupClicked);
//         // this.moddingMenu.cbOverwriteCharList.addEventListener(MouseEvent.CLICK,this.cbOverwriteCharListClicked);
//         // this.moddingMenu.saveDataTF.addEventListener(FocusEvent.FOCUS_IN,this.textFieldFocusIn);
//         // this.moddingMenu.saveDataTF.addEventListener(FocusEvent.FOCUS_OUT,this.textFieldFocusOut);
//         // this.moddingMenu.dialogueLibraryName.addEventListener(FocusEvent.FOCUS_IN,this.textFieldFocusIn);
//         // this.moddingMenu.dialogueLibraryName.addEventListener(FocusEvent.FOCUS_OUT,this.textFieldFocusOut);
//         // this.moddingMenu.dialogueLibraryName.addEventListener(Event.CHANGE,this.dialogueLibraryNameChanged);
         // this.charStoring.addEventListener("CHAR_STORED",this.characterStoredSuccessfully);
         // this.charStoring.addEventListener("CHAR_DELETED",this.characterDeleted);
         // this.charStoring.closeButton.addEventListener(MouseEvent.CLICK,this.charStoringCloseClicked);
         // this.charStoring.visible = false;
//         // this.optionsMenu.cbStrandShaders.addEventListener(MouseEvent.CLICK,this.cbStrandShadersClicked);
//         // this.optionsMenu.cbShowMouse.addEventListener(MouseEvent.CLICK,this.cbShowMouseClicked);
//         // this.optionsMenu.cbHoverOptions.addEventListener(MouseEvent.CLICK,this.cbHoverOptionsClicked);
//         // this.optionsMenu.cbLowQuality.addEventListener(MouseEvent.CLICK,this.cbLowQualityClicked);
//         // this.optionsMenu.cbMedQuality.addEventListener(MouseEvent.CLICK,this.cbMedQualityClicked);
//         // this.optionsMenu.cbHighQuality.addEventListener(MouseEvent.CLICK,this.cbHighQualityClicked);
//         // this.optionsMenu.cbMirrored.addEventListener(MouseEvent.CLICK,this.cbMirroredClicked);
//         // this.optionsMenu.volumeSlider.addEventListener("handleReleased",this.volumeChanged);
//         // this.optionsMenu.cbSpit.addEventListener(MouseEvent.CLICK,this.cbSpitClicked);
//         // this.optionsMenu.cbTears.addEventListener(MouseEvent.CLICK,this.cbTearsClicked);
//         // this.optionsMenu.cbMascara.addEventListener(MouseEvent.CLICK,this.cbMascaraClicked);
//         // this.optionsMenu.cbSmudging.addEventListener(MouseEvent.CLICK,this.cbSmudgingClicked);
//         // this.optionsMenu.cbNostrilSpray.addEventListener(MouseEvent.CLICK,this.cbNostrilSprayClicked);
//         // this.optionsMenu.cbSweat.addEventListener(MouseEvent.CLICK,this.cbSweatClicked);
//         // this.optionsMenu.cbDialogue.addEventListener(MouseEvent.CLICK,this.cbDialogueClicked);
//         // this.optionsMenu.throatBulgeSlider.setRangeEnd(100);
//         // this.optionsMenu.throatBulgeSlider.addEventListener("handleReleased",this.throatBulgeSliderReleased);
//         // this.optionsMenu.throatBulgeSlider.addEventListener("sliderChanged",this.throatBulgeSliderChanged);
//         // this.optionsMenu.mbDefaultThroatBulge.addEventListener(MouseEvent.CLICK,this.mbDefaultThroatBulgeClicked);
//         // this.optionsMenu.cbInvertControls.addEventListener(MouseEvent.CLICK,this.cbInvertControlsClicked);
//         // this.optionsMenu.cbDoubleSizeScreenshot.addEventListener(MouseEvent.CLICK,this.cbDoubleSizeScreenshotClicked);
//         // this.optionsMenu.cbIntroSound.addEventListener(MouseEvent.CLICK,this.cbIntroSoundClicked);
//         // this.optionsMenu.cbBreathing.addEventListener(MouseEvent.CLICK,this.cbBreathingClicked);
//         // this.optionsMenu.cbGagging.addEventListener(MouseEvent.CLICK,this.cbGaggingClicked);
//         // this.optionsMenu.cbCoughing.addEventListener(MouseEvent.CLICK,this.cbCoughingClicked);
//         // this.optionsMenu.cbTongue.addEventListener(MouseEvent.CLICK,this.cbTongueClicked);
//         // this.optionsMenu.mbClearSpit.addEventListener(MouseEvent.CLICK,this.clearSpitClicked);
//         // this.optionsMenu.mbClearCum.addEventListener(MouseEvent.CLICK,this.clearCumClicked);
//         // this.optionsMenu.mbClearMascara.addEventListener(MouseEvent.CLICK,this.clearMascaraClicked);
//         // this.optionsMenu.mbClearLipstick.addEventListener(MouseEvent.CLICK,this.clearLipstickClicked);
//         // this.optionsMenu.mbClearAll.addEventListener(MouseEvent.CLICK,this.clearAllClicked);
//         // this.optionsMenu.secretOptions.cbBukkakeMode.addEventListener(MouseEvent.CLICK,this.cbBukkakeModeClicked);
         // this.costumeMenu.mbSelectCostume.labelContainer.buttonLabel.text = "Select...";
//         // this.optionsMenu.mbClearSpit.labelContainer.buttonLabel.text = "Spit";
//         // this.optionsMenu.mbClearCum.labelContainer.buttonLabel.text = "Cum";
//         // this.optionsMenu.mbClearMascara.labelContainer.buttonLabel.text = "Mascara";
//         // this.optionsMenu.mbClearAll.labelContainer.buttonLabel.text = "All";
//         // this.optionsMenu.mbClearLipstick.labelContainer.buttonLabel.text = "Lipstick";
//         // this.customMenu.mbShuffle.labelContainer.buttonLabel.text = "Shuffle";
//         // this.customMenu.mbClearTints.labelContainer.buttonLabel.text = "Clear All";
//         // this.moddingMenu.mbGenerate.labelContainer.buttonLabel.text = "Generate";
//         // this.moddingMenu.mbLoad.labelContainer.buttonLabel.text = "Load";
//         // this.moddingMenu.mbSaveDialogue.labelContainer.buttonLabel.text = "Save...";
//         // this.moddingMenu.mbLoadDialogue.labelContainer.buttonLabel.text = "Load...";
//         // this.moddingMenu.mbEditDialogue.labelContainer.buttonLabel.text = "Edit...";
//         // this.moddingMenu.mbImportHair.labelContainer.buttonLabel.text = "Hair...";
//         // this.moddingMenu.mbImportBackground.labelContainer.buttonLabel.text = "Background...";
//         // this.moddingMenu.mbImportMod.labelContainer.buttonLabel.text = "Swf mod...";
//         // this.moddingMenu.mbStoreChar.labelContainer.buttonLabel.text = "Save Character...";
//         // this.moddingMenu.mbSaveBackup.labelContainer.buttonLabel.text = "Save...";
//         // this.moddingMenu.mbLoadBackup.labelContainer.buttonLabel.text = "Load...";
         // this.eyedropperCursor = new EyedropperIcon();
         // addChild(this.eyedropperCursor);
         // this.eyedropperCursor.visible = false;
         this.updateMoods();
         this.updateHisBodyList();
         this.updateArmsList();
         this.updateHisArmList();
         this.updateHisLeftArmList();
         this.updateBallsList();
         this.updateResistanceSlider();
         this.setCBResetResistance();
         this.updateThroatResistanceSlider();
         this.setCBAuto();
         this.updateAutoList();
         this.updateZoomSlider();
         this.updatePenisLengthSlider();
         this.updatePenisWidthSlider();
         this.updateBallSizeSlider();
         this.updateHairList();
         this.irisTypes = G.characterControl.getIrisList();
         this.updateIrisList();
         this.skinTypes = G.characterControl.getSkinList();
         this.updateSkinList();
         this.updateNoseList();
         this.updateEyebrowsList();
         this.updateEarList();
         this.updateBreastSlider();
         this.updateBodySlider();
         this.updateMascaraSlider();
         this.updateFrecklesSlider();
         this.updateLipstickSmearing();
         this.updateCBSpit();
         this.updateCBSweat();
         this.updateCBTears();
         this.updateCBMascara();
         this.updateCBSmudging();
         this.updateCBNostrilSpray();
         this.updateCBIntroSound();
         this.updateCBBreathing();
         this.updateCBGagging();
         this.updateCBCoughing();
         this.updateCBTongue();
         this.updateThroatBulgeSlider();
         this.updateCBDialogue();
         this.updateCBDoubleSizeScreenshot();
         this.updateTabs();
         this.setcbStrandShaders();
         this.setcbShowMouse();
         this.setQualityCBs();
         this.setcbHoverOptions();
         this.setcbMirrored();
         this.setBGCheckboxes();
         this.setStyleCheckboxes();
         this.setDialogueLibraryName("Default");
         this.updateOverwriteCharList();
    }

    public function updateHimMenuContent() {}

    public function updateCostumeMenuContent() {}

    @:flash.property public var onlyLoadingCostume(get, set):Bool;

    public function set_onlyLoadingCostume(param1:Bool):Bool {
        return false;
    }

    public function get_onlyLoadingCostume():Bool {
		return false;
	}

	public function showError(param1:String) {}

	public function textFieldFocusIn(param1:FocusEvent) {}

	public function textFieldFocusOut(param1:FocusEvent) {}

	public function getSwatchHandler(param1:UInt):ASFunction {
		return null;
	}

	public function getBGHandler(param1:UInt):ASFunction {
		return null;
	}

	public function setBGCheckboxes() {}

	public function setStyleCheckboxes() {}

	public function mouseReleased(param1:MouseEvent) {}

	public function mouseMoved(param1:Float, param2:Float) {}

    public function tick(param1:Event) {
        if (G.hoverOptions && G.gameRunning && !G.gamePaused && !this.menuOpen && this.menuOver && !G.penisOut) {
            ++this.overTimer;
            if (this.overTimer >= this.openDelay) {
                this.openMenu();
            }
        }
        if (G.hoverOptions && this.menuOpen && !this.menuOver) {
            ++this.offTimer;
            if ((this.offTimer : UInt) >= this.closeDelay) {
                this.closeMenu();
            }
        }
    }

    public function finishSlideout() {}

    public function rolledOver(param1:MouseEvent) {}

    public function rolledOut(param1:MouseEvent) {}

    public function drawerArrowClicked(param1:MouseEvent) {}

	public function menuClicked(param1:MouseEvent) {}

	public function toggleMenu(withOffTimer:Bool = false, tabIndex:UInt = 1) {
         if(tabIndex == this.currentTab)
         {
            if(this.menuOpen)
            {
               this.closeMenu();
            }
            else
            {
               this.openMenu(withOffTimer);
            }
         }
         else if(this.menuOpen)
         {
            this.currentTab = tabIndex;
            this.updateTabs();
         }
         else
         {
            this.currentTab = tabIndex;
            this.updateTabs();
            this.openMenu(withOffTimer);
         }
    }

	public function openMenu(withOffTimer:Bool = false) {
        G.gamePaused = true;
        // this.slidingIn = true;
        // this.slidingOut = false;
        this.menuOpen = true;
        this.mouseEnabled = true;
        Mouse.show();
        if (withOffTimer) {
            this.offTimer = -15;
        }
        this.drawer.opened = true;
        // if (this.drawerArrowShowing) {
        //     // this.menuDrawerLip.arrow.gotoAndPlay("FadeOut");
        //     this.drawerArrowShowing = false;
        // }
    }

    public function closeMenu() {
        if (this.menuOpen) {
            G.gamePaused = false;
            G.inTextField = false;
            this.drawer.opened = false;
            this.menuOpen = false;
            // this.slidingOut = true;
            // this.slidingIn = false;
            // this.clipboardSwatch.visible = false;
            if (G.showMouse) {
                Mouse.show();
            } else if (G.gameRunning) {
                Mouse.hide();
            }
        }
    }

    public function closeClicked(param1:MouseEvent) {}

    public function tab1Clicked(param1:MouseEvent) {}

    public function tab2Clicked(param1:MouseEvent) {}

	public function tab3Clicked(param1:MouseEvent) {}

	public function tab4Clicked(param1:MouseEvent) {}

	public function tab5Clicked(param1:MouseEvent) {}

	public function updateTabs() {}

	public function characterMenuCloseClicked(param1:MouseEvent) {}

	public function mbCharacterMenuClicked(param1:MouseEvent) {}

	public function selectCostumeClicked(param1:MouseEvent) {}

	public function closeCharacterMenu() {}

	public function openCharacterMenu() {}

	public function updateCharMenu(param1:UInt, param2:Bool = false, param3:Bool = false) {}

	public function moodNormalClicked(param1:MouseEvent) {}

	public function moodHappyClicked(param1:MouseEvent) {}

	public function moodAngryClicked(param1:MouseEvent) {}

	public function moodAhegaoClicked(param1:MouseEvent) {}

	public function updateMoods() {}

	public function style1Clicked(param1:MouseEvent) {}

	public function style2Clicked(param1:MouseEvent) {}

	public function leftArmLeftClicked(param1:MouseEvent) {}

	public function leftArmRightClicked(param1:MouseEvent) {}

	public function rightArmLeftClicked(param1:MouseEvent) {}

	public function rightArmRightClicked(param1:MouseEvent) {}

	public function updateArmsList() {}

	public function hisBodyLeftClicked(param1:MouseEvent) {}

	public function hisBodyRightClicked(param1:MouseEvent) {}

	public function updateHisBodyList() {}

	public function hisArmLeftClicked(param1:MouseEvent) {}

	public function hisArmRightClicked(param1:MouseEvent) {}

	public function updateHisArmList() {}

	public function hisLeftArmLeftClicked(param1:MouseEvent) {}

	public function hisLeftArmRightClicked(param1:MouseEvent) {}

	public function updateHisLeftArmList() {}

	public function ballsLeftClicked(param1:MouseEvent) {}

	public function ballsRightClicked(param1:MouseEvent) {}

	public function updateBallsList() {}

	public function ballSizeSliderReleased(param1:Event) {}

	public function ballSizeSliderChanged(param1:Event) {}

	public function updateBallSizeSlider() {}

	public function mbDefaultBallSizeClicked(param1:MouseEvent) {}

	public function resistanceSliderReleased(param1:Event) {}

	public function resistanceSliderChanged(param1:Event) {}

	public function updateResistanceSlider(param1:Bool = false) {}

	public function cbResetResistanceClicked(param1:MouseEvent) {}

	public function setCBResetResistance() {}

	public function mbDefaultResistanceClicked(param1:MouseEvent) {}

	public function throatResistanceSliderReleased(param1:Event) {}

	public function throatResistanceSliderChanged(param1:Event) {}

	public function updateThroatResistanceSlider() {}

	public function mbDefaultThroatResistanceClicked(param1:MouseEvent) {}

	public function zoomSliderReleased(param1:Event) {}

	public function zoomSliderChanged(param1:Event) {}

	public function updateZoomSlider() {}

	public function mbDefaultZoomClicked(param1:MouseEvent) {}

	public function penisLengthSliderReleased(param1:Event) {}

	public function penisLengthSliderChanged(param1:Event) {}

	public function updatePenisLengthSlider() {}

	public function mbDefaultPenisLengthClicked(param1:MouseEvent) {}

	public function penisWidthSliderReleased(param1:Event) {}

	public function penisWidthSliderChanged(param1:Event) {}

	public function updatePenisWidthSlider() {}

	public function mbDefaultPenisWidthClicked(param1:MouseEvent) {}

	public function autoLeftClicked(param1:MouseEvent) {}

	public function autoRightClicked(param1:MouseEvent) {}

	public function updateAutoList() {}

	public function cbAutoClicked(param1:MouseEvent) {}

	public function setCBAuto() {}

	public function hairLeftClicked(param1:MouseEvent) {}

	public function hairRightClicked(param1:MouseEvent) {}

	public function irisLeftClicked(param1:MouseEvent) {}

	public function irisRightClicked(param1:MouseEvent) {}

	public function skinLeftClicked(param1:MouseEvent) {}

	public function skinRightClicked(param1:MouseEvent) {}

	public function noseLeftClicked(param1:MouseEvent) {}

	public function noseRightClicked(param1:MouseEvent) {}

	public function eyebrowsLeftClicked(param1:MouseEvent) {}

	public function eyebrowsRightClicked(param1:MouseEvent) {}

	public function earLeftClicked(param1:MouseEvent) {}

	public function earRightClicked(param1:MouseEvent) {}

	public function updateHairList() {}

	public function updateIrisList() {}

	public function updateSkinList() {}

	public function updateNoseList() {}

	public function updateEyebrowsList() {}

	public function updateEarList() {}

	public function bodySliderReleased(param1:Event) {}

	public function bodySliderChanged(param1:Event) {}

	public function updateBodySlider() {}

	public function mbDefaultBodyScaleClicked(param1:MouseEvent) {}

	public function breastSliderReleased(param1:Event) {}

	public function breastSliderChanged(param1:Event) {}

	public function updateBreastSlider() {}

	public function mascaraSliderReleased(param1:Event) {}

	public function mascaraSliderChanged(param1:Event) {}

	public function defaultMascaraClicked(param1:MouseEvent) {}

	public function updateMascaraSlider() {}

	public function frecklesSliderReleased(param1:Event) {}

	public function frecklesSliderChanged(param1:Event) {}

	public function defaultFrecklesClicked(param1:MouseEvent) {}

	public function updateFrecklesSlider() {}

	public function lipstickSmearingClicked(param1:MouseEvent) {}

	public function updateLipstickSmearing() {}

	public function dialogueNameChanged(param1:Event) {}

	public function mbClearDialogueNameClicked(param1:MouseEvent) {}

	public function shuffleClicked(param1:MouseEvent) {}

	public function shuffle() {}

	public function setDialogueLibraryName(param1:String) {}

	public function dialogueLibraryNameChanged(param1:Event) {}

	public function resetDefaultDialogueClicked(param1:MouseEvent) {}

	public function saveDialogueClicked(param1:MouseEvent) {}

	public function loadDialogueClicked(param1:MouseEvent) {}

	public function editDialogueClicked(param1:MouseEvent) {}

	public function dialogueSelectHandler(param1:Event) {}

	public function dialogueCompleteHandler(param1:Event) {}

	public function dialogueCancelHandler(param1:Event) {}

	public function storeCharClicked(param1:MouseEvent) {}

	public function characterStoredSuccessfully(param1:Event) {}

	public function characterDeleted(param1:Event) {}

	public function openCharStoring(param1:Bool = true) {}

	public function closeCharStoring() {}

	public function charStoringCloseClicked(param1:MouseEvent) {}

	public function editCharListClicked(param1:MouseEvent) {}

	public function saveBackupClicked(param1:MouseEvent) {}

	public function loadBackupClicked(param1:MouseEvent) {}

	public function storedCharsSelectHandler(param1:Event) {}

	public function storedCharsCompleteHandler(param1:Event) {}

	public function storedCharsCancelHandler(param1:Event) {}

	public function instanceStoredCharFile(param1:ASAny) {}

	public function cbOverwriteCharListClicked(param1:MouseEvent) {}

	public function updateOverwriteCharList() {}

	// public function editChar(param1:CustomCharacter) {}

	public function generateClicked(param1:MouseEvent) {}

	public function generateSaveData() {}

	public function getSaveDataString(param1:Bool = true):String {
        return "";
    }

	public function loadClicked(param1:MouseEvent) {}

	// public function loadData(param1:String, param2:Bool = true, param3:Bool = false, param4:CustomCharacter = null) {}

	public function modIOError(param1:Event) {}

	public function checkAndLoadRGB(param1:String, param2:ASFunction) {}

	public function populateRGBSwatch(param1:Array<ASAny>):ASAny {
        return null;
    }

	public function copyRGBSwatchClicked(param1:MouseEvent) {}

	public function pasteRGBSwatchClicked(param1:MouseEvent) {}

	public function eyedropperClicked(param1:MouseEvent) {}

	public function eyedropperDone() {}

	public function rgbEyeShadowClicked(param1:MouseEvent) {}

	public function rgbLipstickClicked(param1:MouseEvent) {}

	public function rgbIrisClicked(param1:MouseEvent) {}

	public function rgbEyebrowFillClicked(param1:MouseEvent) {}

	public function rgbEyebrowLineClicked(param1:MouseEvent) {}

	public function rgbScleraClicked(param1:MouseEvent) {}

	public function rgbBlushClicked(param1:MouseEvent) {}

	public function rgbMascaraClicked(param1:MouseEvent) {}

	public function rgbFrecklesClicked(param1:MouseEvent) {}

	public function rgbNailPolishClicked(param1:MouseEvent) {}

	public function hslHerHairClicked(param1:MouseEvent) {}

	public function hslHerSkinClicked(param1:MouseEvent) {}

	public function hslHisSkinClicked(param1:MouseEvent) {}

	public function clearTintsClicked(param1:MouseEvent) {}

	public function rgbPickerCloseClicked(param1:MouseEvent) {}

	public function openRGBPicker(param1:Float, param2:Float, param3:Array<ASAny>, param4:AlphaRGBObject, param5:ASFunction, param6:Bool = true,
		param7:String = "rgbFill") {}

	public function closeRGBPicker() {}

	public function rgbPickerReleased(param1:Event) {}

	public function rgbPickerChanged(param1:Event) {}

	public function rgbPickerLabelChanged(param1:Event) {}

	public function setRGBPicker(param1:AlphaRGBObject) {}

	public function setRGBPickerFromLabels() {}

	public function updateRGBPicker(param1:AlphaRGBObject) {}

	public function updateRGBReference() {}

	public function hslPickerCloseClicked(param1:MouseEvent) {}

	public function openHSLPicker(param1:Float, param2:Float, param3:ColorHsl) {}

	public function closeHSLPicker() {}

	public function hslRemoveClicked(param1:MouseEvent) {}

	public function hslPickerReleased(param1:Event) {}

	public function hslPickerChanged(param1:Event) {}

	public function hslPickerLabelChanged(param1:Event) {}

	public function setHSLPickerFromLabels() {}

	public function updateHSLPicker(param1:ColorHsl) {}

	public function cbStrandShadersClicked(param1:MouseEvent) {}

	public function updateStrandShaders() {}

	public function setcbStrandShaders() {}

	public function cbShowMouseClicked(param1:MouseEvent) {}

	public function setcbShowMouse() {}

	public function cbLowQualityClicked(param1:MouseEvent) {}

	public function cbMedQualityClicked(param1:MouseEvent) {}

	public function cbHighQualityClicked(param1:MouseEvent) {}

	public function setQualityTo(param1:UInt) {}

	public function setQualityCBs() {}

	public function cbHoverOptionsClicked(param1:MouseEvent) {}

	public function setcbHoverOptions() {}

	public function cbMirroredClicked(param1:MouseEvent) {}

	public function setcbMirrored() {}

	public function volumeChanged(param1:Event) {}

	public function updateVolumeSlider(param1:Float) {}

	public function clearSpitClicked(param1:MouseEvent) {}

	public function clearCumClicked(param1:MouseEvent) {}

	public function clearMascaraClicked(param1:MouseEvent) {}

	public function clearLipstickClicked(param1:MouseEvent) {}

	public function clearAllClicked(param1:MouseEvent) {}

	public function cbSpitClicked(param1:MouseEvent) {}

	public function updateCBSpit() {}

	public function cbTearsClicked(param1:MouseEvent) {}

	public function updateCBTears() {}

	public function cbMascaraClicked(param1:MouseEvent) {}

	public function updateCBMascara() {}

	public function cbSmudgingClicked(param1:MouseEvent) {}

	public function updateCBSmudging() {}

	public function cbNostrilSprayClicked(param1:MouseEvent) {}

	public function updateCBNostrilSpray() {}

	public function cbSweatClicked(param1:MouseEvent) {}

	public function updateCBSweat() {}

	public function cbIntroSoundClicked(param1:MouseEvent) {}

	public function updateCBIntroSound() {}

	public function cbBreathingClicked(param1:MouseEvent) {}

	public function updateCBBreathing() {}

	public function cbGaggingClicked(param1:MouseEvent) {}

	public function updateCBGagging() {}

	public function cbCoughingClicked(param1:MouseEvent) {}

	public function updateCBCoughing() {}

	public function cbTongueClicked(param1:MouseEvent) {}

	public function updateCBTongue() {}

	public function throatBulgeSliderReleased(param1:Event) {}

	public function throatBulgeSliderChanged(param1:Event) {}

	public function updateThroatBulgeSlider() {}

	public function mbDefaultThroatBulgeClicked(param1:MouseEvent) {}

	public function cbDialogueClicked(param1:MouseEvent) {}

	public function updateCBDialogue() {}

	public function cbInvertControlsClicked(param1:MouseEvent) {}

	public function updateCBInvertControls() {}

	public function cbDoubleSizeScreenshotClicked(param1:MouseEvent) {}

	public function updateCBDoubleSizeScreenshot() {}

	public function cbBukkakeModeClicked(param1:MouseEvent) {}

	public function setcbBukkakeMode() {}
}
