package obj;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.MovieClip;
import openfl.filters.BlurFilter;
import openfl.geom.ColorTransform;
import openfl.geom.Matrix;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import obj.dialogue.Dialogue;
import obj.him.Balls;
import obj.him.Penis;
import obj.him.Ejaculation;
import obj.him.bodies.HimFemaleBody;
import obj.him.bodies.HimMaleBody;
import obj.him.bodies.IHimBody;

@:rtti
class HimLeftCalfCostume extends MovieClip
{
	@:keep public var foot(default, null):MovieClip;
}

@:rtti
class HimLeftLegCostume extends MovieClip
{
	@:keep public var calf(default, null):HimLeftCalfCostume;
}

@:rtti
class HimRightCalfCostume extends MovieClip
{
	@:keep public var foot(default, null):MovieClip;
}

@:rtti
class HimRightLegCostume extends MovieClip
{
	@:keep public var calf(default, null):HimRightCalfCostume;
}

@:rtti
class HimLeftCalf extends MovieClip
{
	@:keep public var foot(default, null):MovieClip;
}

@:rtti
class HimLeftLeg extends MovieClip
{
	@:keep public var calf(default, null):HimLeftCalf;
}

@:rtti
class HimRightCalf extends MovieClip
{
	@:keep public var foot(default, null):MovieClip;
}

@:rtti
class HimRightLeg extends MovieClip
{
	@:keep public var calf(default, null):HimRightCalf;
}

@:rtti
class HimLeftNipple extends MovieClip
{
	@:keep public var leftNipple(default, null):Null<MovieClip>;
	@:keep public var tan(default, null):MovieClip;
}

@:rtti
class HimRightNipple extends MovieClip
{
	@:keep public var rightNipple(default, null):Null<MovieClip>;
	@:keep public var tan(default, null):MovieClip;
}

@:rtti
class HimLeftBreast extends MovieClip
{
	@:keep public var nipple(default, null):HimLeftNipple;
	@:keep public var tan(default, null):MovieClip;
}

@:rtti
class HimRightBreast extends MovieClip
{
	@:keep public var nipple(default, null):HimRightNipple;
	@:keep public var tan(default, null):MovieClip;
}

@:rtti
class HimLeftBreastContainer extends MovieClip
{
	@:keep public var leftBreast(default, null):HimLeftBreast;
}

@:rtti
class HimRightBreastContainer extends MovieClip
{
	@:keep public var rightBreast(default, null):HimRightBreast;
}

@:rtti
class HimTorsoLayer extends MovieClip
{
	@:keep public var torso(default, null):MovieClip;
	@:keep public var leftBreastContainer(default, null):HimLeftBreastContainer;
	@:keep public var rightBreastContainer(default, null):HimRightBreastContainer;
}

@:rtti
class HimMidLayer extends MovieClip
{
	@:keep public var hips(default, null):MovieClip;
}

@:rtti
@:access(swf.exporters.animate)
class Him extends MovieClip
{
    public static var armPositions:Array<String> = ["Holding","Free"];
    public static var leftArmPositions:Array<String> = ["Hidden","Loose"];
    public static var DEFAULT_PENIS_SIZE:Float = 1;
    public static var DEFAULT_BALL_SIZE:Float = 1;

	@:keep public var topBack(default, null):MovieClip;
	@:keep public var rightLeg(default, null):HimRightLeg;
	@:keep public var rightLegCostume(default, null):HimRightLegCostume;
	@:keep public var penis(default, null):Penis;
	@:keep public var balls(default, null):obj.him.Balls;
	@:keep public var torsoLayer(default, null):HimTorsoLayer;
	@:keep public var leftLeg(default, null):HimLeftLeg;
	@:keep public var straponStraps(default, null):MovieClip;
	@:keep public var leftLegCostume(default, null):HimLeftLegCostume;
	@:keep public var midLayer(default, null):HimMidLayer;

    public var bodies:Array<IHimBody>;
    public var characterMenu:MovieClip;
    public var bodyNameList:Array<String> = ["Male", "Female"];
    public var penisNameList:Array<String> = ["Penis A", "Penis B", "Strapon"];
    public var ballsNameArray:Array<String> = ["None", "Normal"];
    public var currentBodyID:UInt = 0;
    public var currentArmPosition:UInt = 0;
    public var lastSelectedArmPosition:UInt = 0;
    public var currentLeftArmPosition:UInt = 1;
    public var penisMask:HimMask = new HimMask();
    public var overLayer:HimOverLayer;
    public var armContainer:HimArmContainer;
    public var leftArmContainer:HimLeftArmContainer;
    public var bentPenis:BentPenis;
    public var bpMask:BentPenisMask;
    public var deepestPos:Float = 0;
    public var MIN_PENIS_SIZE:Float = 0.7;
    public var MAX_PENIS_SIZE:Float = 1.2;
    public var currentPenisLengthScale:Float = 1.0;
    public var currentPenisWidthScale:Float = 1.0;
    public var penisPullScale:Float = 0;
    public var MIN_BALL_SIZE:Float = 0.5;
    public var MAX_BALL_SIZE:Float = 1.3;
    public var currentBallSize:Float = 1.0;
    public var currentPenis:Penis;
    public var penisControl:CharacterElementHelper;
    public var penisType1:Penis;
    public var penisType2:Penis;
    public var penisTypes:Array<Penis>;
    public var currentBalls:UInt = 0;
    public var penisTilt:Float = 0;
    public var penisTiltSpeed:Float = 0;
    public var penisTiltTarget:Float = 0;
    public var inMouthTiltOffset:Float = 0;
    public var mouthConstraintSmoothing:Float = 0;
    public var twitchFactor:Float = 0;
    public var twitching:Bool = false;
    public var pleasure:Float = 0;
    public var ejacPleasure:Float = 140;
    public var buildUp:Float = 0;
    public var maxPleasureTimer:UInt = 0;
    public var inMouth:Bool = false;
    public var handOpen:Bool = true;

    public var ejaculating:Bool = false;
    public var ejaculation:Array<Ejaculation>;
    public var playingCumSound:Bool = false;

    public var spurting:Bool = false;
    public var startedSpurt:Bool = false;
    public var currentSpurt:Strand;
    public var spurt:UInt = 0;
    public var spurtNum:UInt = 0;
    public var linkFreq:UInt = 2;

    public var spurtTimer:UInt = 0;
    public var spurtTimerStart:UInt = 0;
    public var randomSpurtAngle:Float = Math.NaN;
    public var randomSpurtAngleRange:Float = Math.NaN;
    public var randomSpurtSpeed:Float = Math.NaN;
    public var randomSpurtCollisionDelay:UInt = 0;
    public var pauseTimer:UInt = 0;

    public var startSpeed:Point;
    public var timerScale:Float = Math.NaN;
    public var bmEjaculating:Bool = false;
    public var bmSpurtAngle:Float = 3.3415926535897933;
    public var bmTimerStart:UInt = 30;
    public var bmTimer:UInt = 0;
    public var lipstickData:BitmapData;
    public var lipstickLayer:Bitmap;
    public var lipstickCounter:UInt = 0;
    public var lipstickBlur:BlurFilter;
    public var lipstickRGB:ColorTransform;
    public var smearGraphic:LipstickSmear;
    public var baseA:Point = new Point(-5, 37);
    public var baseB:Point = new Point(-13,-36);
    public var tipA:Point = new Point(-317,7);
    public var tipB:Point = new Point(-310,-27);
    public var tipMid:Point = new Point(-324,-11);

    public var currentBody:IHimBody;

	public function new()
	{
        var library = swf.exporters.animate.AnimateLibrary.get("sdthx-lib");
		var symbol = library.symbols.get(448);
		symbol.__init(library);

		super();

        this.x = 420;
        this.y = 135;

        this.addChild(this.penisMask);
        this.penis.mask = this.penisMask;

        this.lipstickData = new BitmapData(350,120,true,0);
        this.lipstickLayer = new Bitmap(this.lipstickData,"auto",true);
        this.lipstickBlur = new BlurFilter(3,5.1);
        this.penis.lipstickElements.lipstickContainer.addChild(this.lipstickLayer);
        this.lipstickLayer.alpha = 0.8;
        this.smearGraphic = new LipstickSmear();
        this.penisType1 = new Penis(this.penis,new Point(-315,0));
        this.penisType1.defineWidth(-321.9,-19.3,23.4);
        this.penisType1.defineWidth(-309.5,-29.3,44.8);
        this.penisType1.defineWidth(-291.8,-33.5,52.5);
        this.penisType1.defineWidth(-269.5,-39.2,60.9);
        this.penisType1.defineWidth(-261.5,-33.3,56.6);
        this.penisType1.defineWidth(-168.4,-36.6,71.5);
        this.penisType1.defineWidth(-31.3,-36.3,74.6);
        this.penisType2 = new Penis(this.penis,new Point(-315,0));
        this.penisType2.defineWidth(-318.7,-23.8,29);
        this.penisType2.defineWidth(-293.8,-36,55.1);
        this.penisType2.defineWidth(-286.2,-36.9,57.4);
        this.penisType2.defineWidth(-249.2,-45,68.6);
        this.penisType2.defineWidth(-242.7,-40.6,65.4);
        this.penisType2.defineWidth(-154.6,-38.2,73);
        this.penisType2.defineWidth(-27.7,-37.5,75);
        this.penisTypes = [this.penisType1,this.penisType2,this.penisType1];
        this.currentPenis = this.penisType1;
        this.setBalls(0);
        this.penisControl = new CharacterElementHelper(this.penisNameList,this.setPenis);
        this.penisControl.setStartRGB(new AlphaRGBObject(1,204,94,147));
        this.penisControl.registerComponents([this.penis],"",false);
    }

	public function initBodies() {
		this.bodies = new Array<IHimBody>();
		this.bodies.push(new HimMaleBody(this));
		this.bodies.push(new HimFemaleBody(this));
	}

	public function shuffle() {
		this.currentBody.shuffle();
	}

	public function getDataString():String {
		var _loc1_ = "hisBody:" + G.dataName(this.bodyNameList[this.currentBodyID]);
		var _loc2_ = "hisPenis:" + this.currentPenisID + "," + this.penisLengthScale + "," + this.penisWidthScale;
		var _loc3_ = "balls:" + this.currentBalls + "," + this.ballSizeScale;
		return _loc1_ + ";" + _loc2_ + ";" + _loc3_ + (this.currentBody != null ? ";" + this.currentBody.getDataString() : "");
	}

	public function loadDataPairs(param1:Array<Array<String>>) {
		var _loc3_:Array<String> = null;
		var _loc4_:UInt = 0;
		var _loc5_:Array<String> = null;
		var _loc6_:UInt = 0;
		var _loc7_:Array<String> = null;
		var _loc8_:UInt = 0;
		var _loc2_:Bool = false;
		for (_tmp_ in param1) {
			_loc3_ = _tmp_;
			switch (_loc3_[0]) {
				case "hisBody":
					_loc4_ = this.bodyNameList.length;
					_loc8_ = 0;
					while (_loc8_ < _loc4_) {
						if (G.dataName(_loc3_[1]) == G.dataName(this.bodyNameList[_loc8_])) {
							this.setBody(_loc8_);
							_loc2_ = _loc8_ > 0;
							break;
						}
						_loc8_++;
					}

				case "hisPenis":
					_loc5_ = _loc3_[1].split(",");
					this.penisControl.select(Std.parseInt(_loc5_[0]));
					if (_loc5_.length == 3) {
						this.loadPenisScales(Std.parseFloat(_loc5_[1]), Std.parseFloat(_loc5_[2]));
					}

				case "balls":
					_loc6_ = Std.parseInt(_loc3_[1]);
					_loc7_ = _loc3_[1].split(",");
					this.setBalls(Std.parseInt(_loc7_[0]));
					if (_loc7_.length == 2) {
						this.setBallScale(Std.parseFloat(_loc7_[1]));
					}
					G.inGameMenu.updateBallSizeSlider();
					G.inGameMenu.updateBallsList();
			}
		}
		if (!_loc2_ && this.currentBodyID == 0) {
			this.setBody(0);
		}
		this.currentBody.loadDataPairs(param1);
	}

	// public function loadLegacyData(param1:Array<ASAny>) {
	// 	var _loc2_ = Std.parseInt(param1[0]);
	// 	_loc2_ = Std.int(Math.min(3, Math.max(0, _loc2_)));
	// 	this.setBody(this.bodyNameList.indexOf("Male"));
	// 	if (_loc2_ == 0 || _loc2_ == 2) {
	// 		this.penisControl.select(0);
	// 	} else {
	// 		this.penisControl.select(1);
	// 	}
	// 	if (_loc2_ == 0 || _loc2_ == 1) {
	// 		this.currentBody.loadDataPairs([["hisSkin", 0]]);
	// 	} else {
	// 		this.currentBody.loadDataPairs([["hisSkin", 1]]);
	// 	}
	// 	if (param1.length == 3) {
	// 		this.loadPenisScales(param1[1], param1[2]);
	// 	}
	// 	this.updateArm();
	// }

	public function setBody(param1:UInt) {
		if (this.currentBody != null) {
			this.currentBody.breakdown();
		}
		this.currentBodyID = param1;
		this.currentBody = this.bodies[this.currentBodyID];
		gotoAndStop(this.bodyNameList[this.currentBodyID]);
		this.armContainer.gotoAndStop(this.bodyNameList[this.currentBodyID]);
		this.leftArmContainer.gotoAndStop(this.bodyNameList[this.currentBodyID]);
		this.currentBody.setup();
		this.currentBody.redoLastMove();
		G.characterControl.updateHisSkinHSL();
		G.inGameMenu.updateHisBodyList();
		G.inGameMenu.updateHimMenuContent();
		G.her.setArmPosition();
	}

	public function animationChanged() {
		this.currentBody.animationChanged();
	}

	public function toggleBodySettings() {
		this.currentBody.toggleBodySettings();
	}

	public function giveOverLayer(param1:HimOverLayer) {
		this.overLayer = param1;
		this.overLayer.x = this.x;
		this.overLayer.y = 135;
	}

	public function giveHimArm(param1:HimArmContainer) {
		this.armContainer = param1;
		this.armContainer.x = this.x;
		this.armContainer.y = 135;
		this.openHand();
	}

	public function giveHimLeftArm(param1:HimLeftArmContainer) {
		this.leftArmContainer = param1;
		this.leftArmContainer.x = 136;
		this.leftArmContainer.y = -516;
	}

	public function giveHimBentPenis(param1:BentPenis) {
		this.bentPenis = param1;
		this.bpMask = new BentPenisMask();
		addChild(this.bpMask);
		this.bentPenis.cacheAsBitmap = true;
		this.bpMask.cacheAsBitmap = true;
		this.bentPenis.mask = this.bpMask;
	}

	public function isEjaculating():Bool {
		return this.ejaculating || this.bmEjaculating;
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
		return (this.currentPenisLengthScale - this.MIN_PENIS_SIZE) / (this.MAX_PENIS_SIZE - this.MIN_PENIS_SIZE);
	}

	@:flash.property public var penisWidthSlider(get, never):Float;

	function get_penisWidthSlider():Float {
		return (this.currentPenisWidthScale - this.MIN_PENIS_SIZE) / (this.MAX_PENIS_SIZE - this.MIN_PENIS_SIZE);
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
		this.currentPenis = this.penisTypes[param1];
		if (this.currentPenisID == (this.penisNameList.indexOf("Strapon") : UInt)) {
			// this.characterMenu.rgbPenis.visible = true;
			this.straponStraps.visible = true;
			this.penisControl.resetFills();
		} else {
			// this.characterMenu.rgbPenis.visible = false;
			this.straponStraps.visible = false;
		}
		G.characterControl.updateHisSkinHSL();
	}

	public function updatePenis() {
		if (this.currentPenisID == (this.penisNameList.indexOf("Strapon") : UInt)) {
			this.penis.gotoAndStop(this.penisNameList[this.currentPenisID]);
		} else {
			this.penis.gotoAndStop(G.himSkinType + this.penisNameList[this.currentPenisID]);
		}
		this.penis.wet.gotoAndStop(this.penisNameList[this.currentPenisID]);
		this.penis.lipstickElements.lipstickMask.gotoAndStop(this.penisNameList[this.currentPenisID]);
	}

	public function loadPenisScales(param1:Float, param2:Float) {
		this.currentPenisLengthScale = Math.max(this.MIN_PENIS_SIZE, Math.min(this.MAX_PENIS_SIZE, param1));
		this.currentPenisWidthScale = Math.max(this.MIN_PENIS_SIZE, Math.min(this.MAX_PENIS_SIZE, param2));
		G.inGameMenu.updatePenisWidthSlider();
		G.inGameMenu.updatePenisLengthSlider();
		this.penis.scaleX = this.currentPenisLengthScale;
		this.penis.scaleY = this.currentPenisWidthScale;
		G.her.hisPenisSizeChanged(this.currentPenisLengthScale * this.currentPenis.length);
		EventBus.dispatch("penisTipPosChanged");
	}

	public function setPenisLength(param1:Float) {
		var _loc2_ = this.currentPenisWidthScale / this.currentPenisLengthScale;
		this.currentPenisLengthScale = this.MIN_PENIS_SIZE + (this.MAX_PENIS_SIZE - this.MIN_PENIS_SIZE) * param1;
		this.currentPenisWidthScale = Math.max(this.MIN_PENIS_SIZE, Math.min(this.MAX_PENIS_SIZE, _loc2_ * this.currentPenisLengthScale));
		this.penis.scaleX = this.currentPenisLengthScale;
		this.penis.scaleY = this.currentPenisWidthScale;
		G.her.hisPenisSizeChanged(this.currentPenisLengthScale * this.currentPenis.length);
		EventBus.dispatch("penisTipPosChanged");
	}

	public function setPenisWidth(param1:Float) {
		this.currentPenisWidthScale = this.MIN_PENIS_SIZE + (this.MAX_PENIS_SIZE - this.MIN_PENIS_SIZE) * param1;
		this.penis.scaleX = this.currentPenisLengthScale;
		this.penis.scaleY = this.currentPenisWidthScale;
		G.her.hisPenisSizeChanged(this.currentPenisLengthScale * this.currentPenis.length);
		EventBus.dispatch("penisTipPosChanged");
	}

	public function getPenisTipPoint(param1:Float = 0, param2:Float = 0):Point {
		return this.currentPenis.getGlobalTip(param1, param2);
	}

	public function getPenisBasePoint():Point {
		return this.penis.localToGlobal(new Point());
	}

	public function getSimplePenisWidth(param1:Point):Float {
		return this.currentPenis.getSimplePenisWidth(param1).width;
	}

	public function getPenisWidth(param1:Point, param2:Point, param3:Bool = false):Float {
		var penisWidth: obj.him.Penis.PenisWidth = this.currentPenis.getPenisWidth(param1, param2);
		if (param3) {
			this.inMouthTiltOffset = Math.max(-3, Math.min(3, penisWidth.angOffset));
		} else {
			this.inMouthTiltOffset *= 0.5;
		}
		return penisWidth.width * this.penis.scaleY;
	}

	public function getPosOnPenis(param1:Point):Float {
		return this.currentPenis.getPosOnPenis(param1);
	}

	public function getPenisWidthWithTwitch(param1:Float = 1):Float {
		return this.currentPenisWidthScale * (1 + this.twitchFactor * 0.02 * param1);
	}

	public function getPenisMinRatio():Float {
		return Math.max(0, (1 - this.currentPenisWidthScale) / (1 - this.MIN_PENIS_SIZE));
	}

	@:flash.property public var currentPenisLength(get, never):Float;

	function get_currentPenisLength():Float {
		return this.currentPenisLengthScale * this.currentPenis.length;
	}

	@:flash.property public var currentPenisFullLength(get, never):Float;

	function get_currentPenisFullLength():Float {
		return this.currentPenis.fullLength;
	}

	@:flash.property public var currentPenisBaseWidth(get, never):Float;

	function get_currentPenisBaseWidth():Float {
		return this.currentPenis.baseWidth * this.penis.scaleY;
	}

	public function setBalls(param1:UInt) {
		if (param1 == 0) {
			this.balls.visible = false;
		} else {
			this.balls.visible = true;
		}
		this.currentBalls = param1;
		if (G.inGameMenu != null) {
			G.inGameMenu.updateBallsList();
		}
	}

	public function setBallSize(param1:Float) {
		this.currentBallSize = this.MIN_BALL_SIZE + (this.MAX_BALL_SIZE - this.MIN_BALL_SIZE) * param1;
		this.balls.scaleX = this.currentBallSize;
		this.balls.scaleY = this.currentBallSize;
	}

	public function setBallScale(param1:Float) {
		this.currentBallSize = Math.max(this.MIN_BALL_SIZE, Math.min(this.MAX_BALL_SIZE, param1));
		this.balls.scaleX = this.currentBallSize;
		this.balls.scaleY = this.currentBallSize;
	}

	@:flash.property public var ballSizeSlider(get, never):Float;

	function get_ballSizeSlider():Float {
		return (this.currentBallSize - this.MIN_BALL_SIZE) / (this.MAX_BALL_SIZE - this.MIN_BALL_SIZE);
	}

	@:flash.property public var ballSizeScale(get, never):Float;

	function get_ballSizeScale():Float {
		return this.currentBallSize;
	}

	public function findArmPosition(param1:String, param2:Bool = false) {
		var _loc3_:UInt = armPositions.length;
		var _loc4_:UInt = 0;
		while (_loc4_ < _loc3_) {
			if (G.dataName(armPositions[_loc4_]) == G.dataName(param1)) {
				this.setArmPosition(_loc4_, param2);
				break;
			}
			_loc4_++;
		}
	}

	public function setArmPosition(param1:UInt, param2:Bool = false) {
		this.currentArmPosition = param1;
		switch (this.currentArmPosition) {
			case 0:
				G.handsOff = false;

			case 1:
				G.handsOff = true;
				this.closeHand();
				G.her.setHandsFree();
		}
		if (param2) {
			this.lastSelectedArmPosition = this.currentArmPosition;
		}
		G.inGameMenu.updateHisArmList();
	}

	public function findLeftArmPosition(param1:String) {
		var _loc2_:UInt = leftArmPositions.length;
		var _loc3_:UInt = 0;
		while (_loc3_ < _loc2_) {
			if (G.dataName(leftArmPositions[_loc3_]) == G.dataName(param1)) {
				this.setLeftArmPosition(_loc3_);
				break;
			}
			_loc3_++;
		}
	}

	public function setLeftArmPosition(param1:UInt) {
		this.currentLeftArmPosition = param1;
		if (this.currentLeftArmPosition == 1) {
			this.leftArmContainer.visible = true;
		} else {
			this.leftArmContainer.visible = false;
		}
		G.inGameMenu.updateHisLeftArmList();
	}

	public function resetArmPosition() {
		this.setArmPosition(this.lastSelectedArmPosition);
	}

	public function closeHand() {
		this.armContainer.arm.hand.gotoAndStop("holding" + G.himSkinType);
		this.handOpen = false;
	}

	public function openHand() {
		if (!this.handOpen) {
			this.armContainer.arm.hand.gotoAndPlay("released" + G.himSkinType);
			this.handOpen = true;
		}
	}

	public function updateArm() {
		this.armContainer.arm.upperArm.gotoAndStop(G.himSkinType);
		this.armContainer.arm.lowerArm.gotoAndStop(G.himSkinType);
		if (this.handOpen) {
			this.armContainer.arm.hand.gotoAndStop("releasedDone" + G.himSkinType);
		} else {
			this.armContainer.arm.hand.gotoAndStop("holding" + G.himSkinType);
		}
		this.leftArmContainer.arm.gotoAndStop(G.himSkinType);
		this.leftArmContainer.arm.foreArm.gotoAndStop(G.himSkinType);
		this.leftArmContainer.arm.foreArm.hand.gotoAndStop(G.himSkinType);
	}

	public function givePleasure(amount:Float) {
		var scaled = amount > 0 ? amount * 0.01 : -amount * 0.01;
		this.pleasure = Math.min(this.ejacPleasure + 6, this.pleasure + scaled);
		this.buildUp += scaled;
	}

	public function smearLipstick(param1:Float, param2:Float) {
		if (this.lipstickRGB.alphaMultiplier > 0 && this.lipstickCounter >= 5) {
			this.lipstickCounter = 0;
			var mat = new Matrix();
			var color = new ColorTransform(1, 1, 1, this.lipstickRGB.alphaMultiplier * Math.random() * 0.4 + 0.2, this.lipstickRGB.redOffset,
				this.lipstickRGB.greenOffset, this.lipstickRGB.blueOffset);
			var anchor = this.getRandomAnchor(param1);
			var offsetY = Math.random();
			offsetY *= offsetY;
			if (Math.random() > 0.5) {
				offsetY = 80 - offsetY * 40;
			} else {
				offsetY *= 40;
			}
			mat.scale(Math.max(0.1, Math.random() * 0.1 - 0.05 + param2 * 0.05), Math.random() * 0.8 + 0.2);
			mat.translate((param1 - 0.2) * 380, offsetY);
			this.lipstickData.draw(this.smearGraphic, mat, color);
		} else {
			++this.lipstickCounter;
		}
	}

	public function clearLipstick() {
		this.lipstickData.fillRect(new Rectangle(0, 0, 350, 100), 0);
	}

	public function resetSpit() {
		this.deepestPos = 0;
		this.penis.wetMask.x = -600 + 400 * this.deepestPos;
	}

	public function debugMove(param1:Point) {
		this.currentBody.debugMove(param1);
	}

	public function move(param1:Float, param2:Float, param3:Float) {
		this.inMouth = G.her.isInMouth();
		if (this.inMouth) {
			if (this.mouthConstraintSmoothing < 1) {
				this.mouthConstraintSmoothing = Math.min(1, this.mouthConstraintSmoothing + 0.4);
			}
		} else {
			this.mouthConstraintSmoothing = 0;
		}
		if (this.inMouth) {
			this.penisMask.x = -100 + param1 * 200;
		} else {
			this.penisMask.x = -100;
		}
		this.balls.pushBalls(-this.currentBody.xDelta * 0.003, this.twitchFactor * -2);
		this.balls.update();
		this.penisTiltTarget = 11 - param1 * param1 * 6;
		this.penis.scaleY = this.getPenisWidthWithTwitch();
		if (this.inMouth) {
			this.penisTiltSpeed += G.her.pushPenisTilt() * 0.5;
		} else {
			this.penisTiltTarget += this.twitchFactor * 6;
			if (G.bukkakeMode) {
				this.penisTiltTarget += -2.5 - param3 * 15;
			}
			this.penisTiltSpeed += G.her.pushPenisTilt();
		}
		this.penisPullScale *= 0.9;
		this.penisTiltSpeed += (this.penisTiltTarget - this.penisTilt) / 8;
		this.penisTiltSpeed *= !!this.inMouth ? 0.5 : 0.8;
		this.penisTilt += this.penisTiltSpeed - this.inMouthTiltOffset * this.mouthConstraintSmoothing;
		this.penis.rotation = Math.max(-10, Math.min(25, this.penisTilt));
		this.currentBody.move(param1, param2, param3);
		if (this.pleasure >= this.ejacPleasure) {
			if (this.maxPleasureTimer >= 60) {
				this.ejaculate();
				this.pleasure = 0;
				this.buildUp = 0;
				G.screenEffects.showFlash();
			} else {
				G.screenEffects.showPulse();
				++this.maxPleasureTimer;
				this.pleasure = Math.max(0, this.pleasure - 0.1);
				G.dialogueControl.buildState(Dialogue.PRE_CUM, Dialogue.TICK_BUILD * 2);
			}
		} else {
			G.screenEffects.stopPulse();
			if (G.automaticControl.reducePleasureLoss()) {
				this.pleasure = Math.max(0, this.pleasure - 0.03);
			} else {
				this.pleasure = Math.max(0, this.pleasure - 0.05);
			}
			this.maxPleasureTimer = 0;
		}
		G.screenEffects.showWhiteout((this.pleasure - this.ejacPleasure + 20) * 5);
		if (param1 > this.deepestPos && this.inMouth) {
			this.deepestPos = param1;
			this.penis.wetMask.x = -600 + 400 * this.deepestPos;
			if (param1 > 0.995) {
				this.penis.wetMask.x = -600 + 400 * 1.1;
			}
		}
		if (this.twitchFactor > 0) {
			this.twitchFactor *= 0.83;
			if (this.twitchFactor <= 0.01) {
				this.twitchFactor = 0;
				this.twitching = false;
			}
		}
		if (G.bukkakeMode) {
			if (this.ejaculating && this.spurting) {
				this.currentSpurt.detachSourceLink(new Point(0, 0), 0);
				this.ejaculating = false;
				this.spurting = false;
			}
			if (this.bmEjaculating) {
				this.bmSpurtAngle = 3 - param3 * 1.2;
				if (this.bmTimer > 0) {
					--this.bmTimer;
					if (this.bmTimer % this.linkFreq == 0) {
						if (this.startedSpurt) {
							this.timerScale = this.bmTimer / this.bmTimerStart;
							if (this.spurting) {
								this.twitchFactor += 0.2;
								if (this.inMouth) {
									G.soundControl.switchCumInside();
									this.spurting = false;
									G.her.fillMouth();
									this.currentSpurt.detachSourceLink(new Point(0, 0), 0);
								} else {
									this.startSpeed = new Point();
									this.startSpeed.x = Math.cos(this.bmSpurtAngle) * (this.randomSpurtSpeed - Math.random() * 2 + Math.abs(param3));
									this.startSpeed.y = Math.sin(this.bmSpurtAngle) * (this.randomSpurtSpeed - Math.random() * 2 + Math.abs(param3));
									this.currentSpurt.insertLink(this.startSpeed, Std.int(this.randomSpurtCollisionDelay + Math.ffloor(this.timerScale * 2)),
										G.randomCumMass());
									G.soundControl.adjustCumVolume(this.timerScale, 0.3);
								}
							} else if (!this.inMouth) {
								G.soundControl.switchCumOutside();
								this.currentSpurt = G.strandControl.newCumStrand(this.tipMid, this.penis);
								this.spurting = true;
							} else {
								G.soundControl.adjustCumVolume(this.timerScale, 0.2);
								G.her.fillMouth();
							}
						} else {
							if (!this.inMouth) {
								this.currentSpurt = G.strandControl.newCumStrand(this.tipMid, this.penis);
								this.startedSpurt = true;
								this.spurting = true;
							} else {
								G.her.lastSpurt();
								this.startedSpurt = true;
							}
							G.her.ejaculating();
							G.soundControl.playCum(this.inMouth);
							this.playingCumSound = true;
							if (!this.twitching) {
								this.twitchFactor = Math.random();
								this.twitching = true;
							}
						}
					}
				} else if (this.spurting) {
					this.currentSpurt.detachSourceLink(new Point(0, 0), 0);
					this.spurting = false;
				}
			} else if (this.playingCumSound) {
				this.playingCumSound = G.soundControl.fadeCumVolume(0.1);
			}
		} else if (this.ejaculating) {
			if (this.pauseTimer > 0) {
				--this.pauseTimer;
			} else if (this.spurtTimer > 0) {
				--this.spurtTimer;
				this.twitchFactor += 0.2;
				if (this.spurtTimer % this.linkFreq == 0) {
					if (this.startedSpurt) {
						this.timerScale = this.spurtTimer / this.spurtTimerStart;
						if (this.spurting) {
							if (this.inMouth) {
								G.soundControl.switchCumInside();
								this.spurting = false;
								G.her.fillMouth();
								this.currentSpurt.detachSourceLink(new Point(0, 0), 0);
							} else {
								this.startSpeed = new Point();
								var spurtAngle = this.randomSpurtAngle + Math.sin(this.timerScale * Math.PI) * this.randomSpurtAngleRange;
								this.startSpeed.x = Math.cos(spurtAngle) * (this.randomSpurtSpeed - Math.random());
								this.startSpeed.y = Math.sin(spurtAngle) * (this.randomSpurtSpeed - Math.random());
								this.currentSpurt.insertLink(this.startSpeed, Std.int(this.randomSpurtCollisionDelay + Math.ffloor(this.timerScale * 2)),
									G.randomCumMass());
								G.soundControl.adjustCumVolume(this.timerScale, 0.3);
							}
						} else if (!this.inMouth) {
							G.soundControl.switchCumOutside();
							this.currentSpurt = G.strandControl.newCumStrand(this.tipMid, this.penis);
							this.spurting = true;
						} else {
							G.soundControl.adjustCumVolume(this.timerScale, 0.2);
							G.her.fillMouth();
						}
					} else {
						if (!this.inMouth) {
							this.currentSpurt = G.strandControl.newCumStrand(this.tipMid, this.penis);
							this.startedSpurt = true;
							this.spurting = true;
						} else {
							this.startedSpurt = true;
						}
						G.her.ejaculating();
						G.soundControl.playCum(this.inMouth);
						this.playingCumSound = true;
						if (!this.twitching) {
							this.twitchFactor = Math.random() + this.ejaculation.length / 3;
							this.twitching = true;
						}
					}
				}
			} else {
				if (this.spurting) {
					this.currentSpurt.detachSourceLink(new Point(Math.cos(this.randomSpurtAngle) * this.randomSpurtSpeed,
						Math.sin(this.randomSpurtAngle) * this.randomSpurtSpeed), 0);
				}
				this.startedSpurt = false;
				this.spurting = false;
				if (this.ejaculation.length > 0) {
					if (this.ejaculation.length == 1) {
						G.her.lastSpurt();
					}
					this.nextSpurt();
				} else {
					this.ejaculating = false;
					G.dialogueControl.doneEjaculating();
					G.automaticControl.doneEjaculating();
				}
			}
		} else if (this.playingCumSound) {
			this.playingCumSound = G.soundControl.fadeCumVolume();
		}
	}

	public function ejaculate() {
		var _loc1_ = Math.NaN;
		var _loc2_ = Math.NaN;
		var _loc3_:UInt = 0;
		var _loc4_:UInt = 0;
		var _loc5_ = false;
		var _loc6_:UInt = 0;
		var _loc7_:UInt = 0;
		var _loc8_:UInt = 0;
		if (!this.ejaculating) {
			++G.totalFinishes;
			_loc1_ = Math.min(30, Math.max(0, (this.buildUp - this.ejacPleasure - 20) / 6));
			_loc2_ = Math.ffloor(60 + Math.random() * 10);
			this.ejaculation = new Array<Ejaculation>();
			_loc3_ = 0;
			_loc4_ = Std.int(_loc2_ + _loc1_);
			_loc5_ = true;
			do {
				if ((_loc6_ = _loc4_ - _loc3_) < 20) {
					_loc7_ = Math.floor(Math.random() * _loc6_ * 0.5 + _loc6_ * 0.5);
				} else {
					_loc7_ = Math.floor(Math.random() * _loc6_ * 0.2 + _loc6_ * 0.3);
				}
				_loc7_ = Std.int(Math.min(Math.ffloor(Math.random() * 5 + 21), _loc7_));
				_loc8_ = Std.int(Math.max(6, _loc7_));
				this.addRandomSpurt(_loc8_, _loc5_);
				_loc5_ = false;
				_loc3_ += _loc8_;
			} while (_loc3_ < _loc4_);

			this.nextSpurt();
			G.automaticControl.ejaculate();
			this.ejaculating = true;
		}
	}

	public function addRandomSpurt(param1:UInt, param2:Bool = false) {
        var pauseTimer: UInt;

        if (!param2) {
            pauseTimer = 0;
        } else {
            pauseTimer = Std.int(Math.ffloor(Math.random() * 4 * Math.max(1, 3 - this.ejaculation.length) + 5));
        }

        var ejac = new Ejaculation(param1, param1, Math.random() * 0.8
            - 3.3, Math.random() * 0.4
            + 0.1, Math.random() * 15 + 25,
            Std.int(Math.ffloor(Math.random() * 3)) + 1, pauseTimer);
        this.ejaculation.push(ejac);
    }

    public function nextSpurt() {
        var ejac:Ejaculation = this.ejaculation[0];
        this.spurtTimer = ejac.spurtTimer;
		this.spurtTimerStart = ejac.spurtTimerStart;
		this.randomSpurtAngle = ejac.randomSpurtAngle;
		this.randomSpurtAngleRange = ejac.randomSpurtAngleRange;
		this.randomSpurtSpeed = ejac.randomSpurtSpeed;
		this.randomSpurtCollisionDelay = ejac.randomSpurtCollisionDelay;
		this.pauseTimer = ejac.pauseTimer;
		this.ejaculation.splice(0, 1);
		G.her.tongueContainer.tongue.ejaculating();
	}

	public function startBMSpurt() {
		if (this.bmEjaculating) {
			this.stopBMSpurt();
		}
		this.randomSpurtCollisionDelay = Math.floor(Math.random() * 2);
		this.randomSpurtSpeed = Math.random() * 5 + 25;
		this.bmTimer = this.bmTimerStart;
		this.startedSpurt = false;
		this.spurting = false;
		this.bmEjaculating = true;
	}

	public function stopBMSpurt() {
		if (this.bmEjaculating) {
			if (this.spurting) {
				this.currentSpurt.detachSourceLink(new Point(0, 0), 0);
				this.spurting = false;
			}
			this.bmEjaculating = false;
			this.startedSpurt = false;
		}
	}

	public function getRandomAnchor(param1:Float):AnchorProp {
		var _loc2_ = Math.NaN;
		var _loc3_:Point = null;
		var _loc4_:AnchorProp = null;
		var _loc5_ = new Point(this.baseB.x - this.baseA.x, this.baseB.y - this.baseA.y);
		var _loc6_ = new Point(this.tipB.x - this.tipA.x, this.tipB.y - this.tipA.y);
		var _loc7_ = new Point(this.tipA.x - this.baseA.x, this.tipA.y - this.baseA.y);
		_loc2_ = Math.random();
		var _loc8_ = Math.min(1, 1 - (param1 - 0.2) * (1 / 0.8));
		var _loc9_ = new Point(this.baseA.x + _loc8_ * _loc7_.x, this.baseA.y + _loc8_ * _loc7_.y);
		_loc3_ = new Point(_loc9_.x
			+ _loc2_ * (1 - _loc8_) * _loc5_.x
			+ _loc2_ * _loc8_ * _loc6_.x,
			_loc9_.y
			+ _loc2_ * (1 - _loc8_) * _loc5_.y
			+ _loc2_ * _loc8_ * _loc6_.y);
		return new AnchorProp(_loc3_.clone(), this.penis);
	}

	public function setHimMenu(param1:MovieClip, param2:Array<ASAny>) {
		this.characterMenu = param1;
		// this.penisControl.registerMenuList(this.characterMenu.mlPenis);
		// this.penisControl.registerRGBButton(this.characterMenu.rgbPenis,param2,489,false);
	}

	@:flash.property public var currentPenisID(get, never):UInt;

	function get_currentPenisID():UInt {
		return this.penisControl.selection;
	}
}
