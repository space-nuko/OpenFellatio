package obj.him.bodies;

import flash.events.MouseEvent;
import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Point;
import obj.CharacterControl;
import obj.CharacterElementHelper;
import obj.Him;
import obj.animation.IKController;

class HimMaleBody extends HimBody {
	public var armPos:Float = 0;
	public var armSpeed:Float = 0;
	public var lastX:Float = Math.NaN;
	public var xMovement:Float = 0;
	public var rightArmIK:IKController;
	public var leftArmIK:IKController;
	public var shoulderPoint:Point = new Point(170, -380);
	public var leftArmDefaultPoint:Point = new Point(65, 720);
	public var leftArmTarget:Point;
	public var leftArmSpeed:Point = new Point();
	public var mHim:Matrix;
	public var mLeg:Matrix;
	public var mCalf:Matrix;
	public var mFoot:Matrix;
	public var mArm:Matrix;
	public var mUpperArm:Matrix;
	public var mHand:Matrix;
	public var leftLegIK:IKController;
	public var rightLegIK:IKController;
	public var topControl:CharacterElementHelper;
	public var bottomsControl:CharacterElementHelper;
	public var footwearControl:CharacterElementHelper;
	public var topNameList:Array<ASAny> = ["None", "Shirt"];
	public var bottomsNameList:Array<ASAny> = ["None", "Slacks"];
	public var footwearNameList:Array<ASAny> = ["None", "Loafers"];
	public var skinNameList:Array<ASAny> = ["Light", "Dark"];
	public var currentSkinID:UInt = 0;
	public var hisSwatch:Array<ASAny>;

	public function new(param1:Him) {
		this.leftArmTarget = new Point(this.leftArmDefaultPoint.x, this.leftArmDefaultPoint.y);
		super(param1);
	}

	override public function move(param1:Float, param2:Float, param3:Float) {
		var _loc6_ = Math.NaN;
		super.move(param1, param2, param3);
		this.xMovement = !!Math.isNaN(this.lastX) ? 0 : this.mHim.tx - this.lastX;
		if (this.mHim != null) {
			this.lastX = this.mHim.tx;
		}
		this.mHim = g.animationControl.getHisMatrix(param1);
		_him.transform.matrix = this.mHim;
		this.updateLegs();
		_him.overLayer.x = _him.x;
		_him.overLayer.y = _him.y;
		_him.overLayer.rotation = _him.rotation;
		_him.overLayer.torso.rotation = -3 + 1 * param1;
		_him.torsoLayer.torso.rotation = -3 + 1 * param1;
		_him.midLayer.hips.rotation = -3 + 1 * param1;
		// var _loc4_:* = _him.globalToLocal(g.her.getArmPoint());
		// if(g.her.isReleased())
		// {
		//    this.armSpeed += (param2 - 0.3 - this.armPos) / 3;
		//    this.armSpeed *= 0.5;
		//    this.armPos = Math.max(param1,this.armPos + this.armSpeed);
		// }
		// else
		// {
		//    _loc6_ = this.armPos;
		//    this.armPos = param1;
		//    this.armSpeed = (this.armPos - _loc6_) * 100;
		// }
		// var _loc5_:Number = this.armPos - param1;
		// _him.armContainer.x = _him.x;
		// _him.armContainer.rotation = _him.rotation;
		// if(g.handsOff)
		// {
		//    _him.armContainer.arm.x += (80 - _him.armContainer.arm.x) * 0.25;
		//    _him.armContainer.arm.y += (200 - _him.armContainer.arm.y) * 0.25;
		//    this.shoulderPoint.x += (170 - this.shoulderPoint.x) * 0.5;
		//    this.shoulderPoint.y += (-520 - this.shoulderPoint.y) * 0.5;
		// }
		// else
		// {
		//    if(g.her.isReleased())
		//    {
		//       _him.armContainer.arm.x += (_loc4_.x + _loc5_ * 250 - _him.armContainer.arm.x) * 0.5;
		//       _him.armContainer.arm.y += (_loc4_.y - _loc5_ * 30 - _him.armContainer.arm.y) * 0.5;
		//    }
		//    else
		//    {
		//       _him.armContainer.arm.x = _loc4_.x + _loc5_ * 250;
		//       _him.armContainer.arm.y = _loc4_.y - _loc5_ * 30;
		//    }
		//    this.shoulderPoint.x = 150 + 40 * this.armPos;
		//    this.shoulderPoint.x += (_him.armContainer.arm.x + 580 - this.shoulderPoint.x) * 0.5;
		//    this.shoulderPoint.y = -450 - 100 * this.armPos;
		// }
		this.updateArmPosition();
	}

	public function updateLegs() {
		this.leftLegIK.update();
		this.rightLegIK.update();
		// _him.leftLeg.transform.matrix = this.leftLegIK.section1Matrix;
		// _him.leftLeg.calf.transform.matrix = this.leftLegIK.section2Matrix;
		// _him.leftLegCostume.transform.matrix = this.leftLegIK.section1Matrix;
		// _him.leftLegCostume.calf.transform.matrix = this.leftLegIK.section2Matrix;
		// _him.rightLeg.transform.matrix = this.rightLegIK.section1Matrix;
		// _him.rightLeg.calf.transform.matrix = this.rightLegIK.section2Matrix;
		// _him.rightLegCostume.transform.matrix = this.rightLegIK.section1Matrix;
		// _him.rightLegCostume.calf.transform.matrix = this.rightLegIK.section2Matrix;
		// _him.leftLeg.calf.foot.transform.matrix = this.leftLegIK.section3Matrix;
		// _him.rightLeg.calf.foot.transform.matrix = this.rightLegIK.section3Matrix;
		// _him.leftLegCostume.calf.foot.transform.matrix = this.leftLegIK.section3Matrix;
		// _him.rightLegCostume.calf.foot.transform.matrix = this.rightLegIK.section3Matrix;
		// _him.balls.rotation = _him.leftLeg.rotation;
	}

	public function updateArmPosition() {
		this.rightArmIK.newTarget(this.shoulderPoint, _him, true);
		this.rightArmIK.update(new Point(_him.armContainer.arm.x, _him.armContainer.arm.y));
		_him.armContainer.arm.transform.matrix = this.rightArmIK.section1Matrix;
		// _him.armContainer.arm.upperArm.transform.matrix = this.rightArmIK.section2Matrix;
		// if(g.handsOff)
		// {
		//    _him.armContainer.arm.hand.rotation *= 0.5;
		// }
		// else
		// {
		//    _him.armContainer.arm.hand.rotation = g.her.rotation - _him.armContainer.arm.rotation;
		// }
		this.leftArmSpeed.x += (this.leftArmDefaultPoint.x - this.leftArmTarget.x) * 0.1 - this.xMovement * 0.1;
		this.leftArmSpeed.y += (this.leftArmDefaultPoint.y - this.leftArmTarget.y) * 0.1 - Math.abs(this.xMovement * 0.05);
		this.leftArmTarget.x += this.leftArmSpeed.x;
		this.leftArmTarget.y += this.leftArmSpeed.y;
		this.leftArmSpeed.x *= 0.8;
		this.leftArmSpeed.y *= 0.8;
		this.leftArmIK.newTarget(new Point(this.leftArmTarget.x, this.leftArmTarget.y), _him);
		this.leftArmIK.update(null, true);
	}

	override public function debugMove(param1:Point) {
		super.debugMove(param1);
		this.updateLegs();
		this.updateArmPosition();
	}

	override public function loadDataPairs(param1:Array<ASAny>) {
		var _loc2_:Array<ASAny> = null;
		for (_tmp_ in param1) {
			_loc2_ = _tmp_;
			switch (_loc2_[0]) {
				case "hisSkin":
					this.setSkin(ASCompat.toInt(_loc2_[1]));

				case "hisTop":
					this.topControl.loadDataString(_loc2_[1]);

				case "hisBottoms":
					this.bottomsControl.loadDataString(_loc2_[1]);

				case "hisFootwear":
					this.footwearControl.loadDataString(_loc2_[1]);
			}
		}
	}

	override public function getDataString():String {
		var _loc1_ = "hisSkin:" + this.currentSkinID;
		var _loc2_ = "hisTop:" + this.topControl.getDataString();
		var _loc3_ = "hisBottoms:" + this.bottomsControl.getDataString();
		var _loc4_ = "hisFootwear:" + this.footwearControl.getDataString();
		return _loc1_ + ";" + _loc2_ + ";" + _loc3_ + ";" + _loc4_;
	}

	override public function initElements() {
		// this.rightLegIK = new IKController(_him,_him.rightLeg,_him.rightLeg.calf,_him.rightLeg.calf.foot);
		// this.rightLegIK.newTarget(g.animationControl.getHisRightFootTarget(),g.sceneLayer,true);
		// this.rightLegIK.rescale(0.9);
		// this.leftLegIK = new IKController(_him,_him.leftLeg,_him.leftLeg.calf,_him.leftLeg.calf.foot);
		// this.leftLegIK.newTarget(g.animationControl.getHisLeftFootTarget(),g.sceneLayer,true);
		// this.rightArmIK = new IKController(_him,_him.armContainer.arm,_him.armContainer.arm.upperArm,_him.armContainer.arm.upperArm.shoulderPoint);
		// this.rightArmIK.newTarget(this.shoulderPoint,_him,true);
		// this.leftArmIK = new IKController(_him,_him.leftArmContainer.arm,_him.leftArmContainer.arm.foreArm,_him.leftArmContainer.arm.foreArm.hand,true);
		// this.leftArmIK.newTarget(this.leftArmTarget,_him,true);
		// this.topControl = new CharacterElementHelper(this.topNameList,this.setTop,this.setTopFill);
		// this.topControl.setStartRGB(new AlphaRGBObject(1,238,242,245));
		// this.bottomsControl = new CharacterElementHelper(this.bottomsNameList,this.setBottoms,this.setBottomsFill);
		// this.bottomsControl.setStartRGB(new AlphaRGBObject(1,27,29,29));
		// this.footwearControl = new CharacterElementHelper(this.footwearNameList,this.setFootwear,this.setFootwearFill);
		// this.footwearControl.setStartRGB(new AlphaRGBObject(1,0,0,0));
	}

	override public function initMenu() {
		_bodyMenu = new HimMaleBodyMenu();
		this.hisSwatch = new Array<ASAny>();
		this.hisSwatch[0] = {
			"r": 22,
			"g": 8,
			"b": 0,
			"a": 1
		};
		this.hisSwatch[1] = {
			"r": 82,
			"g": 0,
			"b": 6,
			"a": 1
		};
		this.hisSwatch[2] = {
			"r": 255,
			"g": 126,
			"b": 167,
			"a": 1
		};
		this.hisSwatch[3] = {
			"r": 0,
			"g": 26,
			"b": 114,
			"a": 1
		};
		this.hisSwatch[4] = {
			"r": 63,
			"g": 118,
			"b": 162,
			"a": 1
		};
		this.hisSwatch[5] = {
			"r": 238,
			"g": 242,
			"b": 245,
			"a": 1
		};
		this.hisSwatch[6] = {
			"r": 27,
			"g": 29,
			"b": 29,
			"a": 1
		};
		this.hisSwatch[7] = {
			"r": 0,
			"g": 0,
			"b": 0,
			"a": 1
		};
		this.hisSwatch[8] = {
			"r": 255,
			"g": 255,
			"b": 255,
			"a": 1
		};
		// _bodyMenu.mlSkin.leftArrow.addEventListener(MouseEvent.CLICK,this.hisSkinLeftClicked);
		// _bodyMenu.mlSkin.rightArrow.addEventListener(MouseEvent.CLICK,this.hisSkinRightClicked);
		// this.topControl.registerMenuList(_bodyMenu.mlTop);
		// this.topControl.registerRGBButton(_bodyMenu.rgbTop,this.hisSwatch,489,false);
		// this.bottomsControl.registerMenuList(_bodyMenu.mlBottoms);
		// this.bottomsControl.registerRGBButton(_bodyMenu.rgbBottoms,this.hisSwatch,489,false);
		// this.footwearControl.registerMenuList(_bodyMenu.mlFootwear);
		// this.footwearControl.registerRGBButton(_bodyMenu.rgbFootwear,this.hisSwatch,489,false);
		this.updateSkinList();
		this.topControl.select(1);
		this.bottomsControl.select(1);
		this.footwearControl.select(1);
	}

	override public function animationChanged() {
		this.rightLegIK.newTarget(g.animationControl.getHisRightFootTarget(), g.sceneLayer, true);
		this.leftLegIK.newTarget(g.animationControl.getHisLeftFootTarget(), g.sceneLayer, true);
		this.updateLegs();
	}

	override public function toggleBodySettings() {
		if (g.him.currentPenisID == 1) {
			if (this.currentSkinID == 1) {
				g.him.penisControl.select(0);
				this.setSkin(0);
			} else {
				this.setSkin(1);
			}
		} else if (this.currentSkinID == 1) {
			g.him.penisControl.select(1);
			this.setSkin(0);
		} else {
			this.setSkin(1);
		}
	}

	override public function shuffle() {
		var _loc1_:UInt = Math.floor(Math.random() * 2);
		g.him.penisControl.select(_loc1_);
		var _loc2_:UInt = Math.floor(Math.random() * 2);
		this.setSkin(_loc2_);
	}

	override public function setupElements() {
		this.setSkin(this.currentSkinID);
		this.topControl.resetElement();
		this.bottomsControl.resetElement();
		this.footwearControl.resetElement();
	}

	override public function setupAnimation() {
		// this.rightLegIK.newSegments(_him.rightLeg,_him.rightLeg.calf,_him.rightLeg.calf.foot);
		// this.leftLegIK.newSegments(_him.leftLeg,_him.leftLeg.calf,_him.leftLeg.calf.foot);
		// this.rightArmIK.newSegments(_him.armContainer.arm,_him.armContainer.arm.upperArm,_him.armContainer.arm.upperArm.shoulderPoint);
		// this.leftArmIK.newSegments(_him.leftArmContainer.arm,_him.leftArmContainer.arm.foreArm,_him.leftArmContainer.arm.foreArm.hand);
	}

	override public function setupMenu() {}

	override public function breakdownBody() {}

	public function hisSkinLeftClicked(param1:MouseEvent) {
		var _loc2_:UInt = Std.int(Math.max(0, Math.min(this.skinNameList.length - 1, this.currentSkinID - 1)));
		this.setSkin(_loc2_);
		g.saveData.saveCharData();
	}

	public function hisSkinRightClicked(param1:MouseEvent) {
		var _loc2_:UInt = Std.int(Math.max(0, Math.min(this.skinNameList.length - 1, this.currentSkinID + 1)));
		this.setSkin(_loc2_);
		g.saveData.saveCharData();
	}

	public function updateSkinList() {
		// _bodyMenu.mlSkin.itemLabel.text = this.skinNameList[this.currentSkinID];
	}

	public function setSkin(param1:UInt) {
		this.currentSkinID = param1;
		g.himSkinType = "Male" + this.skinNameList[this.currentSkinID];
		g.him.updatePenis();
		g.him.balls.setSkin(g.himSkinType);
		g.him.updateArm();
		// g.him.torsoLayer.torso.gotoAndStop(g.himSkinType);
		// g.him.leftLeg.gotoAndStop(g.himSkinType);
		// g.him.leftLeg.calf.gotoAndStop(g.himSkinType);
		// g.him.leftLeg.calf.foot.gotoAndStop(g.himSkinType);
		// g.him.rightLeg.gotoAndStop(g.himSkinType);
		// g.him.rightLeg.calf.gotoAndStop(g.himSkinType);
		// g.him.rightLeg.calf.foot.gotoAndStop(g.himSkinType);
		this.updateSkinList();
	}

	public function setTop(param1:UInt) {
		CharacterControl.tryToSetFrameLabel(g.him.topBack, this.topControl.selectedName);
		// CharacterControl.tryToSetFrameLabel(g.him.overLayer.torso.costume,this.topControl.selectedName);
	}

	public function setTopFill(param1:ASObject, param2:String = "rgbFill") {
		var _loc3_ = new ColorTransform(1, 1, 1, param1.a, param1.r, param1.g, param1.b);
		CharacterControl.tryToSetFill(g.him.topBack, param2, _loc3_);
		// CharacterControl.tryToSetFill(g.him.overLayer.torso.costume,param2,_loc3_);
	}

	public function setBottoms(param1:UInt) {
		// CharacterControl.tryToSetFrameLabel(g.him.rightLegCostume,this.bottomsControl.selectedName);
		// CharacterControl.tryToSetFrameLabel(g.him.rightLegCostume.calf,this.bottomsControl.selectedName);
		// CharacterControl.tryToSetFrameLabel(g.him.leftLegCostume,this.bottomsControl.selectedName);
		// CharacterControl.tryToSetFrameLabel(g.him.leftLegCostume.calf,this.bottomsControl.selectedName);
		// CharacterControl.tryToSetFrameLabel(g.him.midLayer.hips,this.bottomsControl.selectedName);
	}

	public function setBottomsFill(param1:ASObject, param2:String = "rgbFill") {
		var _loc3_ = new ColorTransform(1, 1, 1, param1.a, param1.r, param1.g, param1.b);
		// CharacterControl.tryToSetFill(g.him.rightLegCostume,param2,_loc3_);
		// CharacterControl.tryToSetFill(g.him.rightLegCostume.calf,param2,_loc3_);
		// CharacterControl.tryToSetFill(g.him.leftLegCostume,param2,_loc3_);
		// CharacterControl.tryToSetFill(g.him.leftLegCostume.calf,param2,_loc3_);
		// CharacterControl.tryToSetFill(g.him.midLayer.hips,param2,_loc3_);
	}

	public function setFootwear(param1:UInt) {
		// CharacterControl.tryToSetFrameLabel(g.him.rightLegCostume.calf.foot,this.footwearControl.selectedName);
		// CharacterControl.tryToSetFrameLabel(g.him.leftLegCostume.calf.foot,this.footwearControl.selectedName);
	}

	public function setFootwearFill(param1:ASObject, param2:String = "rgbFill") {
		var _loc3_ = new ColorTransform(1, 1, 1, param1.a, param1.r, param1.g, param1.b);
		// CharacterControl.tryToSetFill(g.him.rightLegCostume.calf.foot,param2,_loc3_);
		// CharacterControl.tryToSetFill(g.him.leftLegCostume.calf.foot,param2,_loc3_);
	}

	override function get_xDelta():Float {
		return this.xMovement;
	}
}
