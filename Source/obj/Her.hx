package obj;

import openfl.display.BlendMode;
import openfl.display.MovieClip;
import openfl.geom.Point;
import swf.exporters.animate.AnimateSpriteSymbol;

@:rtti
class CollarContainer extends #if flash flash.display.MovieClip.MovieClip2 #else openfl.display.MovieClip #end
{
	@:keep @:noCompletion @:dox(hide) public var collar(default, null):openfl.display.MovieClip;
}

@:rtti
class RightCalfContainer extends openfl.display.MovieClip
{
    @:keep public var bottoms(default, null): MovieClip;
    @:keep public var cuffs(default, null): MovieClip;
    @:keep public var calfStocking(default, null): MovieClip;
    @:keep public var calfStockingB(default, null): MovieClip;
    @:keep public var footwear(default, null): MovieClip;
}

@:rtti
class ThighCostume extends openfl.display.MovieClip
{
    @:keep public var panties(default, null): MovieClip;
}

@:rtti
class BackUnderCostume extends openfl.display.MovieClip
{
    @:keep public var panties(default, null): MovieClip;
}

@:rtti
class ChestCostume extends openfl.display.MovieClip
{
    @:keep public var bellyPiercing(default, null): MovieClip;
    @:keep public var bottoms(default, null): MovieClip;
}

@:rtti
class ChestUnderCostume extends openfl.display.MovieClip
{
    @:keep public var panties(default, null): MovieClip;
}

@:rtti
class BackCostume extends openfl.display.MovieClip
{
    @:keep public var bottoms(default, null): MovieClip;
}

@:rtti
class TopContainer extends openfl.display.MovieClip
{
    @:keep public var backTop(default, null): MovieClip;
    @:keep public var breastTop(default, null): MovieClip;
    @:keep public var chestTop(default, null): MovieClip;
    @:keep public var topStrap(default, null): MovieClip;
}

@:rtti
class UpperChestCostume extends openfl.display.MovieClip
{
    @:keep public var bra(default, null): MovieClip;
}

@:rtti
class Torso extends openfl.display.MovieClip
{
    @:keep public var backCostume(default, null): BackCostume;
    @:keep public var backUnderCostume(default, null): BackUnderCostume;
    @:keep public var braStrap(default, null): MovieClip;
    @:keep public var breastCostume(default, null): BreastCostume;
    @:keep public var chestCostume(default, null): ChestCostume;
    @:keep public var chestUnderCostume(default, null): ChestUnderCostume;
    @:keep public var cuffs(default, null): MovieClip;
    @:keep public var leftGlove(default, null): MovieClip;
    @:keep public var leftNipplePiercing(default, null): MovieClip;
    @:keep public var nipplePiercing(default, null): MovieClip;
    @:keep public var rightCalfContainer(default, null): RightCalfContainer;
    @:keep public var rightGlove(default, null): MovieClip;
    @:keep public var rightThighBottoms(default, null): MovieClip;
    @:keep public var rightThighBottomsOver(default, null): MovieClip;
    @:keep public var rightThighCostume(default, null): ThighCostume;
    @:keep public var rightThighStocking(default, null): MovieClip;
    @:keep public var rightThighStockingB(default, null): MovieClip;
    @:keep public var shoulderStrap(default, null): MovieClip;
    @:keep public var topContainer(default, null): TopContainer;
    @:keep public var upperChestCostume(default, null): UpperChestCostume;
}

@:rtti
class Hand extends openfl.display.MovieClip
{
    @:keep public var glove(default, null): MovieClip;
}

@:rtti
class HandCostume extends openfl.display.MovieClip
{
    @:keep public var glove(default, null): MovieClip;
    @:keep public var hand(default, null): Hand;
}

@:access(swf.exporters.animate)
@:rtti
class LeftHandOver extends openfl.display.MovieClip
{
    @:keep public var glove(default, null): MovieClip;
    @:keep public var hand(default, null): Hand;

	public function new()
	{
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("FYA8BqNO2PenTmHMYgDK");
		var symbol = library.symbols.get(2051);
		symbol.__initObject(library, this);
	}
}

@:rtti
class LeftForeArmCostume extends openfl.display.MovieClip
{
    @:keep public var cuff(default, null): MovieClip;
    @:keep public var glove(default, null): MovieClip;
    @:keep public var top(default, null): MovieClip;
    @:keep public var handCostume(default, null): HandCostume;
}

@:rtti
class RightForeArmCostume extends openfl.display.MovieClip
{
    @:keep public var cuff(default, null): MovieClip;
    @:keep public var glove(default, null): MovieClip;
    @:keep public var top(default, null): MovieClip;
    @:keep public var handCostume(default, null): HandCostume;
}

@:rtti
class LeftUpperArmCostume extends openfl.display.MovieClip
{
    @:keep public var glove(default, null): MovieClip;
    @:keep public var foreArmCostume(default, null): LeftForeArmCostume;
    @:keep public var top(default, null): MovieClip;
}

@:rtti
class RightUpperForeArmCostume extends openfl.display.MovieClip
{
    @:keep public var foreArmCostume(default, null): RightForeArmCostume;
}

@:rtti
class RightUpperArmCostume extends openfl.display.MovieClip
{
    @:keep public var glove(default, null): MovieClip;
    @:keep public var top(default, null): MovieClip;
}

@:access(swf.exporters.animate)
@:rtti
class HerLeftArmContainer extends openfl.display.MovieClip
{
    @:keep public var upperArm(default, null): MovieClip;
    @:keep public var upperArmCostume(default, null): LeftUpperArmCostume;

	public function new()
	{
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("FYA8BqNO2PenTmHMYgDK");
		var symbol = library.symbols.get(581);
		symbol.__initObject(library, this);
	}
}

@:access(swf.exporters.animate)
@:rtti
class RightUpperForeArm extends openfl.display.MovieClip
{
    @:keep public var foreArm(default, null): MovieClip;

	public function new()
	{
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("FYA8BqNO2PenTmHMYgDK");
		var symbol = library.symbols.get(2022);
		symbol.__initObject(library, this);
	}
}

@:access(swf.exporters.animate)
@:rtti
class HerRightForeArmContainer extends openfl.display.MovieClip
{
    @:keep public var upperArmCostume(default, null): RightUpperForeArmCostume;
    @:keep public var upperArm(default, null): RightUpperForeArm;

	public function new()
	{
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("FYA8BqNO2PenTmHMYgDK");
		var symbol = library.symbols.get(2036);
		symbol.__initObject(library, this);
	}
}

@:access(swf.exporters.animate)
@:rtti
class HerRightArmContainer extends openfl.display.MovieClip
{
    @:keep public var upperArmCostume(default, null): RightUpperArmCostume;
    @:keep public var upperArm(default, null): MovieClip;
    @:keep public var upperArmMask(default, null): MovieClip;

	public function new()
	{
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("FYA8BqNO2PenTmHMYgDK");
		var symbol = library.symbols.get(1998);
		symbol.__initObject(library, this);
	}
}

@:access(swf.exporters.animate)
@:rtti
class HerRightArmEraseContainer extends openfl.display.MovieClip
{
    @:keep public var upperArmCostume(default, null): RightUpperArmCostume;
    @:keep public var upperArm(default, null): MovieClip;

	public function new()
	{
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("FYA8BqNO2PenTmHMYgDK");
		var symbol = library.symbols.get(98);
		symbol.__initObject(library, this);
	}
}

@:rtti
class Leg extends openfl.display.MovieClip
{
    @:keep public var cuffs(default, null): MovieClip;
    @:keep public var footwear(default, null): MovieClip;
    @:keep public var leftThighCostume(default, null): ThighCostume;
    @:keep public var leftThighBottoms(default, null): MovieClip;
    @:keep public var leftCalfBottoms(default, null): MovieClip;
    @:keep public var stocking(default, null): MovieClip;
    @:keep public var stockingB(default, null): MovieClip;
    @:keep public var calfStocking(default, null): MovieClip;
    @:keep public var calfStockingB(default, null): MovieClip;
}

@:rtti
class LegContainer extends openfl.display.MovieClip
{
    @:keep public var leg(default, null): Leg;
}

@:rtti
class BacksideCostume extends openfl.display.MovieClip
{
    @:keep public var bottoms(default, null): MovieClip;
    @:keep public var panties(default, null): MovieClip;
    @:keep public var stocking(default, null): MovieClip;
    @:keep public var stockingB(default, null): MovieClip;
}

@:rtti
class TorsoBackCostume extends openfl.display.MovieClip
{
    @:keep public var backsideCostume(default, null): BacksideCostume;
    @:keep public var breastCostume(default, null): BreastCostume;
}

@:rtti
class BreastCostume extends openfl.display.MovieClip
{
    @:keep public var top(default, null): MovieClip;
    @:keep public var bra(default, null): MovieClip;
}

@:rtti
class TorsoUnderCostume extends openfl.display.MovieClip
{
    @:keep public var top(default, null): MovieClip;
}

@:rtti
class TongueContainer extends openfl.display.MovieClip
{
    @:keep public var tongue(default, null): obj.her.Tongue;
}

@:rtti
class HerHairMidContainer extends openfl.display.MovieClip
{
    @:keep public var hairUnder(default, null): MovieClip;
    @:keep public var hairBottom(default, null): MovieClip;
}

@:rtti
@:access(swf.exporters.animate)
class HairBackContainer extends openfl.display.MovieClip
{
    @:keep public var hairBackLayer(default, null): MovieClip;
    @:keep public var hairBack(default, null): MovieClip;

	public function new()
	{
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("FYA8BqNO2PenTmHMYgDK");
		var symbol = library.symbols.get(598);
		symbol.__initObject(library, this);
	}
}

@:rtti
@:access(swf.exporters.animate)
class Her extends openfl.display.MovieClip
{
    @:keep public var blush(default, null): MovieClip;
    @:keep public var bottomLipstick(default, null): MovieClip;
    @:keep public var collarContainer(default, null):CollarContainer;
    @:keep public var ear(default, null): MovieClip;
    @:keep public var earrings(default, null): Earrings;
    @:keep public var eye(default, null): MovieClip;
    @:keep public var eyewear(default, null): MovieClip;
    @:keep public var freckles(default, null):obj.her.Freckles;
    @:keep public var gagBack(default, null): MovieClip;
    @:keep public var gagFront(default, null): MovieClip;
    @:keep public var hairBetweenLayer(default, null): MovieClip;
    @:keep public var hairCostumeUnderLayer(default, null): MovieClip;
    @:keep public var hairBackContainer(default, null): HairBackContainer;
    @:keep public var hairMidContainer(default, null): HerHairMidContainer;
    @:keep public var hairTop(default, null): MovieClip;
    @:keep public var head(default, null): MovieClip;
    @:keep public var leftArmContainer(default, null): HerLeftArmContainer;
    @:keep public var leftEyebrow(default, null): MovieClip;
    @:keep public var leftHandOverContainer(default, null): MovieClip;
    @:keep public var leftHandOver(default, null): LeftHandOver;
    @:keep public var rightForeArmContainer(default, null): HerRightForeArmContainer;
    @:keep public var rightArmContainer(default, null): HerRightArmContainer;
    @:keep public var rightArmEraseContainer(default, null): HerRightArmEraseContainer;
    @:keep public var rightEyebrow(default, null): MovieClip;
    @:keep public var rightHandOver(default, null): MovieClip;
    @:keep public var tears(default, null):obj.her.Tears;
    @:keep public var tongueContainer(default, null): TongueContainer;
    @:keep public var topLipTongue(default, null):sDT_1_21_1b_fla.TopLipTongue_218;
    @:keep public var topLipstickContainer(default, null): MovieClip;
    @:keep public var torso(default, null):Torso;
    @:keep public var torsoBack(default, null): MovieClip;
    @:keep public var torsoBackCostume(default, null): TorsoBackCostume;
    @:keep public var torsoUnderCostume(default, null): TorsoUnderCostume;
    @:keep public var leftLegContainer(default, null): LegContainer;

    @:keep public var currentLeftArmPosition: UInt = 0;
    @:keep public var currentRightArmPosition: UInt = 0;

    @:keep public var leftShoulderPos: Point;
    @:keep public var rightShoulderPos: Point;
    @:keep public var foreArmPos: Point;

	public function new()
	{
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("FYA8BqNO2PenTmHMYgDK");
		var symbol = library.symbols.get(1982);
		symbol.__initObject(library, this);
	}

	public function giveArmContainers(param1: HerLeftArmContainer,
                                        param2: HerRightArmContainer,
                                        param3: HerRightForeArmContainer,
                                        param4: HerRightArmEraseContainer,
                                        param5: LeftHandOver)
    {
		this.rightArmContainer = param2;
		this.rightArmEraseContainer = param4;
		this.rightForeArmContainer = param3;
		this.leftArmContainer = param1;
		this.leftHandOver = param5;
		this.leftHandOver.visible = false;
		this.rightArmContainer.blendMode = BlendMode.LAYER;
		this.rightArmEraseContainer.visible = false;
		// this.leftArmIK = new IKController(this.torso, this.leftArmContainer.upperArm, this.leftArmContainer.upperArm.foreArm,
		// 	this.leftArmContainer.upperArm.foreArm.hand);
		// this.rightArmIK = new IKController(this.torso, this.rightArmContainer.upperArm, this.rightForeArmContainer.upperArm.foreArm,
		// 	this.rightForeArmContainer.upperArm.foreArm.hand);
		// this.leftArmIK.rescale(0.95);
		this.leftShoulderPos = new Point(this.leftArmContainer.upperArm.x, this.leftArmContainer.upperArm.y);
		this.rightShoulderPos = new Point(this.rightArmContainer.upperArm.x, this.rightArmContainer.upperArm.y);
		this.foreArmPos = new Point(this.rightForeArmContainer.upperArm.foreArm.x, this.rightForeArmContainer.upperArm.foreArm.y);
		this.setLeftArmPosition(this.currentLeftArmPosition);
		this.setRightArmPosition(this.currentRightArmPosition);
	}

    public function giveHairBackContainer(param1: HairBackContainer)
    {
       this.hairBackContainer = param1;
    }

    public function setLeftArmPosition(param1: Int = -1, param2: Bool = true) {}
    public function setRightArmPosition(param1: Int = -1, param2: Bool = true) {}
}
