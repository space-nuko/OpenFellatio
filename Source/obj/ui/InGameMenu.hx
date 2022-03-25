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
class InGameMenu extends MovieClip {
	public function new() {
        super();
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

	public function tick(param1:Event) {}

	public function finishSlideout() {}

	public function rolledOver(param1:MouseEvent) {}

	public function rolledOut(param1:MouseEvent) {}

	public function drawerArrowClicked(param1:MouseEvent) {}

	public function menuClicked(param1:MouseEvent) {}

	public function toggleMenu(param1:Bool = false, param2:UInt = 1) {}

	public function openMenu(param1:Bool = false) {}

	public function closeMenu() {}

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

	public function openRGBPicker(param1:Float, param2:Float, param3:Array<ASAny>, param4:ASObject, param5:ASFunction, param6:Bool = true,
		param7:String = "rgbFill") {}

	public function closeRGBPicker() {}

	public function rgbPickerReleased(param1:Event) {}

	public function rgbPickerChanged(param1:Event) {}

	public function rgbPickerLabelChanged(param1:Event) {}

	public function setRGBPicker(param1:ASObject) {}

	public function setRGBPickerFromLabels() {}

	public function updateRGBPicker(param1:ASObject) {}

	public function updateRGBReference() {}

	public function hslPickerCloseClicked(param1:MouseEvent) {}

	public function openHSLPicker(param1:Float, param2:Float, param3:ASObject) {}

	public function closeHSLPicker() {}

	public function hslRemoveClicked(param1:MouseEvent) {}

	public function hslPickerReleased(param1:Event) {}

	public function hslPickerChanged(param1:Event) {}

	public function hslPickerLabelChanged(param1:Event) {}

	public function setHSLPickerFromLabels() {}

	public function updateHSLPicker(param1:ASObject) {}

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
