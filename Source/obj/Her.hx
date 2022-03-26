package obj;

import fl.motion.Color;
import openfl.Vector;
import openfl.display.BlendMode;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.display.MovieClip;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.geom.Matrix;
import openfl.geom.Point;
import swf.exporters.animate.AnimateSpriteSymbol;
import obj.Maths;
import obj.animation.BreastController;
import obj.animation.IKController;
import obj.animation.LinearTween;
import obj.dialogue.Dialogue;
import obj.her.BraStrap;
import obj.her.BreathMist;
import obj.her.HerPenisControl;
import obj.her.ITannable;
import obj.her.Neck;
import obj.her.Tan;
import obj.her.TearPoint;
import obj.her.Tongue;
import obj.him.Penis;

@:rtti
class BasicTannable extends MovieClip implements ITannable {
	@:keep public var tan(default, null):MovieClip;
}

@:rtti
class HerCollar extends MovieClip {
	@:keep public var tie(default, null):Null<MovieClip>;
}

@:rtti
class CollarContainer extends MovieClip {
	@:keep public var collar(default, null):HerCollar;
}

@:rtti
class RightCalfContainer extends MovieClip {
	@:keep public var bottoms(default, null):MovieClip;
	@:keep public var calf(default, null):BasicTannable;
	@:keep public var cuffs(default, null):MovieClip;
	@:keep public var calfStocking(default, null):MovieClip;
	@:keep public var calfStockingB(default, null):MovieClip;
	@:keep public var footwear(default, null):MovieClip;
}

@:rtti
class ThighCostume extends MovieClip {
	@:keep public var panties(default, null):MovieClip;
}

@:rtti
class HerRightThighCostumeMask extends MovieClip {
	@:keep public var legMask(default, null):MovieClip;
}

@:rtti
class BackUnderCostume extends MovieClip {
	@:keep public var panties(default, null):MovieClip;
}

@:rtti
class HerChestCostumeBottoms extends MovieClip {
	@:keep public var penisCostumeContainer(default, null):MovieClip;
}

@:rtti
class ChestCostume extends MovieClip {
	@:keep public var bellyPiercing(default, null):RigidBody;
	@:keep public var bottoms(default, null):HerChestCostumeBottoms;
	@:keep public var legMask(default, null):MovieClip;
}

@:rtti
class HerPanties extends MovieClip {
	@:keep public var penisCostumeContainer(default, null):MovieClip;
}

@:rtti
class ChestUnderCostume extends MovieClip {
	@:keep public var panties(default, null):HerPanties;
}

@:rtti
class BackCostume extends MovieClip {
	@:keep public var bottoms(default, null):MovieClip;
}

@:rtti
class TopContainer extends MovieClip {
	@:keep public var backTop(default, null):MovieClip;
	@:keep public var breastTop(default, null):MovieClip;
	@:keep public var chestTop(default, null):MovieClip;
	@:keep public var topStrap(default, null):MovieClip;
}

@:rtti
class UpperChestCostume extends MovieClip {
	@:keep public var bra(default, null):MovieClip;
}

@:rtti
class HerRightNipple extends BasicTannable {
	@:keep public var rightNipple(default, null):Null<MovieClip>; // ?
	@:keep public var piercingPoint(default, null):MovieClip;
}

@:rtti
class HerRightBreast extends BasicTannable {
	@:keep public var rightBreast(default, null):Null<MovieClip>;//?
	@:keep public var nipple(default, null):HerRightNipple;
}

@:rtti
class HerMidLayer extends MovieClip {
	@:keep public var chest(default, null):BasicTannable;
	@:keep public var rightBreast(default, null):HerRightBreast;
	@:keep public var leftArm(default, null):BasicTannable;
}

@:rtti
class HerRightLeg extends MovieClip {
	@:keep public var thigh(default, null):BasicTannable;
	@:keep public var highlights(default, null):MovieClip;
}

@:rtti
class HerRightChestStocking extends MovieClip {
	@:keep public var penisCostumeContainer(default, null):MovieClip;
}

@:rtti
class HerRightHipLayer extends MovieClip {
	@:keep public var backStocking(default, null):MovieClip;
	@:keep public var chestStocking(default, null):HerRightChestStocking;
}

@:rtti
class HerRightHipOverLayer extends MovieClip {
	@:keep public var backStocking(default, null):MovieClip;
	@:keep public var chestStocking(default, null):MovieClip;
}

@:rtti
class HerRightStocking extends MovieClip {
	@:keep public var hipLayer(default, null):HerRightHipLayer;
	@:keep public var hipOverLayer(default, null):HerRightHipOverLayer;
}

@:rtti
class HerRightHipLayer2 extends MovieClip {
	@:keep public var backStocking(default, null):MovieClip;
	@:keep public var chestStocking(default, null):MovieClip;
}

@:rtti
class HerRightStocking2 extends MovieClip {
	@:keep public var hipLayer(default, null):HerRightHipLayer2;
}

@:rtti
class HerRightThighStocking extends MovieClip {
	@:keep public var stocking(default, null):HerRightStocking;
	@:keep public var stocking2(default, null):HerRightStocking;
}

@:rtti
class HerPenisContainer extends MovieClip {
	@:keep public var penis(default, null):Penis;
}

@:rtti
class Torso extends MovieClip {
	@:keep public var back(default, null):BasicTannable;
	@:keep public var backMask(default, null):MovieClip;
	@:keep public var backHighlight(default, null):MovieClip;
	@:keep public var backCostume(default, null):BackCostume;
	@:keep public var backUnderCostume(default, null):BackUnderCostume;
	@:keep public var backside(default, null):BasicTannable;
	@:keep public var braStrap(default, null):MovieClip;
	@:keep public var breastCostume(default, null):BreastCostume;
	@:keep public var chestCostume(default, null):ChestCostume;
	@:keep public var chestUnderCostume(default, null):ChestUnderCostume;
	@:keep public var cuffs(default, null):MovieClip;
	@:keep public var leftGlove(default, null):MovieClip;
	@:keep public var leftNipplePiercing(default, null):RigidBody;
	@:keep public var nipplePiercing(default, null):RigidBody;
	@:keep public var rightCalfContainer(default, null):RightCalfContainer;
	@:keep public var rightGlove(default, null):MovieClip;
	@:keep public var rightThighBottoms(default, null):MovieClip;
	@:keep public var rightThighBottomsOver(default, null):MovieClip;
	@:keep public var rightThighCostume(default, null):ThighCostume;
	@:keep public var rightThighCostumeMask(default, null):HerRightThighCostumeMask;
	@:keep public var rightThighStocking(default, null):HerRightThighStocking;
	@:keep public var rightThighStockingB(default, null):HerRightThighStocking;
	@:keep public var shoulderStrap(default, null):MovieClip;
	@:keep public var topContainer(default, null):TopContainer;
	@:keep public var upperChestCostume(default, null):UpperChestCostume;
	@:keep public var midLayer(default, null):HerMidLayer;
	@:keep public var behindBackRightArm(default, null):BasicTannable;
	@:keep public var leg(default, null):HerRightLeg;
	@:keep public var nailPolish(default, null):MovieClip;
	@:keep public var penisContainer(default, null):HerPenisContainer;
}

@:rtti
class LeftHandOverHand extends MovieClip {
	@:keep public var grip(default, null):Null<BasicTannable>;
	@:keep public var glove(default, null):MovieClip;
	@:keep public var nailPolish(default, null):MovieClip;
}

@:rtti
class HandCostumeHand extends MovieClip {
	@:keep public var glove(default, null):MovieClip;
}

@:rtti
class HandCostumeGlove extends MovieClip {
	@:keep public var grip(default, null):Null<MovieClip>;
}

@:rtti
class HandCostume extends MovieClip {
	@:keep public var hand(default, null):HandCostumeHand;
	@:keep public var glove(default, null):HandCostumeGlove;
	@:keep public var nailPolish(default, null):MovieClip;
}

@:access(swf.exporters.animate)
@:rtti
class LeftHandOver extends MovieClip {
	@:keep public var glove(default, null):MovieClip;
	@:keep public var hand(default, null):LeftHandOverHand;

	public function new() {
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("Ld39TJPQZsVJfqCLrG3m");
		var symbol = library.symbols.get(2051);
		symbol.__initObject(library, this);
	}
}

@:rtti
class HerLeftHand extends BasicTannable {
	@:keep public var grip(default, null):Null<MovieClip>; // ?
}

@:rtti
class HerLeftForeArm extends BasicTannable {
	@:keep public var hand(default, null):HerLeftHand;
}

@:rtti
class HerLeftUpperArm extends BasicTannable {
	@:keep public var foreArm(default, null):HerLeftForeArm;
}

@:rtti
class LeftForeArmCostume extends MovieClip {
	@:keep public var cuff(default, null):MovieClip;
	@:keep public var glove(default, null):MovieClip;
	@:keep public var top(default, null):MovieClip;
	@:keep public var handCostume(default, null):HandCostume;
}

@:rtti
class RightForeArmCostume extends MovieClip {
	@:keep public var cuff(default, null):MovieClip;
	@:keep public var glove(default, null):MovieClip;
	@:keep public var top(default, null):MovieClip;
	@:keep public var handCostume(default, null):HandCostume;
}

@:rtti
class LeftUpperArmCostume extends MovieClip {
	@:keep public var glove(default, null):MovieClip;
	@:keep public var foreArmCostume(default, null):LeftForeArmCostume;
	@:keep public var top(default, null):MovieClip;
}

@:rtti
class RightUpperForeArmCostume extends MovieClip {
	@:keep public var foreArmCostume(default, null):RightForeArmCostume;
}

@:rtti
class RightUpperArmCostume extends MovieClip {
	@:keep public var glove(default, null):MovieClip;
	@:keep public var top(default, null):MovieClip;
}

@:access(swf.exporters.animate)
@:rtti
class HerLeftArmContainer extends MovieClip {
	@:keep public var upperArm(default, null):HerLeftUpperArm;
	@:keep public var upperArmCostume(default, null):LeftUpperArmCostume;

	public function new() {
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("Ld39TJPQZsVJfqCLrG3m");
		var symbol = library.symbols.get(581);
		symbol.__initObject(library, this);
	}
}

@:rtti
class HerRightHandTan extends MovieClip {
	@:keep public var grip(default, null):Null<MovieClip>;
}

@:rtti
class HerRightHand extends MovieClip implements ITannable {
	@:keep public var grip(default, null):Null<MovieClip>; // ?
	@:keep public var tan(default, null):HerRightHandTan;
}

@:rtti
class HerRightForeArm extends BasicTannable {
	@:keep public var hand(default, null):HerRightHand;
}

@:access(swf.exporters.animate)
@:rtti
class RightUpperForeArm extends MovieClip {
	@:keep public var foreArm(default, null):HerRightForeArm;

	public function new() {
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("Ld39TJPQZsVJfqCLrG3m");
		var symbol = library.symbols.get(2022);
		symbol.__initObject(library, this);
	}
}

@:access(swf.exporters.animate)
@:rtti
class HerRightForeArmContainer extends MovieClip {
	@:keep public var upperArmCostume(default, null):RightUpperForeArmCostume;
	@:keep public var upperArm(default, null):RightUpperForeArm;

	public function new() {
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("Ld39TJPQZsVJfqCLrG3m");
		var symbol = library.symbols.get(2036);
		symbol.__initObject(library, this);
	}
}

@:access(swf.exporters.animate)
@:rtti
class HerRightArmContainer extends MovieClip {
	@:keep public var upperArmCostume(default, null):RightUpperArmCostume;
	@:keep public var upperArm(default, null):BasicTannable;
	@:keep public var upperArmMask(default, null):MovieClip;

	public function new() {
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("Ld39TJPQZsVJfqCLrG3m");
		var symbol = library.symbols.get(1998);
		symbol.__initObject(library, this);
	}
}

@:access(swf.exporters.animate)
@:rtti
class HerRightArmEraseContainer extends MovieClip {
	@:keep public var upperArmCostume(default, null):RightUpperArmCostume;
	@:keep public var upperArm(default, null):MovieClip;

	public function new() {
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("Ld39TJPQZsVJfqCLrG3m");
		var symbol = library.symbols.get(98);
		symbol.__initObject(library, this);
	}
}

@:rtti
class Leg extends MovieClip {
	@:keep public var cuffs(default, null):MovieClip;
	@:keep public var footwear(default, null):MovieClip;
	@:keep public var leftThighCostume(default, null):ThighCostume;
	@:keep public var leftThighBottoms(default, null):MovieClip;
	@:keep public var leftCalfBottoms(default, null):MovieClip;
	@:keep public var stocking(default, null):MovieClip;
	@:keep public var stockingB(default, null):MovieClip;
	@:keep public var calfStocking(default, null):MovieClip;
	@:keep public var calfStockingB(default, null):MovieClip;
	@:keep public var calf(default, null):BasicTannable;
	@:keep public var thigh(default, null):BasicTannable;
}

@:rtti
class LegContainer extends MovieClip {
	@:keep public var leg(default, null):Leg;
}

@:rtti
class BacksideCostume extends MovieClip {
	@:keep public var bottoms(default, null):MovieClip;
	@:keep public var panties(default, null):MovieClip;
	@:keep public var stocking(default, null):MovieClip;
	@:keep public var stockingB(default, null):MovieClip;
}

@:rtti
class HerLeftNipple extends BasicTannable {
	@:keep public var leftNipple(default, null):Null<MovieClip>; // ?
	@:keep public var piercingPoint(default, null):MovieClip;
}

@:rtti
class HerLeftBreast extends BasicTannable {
	@:keep public var leftBreast(default, null):Null<MovieClip>;//?
	@:keep public var nipple(default, null):HerLeftNipple;
}

@:rtti
class TorsoBack extends BasicTannable {
	@:keep public var leftShoulder(default, null):MovieClip;
	@:keep public var chestBack(default, null):MovieClip;
	@:keep public var leftBreast(default, null):HerLeftBreast;
	@:keep public var backside(default, null):BasicTannable;
}

@:rtti
class TorsoBackCostume extends MovieClip {
	@:keep public var backsideCostume(default, null):BacksideCostume;
	@:keep public var breastCostume(default, null):BreastCostume;
}

@:rtti
class BreastCostume extends MovieClip {
	@:keep public var top(default, null):MovieClip;
	@:keep public var bra(default, null):MovieClip;
}

@:rtti
class TorsoUnderCostume extends MovieClip {
	@:keep public var top(default, null):MovieClip;
}

@:rtti
class TongueContainer extends MovieClip {
	@:keep public var tongue(default, null):obj.her.Tongue;
}

@:rtti
class HerHairMidContainer extends MovieClip {
	@:keep public var hairUnder(default, null):MovieClip;
	@:keep public var hairUnderLayer(default, null):MovieClip;
	@:keep public var hairBottom(default, null):MovieClip;
}

@:rtti
@:access(swf.exporters.animate)
class HairBackContainer extends MovieClip {
	@:keep public var hairBackLayer(default, null):MovieClip;
	@:keep public var hairBack(default, null):MovieClip;

	public function new() {
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("Ld39TJPQZsVJfqCLrG3m");
		var symbol = library.symbols.get(598);
		symbol.__initObject(library, this);
	}
}

@:rtti
class HerLeftEyebrow extends MovieClip {
	@:keep public var leftEyebrowLine(default, null):MovieClip;
	@:keep public var leftEyebrowFill(default, null):MovieClip;
}

@:rtti
class HerRightEyebrow extends MovieClip {
	@:keep public var rightEyebrowLine(default, null):MovieClip;
	@:keep public var rightEyebrowFill(default, null):MovieClip;
}

@:rtti
class HerIris extends MovieClip {
	@:keep public var irisFill(default, null):MovieClip;
}

@:rtti
class HerIrisContainer extends MovieClip {
	@:keep public var iris(default, null):HerIris;
}

@:rtti
class HerSclera extends MovieClip {
	@:keep public var overlay(default, null):MovieClip;
}

@:rtti
class HerEyeBall extends MovieClip {
	@:keep public var highlights(default, null):MovieClip;
	@:keep public var upperEyelidMask(default, null):MovieClip;
	@:keep public var lowerEyelidMask(default, null):MovieClip;
	@:keep public var sclera(default, null):HerSclera;
	@:keep public var irisContainer(default, null):HerIrisContainer;
}

@:rtti
class HerUpperEyelid extends MovieClip {
	@:keep public var eyeshadow(default, null):MovieClip;
	@:keep public var mascara(default, null):MovieClip;
}

@:rtti
class HerLowerEyelid extends MovieClip {
	@:keep public var mascara(default, null):MovieClip;
	@:keep public var mascaraContainer(default, null):MovieClip;
}

@:rtti
class HerEye extends MovieClip {
	@:keep public var eyebrowMask(default, null):MovieClip;
	@:keep public var eyebrowUnderMask(default, null):BasicTannable;
	@:keep public var upperEyelid(default, null):HerUpperEyelid;
	@:keep public var lowerEyelid(default, null):HerLowerEyelid;
	@:keep public var ball(default, null):HerEyeBall;
	@:keep public var hitBox(default, null):MovieClip;
}

@:rtti
class HerNose extends MovieClip {
	@:keep public var tip(default, null):MovieClip;
}

@:rtti
class HerFace extends MovieClip {
	@:keep public var lipFill(default, null):MovieClip;
	@:keep public var lipShading(default, null):MovieClip;
	@:keep public var lipHighlight(default, null):MovieClip;
	@:keep public var lipOutline(default, null):MovieClip;
	@:keep public var skull(default, null):MovieClip;
	@:keep public var nose(default, null):HerNose;
}

@:rtti
class HerHeadTanFace extends MovieClip {
	@:keep public var nose(default, null):MovieClip;
	@:keep public var lipFill(default, null):MovieClip;
	@:keep public var lipOutline(default, null):MovieClip;
	@:keep public var jawBulge(default, null):MovieClip;
}

@:rtti
class HerHeadTanJaw extends MovieClip {
	@:keep public var jawBulge(default, null):HerHeadTanJawBack;
}

@:rtti
class HerHeadTanJawBack extends MovieClip {
	@:keep public var jawBulgeOutline(default, null):HerHeadTanJawBack;
}

@:rtti
class HerHeadTan extends MovieClip {
	@:keep public var face(default, null):HerHeadTanFace;
	@:keep public var jaw(default, null):HerHeadTanJaw;
	@:keep public var jawBack(default, null):HerHeadTanJawBack;
}

@:rtti
class HerJaw extends MovieClip {
	@:keep public var jawBulge(default, null):MovieClip;
	@:keep public var jawBulgeOutline(default, null):MovieClip;
	@:keep public var teeth(default, null):MovieClip;
}

@:rtti
class HerJawBack extends MovieClip {
	@:keep public var jawBulge(default, null):MovieClip;
	@:keep public var jawBulgeOutline(default, null):MovieClip;
}

@:rtti
class HerHead extends MovieClip {
	@:keep public var headTan(default, null):HerHeadTan;
	@:keep public var cheekSuck(default, null):MovieClip;
	@:keep public var cheekBulge(default, null):MovieClip;
	@:keep public var cheekMask(default, null):MovieClip;
	@:keep public var neck(default, null):Neck;
	@:keep public var face(default, null):HerFace;
	@:keep public var jaw(default, null):HerJaw;
	@:keep public var jawBack(default, null):HerJawBack;
	@:keep public var teeth(default, null):MovieClip;
	@:keep public var scalpHair(default, null):MovieClip;
}

@:rtti
class HerTopLipstickContainer extends MovieClip {
	@:keep public var topLipstick(default, null):MovieClip;
}

class MouthShape {
	public var name(default, null):String;
	public var upperLip(default, null):Float;
	public var lowerLip(default, null):Float;
	public var jaw(default, null):Float;

	public function new(_name:String, _upperLip:Float, _lowerLip:Float, _jaw:Float) {
		name = _name;
		upperLip = _upperLip;
		lowerLip = _lowerLip;
		jaw = _jaw;
	}
}

class RandomMotion {
	public var pos:Float;
	public var speed:Float;
	public var target:Float;
	public var next:Float;

	public function new(_pos:Float, _speed:Float, _target:Float, _next:Float) {
		pos = _pos;
		speed = _speed;
		target = _target;
		next = _next;
	}
}

class Resistance {
	public var upper:Float;
	public var boundary:Float;
	public var lower:Float;
	public var multiplier:Float;

	public function new(_upper:Float, _boundary:Float, _lower:Float, _multiplier:Float) {
		upper = _upper;
		boundary = _boundary;
		lower = _lower;
		multiplier = _multiplier;
	}
}

class SwallowSequence {
	public var build:Float;
	public var swallow:Float;
	public var relax:Float;
	public var end:Float;
	public var intensity:Float = 0;

	public function new(_build:Float, _swallow:Float, _relax:Float, _end:Float) {
		build = _build;
		swallow = _swallow;
		relax = _relax;
		end = _end;
	}
}

class EyeMotion {
	public var ang:Float;
	public var target:Float;

	public function new(_ang:Float, _target:Float) {
		ang = _ang;
		target = _target;
	}
}

class EyelidMotion {
	public var pos:Float;
	public var shock:Float;
	public var target:Float;
	public var isClosed:Bool;
	public var closedTimer:Float;

	public function new(_pos:Float, _shock:Float, _target:Float, _isClosed:Bool, _closedTimer:Float) {
		pos = _pos;
		shock = _shock;
		target = _target;
		isClosed = _isClosed;
		closedTimer = _closedTimer;
	}
}

class PullOffPower {
	public var start:Float;
	public var current:Float;
	public var increase:Float;
	public var max:Float;

	public function new(_start:Float, _current:Float, _increase:Float, _max:Float) {
		start = _start;
		current = _current;
		increase = _increase;
		max = _max;
	}
}

@:rtti
@:access(swf.exporters.animate)
class Her extends MovieClip {
	public static var NORMAL_MOOD(default, never):String = "Normal";
	public static var HAPPY_MOOD(default, never):String = "Happy";
	public static var ANGRY_MOOD(default, never):String = "Angry";
	public static var AHEGAO_MOOD(default, never):String = "Ahegao";

    public static var fullUp:Float = -40;
    public static var fullDown:Float = 250;
    public static var range:Float = fullDown - fullUp;

	public static var armPositions:Array<String> = ["Back", "On Legs", "On His Legs", "Hand Job", "Loose"];
	public static var randomArmPositions:Array<String> = ["Back", "On Legs", "On His Legs", "Loose"];

	public static var MouthShapeAH:MouthShape = new MouthShape("AH", 51, 61, -4.6);
	public static var MouthShapeOO:MouthShape = new MouthShape("OO", 59, 64, -6.6);
	public static var MouthShapeUH:MouthShape = new MouthShape("UH", 60, 69, -7);
	public static var MouthShapeOH:MouthShape = new MouthShape("OH", 45, 51, -2.6);
	public static var MouthShapeEE:MouthShape = new MouthShape("EE", 71, 67, -8.4);
	public static var MouthShapeFF:MouthShape = new MouthShape("FF", 65, 75, -9);
	public static var MouthShapeMM:MouthShape = new MouthShape("MM", 79, 75, -11.6);

	public static var allMouthShapes:Array<MouthShape> = [
		MouthShapeAH,
		MouthShapeOO,
		MouthShapeUH,
		MouthShapeOH,
		MouthShapeEE,
		MouthShapeFF,
		MouthShapeMM
	];

	@:keep public var blush(default, null):MovieClip;
	@:keep public var bottomLipstick(default, null):MovieClip;
	@:keep public var collarContainer(default, null):CollarContainer;
	@:keep public var ear(default, null):BasicTannable;
	@:keep public var earrings(default, null):Earrings;
	@:keep public var eye(default, null):HerEye;
	@:keep public var eyewear(default, null):MovieClip;
	@:keep public var freckles(default, null):obj.her.Freckles;
	@:keep public var gagBack(default, null):MovieClip;
	@:keep public var gagFront(default, null):MovieClip;
	@:keep public var hairBetweenLayer(default, null):MovieClip;
	@:keep public var hairCostumeUnderLayer(default, null):MovieClip;
	@:keep public var hairBackContainer(default, null):HairBackContainer;
	@:keep public var hairMidContainer(default, null):HerHairMidContainer;
	@:keep public var hairTop(default, null):MovieClip;
	@:keep public var head(default, null):HerHead;
	@:keep public var leftArmContainer(default, null):HerLeftArmContainer;
	@:keep public var leftEyebrow(default, null):HerLeftEyebrow;
	@:keep public var leftHandOverContainer(default, null):MovieClip;
	@:keep public var leftHandOver(default, null):LeftHandOver;
	@:keep public var rightForeArmContainer(default, null):HerRightForeArmContainer;
	@:keep public var rightArmContainer(default, null):HerRightArmContainer;
	@:keep public var rightArmEraseContainer(default, null):HerRightArmEraseContainer;
	@:keep public var rightEyebrow(default, null):HerRightEyebrow;
	@:keep public var rightHandOver(default, null):MovieClip;
	@:keep public var tears(default, null):obj.her.Tears;
	@:keep public var tongueContainer(default, null):TongueContainer;
	@:keep public var topLipTongue(default, null):sDT_1_21_1b_fla.TopLipTongue_218;
	@:keep public var topLipstickContainer(default, null):HerTopLipstickContainer;
	@:keep public var torso(default, null):Torso;
	@:keep public var torsoBack(default, null):TorsoBack;
	@:keep public var torsoBackCostume(default, null):TorsoBackCostume;
	@:keep public var torsoUnderCostume(default, null):TorsoUnderCostume;
	@:keep public var leftLegContainer(default, null):LegContainer;

	public var backModContainer:Sprite = new Sprite();

	public var initialised:Bool = false;

	public var userHasClicked:UInt = 0;
	public var heldTimer:UInt = 0;
	public var tan(default, null):Tan;
	public var penisControl(default, null):HerPenisControl;
	public var mood(default, null):String = NORMAL_MOOD;
	public var deepthroatDistance:Float = 150;
	public var deepthroatStartDistance:Float = 75;
	public var hiltDistance:Float = 0;
	public var releasedPos:Float = -0.15;
	public var maxPos:Float = 1.02;
	public var minPos:Float = -0.25;
	public var pos:Float = 0;
	public var speed:Float = 0;
	public var acceleration:Float = 0;
	public var speedFriction:Float = 0.5;
	public var moveSmoothing:Float = 3;
	public var mouseHeld:Bool = false;
	public var penisOutDelay:UInt = 0;
	public var lastPenisDirection:Float = -1;
	public var penisInMouthDist:Float = 0;
	public var currentPenisTipPos:Float = 0;
	public var mouthLength:Float = 0;
	public var penisTipMouthOffset:Float = 0;
	public var intro:Bool = true;
	public var introStartDist:Float = 80;
	public var maxIntroDist:Float = Math.NaN;
	public var introRelaxDist:Float = 15;
	public var introPosToBeMoved:Bool = false;
	public var firstDT:Bool = true;
	public var movement:Float = 0;
	public var absMovement:Float = 0;
	public var previousMovement:Float = 0;
	public var lastYPos:Float = Math.NaN;
	public var absYMovement:Float = 0;
	public var vigour:Float = 0;
	public var VIGOUR_WINCE_LEVEL:UInt = 1000;
	public var downTravel:Float = 0;
	public var upTravel:Float = 0;
	public var HAND_JOB_HAND_WIDTH:Float = 70;
	public var movingHeadWithHandJob:Bool = false;
	public var handJobDistance:Float = Math.NaN;
	public var doubleHandJobDistance:Float = Math.NaN;
	public var workingHandJobDistance:Float = Math.NaN;
	public var workingHandJobOffset:Float = Math.NaN;
	public var handJobPenisWidth:Float = 100;
	public var handJobHeadPadding:Float = Math.NaN;
	public var lastHeadPos:Point = new Point();
	public var rightHandAngleOffset:Float = 0;
	public var leftHandAngleOffset:Float = 0;
	public var torsoJointAng:Float = 0;
	public var torsoJointDist:Float = 0;
	public var minBodyScale:Float = 0.95;
	public var maxBodyScale:Float = 1.075;
	public var bodyScale:Float = 1.0;
	public var headTilt:Float = 0;
	public var headTiltScaling:Float = 1;
	public var headTiltTarget:Float = 0;
	public var headTiltAngle:Float = 0;
	public var breathingFactor:Float = 0;
	public var randomMotion:RandomMotion = new RandomMotion(0, 0, 0, 0);
	public var previousPos:Float = 0;
	public var cheekBulgeTarget:Float = 0;
	public var cheekSuckTarget:Float = 0;
	public var suckPower:Float = 0;
	public var neckSkinOffset:Float = 2;
	public var offActionTimer:UInt = 0;
	public var offActionTime:UInt = 9000;
	public var noseSquashUp:LinearTween;
	public var noseSquashDown:LinearTween;
	public var currentNoseSquash:LinearTween;
	public var noseSquashAmount:Float = 0;
	public var lastNoseSquash:Bool = false;
	public var torsoIK:IKController;
	public var leftLegStartPoint:Point;
	public var mHer:Matrix;
	public var mZero:Matrix;
	public var currentLeftArmPosition:UInt = 0;
	public var currentRightArmPosition:UInt = 0;
	public var leftArmFree:Bool = false;
	public var rightArmFree:Bool = false;
	public var leftIsFirstHandJobHand:Bool = false;
	public var armsPushing:Bool = false;
	public var armsPushPower:Float = 0;
	public var armsPushPowerMax:Float = 40;
	public var armsPushTimer:UInt = 0;
	public var rightHandOnLegs:Point = new Point(150, 60);
	public var leftHandOnLegs:Point = new Point(140, 40);
	public var rightHandOnHim:Point = new Point(-125, 240);
	public var leftHandOnHim:Point = new Point(-125, 300);
	public var leftArmIK:IKController;
	public var rightArmIK:IKController;
	public var leftShoulderPos:Point;
	public var rightShoulderPos:Point;
	public var foreArmPos:Point;
	public var armIKOffset:Point = new Point();
	public var armIKOffsetSpeed:Point = new Point();
	public var gagged:Bool = true;
	public var gaggedRotation:Float = 6;
	public var resistance:Resistance = new Resistance(0.01, 0.1, 0, 5);
	public var previousResistance:Float = Math.NaN;
	public var pullOff:Float = 0;
	public var pullOffPower:PullOffPower = new PullOffPower(0.001, 0, 0.00005, 0.008);
	public var pullingOff:Bool = true;
	public var released:Bool = true;
	public var coughing:Bool = false;
	public var coughFactor:Float = 0;
	public var coughBuild:Float = 0;
	public var nextCoughTime:Int = 0;
	public var justCoughed:Bool = false;
	public var startSwallowTimer:UInt = 0;
	public var startSwallowTime:UInt = 30;
	public var closedJawAngle:Float = -12;
	public var swallowTilt:Float = -0.2;
	public var aboveSwallowTilt:Bool = false;
	public var jawAngleTarget:Float = 0;
	public var swallowing:Bool = false;
	public var lipSkinOffset:UInt = 0;
	public var jawBulgeTarget:Int = 0;
	public var swallowTimer:UInt = 0;
	public var swallowPoint:Float = 0;
	public var swallowSequence:SwallowSequence = new SwallowSequence(20, 30, 40, 60);
	public var tongue:Tongue;
	public var topTeethTween:LinearTween;
	public var bottomTeethTween:LinearTween;
	public var clenchTeeth:Bool = false;
	public var clenchTeethRatio:Float = 0;
	public var clenchedTeethTimer:Int = 0;
	public var clenchedTeethTime:UInt = 0;
	public var speaking:Bool = false;
	public var speakStopDelay:UInt = 0;
	public var targetPhoneme:MouthShape = MouthShapeUH;
	public var phonemeDelay:UInt = 0;
	public var lastUpperLipPos:UInt = 0;
	public var lastLowerLipPos:UInt = 0;
	public var eyeMotion:EyeMotion = new EyeMotion(83, 83);
	public var eyelidMotion:EyelidMotion = new EyelidMotion(50, 0, 50, false, 0);
	public var eyePosBlink:UInt = 150;
	public var eyePosWince:UInt = 200;
	public var blinkTime:UInt = 1;
	public var blinkTimer:UInt = 0;
	public var winceTimer:UInt = 0;
	public var lookChangeTimer:Int = -1;
	public var cumInEye:UInt = 0;
	public var leftEyebrowNormalTween:LinearTween;
	public var rightEyebrowNormalTween:LinearTween;
	public var rightEyebrowAngryTween:LinearTween;
	public var leftEyebrowAngryTween:LinearTween;
	public var eyebrowOffsets:Vector<UInt> = new Vector<UInt>();
	public var passedOut:Bool = false;
	public var passOutFactor:Float = 0;
	public var passOutMax:Float = 40;
	public var leftBreastController:BreastController;
	public var rightBreastController:BreastController;
	public var breastCostumeOn:Bool = false;
	public var braStrapController:BraStrap;
	public var shoulderStrapController:BraStrap;
	public var topStrapController:BraStrap;
	public var cumInMouth:UInt = 0;
	public var maxCumInMouth:UInt = 40;
	public var droolingCum:Bool = false;
	public var startedCumDrool:Bool = false;
	public var currentCumDrool:Strand;
	public var cumDroolTimer:UInt = 0;
	public var cumDrool:UInt = 0;
	public var cumDroolNum:UInt = 0;
	public var cumDroolLinkFreq:UInt = 4;
	public var droolingSpit:Bool = false;
	public var startedSpitDrool:Bool = false;
	public var currentSpitDrool:Strand;
	public var spitDroolTimer:UInt = 0;
	public var spitDroolLinkFreq:UInt = 8;
	public var gagDroolTimer:UInt = 0;
	public var wetGenerate:Float = 0;
	public var fullCumInMouth:UInt = 25;
	public var minNostrilSpray:UInt = 5;
	public var nostrilSpraying:Bool = false;
	public var nostrilSprayToggle:Bool = false;
	public var currentNostrilSpray:Strand;
	public var mouthFull:Bool = false;
	public var held:Bool = false;
	public var hilt:Bool = false;
	public var justHilt:Bool = false;
	public var downPlayed:Bool = false;
	public var upPlayed:Bool = false;
	public var breatheDelay:UInt = 0;
	public var breatheDelayTime:UInt = 10;
	public var breathing:Bool = true;
	public var topLipA:Point;
	public var topLipB:Point;
	public var midMouth:Point;
	public var bottomLipA:Point;
	public var bottomLipB:Point;
	public var offBottomLip:Point;
	public var eyelidEnd:Point;
	public var eyelidStart:Point;
	public var nostril:Point;
	public var armConnection:Point;
	public var hairLimits:Array<Float>;
	public var eyeAim:Point;
	public var hisFace:Point;
	public var eyesDown:Point;
	public var eyesUnfocused:Point;
	public var currentLookTarget:Point;
	public var nextLookTarget:Point;
	public var blankEyed:Bool = false;
	public var debug:Sprite;

	public function new() {
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("Ld39TJPQZsVJfqCLrG3m");
		var symbol = library.symbols.get(1982);
		symbol.__initObject(library, this);

         this.previousResistance = this.resistance.upper;

         this.leftBreastController = new BreastController(this.torsoBack.leftBreast,[this.torsoBackCostume.breastCostume]);
         this.rightBreastController = new BreastController(this.torso.midLayer.rightBreast,[this.torso.breastCostume,this.torso.topContainer.breastTop]);
         this.torso.back.cacheAsBitmap = true;
         this.torso.backMask.cacheAsBitmap = true;
         this.torso.back.mask = this.torso.backMask;
         this.backModContainer.name = "backModContainer";
         this.backModContainer.x = this.torso.back.x;
         this.backModContainer.y = this.torso.back.y;
         this.backModContainer.rotation = this.torso.back.rotation;
         this.torso.addChildAt(this.backModContainer,this.torso.getChildIndex(this.torso.back) + 1);
         this.leftEyebrowNormalTween = new LinearTween([this.leftEyebrow]);
         this.rightEyebrowNormalTween = new LinearTween([this.rightEyebrow,this.eye.eyebrowMask]);
         this.leftEyebrowAngryTween = new LinearTween([this.leftEyebrow]);
         this.rightEyebrowAngryTween = new LinearTween([this.rightEyebrow,this.eye.eyebrowMask]);
         this.leftEyebrowAngryTween.skewStart(-4.2,-71.9,0.627,0.997);
         this.leftEyebrowAngryTween.offsetStart(1,-2.25);
         this.leftEyebrowAngryTween.skewEnd(0,-63.4,1,0.557);
         this.leftEyebrowAngryTween.offsetEnd(-2.25,15.25);
         this.rightEyebrowAngryTween.offsetStart(0,0,26);
         this.rightEyebrowAngryTween.offsetEnd(14,8,38);
         this.topTeethTween = new LinearTween([this.head.teeth]);
         this.topTeethTween.offsetEnd(-8.2,13.44);
         this.bottomTeethTween = new LinearTween([this.head.jaw.teeth]);
         this.bottomTeethTween.offsetEnd(5.1,-8.2);
         this.noseSquashUp = new LinearTween([this.head.face.nose,this.head.headTan.face.nose]);
         this.noseSquashUp.skewEnd(2.9,-11.6,0.762,1.041);
         this.noseSquashUp.offsetEnd(1.75,2);
         this.noseSquashDown = new LinearTween([this.head.face.nose,this.head.headTan.face.nose]);
         this.noseSquashDown.skewEnd(-2,11.5,0.712,1.02);
         this.noseSquashDown.offsetEnd(3.5,2);
         this.currentNoseSquash = this.noseSquashUp;
         this.x = fullUp;
         this.y = 275;
         this.tongue = this.tongueContainer.tongue;
         this.torsoIK = new IKController(this,this.torso,this.torso.leg,this.torso.rightCalfContainer.calf);
         this.updateKneeTarget();
         this.torsoIK.rescale(this.bodyScale);
         this.leftLegStartPoint = new Point(this.leftLegContainer.leg.x,this.leftLegContainer.leg.y);
         this.tears.addLowerEyelidMascaraLayer(this.eye.lowerEyelid.mascaraContainer);
         G.hairUnderLayer = this.hairMidContainer.hairUnderLayer;
         G.hairBetweenLayer = this.hairBetweenLayer;
         G.hairUnder = this.hairMidContainer.hairUnder;
         G.hairBottom = this.hairMidContainer.hairBottom;
         G.hairCostumeUnder = this.hairCostumeUnderLayer;
         G.characterControl.addBreastSizeChangeListener(this.breastSizeChanged);
         G.characterControl.braControl.registerListener(this.breastCostumeChanged);
         G.characterControl.topControl.registerListener(this.breastCostumeChanged);
         this.braStrapController = new BraStrap(this.torso.braStrap,this.torso.breastCostume.bra,"strapPoint",G.characterControl.braControl);
         this.shoulderStrapController = new BraStrap(this.torso.shoulderStrap,this.torso.breastCostume.bra,"shoulderStrapPoint",G.characterControl.braControl);
         this.topStrapController = new BraStrap(this.torso.topContainer.topStrap,this.torso.topContainer.breastTop,"strapPoint",G.characterControl.topControl);
         this.torso.nipplePiercing.setLimit(20);
         this.torso.leftNipplePiercing.setLimit(20);
         this.torso.chestCostume.bellyPiercing.setLimit(30);
         this.head.face.gotoAndStop("Normal");
         this.head.headTan.face.gotoAndStop("Normal");
         EventBus.addListener("penisTipPosChanged",this.updatePenisTipPos);
         this.freckles.cacheAsBitmap = true;
	}

	public function getDataString():String {
		return this.penisControl.getDataString();
	}

	public function loadDataPairs(param1:Array<Array<String>>) {
		this.penisControl.loadDataPairs(param1);
	}

	public function updatePenisTipPos() {
		this.currentPenisTipPos = G.animationControl.estimateTipPos();
	}

	public function updateKneeTarget() {
		this.torsoIK.newTarget(G.animationControl.getHerKneeTarget(), G.sceneLayer, true);
	}

	public function setupTan() {
		this.tan = new Tan();
	}

	public function setMenu(param1:MovieClip, param2:Array<ASAny>) {
		this.penisControl = new HerPenisControl();
		this.penisControl.setMenu(param1, param2);
	}

	public function initialise() {
		this.setIntroResistance(G.defaultResistance);
		this.startIntro();
		this.hisPenisSizeChanged(G.him.currentPenisLength);
		this.updatePenisTipPos();
		this.initialised = true;
	}

	public function giveArmContainers(param1:HerLeftArmContainer, param2:HerRightArmContainer, param3:HerRightForeArmContainer,
			param4:HerRightArmEraseContainer, param5:LeftHandOver) {
		this.rightArmContainer = param2;
		this.rightArmEraseContainer = param4;
		this.rightForeArmContainer = param3;
		this.leftArmContainer = param1;
		this.leftHandOver = param5;
		this.leftHandOver.visible = false;
		this.rightArmContainer.blendMode = BlendMode.LAYER;
		this.rightArmEraseContainer.visible = false;
		this.leftArmIK = new IKController(this.torso, this.leftArmContainer.upperArm, this.leftArmContainer.upperArm.foreArm,
			this.leftArmContainer.upperArm.foreArm.hand);
		this.rightArmIK = new IKController(this.torso, this.rightArmContainer.upperArm, this.rightForeArmContainer.upperArm.foreArm,
			this.rightForeArmContainer.upperArm.foreArm.hand);
		this.leftArmIK.rescale(0.95);
		this.leftShoulderPos = new Point(this.leftArmContainer.upperArm.x, this.leftArmContainer.upperArm.y);
		this.rightShoulderPos = new Point(this.rightArmContainer.upperArm.x, this.rightArmContainer.upperArm.y);
		this.foreArmPos = new Point(this.rightForeArmContainer.upperArm.foreArm.x, this.rightForeArmContainer.upperArm.foreArm.y);
		this.setLeftArmPosition(this.currentLeftArmPosition);
		this.setRightArmPosition(this.currentRightArmPosition);
	}

	public function getPositionLength(param1: Point):Float {
		return param1.x * param1.x + param1.y * param1.y;
	}

	public function mousePressed(param1:MouseEvent = null) {
		this.mouseHeld = true;
	}

	public function movementHeld() {
		if (!this.mouthFull && !G.shiftDown) {
			G.setPenisOut(true);
		}
	}

	public function mouseReleased(param1:MouseEvent) {
		this.movementRelease();
	}

	public function movementRelease() {
		this.penisOutDelay = 0;
		if (this.mouseHeld) {
			this.mouseHeld = false;
		}
		if (this.movingHeadWithHandJob) {
			this.movingHeadWithHandJob = false;
		}
	}

	public function activeHold(param1:Bool = true) {
		if (this.mouthFull) {
			this.pullOff /= 2;
		}
		if (this.clenchTeeth) {
			this.clenchedTeethTimer += 25;
		}
		if (this.held) {
			if (param1) {
				++this.userHasClicked;
				if (this.userHasClicked >= 3) {
					// G.clickPrompt.fadeOut();
				}
			}
			G.dialogueControl.buildState(Dialogue.HELD, Dialogue.TICK_BUILD);
		}
	}

	@:flash.property public var bodySize(get, never):Float;

	function get_bodySize():Float {
		return (this.bodyScale - this.minBodyScale) / (this.maxBodyScale - this.minBodyScale);
	}

	public function setDefaultBodyScale() {
		this.bodyScale = 1;
		this.setBodyScale(this.bodyScale);
	}

	public function setBodyScaleFromSlider(param1:Float) {
		this.bodyScale = this.minBodyScale + param1 * (this.maxBodyScale - this.minBodyScale);
		this.setBodyScale(this.bodyScale);
	}

	public function setBodyScale(param1:Float) {
		this.bodyScale = Maths.clampf(param1, this.minBodyScale, this.maxBodyScale);
		var _loc2_ = 1 + (this.bodyScale - 1) * 0.5;
		this.head.neck.scaleX = _loc2_;
		this.head.neck.scaleY = _loc2_;
		this.collarContainer.scaleX = _loc2_;
		this.collarContainer.scaleY = _loc2_;
		this.torsoIK.rescale(this.bodyScale);
		this.updateTorso();
		this.updateArms();
		this.updateNeck();
	}

	public function setLipSkinOffset(param1:UInt) {
		this.lipSkinOffset = param1;
	}

	public function setSpeaking(param1:Bool) {
		if (param1) {
			G.automaticControl.dialogueStarting();
			this.tongue.startFastIn();
			this.clenchTeeth = false;
			this.changeLookTarget(this.hisFace, 0, 1);
		} else if (this.speaking) {
			this.speakStopDelay = 3;
		}
		this.speaking = param1;
	}

	public function isSpeaking():Bool {
		return this.speaking;
	}

	public function canSpeak():Bool {
		if (!this.gagged && !this.speaking && !this.mouthFull && !this.passedOut && !this.swallowing && !this.clenchTeeth) {
			return true;
		}
		return false;
	}

	@:flash.property public var teethClenched(get, never):Bool;

	function get_teethClenched():Bool {
		return this.clenchTeeth;
	}

	public function setTargetPhoneme(param1:obj.dialogue.Word.Phoneme, param2:UInt = 0) {
		if (param1.phoneme != null) {
			this.targetPhoneme = param1.phoneme;
			this.phonemeDelay = param2;
			if (G.tongue && param1.sayL && !this.tongue.tongueOut && this.topLipTongue.currentFrameLabel == "Hidden") {
				this.topLipTongue.gotoAndPlay("SayL");
			}
		}
	}

	public function findLeftArmPosition(param1:String) {
		var _loc2_:UInt = armPositions.length;
		var _loc3_:UInt = 0;
		while (_loc3_ < _loc2_) {
			if (G.dataName(armPositions[_loc3_]) == G.dataName(param1)) {
				this.setLeftArmPosition(_loc3_);
				break;
			}
			_loc3_++;
		}
	}

	public function findRightArmPosition(param1:String) {
		var _loc2_:UInt = armPositions.length;
		var _loc3_:UInt = 0;
		while (_loc3_ < _loc2_) {
			if (G.dataName(armPositions[_loc3_]) == G.dataName(param1)) {
				this.setRightArmPosition(_loc3_);
				break;
			}
			_loc3_++;
		}
	}

	public function setArmPosition(param1:Int = -1, param2:Bool = true) {
		this.setLeftArmPosition(param1, param2);
		this.setRightArmPosition(param1, param2);
	}

	public function setRandomArmPosition() {
		if (armPositions[this.currentLeftArmPosition] != "Hand Job") {
			this.setLeftArmPosition(Std.int(Math.ffloor(Math.random() * (randomArmPositions.length - 1))), true);
		}
		if (armPositions[this.currentRightArmPosition] != "Hand Job") {
			this.setRightArmPosition(Std.int(Math.ffloor(Math.random() * (randomArmPositions.length - 1))), true);
		}
	}

	public function setLeftArmPosition(param1:Int = -1, param2:Bool = true) {
		if (param1 == -1) {
			param1 = this.currentLeftArmPosition;
		}
		this.leftHandOver.visible = false;
		switch (param1) {
			case 1:
				G.changeLayer(this.leftArmContainer, this, this.leftLegContainer);
				this.leftArmIK.stopDropping();
			    this.leftArmIK.newTarget(this.leftHandOnLegs,this.leftLegContainer.leg,true);
			    this.leftArmIK.setEndRotationTarget(-50,[G.her.torso.leg,G.her.torso]);

			case 2:
				G.changeLayer(this.leftArmContainer, G.backLayer);
				this.leftArmIK.stopDropping();
			    this.leftArmIK.newTarget(this.leftHandOnHim,G.him.rightLeg,true);
			    this.leftArmIK.setEndRotationTarget(-170,[G.him.rightLeg]);

			case 3:
				G.changeLayer(this.leftArmContainer, G.backLayer);
				if (G.penisOut) {
					G.frontLayer.addChildAt(this.leftHandOver, G.frontLayer.getChildIndex(G.himOverLayer));
				} else {
					G.changeLayer(this.leftHandOver, this.leftHandOverContainer);
				}
				this.leftArmIK.stopDropping();
				this.leftHandOver.visible = true;
				param2 = true;

			case 4:
				if (this.currentLeftArmPosition != 4) {
					this.leftArmIK.newTarget(this.leftHandOnLegs,this.leftLegContainer.leg,false);
					this.leftArmIK.setEndRotationTarget(-50,[G.her.torso.leg,G.her.torso]);
				}
				this.startArmsPassOut(true, false);
		}
		this.currentLeftArmPosition = param1;
		this.checkHandJobMode();
		if (this.passedOut) {
			this.startArmsPassOut();
		}
		if (param2) {
			if (this.currentLeftArmPosition > 0) {
				this.setLeftArmFree(true);
			} else {
				this.setLeftArmFree(false);
			}
			this.updateTorso();
			this.updateArms();
		}
		if (this.tan != null) {
			this.tan.updateSkin();
		}
		G.characterControl.setNailPolish(G.characterControl.nailPolishRGB);
	}

	public function setRightArmPosition(param1:Int = -1, param2:Bool = true) {
		if (param1 == -1) {
			param1 = this.currentRightArmPosition;
		}
		switch (param1) {
			case 1:
				this.rightArmIK.stopDropping();
			    this.rightArmIK.newTarget(this.rightHandOnLegs,this.torso.leg,true);
			    this.rightArmIK.setEndRotationTarget(-50,[G.her.torso.leg,G.her.torso,G.her]);

			case 2:
				this.rightArmIK.stopDropping();
			    this.rightArmIK.newTarget(this.rightHandOnHim,G.him.leftLeg,true);
			    this.rightArmIK.setEndRotationTarget(-170,[G.him.leftLeg]);

			case 3:
				this.rightArmIK.stopDropping();
				param2 = true;

			case 4:
				if (this.currentRightArmPosition != 4) {
					this.rightArmIK.newTarget(this.rightHandOnLegs,this.torso.leg,false);
					this.rightArmIK.setEndRotationTarget(-50,[G.her.torso.leg,G.her.torso,G.her]);
				}
				this.startArmsPassOut(false, true);
		}
		this.currentRightArmPosition = param1;
		this.checkHandJobMode();
		if (this.passedOut) {
			this.startArmsPassOut();
		}
		if (param2) {
			if (this.currentRightArmPosition > 0) {
				this.setRightArmFree(true);
			} else {
				this.setRightArmFree(false);
			}
			this.updateTorso();
			this.updateArms();
		}
		if (this.tan != null) {
			this.tan.updateSkin();
		}
		G.characterControl.setNailPolish(G.characterControl.nailPolishRGB);
	}

	public function setLeftArmFree(param1:Bool) {
		this.leftArmFree = param1;
		this.leftArmContainer.upperArm.visible = this.leftArmFree;
		this.leftArmContainer.upperArmCostume.visible = this.leftArmFree;
		this.torso.cuffs.visible = !this.leftArmFree;
		this.torso.nailPolish.visible = !this.leftArmFree;
		this.torso.leftGlove.visible = !this.leftArmFree;
		this.torso.midLayer.leftArm.visible = !this.leftArmFree;
		G.characterControl.setArmSkin();
		G.characterControl.armwearControl.resetElement();
	}

	public function setRightArmFree(param1:Bool) {
		this.rightArmFree = param1;
		if (this.rightArmFree) {
			this.updateArms();
		} else {
			this.rightArmContainer.upperArm.rotation = 53;
			this.rightArmContainer.upperArmCostume.rotation = 53;
			this.rightArmContainer.upperArmMask.rotation = 53;
		}
		this.rightForeArmContainer.upperArm.foreArm.visible = this.rightArmFree;
		this.rightForeArmContainer.upperArmCostume.foreArmCostume.visible = this.rightArmFree;
		this.torso.rightGlove.visible = !this.rightArmFree;
		this.torso.behindBackRightArm.visible = !this.rightArmFree;
		G.characterControl.setArmSkin();
		G.characterControl.armwearControl.resetElement();
	}

	public function checkHandJobMode() {
		this.leftIsFirstHandJobHand = G.leftHandJobMode;
		G.leftHandJobMode = armPositions[this.currentLeftArmPosition] == "Hand Job";
		G.rightHandJobMode = armPositions[this.currentRightArmPosition] == "Hand Job";
		if (G.leftHandJobMode || G.rightHandJobMode) {
			G.soundControl.startRub();
			if (G.leftHandJobMode && G.rightHandJobMode) {
				this.handJobHeadPadding = 0.4;
			} else {
				this.handJobHeadPadding = 0.25;
			}
		} else {
			G.soundControl.stopRub();
		}
		this.rightArmEraseContainer.visible = G.rightHandJobMode;
	}

	public function isRightArmFree():Bool {
		return this.rightArmFree;
	}

	public function isLeftArmFree():Bool {
		return this.leftArmFree;
	}

	public function setMood(param1:String) {
		this.mood = param1;
		this.head.face.gotoAndStop(param1);
		this.head.headTan.face.gotoAndStop(param1);
		this.topLipstickContainer.gotoAndStop(param1);
		this.updateLips();
		this.updateEyes();
		G.characterControl.setLipFills();
		if (this.mood == AHEGAO_MOOD) {
			this.tongue.hangOut();
		} else {
			this.tongue.stopHangingOut();
		}
		if (this.mood != ANGRY_MOOD) {
			this.clenchTeeth = false;
		}
	}

	public function setGagged(param1:Bool) {
		this.gagged = param1;
		if (this.gagged) {
			this.head.jaw.rotation = this.head.jawBack.rotation = this.gaggedRotation;
			this.head.headTan.jaw.rotation = this.head.headTan.jawBack.rotation = this.gaggedRotation;
			this.updateLips();
			this.randomGagDroolTimer();
		}
	}

	public function isGagged():Bool {
		return this.gagged;
	}

	public function tongueToggled() {
		if (G.tongue) {
			this.tongue.startMovingTongue("out");
		} else {
			this.tongue.startMovingTongue("in");
		}
	}

	public function throatBulgeChanged() {
		this.head.neck.throatBulge = G.throatBulgeAmount;
		this.updateNeck();
	}

	public function breathingToggled() {
		if (!G.breathing && this.breathing) {
			this.breathing = G.soundControl.stopBreathing();
		} else if (!this.breathing) {
			G.setBreathTo(0);
			this.checkBreathing(true);
		}
	}

	public function breastCostumeChanged(param1:String) {
		if (G.characterControl.braControl.selectedName == "None" && G.characterControl.topControl.selectedName == "None") {
			this.breastCostumeOn = false;
		} else {
			this.breastCostumeOn = true;
		}
		var hidden: Bool = G.characterControl.braControl.selectedName != "None";
		this.torsoBack.leftBreast.nipple.visible = !hidden;
		this.torso.midLayer.rightBreast.nipple.visible = !hidden;
		this.torso.nipplePiercing.visible = !hidden;
		this.torso.leftNipplePiercing.visible = !hidden;
		this.updateBreastFirmness();
	}

	public function startIntro() {
		if (this.passedOut) {
			this.wakeUp();
		}
		this.pullingOff = true;
		this.firstDT = true;
		this.intro = true;
		this.maxIntroDist = this.introStartDist;
		G.automaticControl.resetSelfMode();
		G.dialogueControl.reset();
	}

	public function setHandsFree() {
		this.pullingOff = true;
	}

	public function setIntroResistance(param1:Float) {
		this.introRelaxDist = Math.max(0.25, 25 - param1 * 0.25);
		G.introResistance = param1;
	}

	public function setThroatResistance(param1:Float) {
		this.resistance.boundary = Math.max(0, Math.min(100, param1)) * 0.002;
		G.throatResistance = param1;
	}

	public function setFreckleAmount(param1:Float) {
		this.freckles.setFreckleAmount(param1);
	}

	public function giveHairBackContainer(param1:HairBackContainer) {
		this.hairBackContainer = param1;
	}

	public function clearMascara() {
		this.tears.clearMascara();
	}

	public function clearTearSpots() {
		this.tears.clearTearSpots();
	}

	public function isInMouth():Bool {
		return this.mouthFull;
	}

	public function isActingOff():Bool {
		if (if (this.speaking) this.speaking else this.tongue.block() || this.swallowing && !this.mouthFull) {
			return true;
		}
		return false;
	}

	public function isReleased():Bool {
		if (this.pullingOff || this.released) {
			return true;
		}
		return false;
	}

	public function getHeadTilt():Float {
		return this.headTilt;
	}

	public function getPenisMouthOffset():Float {
		return this.penisTipMouthOffset - this.mouthLength * 0.5;
	}

	public function getPenisMouthDist():Float {
		return this.penisInMouthDist;
	}

	public function hisPenisSizeChanged(param1:Float) {
		this.hiltDistance = param1 - 25;
		this.handJobDistance = G.him.currentPenisFullLength;
		this.doubleHandJobDistance = this.handJobDistance - this.HAND_JOB_HAND_WIDTH / G.him.penisLengthScale;
		if (this.initialised) {
			this.updateElements();
			this.updateArms();
		}
	}

	public function getPenisTiltInterp():Float {
		if (this.gagged) {
			if (this.penisInMouthDist > 100) {
				return 1;
			}
			if (this.penisInMouthDist < 0) {
				return 0;
			}
			return this.penisInMouthDist * 0.01;
		}
		if (this.penisInMouthDist > 25) {
			return 1;
		}
		if (this.penisInMouthDist < -25) {
			return 0;
		}
		return (this.penisInMouthDist + 25) * 0.02;
	}

	public function pushPenisTilt():Float {
		var _loc1_:Float = this.tongue.getPush();
		var _loc2_ = this.tongue.localToGlobal(this.tongue.tip);
		if (G.him.penis.hitTestPoint(_loc2_.x, _loc2_.y, true)) {
			if (this.tongue.touched()) {
				if (Math.random() > 0.8) {
					this.generateTongueStrand();
				}
				G.dialogueControl.buildState(Dialogue.LICK_PENIS, Dialogue.ONE_OFF_BUILD);
			}
		}
		if (G.him.balls.hitTestPoint(_loc2_.x, _loc2_.y, true)) {
			this.tongue.touched();
			G.him.balls.pushBalls(-1 * _loc1_, _loc1_ * 20);
			G.dialogueControl.buildState(Dialogue.LICK_BALLS, Dialogue.FRAME_BUILD);
		}
		var _loc3_:Float = 0;
		if (G.penisOut && this.penisInMouthDist > 0) {
			_loc3_ = (this.headTilt - 0.5) * (0.2 + this.absMovement * 0.01);
		}
		var _loc4_ = G.handJobMode && !this.passedOut ? -G.currentHandJobPos.y * 1.2 : 0;
		return _loc1_ + _loc3_ + _loc4_;
	}

	public function ejaculating() {
		this.shock(10);
		if (Math.random() > 0.5) {
			this.changeLookTarget(this.eyesDown, 5, 5);
			if (this.mood == ANGRY_MOOD && !this.mouthFull) {
				this.startClenchingTeeth();
			}
		}
		if (this.held && Math.random() > 0.5 && this.aboveSwallowTilt) {
			this.swallow();
		}
	}

	public function suck() {
		this.suckPower += 0.3;
	}

	public function shock(param1:UInt) {
		this.eyelidMotion.shock = param1;
		if (Math.random() > 0.5) {
			this.blink(false);
		}
	}

	public function cumOnFace() {
		G.dialogueControl.buildState(Dialogue.CUM_ON_FACE, Dialogue.TICK_BUILD * 2);
		if (this.mood == HAPPY_MOOD || this.mood == AHEGAO_MOOD) {
			this.wetGenerate += this.swallowSequence.intensity * 10;
		}
	}

	public function eyeHit() {
		++this.cumInEye;
		this.closeEye();
	}

	public function eyeClearHit() {
		if (this.cumInEye > 0) {
			--this.cumInEye;
			if (this.cumInEye == 0) {
				this.openEye();
			}
		}
	}

	public function closeEye() {
		this.eyelidMotion.pos = this.eyePosBlink + 20;
		this.eyelidMotion.isClosed = true;
		this.eyelidMotion.closedTimer = 0;
		this.lookChangeTimer = -1;
	}

	public function openEye() {
		this.eyelidMotion.isClosed = false;
	}

	public function getArmPoint():Point {
		return this.localToGlobal(this.armConnection);
	}

	public function debugMove(param1:Point) {
		this.x = param1.x;
		this.y = param1.y;
		this.mHer = this.transform.matrix;
		this.updateElements();
	}

	public function debugRotate(param1:Float) {
		this.rotation = param1;
		this.mHer = this.transform.matrix;
		this.updateElements();
	}

	public function move(param1:Float, param2:Float):Float {
		var _loc4_:Point = null;
		G.animationControl.update();
		this.updateBlink();
		Sweat.staticTick();
		if (Math.random() < G.breathLevel / G.breathLevelMax && Math.random() > 0.9) {
			if (Math.random() > 0.5) {
				new Sweat(this.head,new Point(21,-65),new Point(150,100),[this.rightArmContainer.upperArm,this.torso.back,this.torso.midLayer.chest,this.torso.midLayer.rightBreast.hitArea,this.torso.leg]);
			} else {
				new Sweat(this.torso.back,new Point(110,-230),new Point(320,100),[this.torso.midLayer.chest,this.torso.midLayer.rightBreast.hitArea,this.torso.leg]);
			}
		}
		if (this.mouseHeld) {
			if (!G.penisOut && !G.handJobMode) {
				if (this.penisOutDelay < 5) {
					++this.penisOutDelay;
				} else {
					this.movementHeld();
				}
			}
			if (G.handJobMode) {
				this.movingHeadWithHandJob = true;
			}
		}
		if (G.penisOut || this.movingHeadWithHandJob) {
			if (param2 > 0.8) {
				G.dialogueControl.buildState(Dialogue.PULLED_DOWN, Dialogue.FRAME_BUILD);
			} else if (param2 < -0.8) {
				G.dialogueControl.buildState(Dialogue.PULLED_UP, Dialogue.FRAME_BUILD);
			}
		}
		if (this.movingHeadWithHandJob || G.autoModeOn) {
			this.lastHeadPos.x = G.currentMousePos.x;
			this.lastHeadPos.y = G.currentMousePos.y;
			if (!G.penisOut) {
				if (G.leftHandJobMode && G.rightHandJobMode) {
					this.lastHeadPos.x = Math.min(0.8, this.lastHeadPos.x);
				} else {
					this.lastHeadPos.x = Math.min(0.9, this.lastHeadPos.x);
				}
			}
		}
		if (!this.movingHeadWithHandJob || G.autoModeOn) {
			G.targetHandJobPos.x = param1 / 1.2;
			G.targetHandJobPos.y = param2 - Math.max(-0.3, Math.min(0.3, this.rightHandAngleOffset * 0.05));
		}
		if (G.handJobMode) {
			param1 = this.lastHeadPos.x;
			param2 = this.lastHeadPos.y;
		}
		if (this.pullingOff && !this.passedOut && !G.handsOff) {
			if (this.released) {
				this.acceleration = (this.releasedPos - this.pos) / this.moveSmoothing;
			} else {
				this.acceleration = (this.releasedPos - this.pos) / 5;
			}
			if (param1 < this.pos + 0.3 && !G.handsOff) {
				this.pullingOff = false;
				if (this.released) {
					this.released = false;
					G.soundControl.playGrab();
					G.dialogueControl.buildState(Dialogue.HEAD_GRABBED, Dialogue.ONE_OFF_BUILD);
				}
				G.him.closeHand();
			}
		} else {
			this.acceleration = (param1 - this.pos) / this.moveSmoothing;
		}
		this.speed += this.acceleration;
		if (!this.passedOut) {
			if (this.penisInMouthDist > 0 && this.acceleration > 0) {
				this.speed -= this.previousResistance + this.armsPushPower * 0.001;
			}
			if (!G.handsOff) {
				this.speed -= this.pullOff;
			}
		}
		this.speed *= this.speedFriction;
		this.pos = Math.max(this.minPos, Math.min(this.maxPos, this.pos + this.speed));
		if (this.intro && !G.penisOut) {
			this.pos -= Math.max(0, (this.penisInMouthDist - this.maxIntroDist) * 0.0015);
		}
		if (!this.mouthFull && this.clenchTeeth && !G.penisOut && !this.gagged) {
			if (this.penisInMouthDist > 0) {
				this.clenchedTeethTimer = Std.int(Math.max(0, this.clenchedTeethTimer - 1));
			} else if (this.pos < 0.1) {
				++this.clenchedTeethTimer;
			}
			this.pos -= Math.max(0, this.penisInMouthDist + 25) * 0.002;
			this.pos = Math.min(this.currentPenisTipPos - 0.05, this.pos);
		}
		var _loc3_ = this.pos;
		this.generateSpit();
		this.movement = this.pos * range - this.previousPos * range;
		this.absMovement = this.movement > 0 ? this.movement : -this.movement;
		this.vigour += !!G.penisOut ? this.absMovement * 0.2 : this.absMovement;
		this.vigour = Math.min(1050, Math.max(0, this.vigour - 20));
		if (this.mood == HAPPY_MOOD || this.mood == AHEGAO_MOOD) {
			if (this.movement < 0 && !this.passedOut) {
				this.suck();
			}
			this.wetGenerate += this.vigour * (this.mood == AHEGAO_MOOD ? 0.02 : 0.01);
			if (this.wetGenerate > 500 + Math.random() * 300) {
				this.generateWetness();
			}
		}
		if (this.vigour > this.VIGOUR_WINCE_LEVEL) {
			this.wince();
		}
		if (this.vigour > 600) {
			G.dialogueControl.buildState(Dialogue.VIGOROUS, Dialogue.FRAME_BUILD);
		}
		if (this.released && !G.handsOff && !G.handJobMode) {
			this.headTiltTarget = 0;
		} else {
			this.headTiltTarget = param2 * this.headTiltScaling;
			if (G.penisOut) {
				this.headTiltScaling = Math.max(0, Math.min(1, 1 - this.pos * 1.25 * (1 - G.animationControl.penisOutTransition)));
			} else {
				this.headTiltScaling = Math.max(0, Math.min(1, 1 - this.pos * 1.25));
			}
		}
		this.tickSwallowing();
		this.headTilt += (this.headTiltTarget - this.headTilt) * 0.25;
		if (param2 < this.swallowTilt) {
			if (!this.aboveSwallowTilt) {
				this.aboveSwallowTilt = true;
				if (Math.random() > 0.2) {
					this.changeLookTarget(this.hisFace);
				}
			}
		} else if (this.aboveSwallowTilt) {
			this.aboveSwallowTilt = false;
		}
		this.updatePosition();
		this.checkMovementSounds();
		this.checkBreathing();
		this.checkPosition();
		this.animateBreathing();
		this.updateElements();
		this.tongue.update(this.pos, this.movement, this.absMovement, this.vigour);
		this.penisControl.update();
		if (this.droolingCum) {
			this.tickCumDrool();
		}
		if (this.nostrilSpraying) {
			this.tickNostrilSpray();
		}
		if (this.gagged || this.mood == AHEGAO_MOOD) {
			if (this.gagDroolTimer > 0) {
				--this.gagDroolTimer;
			} else {
				this.randomSpitDrool();
				this.randomGagDroolTimer();
			}
		}
		if (this.droolingSpit) {
			this.tickSpitDrool();
		}
		if (this.userHasClicked < 3 && this.held) {
			++this.heldTimer;
		}
		if (G.smearLipstick && this.mouthFull && this.absMovement > 10) {
			G.him.smearLipstick(this.pos, this.absMovement);
		}
		if (G.coughing) {
			this.tickCoughBuild();
		}
		if (this.held) {
			if (Math.random() + 0.97 < G.breathLevel / G.breathLevelMax) {
				this.tapHands();
			}
		}
		if (armPositions[this.currentLeftArmPosition] == "On Him" || armPositions[this.currentRightArmPosition] == "On Him") {
			this.slipHands();
		}
		if (this.armsPushing) {
			if (this.armsPushTimer > 0) {
				--this.armsPushTimer;
				if (this.armsPushPower < this.armsPushPowerMax) {
					this.armsPushPower = Math.min(this.armsPushPower + 4, this.armsPushPowerMax);
				}
			} else {
				this.armsPushing = false;
			}
		} else if (this.armsPushPower > 0) {
			this.armsPushPower *= 0.8;
			if (this.armsPushPower < 0.05) {
				this.armsPushPower = 0;
			}
		}
		this.tears.tick(this.rotation);
		if (G.penisOut && G.smudging) {
			_loc4_ = G.him.getPenisTipPoint(45, -8);
			this.tears.smudge(_loc4_);
			G.strandControl.smearStrands(_loc4_, 25);
			G.clearSmudgeCache();
		}
		this.previousMovement = this.movement;
		this.previousPos = this.pos;
		this.updateHairLimits();
		return _loc3_;
	}

	public function updateHairLimits() {
		this.hairLimits[0] = -this.pos * 0.6;
		this.hairLimits[1] = -this.pos * 1.2;
		this.hairLimits[2] = 1 - this.pos;
	}

	public function passOut() {
		this.passOutFactor = this.passOutMax;
		G.soundControl.playPassOut(this.pos);
		this.passedOut = true;
		this.startArmsPassOut();
	}

	public function startArmsPassOut(param1:Bool = true, param2:Bool = true) {
		if (param1) {
			if (armPositions[this.currentLeftArmPosition] == "On Legs") {
				this.leftArmIK.startDropping(5);
			} else if (armPositions[this.currentLeftArmPosition] == "On His Legs") {
				this.leftArmIK.startDropping(15);
			} else {
				this.leftArmIK.newTarget(this.leftHandOnLegs,this.leftLegContainer.leg,false);
				this.leftArmIK.setEndRotationTarget(-50,[G.her.torso.leg,G.her.torso]);
				this.leftArmIK.startDropping(15);
			}
			G.changeLayer(this.leftArmContainer, G.backLayer);
			G.changeLayer(this.leftHandOver, G.backLayer);
		}
		if (param2) {
			if (armPositions[this.currentRightArmPosition] == "On Legs") {
				this.rightArmIK.startDropping(5);
			} else if (armPositions[this.currentRightArmPosition] == "On His Legs") {
				this.rightArmIK.startDropping(15);
			} else {
				this.rightArmIK.newTarget(this.rightHandOnLegs,this.torso.leg,false);
				this.rightArmIK.setEndRotationTarget(-50,[G.her.torso.leg,G.her.torso,G.her]);
				this.rightArmIK.startDropping(15);
			}
		}
	}

	public function wakeUp() {
		var _loc1_:Point = null;
		this.shock(85);
		this.eyeMotion.ang = 20;
		G.dialogueControl.clearStates();
		G.dialogueControl.buildState(Dialogue.WAKE, Dialogue.ONE_OFF_BUILD);
		this.passedOut = false;
		G.addBreath(G.outOfBreathPoint);
		if (G.breathing) {
			this.breathing = G.soundControl.startBreathing(true);
		}
		this.setLeftArmPosition(this.currentLeftArmPosition, false);
		this.setRightArmPosition(this.currentRightArmPosition, false);
		if (armPositions[this.currentLeftArmPosition] != "Loose") {
			_loc1_ = this.leftArmContainer.upperArm.foreArm.hand.localToGlobal(new Point());
			this.leftArmIK.jumpTo(_loc1_);
			this.leftArmIK.startTrackingTarget(true);
		}
		if (armPositions[this.currentRightArmPosition] != "Loose") {
			_loc1_ = this.rightForeArmContainer.upperArm.foreArm.hand.localToGlobal(new Point());
			this.rightArmIK.jumpTo(_loc1_);
			this.rightArmIK.startTrackingTarget(true);
		}
	}

	public function updateBlink() {
		if (this.blinkTime > 0) {
			--this.blinkTime;
		} else {
			this.blink();
		}
	}

	public function blink(param1:Bool = true) {
		if (Math.random() > 0.8) {
			this.blinkTime = Math.floor(Math.random() * 5 + 5);
		} else {
			this.blinkTime = Math.floor(Math.random() * 60 + 90);
		}
		this.blinkTimer = 2;
		this.tears.releaseTears();
		if (param1) {
			if (Math.random() > 0.5) {
				if (Math.random() > 0.5) {
					this.changeLookTarget(this.hisFace, 5, 0);
				} else {
					this.changeLookTarget(this.eyesDown, 5, 0);
				}
			}
		}
	}

	public function wince() {
		this.winceTimer = 5;
		this.tears.drawLowerEyelidMascara();
		this.tears.releaseTears();
	}

	public function waggleEyebrows() {
		this.changeLookTarget(this.hisFace, 0, 1);
		var _loc1_:UInt = 0;
		while (_loc1_ < 24) {
			this.eyebrowOffsets.push(Std.int(-10 * (Math.pow(4, Math.cos(_loc1_ * Math.PI / 6 - 1.8)) - Math.cos(_loc1_ * Math.PI / 6))));
			_loc1_++;
		}
	}

	public function startClenchingTeeth() {
		if (!this.clenchTeeth && !this.gagged && !this.mouthFull) {
			this.clenchTeeth = true;
			this.clenchedTeethTime = Std.int(Math.random() * 120 + 60);
			this.clenchedTeethTimer = 0;
			this.tongue.startFastIn();
			this.tapHands(3);
		}
	}

	public function lookUp() {
		this.changeLookTarget(this.hisFace, 0, 1);
	}

	public function lookDown() {
		this.changeLookTarget(this.eyesDown, 0, 1);
	}

	public function tapHands(param1:Float = 0) {
		var _loc2_ = Math.NaN;
		if (!G.handJobMode) {
			_loc2_ = Math.random() + (1 - this.passOutFactor / this.passOutMax) * 8 + param1;
			if (_loc2_ > 2) {
				if (Math.random() > 0.2) {
					this.rightArmIK.tap(_loc2_ / 9);
				} else {
					this.leftArmIK.tap(_loc2_ / 9);
				}
			}
		}
	}

	public function pushArms() {
		this.armsPushing = true;
		this.armsPushPower = 0;
		this.armsPushTimer = Std.int(Math.random() * 60 + 15);
	}

	public function cough() {
		if (G.coughing) {
			this.nextCoughTime = Std.int(Math.ffloor(Math.random() * 210) + 30);
			this.coughing = true;
			this.coughFactor = Math.random() * 1.5 + 0.5;
			this.head.cheekBulge.alpha = 1;
			this.tears.addTearSpot();
			this.generateSplat(5, 10);
			this.leftBreastController.accelerate(0.1);
			this.rightBreastController.accelerate(0.1);
			this.wince();
			G.soundControl.playCough();
			this.justCoughed = true;
		}
	}

	public function openCough() {
		var _loc1_ = false;
		if (G.coughing) {
			this.coughing = true;
			this.coughFactor = Math.random() + 0.25;
			this.head.cheekBulge.alpha = Math.min(1,this.head.cheekBulge.alpha + 0.3);
			this.tears.addTearSpot();
			_loc1_ = this.cumInMouth > 0 ? true : false;
			this.generateSplat(15, 5, 1, _loc1_);
			this.leftBreastController.accelerate(0.1);
			this.rightBreastController.accelerate(0.1);
			this.wince();
			this.justCoughed = true;
		}
	}

	public function swallow(param1:Float = 0, param2:Bool = true) {
		if (!this.swallowing && !this.passedOut && !this.speaking) {
			if (param1 <= 0.5) {
				this.swallowSequence.intensity = Math.random() * 0.3 + 0.5 * (this.cumInMouth / this.maxCumInMouth) + 0.4;
			} else {
				this.swallowSequence.intensity = param1;
			}
			this.swallowSequence.build = Math.fround(30 * this.swallowSequence.intensity);
			this.swallowSequence.swallow = Math.fround(this.swallowSequence.build + 16 * this.swallowSequence.intensity);
			this.swallowSequence.relax = Math.fround(this.swallowSequence.swallow + 16 * this.swallowSequence.intensity);
			this.swallowSequence.end = Math.fround(this.swallowSequence.relax + 30 * this.swallowSequence.intensity);
			this.swallowTimer = 0;
			this.startSwallowTime = Math.floor(Math.random() * 60 + 50);
			this.startSwallowTimer = 0;
			G.addBreath(2);
			this.breathing = G.soundControl.stopBreathing();
			if (this.cumInMouth > 0 && param2) {
				G.dialogueControl.buildState(Dialogue.SWALLOW, Dialogue.ONE_OFF_BUILD);
			}
			if (this.mood == HAPPY_MOOD || this.mood == AHEGAO_MOOD) {
				this.wetGenerate += this.swallowSequence.intensity * 100;
			}
			this.coughBuild += this.swallowSequence.intensity * 10;
			this.swallowing = true;
		}
	}

	public function checkMovementSounds() {
		var _loc12_:UInt = 0;
		var _loc13_:UInt = 0;
		var _loc1_:Point = this.globalToLocal(this.head.jaw.localToGlobal(this.bottomLipA));
		var _loc2_:Point = new Point(_loc1_.x - this.topLipA.x,_loc1_.y - this.topLipA.y);
		var _loc3_:Point = this.globalToLocal(G.him.getPenisTipPoint());
		var _loc4_:Point = new Point(_loc3_.x - this.topLipA.x,_loc3_.y - this.topLipA.y);
		var _loc5_:Float;
		var _loc6_:Bool = (_loc5_ = Maths.cross(_loc2_,_loc4_)) > 0;
		var _loc7_:Bool = false;
		var _loc8_:Float = Maths.pointDot(this.topLipA,_loc1_,_loc3_);
		var _loc9_:Float = _loc2_.x * _loc2_.x + _loc2_.y * _loc2_.y;
		this.penisTipMouthOffset = _loc8_ / Math.sqrt(_loc9_);
		var _loc10_:Float = _loc8_ / _loc9_;
		var _loc11_:Point = new Point(this.topLipA.x + _loc2_.x * _loc10_,this.topLipA.y + _loc2_.y * _loc10_);
		this.mouthLength = Maths.vectorLength(_loc2_);
		if(this.lastPenisDirection < 0 && _loc5_ > 0)
		{
		   this.lastPenisDirection = 1;
		   if(this.penisTipMouthOffset > -5 && this.penisTipMouthOffset < this.mouthLength + 5)
		   {
		      _loc7_ = true;
		   }
		}
		this.penisInMouthDist = this.lastPenisDirection * Maths.vectorLength(new Point(_loc3_.x - _loc11_.x,_loc3_.y - _loc11_.y));
		if(_loc6_)
		{
		   if(!this.mouthFull && !G.penisOut)
		   {
		      if(this.swallowing && !this.gagged || !_loc7_ || this.clenchTeeth)
		      {
		         G.setPenisOut(true);
		      }
		      else
		      {
		         this.tongue.setMouthFull();
		         this.changeLookTarget(this.eyesDown);
		         this.mouthFull = true;
		         G.dialogueControl.interrupt();
		         this.breathing = G.soundControl.stopBreathing();
		         G.soundControl.playTouch();
		         if(this.droolingCum)
		         {
		            this.stopDroolingCum();
		         }
		      }
		   }
		   if(!G.penisOut)
		   {
		      _loc12_ = 0;
		      while(_loc12_ < 4)
		      {
		         this.updateNoseSquash();
		         _loc12_++;
		      }
		      if(this.movement > 0)
		      {
		         this.downTravel += this.movement;
		         this.upTravel = 0;
		         this.upPlayed = false;
		         if(this.downTravel > 50 && !this.downPlayed)
		         {
		            if(!this.passedOut && this.absMovement > 30 && this.penisInMouthDist > this.deepthroatStartDistance && !this.intro)
		            {
		               if(G.gagging)
		               {
		                  G.soundControl.playGag(this.pos);
		               }
		               this.wince();
		               this.downPlayed = true;
		            }
		            else if(this.absMovement > 10)
		            {
		               G.soundControl.playDown(this.pos,this.movement);
		               this.downPlayed = true;
		            }
		         }
		      }
		      else
		      {
		         this.upTravel -= this.movement;
		         this.downTravel = 0;
		         this.downPlayed = false;
		         if(this.absMovement > 10 && this.upTravel > 50 && !this.upPlayed)
		         {
		            G.soundControl.playUp(this.pos,this.movement);
		            this.generateRandomStrand("random");
		            this.upPlayed = true;
		         }
		      }
		   }
		}
		else
		{
		   if(this.lastPenisDirection > 0 && _loc5_ < 0)
		   {
		      this.lastPenisDirection = -1;
		   }
		   if(G.penisOut && (!this.mouseHeld || G.handJobMode))
		   {
		      G.setPenisOut(false);
		   }
		   if(this.mouthFull)
		   {
		      this.changeLookTarget(this.hisFace);
		      this.tongue.setMouthFull(false);
		      this.mouthFull = false;
		      _loc13_ = Math.floor(Math.random() * 3);
		      while(_loc13_ < 3)
		      {
		         this.generateRandomStrand("back",false);
		         _loc13_++;
		      }
		      if(this.headTilt > 0)
		      {
		         this.startDroolingCum();
		      }
		      this.breatheDelay = 0;
		      this.offActionTime = Math.floor(Math.random() * 300) + 60;
		      this.offActionTimer = 0;
		      if(this.mood == ANGRY_MOOD && this.vigour > this.VIGOUR_WINCE_LEVEL && Math.random() > 0.5)
		      {
		         this.startClenchingTeeth();
		      }
		      G.dialogueControl.readyToSpeak();
		   }
		   ++this.offActionTimer;
		   if(this.offActionTimer >= this.offActionTime)
		   {
		      if(this.mood == HAPPY_MOOD)
		      {
		         this.waggleEyebrows();
		      }
		      else if(this.mood == ANGRY_MOOD)
		      {
		         this.startClenchingTeeth();
		      }
		      this.offActionTime = Math.floor(Math.random() * 300) + 150;
		      this.offActionTimer = 0;
		   }
		}
	}

	public function updateNoseSquash() {
		var _loc1_:Point = this.head.face.nose.localToGlobal(new Point(this.head.face.nose.tip.x,this.head.face.nose.tip.y));
		var _loc2_:Bool = G.him.overLayer.hitTestPoint(_loc1_.x,_loc1_.y,true) || G.him.hitTestPoint(_loc1_.x,_loc1_.y,true);
		if(_loc2_)
		{
		   this.noseSquashAmount = Math.min(1,this.noseSquashAmount + 0.1);
		}
		else if(this.noseSquashAmount > 0)
		{
		   this.noseSquashAmount = Math.max(0,this.noseSquashAmount - 0.1);
		}
		this.currentNoseSquash.tween(this.noseSquashAmount);
	}

	public function checkBreathing(param1:Bool = false) {
		if (!this.mouthFull && !this.breathing && !this.swallowing) {
			++this.breatheDelay;
			if ((param1 || this.breatheDelay >= this.breatheDelayTime) && G.breathing) {
				this.breathing = G.soundControl.startBreathing();
			}
		}
	}

	public function stopBreathing() {
		this.breathing = G.soundControl.stopBreathing();
	}

	public function checkPosition() {
		if (G.penisOut) {
			this.previousResistance = 0;
		} else {
			this.previousResistance = this.resistance.upper * (this.pos - this.currentPenisTipPos) * 5;
		}
		if (this.penisInMouthDist > 0) {
			if (!G.penisOut) {
				G.him.givePleasure(this.movement);
				G.dialogueControl.movement(this.movement);
			}
			if (this.intro && !G.penisOut) {
				if (this.penisInMouthDist >= this.maxIntroDist - 13) {
					G.dialogueControl.buildState(Dialogue.RESISTANCE, Dialogue.FRAME_BUILD);
					if (!this.introPosToBeMoved) {
						this.introPosToBeMoved = true;
					}
				}
			}
			if (this.penisInMouthDist > this.deepthroatDistance && !G.penisOut) {
				if (!this.held) {
					G.soundControl.startHolding();
					this.nextCoughTime = Std.int(Math.ffloor(Math.random() * 210) + 30);
					this.tears.addTearSpot();
					// if (!G.autoModeOn && this.userHasClicked < 3 && this.heldTimer > 150) {
					// 	G.clickPrompt.fadeIn();
					// }
					this.coughBuild += Math.random() * 2;
					if (this.intro) {
						G.dialogueControl.buildState(Dialogue.FIRST_THROAT, Dialogue.ONE_OFF_BUILD * 2);
					}
					this.held = true;
				}
				if (this.firstDT) {
					this.coughBuild += 0.2;
					G.setBreathTo(G.outOfBreathPoint);
					this.wince();
				}
				this.previousResistance = this.resistance.lower;
				G.addBreath(0.1);
				this.pullOff = Math.min(1, this.pullOff + this.pullOffPower.current);
				this.pullOffPower.current = Math.min(this.pullOffPower.max, this.pullOffPower.current + this.pullOffPower.increase);
				G.dialogueControl.buildState(Dialogue.PULL_OFF, Dialogue.FRAME_BUILD);
			} else {
				if (!G.penisOut) {
					if (this.penisInMouthDist >= this.deepthroatStartDistance) {
						this.previousResistance = this.resistance.upper
							+ this.resistance.boundary * (this.penisInMouthDist - this.deepthroatStartDistance) / (this.deepthroatDistance
								- this.deepthroatStartDistance);
					} else {
						G.addBreath(-0.05);
					}
				}
				if (this.held) {
					G.soundControl.stopHolding();
					this.pullOff = 0;
					this.pullOffPower.current = this.pullOffPower.start;
					if (!this.passedOut && !G.handsOff && !G.penisOut && G.currentPos.x > this.pos) {
						this.pullingOff = true;
						G.him.openHand();
					}
					// G.clickPrompt.fadeOut();
					this.held = false;
				}
			}
			if (this.penisInMouthDist >= this.hiltDistance || this.pos > 1) {
				if (G.penisOut) {
					this.tongue.encourage();
				} else {
					G.him.givePleasure(Math.random() * 5 + 5);
					if (!this.hilt) {
						G.sceneLayer.shake(this.movement);
						this.tears.addTearSpot();
						this.hilt = true;
						this.justHilt = true;
						this.coughBuild += 2;
					}
					if (this.firstDT) {
						this.coughBuild += 6;
						this.firstDT = false;
						G.dialogueControl.maxState(Dialogue.FIRST_DT);
					}
					this.coughBuild += 0.1;
				}
			} else if (this.hilt) {
				this.hilt = false;
			}
		} else {
			if (this.intro && this.introPosToBeMoved) {
				this.maxIntroDist += this.introRelaxDist;
				if (this.maxIntroDist >= this.deepthroatDistance || this.maxIntroDist > this.hiltDistance - 50) {
					this.intro = false;
				}
				this.introPosToBeMoved = false;
			}
			if (this.pullingOff) {
				this.released = true;
			}
		}
		if (this.held && !this.passedOut) {
			if (this.nextCoughTime > 0) {
				if (!this.swallowing) {
					--this.nextCoughTime;
				}
			} else {
				this.cough();
			}
			this.pos += Math.random() * 0.01 - 0.005;
		}
	}

	public function animateBreathing() {
		var _loc1_ = Math.NaN;
		var _loc2_:BreathMist = null;
		var _loc3_:Point = null;
		if (this.breathing) {
			_loc1_ = !!this.passedOut ? 0.5 : Math.max(0.5, Math.min(2, G.breathLevel / G.outOfBreathPoint * 2));
			this.breathingFactor = Math.sin(G.soundControl.breathPosition() * Math.PI * 2) * _loc1_;
			this.pos += this.breathingFactor * 0.00625;
			if (G.soundControl.justBreathedOut() && G.herMouthOpeness > 0.4) {
				_loc2_ = new BreathMist();
				_loc3_ = G.sceneLayer.globalToLocal(this.localToGlobal(this.midMouth));
				_loc2_.x = _loc3_.x;
				_loc2_.y = _loc3_.y;
				G.backLayer.addChild(_loc2_);
			}
			if (this.passOutFactor > 0) {
				this.passOutFactor = Math.max(0, this.passOutFactor - 0.5);
			} else if (this.passedOut) {
				this.wakeUp();
			}
		} else {
			if (G.breathLevel == G.breathLevelMax && this.passOutFactor < this.passOutMax) {
				this.passOutFactor += 0.05;
				if (!this.blankEyed && this.currentLookTarget != this.eyesDown && this.passOutFactor > 5) {
					this.currentLookTarget = this.eyesDown;
					this.lookChangeTimer = -1;
				}
				if (!this.passedOut && this.passOutFactor >= this.passOutMax) {
					this.passOut();
				}
			}
			this.breathingFactor *= 0.8;
			this.pos += this.getRandomMotion();
		}
		this.breathingFactor += this.coughFactor * 0.8;
	}

	public function tickCoughBuild() {
		this.coughBuild = Math.max(0, this.coughBuild - 0.05);
		if (this.coughBuild >= 10) {
			this.coughBuild -= 10;
			G.soundControl.queueOpenCough();
		}
	}

	public function updatePosition() {
		this.headTiltAngle = this.headTilt * 10 + (this.coughFactor * 2.5 + this.tongue.getHeadTilt()) * this.headTiltScaling;
		this.mHer = G.animationControl.getHerMatrix(this.pos, this.headTilt);
		this.mHer.translate(this.coughFactor * 3 * this.headTiltScaling, this.coughFactor * this.headTiltScaling);
		Maths.rotateMatrix(this.mHer, Maths.degToRad(this.headTiltAngle));
		this.mHer.tx -= Math.max(-5, 20 * this.headTilt);
		if (Math.isNaN(this.lastYPos)) {
			this.lastYPos = this.mHer.ty;
		}
		this.absYMovement = this.mHer.ty - this.lastYPos;
		this.lastYPos = this.mHer.ty;
		this.transform.matrix = this.mHer;
	}

	public function updateElements() {
		var _loc7_ = Math.NaN;
		var _loc8_ = 0;
		this.updateTorso();
		this.updateNeck();
		if (G.characterControl.collarControl.selection == 2) {
			if(this.collarContainer.collar.tie != null)
			{
			   this.collarContainer.collar.tie.rotation = 6 - 6 * this.pos;
			}
		}
		this.hairBackContainer.hairBack.transform.matrix = this.mHer;
		G.hairCostumeBack.transform.matrix = this.mHer;
		G.hairTop.transform.matrix = this.mHer;
		G.hairCostumeOver.transform.matrix = this.mHer;
		G.hairCostumeUnderOver.transform.matrix = this.mHer;
		var _loc1_ = this.globalToLocal(G.sceneLayer.localToGlobal(new Point()));
		this.mZero = new Matrix();
		this.mZero.rotate(-this.rotation / 180 * Math.PI);
		this.mZero.translate(_loc1_.x, _loc1_.y);
		this.hairMidContainer.hairUnderLayer.transform.matrix = this.mZero;
		this.hairBetweenLayer.transform.matrix = this.mZero;
		var _loc2_:Float = G.him.getPenisWidth(localToGlobal(this.topLipA),this.head.jaw.localToGlobal(this.bottomLipA),this.mouthFull);
		var _loc3_:Float = (_loc2_ - 20) / 2 / 165;
		var _loc4_:Float = Math.asin(_loc3_) / 1.2 / 0.5;
		var _loc5_:Float = Maths.radToDeg(_loc4_) - 11;
		if(this.speaking || this.speakStopDelay > 0)
		{
		   this.jawAngleTarget = this.targetPhoneme.jaw;
		   this.head.jaw.rotation += (this.jawAngleTarget - this.head.jaw.rotation) / (this.phonemeDelay + 1);
		}
		else if(this.swallowing)
		{
		   if(this.swallowTimer < this.swallowSequence.relax)
		   {
		      if(this.penisInMouthDist > 0 && this.mouthFull)
		      {
		         this.jawAngleTarget = _loc5_;
		      }
		      else
		      {
		         this.jawAngleTarget = this.closedJawAngle;
		      }
		      if(this.swallowTimer == this.swallowSequence.swallow)
		      {
		         this.wince();
		         G.soundControl.playSwallow(this.pos);
		         this.head.neck.swallow();
		         this.swallowFromMouth();
		      }
		   }
		   else if(this.swallowTimer >= this.swallowSequence.end)
		   {
		      this.swallowing = false;
		      this.swallowTimer = 0;
		      if(this.cumInMouth > 10 && this.aboveSwallowTilt && this.penisInMouthDist < 0 && Math.random() > 0.4)
		      {
		         this.swallow();
		      }
		      else if(!this.mouthFull)
		      {
		         if(G.breathing)
		         {
		            if(G.coughing && this.coughBuild > 5)
		            {
		               this.breathing = G.soundControl.startBreathingWithCough();
		            }
		            else
		            {
		               this.breathing = G.soundControl.startBreathing();
		            }
		         }
		      }
		      if(this.cumInMouth == 0 && Math.random() > 0.2)
		      {
		         this.changeLookTarget(this.hisFace);
		      }
		   }
		   else if(this.penisInMouthDist > 0 && !G.penisOut)
		   {
		      this.jawAngleTarget = _loc5_;
		   }
		   else
		   {
		      this.jawAngleTarget = this.getJawAngle(0.8);
		   }
		   this.head.jaw.rotation += (this.jawAngleTarget - this.head.jaw.rotation) * 0.5;
		}
		else
		{
		   if(this.penisInMouthDist > 0 && !G.penisOut)
		   {
		      this.jawAngleTarget = _loc5_;
		   }
		   else
		   {
		      this.jawAngleTarget = Math.max(-6,-2.5 - 2 * this.pos * 10);
		   }
		   if(this.penisInMouthDist < 0)
		   {
		      _loc7_ = Math.min(0.8,Math.min(100,-this.penisInMouthDist) / 50);
		      if(this.cumInMouth > 0)
		      {
		         this.jawAngleTarget = Math.min(this.jawAngleTarget,this.getJawAngle(Math.max(0,-this.headTilt),_loc7_));
		      }
		      else
		      {
		         this.jawAngleTarget = Math.min(this.jawAngleTarget,this.getJawAngle(Math.max(0,-this.headTilt),Math.min(0.5,_loc7_)));
		      }
		      this.head.jaw.rotation += (this.jawAngleTarget - this.head.jaw.rotation) * 0.25;
		      if(this.cumInMouth > 0 && this.aboveSwallowTilt && !this.passedOut)
		      {
		         ++this.startSwallowTimer;
		         if(this.startSwallowTimer >= this.startSwallowTime)
		         {
		            this.swallow();
		         }
		      }
		      else
		      {
		         this.startSwallowTimer = 0;
		      }
		   }
		   else
		   {
		      if(this.cumInMouth > 0 && this.aboveSwallowTilt && !this.passedOut)
		      {
		         this.startSwallowTimer += 1;
		         if(this.startSwallowTimer >= this.startSwallowTime)
		         {
		            this.swallow();
		         }
		      }
		      else
		      {
		         this.startSwallowTimer = 0;
		      }
		      this.head.jaw.rotation += (this.jawAngleTarget - this.head.jaw.rotation) * 0.8;
		   }
		}
		if(this.mood == ANGRY_MOOD || this.clenchTeethRatio > 0)
		{
		   this.head.jaw.rotation += (-6.5 - this.head.jaw.rotation) * this.clenchTeethRatio;
		}
		if(this.gagged)
		{
		   this.head.jaw.rotation = this.gaggedRotation;
		}
		this.head.jawBack.rotation = this.head.jaw.rotation;
		this.head.headTan.jaw.rotation = this.head.headTan.jawBack.rotation = this.head.jaw.rotation;
		G.herMouthOpeness = Math.max(0,Math.min(1,1 - this.head.jaw.rotation / this.closedJawAngle));
		this.updateLips();
		if(G.herMouthOpeness < 0.2)
		{
		   if(this.droolingCum)
		   {
		      this.stopDroolingCum();
		   }
		}
		else if(!this.droolingCum && !this.mouthFull && this.headTilt > 0)
		{
		   this.startDroolingCum();
		}
		this.head.cheekMask.gotoAndStop(Math.floor(Math.min(144,Math.max(1,(this.head.jaw.rotation + 12) * 8))));
		this.leftBreastController.update(-this.movement / range * 0.2 - this.absYMovement * 0.002,this.breathingFactor * 1.25 - 1,-4 - this.breathingFactor * 3.125,this.breathingFactor * 1.75);
		this.rightBreastController.update(-this.movement / range * 0.2 - this.absYMovement * 0.002,this.breathingFactor * 1.25,-3 - this.breathingFactor * 4.375,this.breathingFactor * 1.75);
		this.braStrapController.update();
		this.shoulderStrapController.update();
		this.topStrapController.update();
		this.updateNipplePiercing();
		this.updateBreathingScaledElements();
		this.torsoBack.chestBack.rotation = 27 + this.breathingFactor * 2.6;
		if(this.mouthFull)
		{
		   this.cheekBulgeTarget = Math.min(1,Math.max(0,this.movement) / 20 + this.cumInMouth / 20 + this.pos / 2);
		   this.cheekSuckTarget = Math.min(1,Math.max(0,-this.movement) / 20 + this.suckPower);
		}
		else
		{
		   this.cheekBulgeTarget = 0;
		   this.cheekSuckTarget = 0;
		}
		this.suckPower *= 0.7;
		if(this.hilt)
		{
		   this.cheekBulgeTarget += 0.5;
		}
		this.head.cheekBulge.alpha += (this.cheekBulgeTarget - this.head.cheekBulge.alpha) / 5;
		this.head.cheekSuck.alpha += (this.cheekSuckTarget - this.head.cheekSuck.alpha) / 5;
		if(this.lookChangeTimer > 0)
		{
		   --this.lookChangeTimer;
		}
		else if(this.lookChangeTimer == 0)
		{
		   this.currentLookTarget = this.nextLookTarget;
		   this.lookChangeTimer = -1;
		}
		this.lookAt(this.currentLookTarget);
		if(this.eyelidMotion.shock > 0)
		{
		   --this.eyelidMotion.shock;
		   if(this.mood == AHEGAO_MOOD)
		   {
		   }
		}
		if(this.winceTimer > 0)
		{
		   --this.winceTimer;
		   this.eyelidMotion.pos += (this.eyePosWince - this.eyelidMotion.pos) * 0.75;
		}
		else if(this.blinkTimer > 0)
		{
		   --this.blinkTimer;
		   this.eyelidMotion.pos = this.eyePosBlink;
		}
		else if(this.eyelidMotion.isClosed || this.passedOut)
		{
		   this.eyelidMotion.pos += (this.eyePosBlink - this.eyelidMotion.pos) * 0.25;
		   this.tears.clearLowerEyelid(200 - this.eyelidMotion.pos);
		   ++this.eyelidMotion.closedTimer;
		   if(this.eyelidMotion.closedTimer >= 1200)
		   {
		      this.openEye();
		      this.cumInEye = 0;
		   }
		}
		else
		{
		   _loc8_ = G.penisOut ? 0 : Std.int(Math.min(80,Math.floor(this.pos * 80)));
		   this.eyelidMotion.target = 101 - _loc8_ - this.eyelidMotion.shock - this.cumInMouth * 2 + Math.floor(this.swallowPoint * 100);
		   this.eyelidMotion.target = Math.max(2,Math.min(this.eyePosWince,this.eyelidMotion.target));
		   if(this.passOutFactor > 0)
		   {
		      this.eyelidMotion.target = Math.min(this.eyePosBlink,this.eyelidMotion.target + Math.floor(this.passOutFactor * 3));
		   }
		   this.eyelidMotion.pos += (this.eyelidMotion.target - this.eyelidMotion.pos) * 0.2;
		   this.tears.clearLowerEyelid(200 - this.eyelidMotion.pos);
		}
		this.updateEyes();
		var _loc6_:Float = 0.9 - (0.25 - this.eyelidMotion.pos / 400) - this.eyelidMotion.shock / 200;
		this.eye.ball.irisContainer.iris.scaleX = _loc6_;
		this.eye.ball.irisContainer.iris.scaleY = _loc6_;
		if(this.coughing)
		{
		   if(this.justCoughed)
		   {
		      this.justCoughed = false;
		      this.coughFactor *= 2;
		   }
		   else
		   {
		      this.coughFactor *= 0.8;
		      if(this.coughFactor <= 0.01)
		      {
		         this.coughFactor = 0;
		         this.coughing = false;
		      }
		   }
		}
	}

	public function updateBreathingScaledElements() {
		var _loc1_ = 1 - this.breathingFactor * 0.024;
		var _loc2_ = 1 / _loc1_;
		this.torso.midLayer.chest.scaleX = _loc1_;
		this.torso.chestCostume.scaleX = _loc1_;
		this.torso.chestUnderCostume.scaleX = _loc1_;
		this.torso.upperChestCostume.scaleX = _loc1_;
		this.torso.topContainer.chestTop.scaleX = _loc1_;
		this.torso.rightThighStocking.stocking.hipLayer.chestStocking.scaleX = _loc1_;
		this.torso.rightThighStocking.stocking.hipOverLayer.chestStocking.scaleX = _loc1_;
		this.torso.rightThighStocking.stocking2.hipLayer.chestStocking.scaleX = _loc1_;
		this.torso.rightThighStocking.stocking.hipLayer.chestStocking.penisCostumeContainer.scaleX = _loc2_;
		this.torso.chestCostume.bottoms.penisCostumeContainer.scaleX = _loc2_;
	}

	public function updateEyes() {
		var _loc10_ = Math.NaN;
		var _loc1_:UInt = Std.int(Math.max(2, Math.ffloor(this.eyelidMotion.pos)));
		var _loc2_ = _loc1_;
		var _loc3_:Float = 0;
		var _loc4_:Float = 0;
		var _loc5_ = new Point();
		var _loc6_ = new Point();
		if (this.eyebrowOffsets.length > 0) {
			_loc2_ += this.eyebrowOffsets[0];
			this.eyebrowOffsets.splice(0, 1);
		}
		this.rightEyebrow.rightEyebrowFill.gotoAndStop(_loc2_);
		this.rightEyebrow.rightEyebrowLine.gotoAndStop(_loc2_);
		this.leftEyebrow.leftEyebrowFill.gotoAndStop(_loc2_);
		this.leftEyebrow.leftEyebrowLine.gotoAndStop(_loc2_);
		if (this.mood == ANGRY_MOOD) {
			_loc10_ = _loc2_ / 200;
			this.leftEyebrowAngryTween.tween(_loc10_);
			this.rightEyebrowAngryTween.tween(_loc10_);
		} else {
			this.leftEyebrowNormalTween.tween(0);
			this.rightEyebrowNormalTween.tween(0);
		}
		this.rightEyebrow.rightEyebrowFill.gotoAndStop(_loc2_);
		this.rightEyebrow.rightEyebrowLine.gotoAndStop(_loc2_);
		this.leftEyebrow.leftEyebrowFill.gotoAndStop(_loc2_);
		this.leftEyebrow.leftEyebrowLine.gotoAndStop(_loc2_);
		this.eye.eyebrowMask.gotoAndStop(_loc2_);
		var _loc7_:Float = Maths.clampf(-55, 0, (this.eyeMotion.ang - 90) * 0.15 * Math.max(0, 150 - _loc1_));
		var _loc8_:UInt = Math.floor(Math.max(2, _loc1_ + _loc7_));
		var _loc9_:UInt = _loc1_;
		if (this.mood == HAPPY_MOOD) {
			_loc9_ = _loc1_ + Std.int(Math.max(0, (160 - _loc1_) * 0.9));
		}
		this.eye.upperEyelid.gotoAndStop(_loc8_);
		this.eye.lowerEyelid.gotoAndStop(_loc9_);
		this.eye.ball.upperEyelidMask.gotoAndStop(_loc8_);
		this.eye.ball.lowerEyelidMask.gotoAndStop(_loc9_);
		this.eye.upperEyelid.eyeshadow.gotoAndStop(_loc8_);
		this.eye.upperEyelid.mascara.gotoAndStop(_loc8_);
		this.eye.lowerEyelid.mascara.gotoAndStop(_loc9_);
	}

	public function changeLookTarget(param1:Point, param2:UInt = 30, param3:UInt = 5) {
		if (this.passOutFactor < 5 && !this.eyelidMotion.isClosed) {
			if (this.blankEyed) {
				this.nextLookTarget = this.eyesUnfocused;
			} else {
				this.nextLookTarget = param1;
			}
			this.lookChangeTimer = Std.int(Math.ffloor(Math.random() * param2) + param3);
		}
	}

	public function lookAt(param1:Point) {
		var _loc2_ = this.globalToLocal(G.sceneLayer.localToGlobal(param1));
		var _loc3_ = this.eyeAim;
		var _loc4_ = new Point(_loc2_.x - _loc3_.x, _loc2_.y - _loc3_.y);
		this.eyeMotion.target = Maths.clampf(Maths.getAngle(_loc4_.x, _loc4_.y), 75, 110);
		if (this.mood == AHEGAO_MOOD) {
			this.eyeMotion.target = 62 + this.eyelidMotion.pos * 0.05 + Math.random() * 2 - 1;
		}
		this.eyeMotion.target -= Math.random() * 0.5 * this.passOutFactor + this.passOutFactor * 0.5;
		this.eyeMotion.ang += (this.eyeMotion.target - this.eyeMotion.ang) * 0.2;
		this.eye.ball.irisContainer.rotation = this.eyeMotion.ang - 90;
	}

	public function getJawAngle(param1:Float, param2:Float = 1):Float {
		return param1 * this.closedJawAngle * param2;
	}

	public function updateNeck() {
		this.head.neck.render(G.penisOut ? 0 : this.penisInMouthDist / 400);
		var _loc1_:Color = new Color();
		_loc1_.tintColor = G.characterControl.currentSkinPalette.shade1.rgb;
		_loc1_.tintMultiplier = G.penisOut ? 0 : this.penisInMouthDist / 400 * G.him.getPenisWidthWithTwitch() * 0.6;
		this.head.jaw.jawBulge.transform.colorTransform = _loc1_;
		var _loc2_:Point = this.globalToLocal(this.head.localToGlobal(new Point(this.head.neck.x,this.head.neck.y)));
		var _loc3_:Point = this.globalToLocal(this.torso.localToGlobal(new Point(0,0)));
		var _loc4_:Float = Maths.getAngle(_loc3_.x - _loc2_.x,_loc3_.y - _loc2_.y) + 180;
		this.head.neck.rotation = _loc4_;
		this.collarContainer.rotation = this.head.neck.rotation;
	}

	public function updateLips() {
		var _loc1_:UInt = 0;
		var _loc2_:UInt = 0;
		this.bottomLipstick.rotation = this.head.jaw.rotation;
		if(this.clenchTeeth || this.clenchTeethRatio > 0)
		{
		   ++this.clenchedTeethTimer;
		   if(this.clenchedTeethTimer >= this.clenchedTeethTime)
		   {
		      this.clenchTeeth = false;
		   }
		   if(this.clenchTeeth && this.clenchTeethRatio < 1)
		   {
		      this.clenchTeethRatio = Math.min(1,this.clenchTeethRatio + 0.2);
		   }
		   else if(!this.clenchTeeth)
		   {
		      this.clenchTeethRatio = Math.max(0,this.clenchTeethRatio - 0.3);
		   }
		   this.topTeethTween.tween(this.clenchTeethRatio);
		   this.bottomTeethTween.tween(this.clenchTeethRatio);
		}
		if(this.speaking || this.speakStopDelay > 0)
		{
		   _loc1_ = this.lastUpperLipPos + Math.round((this.targetPhoneme.upperLip - this.lastUpperLipPos) / (this.phonemeDelay + 1));
		   _loc2_ = this.lastLowerLipPos + Math.round((this.targetPhoneme.lowerLip - this.lastLowerLipPos) / (this.phonemeDelay + 1));
		   if(this.phonemeDelay > 0)
		   {
		      --this.phonemeDelay;
		   }
		   if(this.speakStopDelay > 0)
		   {
		      --this.speakStopDelay;
		   }
		}
		else
		{
		   _loc1_ = Std.int(Maths.clampf(Math.floor(-this.head.jaw.rotation * 4.5 + 30), 0, 79));
		   _loc2_ = _loc1_;
		}
		if(this.mood == ANGRY_MOOD || this.clenchTeethRatio > 0)
		{
		   _loc1_ = Math.round(_loc1_ + (58 - _loc1_) * this.clenchTeethRatio);
		   _loc2_ = Math.round(_loc2_ + (61 - _loc2_) * this.clenchTeethRatio);
		   _loc1_ = Std.int(Math.max(0,_loc1_ - 1));
		   _loc2_ = Std.int(Math.min(79,_loc2_ + 6));
		}
		this.bottomLipstick.gotoAndStop(_loc2_ + 2);
		this.topLipstickContainer.topLipstick.gotoAndStop(_loc1_ + 2);
		this.tongueContainer.gotoAndStop(_loc2_ + 2);
		this.tongueContainer.rotation = this.head.jaw.rotation;
		this.lastUpperLipPos = _loc1_;
		this.lastLowerLipPos = _loc2_;
		this.head.face.lipHighlight.gotoAndStop(_loc1_);
		this.head.face.lipShading.gotoAndStop(_loc1_);
		this.head.face.lipFill.gotoAndStop(_loc1_);
		this.head.face.lipOutline.gotoAndStop(_loc1_);
		this.head.headTan.face.lipFill.gotoAndStop(_loc1_);
		this.head.headTan.face.lipOutline.gotoAndStop(_loc1_);
		_loc2_ += this.lipSkinOffset;
		this.head.jaw.gotoAndStop(_loc2_);
		this.head.headTan.jaw.gotoAndStop(_loc2_);
	}

	public function breastSizeChanged() {
		this.updateBreastFirmness();
		this.braStrapController.update();
		this.shoulderStrapController.update();
		this.topStrapController.update();
		this.updateNipplePiercing();
	}

	public function updateBreastFirmness() {
		this.leftBreastController.updateFirmness(G.characterControl.breastSize, this.breastCostumeOn);
		this.rightBreastController.updateFirmness(G.characterControl.breastSize, this.breastCostumeOn);
	}

	public function findChild(param1:String, param2:DisplayObjectContainer):DisplayObject {
		var _loc4_:DisplayObject = null;
		if (param2.getChildByName(param1) != null) {
			return param2.getChildByName(param1);
		}
		var _loc3_:UInt = param2.numChildren;
		var _loc5_:UInt = 0;
		while (_loc5_ < _loc3_) {
			if (Std.isOfType(param2.getChildAt(_loc5_), DisplayObjectContainer)) {
				if ((_loc4_ = this.findChild(param1, Std.downcast(param2.getChildAt(_loc5_), DisplayObjectContainer))) != null) {
					return _loc4_;
				}
			}
			_loc5_++;
		}
		return null;
	}

	public function updateNipplePiercing() {
		var rightPiercingPoint:Point = null;
		var leftPiercingPoint:Point = null;
		var leftNipple:MovieClip = null;
		var rightNipple:MovieClip = null;
		if(this.torsoBack.leftBreast.leftBreast != null)
		{
		   leftNipple = cast(this.findChild("nipple",this.torsoBack.leftBreast.leftBreast), MovieClip);
		}
		if(leftNipple == null)
		{
		   if(this.torsoBack.leftBreast.nipple.leftNipple != null)
		   {
		      leftNipple = this.torsoBack.leftBreast.nipple.leftNipple;
		   }
		   else
		   {
		      leftNipple = this.torsoBack.leftBreast.nipple;
		   }
		}
		if(this.torso.midLayer.rightBreast.rightBreast != null)
		{
		   rightNipple = cast(this.findChild("nipple",this.torso.midLayer.rightBreast.rightBreast), MovieClip);
		}
		if(rightNipple == null)
		{
		   if(this.torso.midLayer.rightBreast.nipple.rightNipple != null)
		   {
		      rightNipple = this.torso.midLayer.rightBreast.nipple.rightNipple;
		   }
		   else
		   {
		      rightNipple = this.torso.midLayer.rightBreast.nipple;
		   }
		}
		if(leftNipple.getChildByName("piercingPoint") != null)
		{
		   leftPiercingPoint = new Point(leftNipple.getChildByName("piercingPoint").x,leftNipple.getChildByName("piercingPoint").y);
		}
		else
		{
		   leftPiercingPoint = new Point();
		}
		if(rightNipple.getChildByName("piercingPoint") != null)
		{
		   rightPiercingPoint = new Point(rightNipple.getChildByName("piercingPoint").x,rightNipple.getChildByName("piercingPoint").y);
		}
		else
		{
		   rightPiercingPoint = new Point();
		}
		leftPiercingPoint = this.torsoBack.globalToLocal(leftNipple.localToGlobal(leftPiercingPoint));
		rightPiercingPoint = this.torso.globalToLocal(rightNipple.localToGlobal(rightPiercingPoint));
		this.torso.nipplePiercing.x = rightPiercingPoint.x;
		this.torso.nipplePiercing.y = rightPiercingPoint.y;
		this.torso.leftNipplePiercing.x = leftPiercingPoint.x;
		this.torso.leftNipplePiercing.y = leftPiercingPoint.y;
	}

	public function updateTorso() {
		this.torsoJointAng = Math.min(G.animationControl.torsoMinAng,
			G.animationControl.torsoStartAng + this.pos * G.animationControl.torsoAngMultiplier - Maths.degToRad(this.rotation) * 0.9);
		this.torsoJointDist = Math.min(G.animationControl.torsoMinDist, G.animationControl.torsoStartDist + this.pos * G.animationControl.torsoDistMultiplier);
		var torsoVec:Point = Maths.getVector(this.torsoJointDist, this.torsoJointAng);
		this.torsoIK.update(torsoVec);
		var _loc2_ = this.torsoIK.section1Matrix;
		var _loc3_ = this.torsoIK.section2Matrix;
		var _loc4_ = this.torsoIK.section3Matrix;
		this.torso.transform.matrix = _loc2_;
		this.torsoBack.transform.matrix = _loc2_;
		this.leftLegContainer.transform.matrix = _loc2_;
		this.torsoBackCostume.transform.matrix = _loc2_;
		this.torsoUnderCostume.transform.matrix = _loc2_;
		var _loc5_:Matrix;
		(_loc5_ = _loc2_.clone()).concat(this.transform.matrix);
		this.rightArmContainer.transform.matrix = _loc5_;
		this.rightForeArmContainer.transform.matrix = _loc5_;
		if (this.leftArmContainer.parent == this) {
			this.leftArmContainer.transform.matrix = _loc2_;
		} else {
			this.leftArmContainer.transform.matrix = _loc5_;
		}
		var _loc6_:Matrix;
		(_loc6_ = new Matrix()).rotate(-this.torsoIK.section2Angle);
		this.torso.leg.transform.matrix = _loc3_;
		this.torso.rightThighBottoms.transform.matrix = _loc3_;
		this.torso.rightThighBottomsOver.transform.matrix = _loc3_;
		this.torso.rightCalfContainer.transform.matrix = _loc3_;
		this.torso.rightThighStocking.transform.matrix = _loc3_;
		this.torso.rightThighStocking.stocking.hipLayer.transform.matrix = _loc6_;
		this.torso.rightThighStocking.stocking2.hipLayer.transform.matrix = _loc6_;
		this.torso.rightThighStocking.stocking.hipOverLayer.transform.matrix = _loc6_;
		this.torso.rightThighStockingB.transform.matrix = _loc3_;
		this.torso.rightThighStockingB.stocking.hipLayer.transform.matrix = _loc6_;
		this.torso.rightThighStockingB.stocking2.hipLayer.transform.matrix = _loc6_;
		this.torso.rightThighStockingB.stocking.hipOverLayer.transform.matrix = _loc6_;
		this.torso.rightThighCostume.transform.matrix = _loc3_;
		var _loc7_:Matrix;
		(_loc7_ = _loc3_.clone()).tx = 0;
		_loc7_.ty = 0;
		_loc7_.scale(0.95,0.95);
		_loc7_.translate(this.leftLegStartPoint.x,this.leftLegStartPoint.y);
		this.leftLegContainer.leg.transform.matrix = _loc7_;
		this.torso.chestCostume.legMask.rotation = this.torso.leg.rotation - 27.6;
		this.torso.rightThighCostumeMask.legMask.rotation = this.torso.leg.rotation;
		this.torso.rightCalfContainer.calf.transform.matrix = _loc4_;
		this.torso.rightCalfContainer.calfStocking.transform.matrix = _loc4_;
		this.torso.rightCalfContainer.calfStockingB.transform.matrix = _loc4_;
		this.torso.rightCalfContainer.footwear.transform.matrix = _loc4_;
		this.torso.rightCalfContainer.bottoms.transform.matrix = _loc4_;
		this.torso.rightCalfContainer.cuffs.transform.matrix = _loc4_;
		this.leftLegContainer.leg.calf.transform.matrix = _loc4_;
		this.leftLegContainer.leg.calfStocking.transform.matrix = _loc4_;
		this.leftLegContainer.leg.calfStockingB.transform.matrix = _loc4_;
		this.leftLegContainer.leg.footwear.transform.matrix = _loc4_;
		this.leftLegContainer.leg.leftCalfBottoms.transform.matrix = _loc4_;
		this.leftLegContainer.leg.cuffs.transform.matrix = _loc4_;
	}

	public function updateArms() {
		var _loc1_:Matrix = null;
		var _loc2_:Matrix = null;
		var _loc3_:Matrix = null;
		var _loc4_:Matrix = null;
		var _loc5_:Matrix = null;
		var _loc6_:Matrix = null;
		var _loc7_:Matrix = null;
		var _loc8_:Matrix = null;
		var _loc9_:Matrix = null;
		if (G.handJobMode && this.initialised) {
			this.updateHandJobMode();
		}
		if (this.leftArmFree) {
			this.leftArmIK.update();
			_loc1_ = this.leftArmIK.section1Matrix;
			_loc2_ = this.leftArmIK.section2Matrix;
			_loc3_ = this.leftArmIK.section3Matrix;
			if (G.leftHandJobMode) {
				this.workingHandJobOffset = 0;
				if (G.rightHandJobMode) {
					this.workingHandJobDistance = this.doubleHandJobDistance;
					if (this.leftIsFirstHandJobHand) {
						this.workingHandJobOffset = this.HAND_JOB_HAND_WIDTH / G.him.penisLengthScale;
					}
				} else {
					this.workingHandJobDistance = this.handJobDistance;
				}
				this.leftArmIK.newTarget(new Point(-25 * G.him.penisLengthScale
					- this.handJobDistance
					+ this.workingHandJobDistance * G.currentHandJobPos.x
					+ this.workingHandJobOffset,
					90 * this.bodyScale * (1 / G.him.getPenisWidthWithTwitch())
					+ 40
					- 35 * G.him.getPenisWidthWithTwitch()),
					G.him.penis, true);
				this.leftHandAngleOffset = -(Math.atan(this.leftArmIK.section3Angle) * 180 / Math.PI) * 0.3;
				this.leftArmIK.setEndRotationTarget(this.leftHandAngleOffset - 180, [G.him.penis, G.him]);
			}
			this.leftArmContainer.upperArm.transform.matrix = _loc1_;
			this.leftArmContainer.upperArmCostume.transform.matrix = _loc1_;
			this.leftArmContainer.upperArm.foreArm.transform.matrix = _loc2_;
			this.leftArmContainer.upperArmCostume.foreArmCostume.transform.matrix = _loc2_;
			this.leftArmContainer.upperArm.foreArm.hand.transform.matrix = _loc3_;
			this.leftArmContainer.upperArmCostume.foreArmCostume.handCostume.transform.matrix = this.leftArmContainer.upperArm.foreArm.hand.transform.matrix;
			(_loc4_ = _loc3_.clone()).concat(_loc2_);
			_loc4_.concat(_loc1_);
			if (this.leftHandOver.parent == this.leftHandOverContainer) {
				_loc4_.concat(this.torso.transform.matrix);
			} else {
				_loc4_.concat(this.leftArmContainer.transform.matrix);
			}
			this.leftHandOver.transform.matrix = _loc4_;
		}
		if (this.rightArmFree) {
			this.rightArmIK.update();
			_loc5_ = this.rightArmIK.section1Matrix;
			_loc6_ = this.rightArmIK.section2Matrix;
			_loc7_ = this.rightArmIK.section3Matrix;
			if (G.rightHandJobMode) {
				this.workingHandJobOffset = 0;
				if (G.leftHandJobMode) {
					this.workingHandJobDistance = this.doubleHandJobDistance;
					if (!this.leftIsFirstHandJobHand) {
						this.workingHandJobOffset = this.HAND_JOB_HAND_WIDTH / G.him.penisLengthScale;
					}
				} else {
					this.workingHandJobDistance = this.handJobDistance;
				}
				this.rightArmIK.newTarget(new Point(-25 * G.him.penisLengthScale - this.handJobDistance
					+ this.workingHandJobDistance * G.currentHandJobPos.x + this.workingHandJobOffset,
					90 * this.bodyScale * (1 / G.him.getPenisWidthWithTwitch())),
					G.him.penis, true);
				this.rightHandAngleOffset = -(Math.atan(this.rightArmIK.section3Angle) * 180 / Math.PI) * 0.3;
				this.rightArmIK.setEndRotationTarget(this.rightHandAngleOffset - 180, [G.him.penis, G.him]);
			}
			if (this.currentRightArmPosition == 2) {
				if (Math.asin(_loc7_.b) > 0.1) {
					this.armIKOffsetSpeed.y += (Math.asin(_loc7_.b) - 0.1) * 20;
				} else {
					this.armIKOffsetSpeed.y -= this.armIKOffset.y * 0.05 * Math.max(0, -(Math.asin(_loc7_.b) - 0.1));
				}
				this.armIKOffset.y += this.armIKOffsetSpeed.y;
				this.rightArmIK.newTarget(new Point(this.rightHandOnHim.x, this.rightHandOnHim.y + this.armIKOffset.y), G.him.leftLeg, true);
				if (this.currentLeftArmPosition == 2) {
					this.leftArmIK.newTarget(this.leftHandOnHim, G.him.rightLeg, true);
				}
			}
			this.armIKOffsetSpeed.y *= 0.7;
			_loc8_ = this.rightArmContainer.transform.matrix.clone();
			(_loc9_ = G.him.transform.matrix.clone()).invert();
			_loc8_.concat(_loc9_);
			this.rightArmEraseContainer.transform.matrix = _loc8_;
			this.rightArmContainer.upperArm.transform.matrix = _loc5_;
			this.rightArmContainer.upperArmMask.transform.matrix = _loc5_;
			this.rightArmContainer.upperArmCostume.transform.matrix = _loc5_;
			this.rightArmEraseContainer.upperArm.transform.matrix = _loc5_;
			this.rightArmEraseContainer.upperArmCostume.transform.matrix = _loc5_;
			this.rightForeArmContainer.upperArm.transform.matrix = _loc5_;
			this.rightForeArmContainer.upperArmCostume.transform.matrix = _loc5_;
			this.rightForeArmContainer.upperArm.foreArm.transform.matrix = _loc6_;
			this.rightForeArmContainer.upperArmCostume.foreArmCostume.transform.matrix = _loc6_;
			this.rightForeArmContainer.upperArm.foreArm.hand.transform.matrix = _loc7_;
			this.rightForeArmContainer.upperArmCostume.foreArmCostume.handCostume.transform.matrix = this.rightForeArmContainer.upperArm.foreArm.hand.transform.matrix;
		}
	}

	public function updateHandJobMode() {
		var _loc1_ = G.currentHandJobPos.x;
		var _loc2_:Float = G.him.getPosOnPenis(localToGlobal(this.topLipA)) + this.handJobHeadPadding / G.him.penisLengthScale;
		G.currentHandJobPos.x += (G.targetHandJobPos.x * (1 - _loc2_) + _loc2_ - G.currentHandJobPos.x) / 2;
		G.currentHandJobPos.x = Math.min(1, Math.max(_loc2_, G.currentHandJobPos.x));
		G.currentHandJobPos.y += (G.targetHandJobPos.y - G.currentHandJobPos.y) / 2;
		var _loc3_ = G.currentHandJobPos.x * range - _loc1_ * range;
		if (!this.passedOut) {
			G.him.givePleasure(!!Math.isNaN(_loc3_) ? 0 : _loc3_ * 0.8);
			if (Math.abs(_loc3_) > 10) {
				G.dialogueControl.buildState(Dialogue.HAND_JOB_STROKE, Dialogue.FRAME_BUILD);
			}
		}
		G.soundControl.updateRub(Math.min(0.5, _loc3_ * 0.01), this.pos);
		this.handJobPenisWidth = G.him.getSimplePenisWidth(G.her.rightForeArmContainer.upperArm.foreArm.hand.localToGlobal(new Point(0,0)));
        var _loc4_ = 0.5 - 0.5 * G.him.getPenisMinRatio() + 0.5 * this.handJobPenisWidth / 65;
		_loc4_ += Math.abs(Math.tan(this.rightHandAngleOffset / 180 * Math.PI) * 0.4);
		_loc4_ = Math.min(1.1,_loc4_);
		if(this.rightForeArmContainer.upperArm.foreArm.hand.grip != null)
		{
		   this.rightForeArmContainer.upperArm.foreArm.hand.grip.scaleY = _loc4_;
		}
		if(this.rightForeArmContainer.upperArmCostume.foreArmCostume.handCostume.glove.grip != null)
		{
		   this.rightForeArmContainer.upperArmCostume.foreArmCostume.handCostume.glove.grip.scaleY = _loc4_;
		}
		if(this.rightForeArmContainer.upperArm.foreArm.hand.tan.grip != null)
		{
		   this.rightForeArmContainer.upperArm.foreArm.hand.tan.grip.scaleY = _loc4_;
		}
		if(this.leftHandOver.hand.grip != null)
		{
		   this.leftHandOver.hand.scaleY = 0.8 + (1 - _loc4_) * 0.3;
		}
	}

	public function slipHands() {
		if (armPositions[this.currentLeftArmPosition] == "On Him") {
			if (G.breathLevel > G.outOfBreathPoint) {
				this.leftArmIK.slip(this.passOutFactor / this.passOutMax * Math.random());
			} else {
				this.leftArmIK.resetTarget(0.3);
			}
		}
		if (armPositions[this.currentRightArmPosition] == "On Him") {
			if (G.breathLevel > G.outOfBreathPoint) {
				this.rightArmIK.slip(this.passOutFactor / this.passOutMax * Math.random());
			} else {
				this.rightArmIK.resetTarget(0.3);
			}
		}
	}

	public function generateSpit() {
		if (this.justHilt) {
			if (this.previousMovement > 15) {
				G.soundControl.playSplat();
				this.generateSplat(this.previousMovement / 10, 20, this.movement / 10);
			}
			this.justHilt = false;
		}
	}

	public function generateSplat(param1:Float, param2:UInt = 1, param3:Float = 1, param4:Bool = false) {
		var _loc9_ = Math.NaN;
		var _loc10_:Point = null;
		var _loc11_ = Math.NaN;
		var _loc12_ = Math.NaN;
		var _loc13_ = Math.NaN;
		param1 = Math.min(8, param1);
		param3 = Math.min(2, param3);
		var _loc5_ = G.sceneLayer.globalToLocal(this.localToGlobal(this.topLipB));
		var _loc6_:Point = G.sceneLayer.globalToLocal(this.head.jaw.localToGlobal(this.bottomLipA));
		var _loc7_:Point = new Point(_loc5_.x - _loc6_.x,_loc5_.y - _loc6_.y);
		_loc7_.x /= 100;
		_loc7_.y /= 100;
		var _loc8_:UInt = 0;
		while(_loc8_ < param2)
		{
		   _loc9_ = Math.random() * 100;
		   _loc10_ = new Point(_loc6_.x + _loc9_ * _loc7_.x,_loc6_.y + _loc9_ * _loc7_.y);
		   _loc11_ = (Math.random() * 2 - 1 - (_loc9_ - 50) * 0.25) * param3;
		   _loc12_ = (Math.random() * 8 - 4 + param1) * param3;
		   _loc13_ = Math.random() * 1.5 + 0.1;
		   if(param4)
		   {
		      G.cumLayer.addChild(new Droplet(_loc10_,new Point(_loc12_,_loc11_),_loc13_,0.2,1,true));
		   }
		   else if(G.spit)
		   {
		      G.strandFrontLayer.addChild(new Droplet(_loc10_,new Point(_loc12_,_loc11_),_loc13_));
		   }
		   _loc8_++;
		}
	}

	public function generateRandomStrand(param1:String = "front", param2:Bool = true) {
		var _loc3_:Point = null;
		var _loc4_:Float = Math.NaN;
		var _loc5_:Point = null;
		var _loc6_:AnchorProp = null;
		var _loc7_:AnchorProp = null;
		var _loc8_:UInt = 0;
		if(G.spit && !G.strandControl.maxPop())
		{
		   if(param1 == "random")
		   {
		      if(Math.random() > 0.7)
		      {
		         param1 = "front";
		      }
		      else
		      {
		         param1 = "back";
		      }
		   }
		   if(Math.random() > 0.5)
		   {
		      _loc3_ = new Point(this.topLipA.x - this.topLipB.x,this.topLipA.y - this.topLipB.y);
		      _loc4_ = Math.random();
		      _loc5_ = new Point(this.topLipB.x + _loc4_ * _loc3_.x,this.topLipB.y + _loc4_ * _loc3_.y);
		      _loc6_ = new AnchorProp(_loc5_.clone(),this);
		   }
		   else
		   {
		      _loc3_ = new Point(this.bottomLipA.x - this.bottomLipB.x,this.bottomLipA.y - this.bottomLipB.y);
		      _loc4_ = Math.random();
		      _loc5_ = new Point(this.bottomLipB.x + _loc4_ * _loc3_.x,this.bottomLipB.y + _loc4_ * _loc3_.y);
		      _loc6_ = new AnchorProp(_loc5_.clone(),this.head.jaw);
		   }
		   _loc7_ = G.him.getRandomAnchor(this.pos);
		   if(param2)
		   {
		      _loc8_ = Math.floor(Math.random() * 4) + 4;
		   }
		   else
		   {
		      _loc8_ = Math.floor(Math.random() * 2) + 3;
		   }
		   if(param1 == "front")
		   {
		      G.strandControl.newStrand(G.strandFrontLayer,_loc8_,G.randomSpitMass(),_loc6_,_loc7_,param2,new Point(this.movement / 5,0));
		   }
		   else if(param1 == "back")
		   {
		      G.strandControl.newStrand(G.strandBackLayer,_loc8_,G.randomSpitMass(),_loc6_,_loc7_,param2,new Point(this.movement / 5,0),true);
		   }
		}
	}

	public function generateTongueStrand() {
		var _loc1_:AnchorProp = null;
		var _loc2_:AnchorProp = null;
		var _loc3_:UInt = 0;
		if (G.spit && !G.strandControl.maxPop()) {
			_loc1_ = new AnchorProp(new Point(), this.tongue.tipPoint);
			_loc2_ = new AnchorProp(G.him.penis.globalToLocal(this.tongue.localToGlobal(this.tongue.tip)), G.him.penis);
			_loc3_ = Std.int(Math.ffloor(Math.random() * 2) + 4);
			G.strandControl.newStrand(G.strandBackLayer, _loc3_, G.randomSpitMass() * 0.5, _loc1_, _loc2_, false, new Point(this.movement / 5, 0));
		}
	}

	public function generateWetness() {
		this.wetGenerate = Math.max(0, this.wetGenerate - 500);
	}

	public function tickSwallowing() {
		var _loc1_:UInt = 0;
		this.jawBulgeTarget = Math.floor(Math.max(0, Math.min(25, this.pos * 25)));
		if (this.swallowing) {
			++this.swallowTimer;
			if (this.swallowTimer < this.swallowSequence.relax) {
				this.swallowPoint = 1 - (this.swallowSequence.relax - this.swallowTimer) / this.swallowSequence.relax;
			} else {
				this.swallowPoint = 1 - (this.swallowTimer - this.swallowSequence.relax) / (this.swallowSequence.end - this.swallowSequence.relax);
			}
			this.headTiltTarget += 0.3 * this.swallowPoint * this.headTiltScaling;
			this.jawBulgeTarget = Std.int(Math.min(49, this.jawBulgeTarget + Math.ffloor(this.swallowPoint * 40)));
			_loc1_ = Std.int(Math.abs(this.swallowTimer - this.swallowSequence.swallow));
			if (_loc1_ < 10) {
				this.wince();
				this.headTiltTarget += 0.2 * this.headTiltScaling - 0.02 * _loc1_ * this.headTiltScaling;
				this.jawBulgeTarget = Std.int(Math.max(0, this.jawBulgeTarget - Math.ffloor(35 * 0.1 * (10 - _loc1_))));
			}
		}
		this.updateJawBulge();
	}

	public function updateJawBulge() {
		this.head.jaw.jawBulge.gotoAndStop(this.lipSkinOffset + this.jawBulgeTarget);
		this.head.jawBack.jawBulgeOutline.gotoAndStop(this.jawBulgeTarget);
		this.head.headTan.jaw.jawBulge.gotoAndStop(this.lipSkinOffset + this.jawBulgeTarget);
		this.head.headTan.jawBack.jawBulgeOutline.gotoAndStop(this.jawBulgeTarget);
	}

	public function fillMouth(param1:Bool = false) {
		if (param1 || this.mouthFull) {
			if (this.held) {
				G.dialogueControl.buildState(Dialogue.CUM_IN_THROAT, Dialogue.TICK_BUILD * 2);
			} else {
				G.dialogueControl.buildState(Dialogue.CUM_IN_MOUTH, Dialogue.TICK_BUILD * 2);
				this.cumInMouth = Std.int(Math.min(this.maxCumInMouth, this.cumInMouth + 1));
			}
		}
	}

	public function swallowFromMouth() {
		var _loc1_:UInt = Std.int(Math.min(this.cumInMouth, Math.ffloor(Math.random() * 5 + 5)));
		this.cumInMouth -= _loc1_;
	}

	public function lastSpurt() {
		if (G.nostrilSpray && this.cumInMouth >= this.fullCumInMouth + this.minNostrilSpray) {
			this.currentNostrilSpray = G.strandControl.newCumStrand(this.nostril,this.head.face);
			this.currentNostrilSpray.myGravity = G.gravity / 2;
			this.shock(50);
			this.wince();
			this.nostrilSpraying = true;
			this.nostrilSprayToggle = true;
		}
	}

	public function tickNostrilSpray() {
		this.nostrilSprayToggle = !this.nostrilSprayToggle;
		var _loc1_ = ((this.cumInMouth - this.fullCumInMouth) * 2 + Math.max(0, this.movement) * 0.2) * 0.02;
		if (this.mouthFull && this.cumInMouth > this.fullCumInMouth) {
			if (this.nostrilSprayToggle) {
				G.dialogueControl.buildState(Dialogue.CUM_IN_NOSE, Dialogue.TICK_BUILD * 2);
				this.currentNostrilSpray.insertLink(new Point(25 * _loc1_ + this.movement, 10 * _loc1_), 5, G.randomCumMass() * 0.8);
				--this.cumInMouth;
			}
		} else {
			this.currentNostrilSpray.detachSourceLink(new Point(25 * _loc1_ + this.movement, 10 * _loc1_), 5);
			this.nostrilSpraying = false;
		}
	}

	public function tickSpitDrool() {
		if (this.spitDroolTimer > 0) {
			--this.spitDroolTimer;
			if (this.spitDroolTimer % this.spitDroolLinkFreq == 0) {
				if (this.startedSpitDrool) {
					this.currentSpitDrool.insertLink(new Point(0, 0), 2, G.randomSpitMass());
				} else {
					this.currentSpitDrool = G.strandControl.newStrand(G.strandFrontLayer, 1, G.randomSpitMass(), null, null, true);
					this.currentSpitDrool.addSourceLink(this.offBottomLip,this.head.jaw);
					this.currentSpitDrool.myGravity = G.gravity / 2;
					this.currentSpitDrool.collisionFree = 5;
					this.startedSpitDrool = true;
				}
			}
		} else {
			this.stopDroolingSpit();
			this.droolingSpit = false;
		}
	}

	public function stopDroolingSpit() {
		if (Math.random() > 0.3) {
			this.currentSpitDrool.detachSourceLink(new Point(0, 0), 5);
		}
		this.currentSpitDrool.collisionFree = 5;
		this.currentSpitDrool.myGravity = G.gravity;
		this.startedSpitDrool = false;
		this.droolingSpit = false;
	}

	public function randomSpitDrool() {
		if (G.spit) {
			this.spitDroolTimer = Std.int(Math.ffloor(Math.random() * 5 + 3) * this.spitDroolLinkFreq);
			this.droolingSpit = true;
		}
	}

	public function randomGagDroolTimer() {
		this.gagDroolTimer = Std.int(Math.ffloor(Math.random() * 240) + 300);
	}

	public function tickCumDrool() {
		if (this.cumDroolTimer > 0) {
			--this.cumDroolTimer;
			if (this.cumDroolTimer % this.cumDroolLinkFreq == 0) {
				if (this.startedCumDrool) {
					this.currentCumDrool.insertLink(new Point(0, 0), 2, G.randomCumMass() * 2);
				} else {
					this.currentCumDrool = G.strandControl.newCumStrand(this.offBottomLip,this.head.jaw);
					this.currentCumDrool.myGravity = G.gravity / 2;
					this.currentCumDrool.collisionFree = 2;
					this.startedCumDrool = true;
				}
			}
		} else {
			this.stopDroolingCum();
			if (this.cumDrool < this.cumDroolNum) {
				this.randomCumDrool();
			} else {
				this.droolingCum = false;
			}
		}
	}

	public function startDroolingCum(param1:Bool = false) {
		if (this.cumInMouth < 5 && param1) {
			this.cumInMouth = Std.int(5 + Math.fceil(Math.random() * 5));
		}
		if (this.cumInMouth > 5) {
			G.dialogueControl.buildState(Dialogue.DROOL, Dialogue.ONE_OFF_BUILD);
			this.cumDroolNum = Std.int(Math.max(1, Math.ffloor(Math.random() * 2 + this.cumInMouth / 10)));
			this.cumDrool = 0;
			this.randomCumDrool();
		}
	}

	public function stopDroolingCum() {
		if (this.currentCumDrool != null) {
			if (Math.random() > 0.3) {
				this.currentCumDrool.detachSourceLink(new Point(0, 0), 5);
			}
			this.currentCumDrool.collisionFree = 4;
			this.currentCumDrool.myGravity = G.gravity / 2;
			this.currentCumDrool = null;
		}
		this.startedCumDrool = false;
		this.droolingCum = false;
	}

	public function randomCumDrool() {
		this.cumDroolTimer = Std.int(Math.min(this.cumInMouth * this.cumDroolLinkFreq,
			Math.ffloor(this.cumInMouth * this.cumDroolLinkFreq / (this.cumDroolNum - this.cumDrool) + Math.random() * 5)));
		this.cumInMouth -= Math.floor(this.cumDroolTimer / this.cumDroolLinkFreq);
		++this.cumDrool;
		this.droolingCum = true;
	}

	public function getRandomMotion():Float {
		if (this.randomMotion.next > 0) {
			--this.randomMotion.next;
			this.randomMotion.speed += (this.randomMotion.target - this.randomMotion.pos) / 10;
			this.randomMotion.speed *= 0.8;
			this.randomMotion.pos += this.randomMotion.speed;
		} else {
			this.randomMotion.target = Math.random() * 0.6 - 0.3;
			this.randomMotion.next = Math.ffloor(Math.random() * 20 + 5);
		}
		return this.randomMotion.pos / 50;
	}

	@:flash.property public var currentHiltDistance(get, never):Float;

	function get_currentHiltDistance():Float {
		return this.hiltDistance;
	}

	@:flash.property public var currentPenisDistance(get, never):Float;

	function get_currentPenisDistance():Float {
		return this.penisInMouthDist;
	}

	@:flash.property public var breathingAnimationAmount(get, never):Float;

	function get_breathingAnimationAmount():Float {
		return this.breathingFactor;
	}

	@:flash.property public var penisOn(get, never):Bool;

	function get_penisOn():Bool {
		return this.penisControl.currentPenisID > 0;
	}
}
