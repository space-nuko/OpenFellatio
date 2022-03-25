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
	public var topNameList:Array<String> = ["None", "Shirt"];
	public var bottomsNameList:Array<String> = ["None", "Slacks"];
	public var footwearNameList:Array<String> = ["None", "Loafers"];
	public var skinNameList:Array<String> = ["Light", "Dark"];
	public var currentSkinID:UInt = 0;
	public var hisSwatch:Array<AlphaRGBObject>;

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
		this.mHim = G.animationControl.getHisMatrix(param1);
		_him.transform.matrix = this.mHim;
		this.updateLegs();
		_him.overLayer.x = _him.x;
		_him.overLayer.y = _him.y;
		_him.overLayer.rotation = _him.rotation;
		_him.overLayer.torso.rotation = -3 + 1 * param1;
		_him.torsoLayer.torso.rotation = -3 + 1 * param1;
		_him.midLayer.hips.rotation = -3 + 1 * param1;
		var _loc4_ = _him.globalToLocal(G.her.getArmPoint());
		if(G.her.isReleased())
		{
		   this.armSpeed += (param2 - 0.3 - this.armPos) / 3;
		   this.armSpeed *= 0.5;
		   this.armPos = Math.max(param1,this.armPos + this.armSpeed);
		}
		else
		{
		   _loc6_ = this.armPos;
		   this.armPos = param1;
		   this.armSpeed = (this.armPos - _loc6_) * 100;
		}
		var _loc5_:Float = this.armPos - param1;
		_him.armContainer.x = _him.x;
		_him.armContainer.rotation = _him.rotation;
		if(G.handsOff)
		{
		   _him.armContainer.arm.x += (80 - _him.armContainer.arm.x) * 0.25;
		   _him.armContainer.arm.y += (200 - _him.armContainer.arm.y) * 0.25;
		   this.shoulderPoint.x += (170 - this.shoulderPoint.x) * 0.5;
		   this.shoulderPoint.y += (-520 - this.shoulderPoint.y) * 0.5;
		}
		else
		{
		   if(G.her.isReleased())
		   {
		      _him.armContainer.arm.x += (_loc4_.x + _loc5_ * 250 - _him.armContainer.arm.x) * 0.5;
		      _him.armContainer.arm.y += (_loc4_.y - _loc5_ * 30 - _him.armContainer.arm.y) * 0.5;
		   }
		   else
		   {
		      _him.armContainer.arm.x = _loc4_.x + _loc5_ * 250;
		      _him.armContainer.arm.y = _loc4_.y - _loc5_ * 30;
		   }
		   this.shoulderPoint.x = 150 + 40 * this.armPos;
		   this.shoulderPoint.x += (_him.armContainer.arm.x + 580 - this.shoulderPoint.x) * 0.5;
		   this.shoulderPoint.y = -450 - 100 * this.armPos;
		}
		this.updateArmPosition();
	}

	public function updateLegs() {
		this.leftLegIK.update();
		this.rightLegIK.update();
		_him.leftLeg.transform.matrix = this.leftLegIK.section1Matrix;
		_him.leftLeg.calf.transform.matrix = this.leftLegIK.section2Matrix;
		_him.leftLegCostume.transform.matrix = this.leftLegIK.section1Matrix;
		_him.leftLegCostume.calf.transform.matrix = this.leftLegIK.section2Matrix;
		_him.rightLeg.transform.matrix = this.rightLegIK.section1Matrix;
		_him.rightLeg.calf.transform.matrix = this.rightLegIK.section2Matrix;
		_him.rightLegCostume.transform.matrix = this.rightLegIK.section1Matrix;
		_him.rightLegCostume.calf.transform.matrix = this.rightLegIK.section2Matrix;
		_him.leftLeg.calf.foot.transform.matrix = this.leftLegIK.section3Matrix;
		_him.rightLeg.calf.foot.transform.matrix = this.rightLegIK.section3Matrix;
		_him.leftLegCostume.calf.foot.transform.matrix = this.leftLegIK.section3Matrix;
		_him.rightLegCostume.calf.foot.transform.matrix = this.rightLegIK.section3Matrix;
		_him.balls.rotation = _him.leftLeg.rotation;
	}

	public function updateArmPosition() {
		this.rightArmIK.newTarget(this.shoulderPoint, _him, true);
		this.rightArmIK.update(new Point(_him.armContainer.arm.x, _him.armContainer.arm.y));
		_him.armContainer.arm.transform.matrix = this.rightArmIK.section1Matrix;
		_him.armContainer.arm.upperArm.transform.matrix = this.rightArmIK.section2Matrix;
		if(G.handsOff)
		{
		   _him.armContainer.arm.hand.rotation *= 0.5;
		}
		else
		{
		   _him.armContainer.arm.hand.rotation = G.her.rotation - _him.armContainer.arm.rotation;
		}
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

	override public function loadDataPairs(param1:Array<Array<String>>) {
		var _loc2_:Array<String> = null;
		for (_tmp_ in param1) {
			_loc2_ = _tmp_;
			switch (_loc2_[0]) {
				case "hisSkin":
					this.setSkin(Std.parseInt(_loc2_[1]));

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
		this.rightLegIK = new IKController(_him,_him.rightLeg,_him.rightLeg.calf,_him.rightLeg.calf.foot);
		this.rightLegIK.newTarget(G.animationControl.getHisRightFootTarget(),G.sceneLayer,true);
		this.rightLegIK.rescale(0.9);
		this.leftLegIK = new IKController(_him,_him.leftLeg,_him.leftLeg.calf,_him.leftLeg.calf.foot);
		this.leftLegIK.newTarget(G.animationControl.getHisLeftFootTarget(),G.sceneLayer,true);
		this.rightArmIK = new IKController(_him,_him.armContainer.arm,_him.armContainer.arm.upperArm,_him.armContainer.arm.upperArm.shoulderPoint);
		this.rightArmIK.newTarget(this.shoulderPoint,_him,true);
		this.leftArmIK = new IKController(_him,_him.leftArmContainer.arm,_him.leftArmContainer.arm.foreArm,_him.leftArmContainer.arm.foreArm.hand,true);
		this.leftArmIK.newTarget(this.leftArmTarget,_him,true);
		this.topControl = new CharacterElementHelper(this.topNameList,this.setTop,this.setTopFill);
		this.topControl.setStartRGB(new AlphaRGBObject(1,238,242,245));
		this.bottomsControl = new CharacterElementHelper(this.bottomsNameList,this.setBottoms,this.setBottomsFill);
		this.bottomsControl.setStartRGB(new AlphaRGBObject(1,27,29,29));
		this.footwearControl = new CharacterElementHelper(this.footwearNameList,this.setFootwear,this.setFootwearFill);
		this.footwearControl.setStartRGB(new AlphaRGBObject(1,0,0,0));
	}

	override public function initMenu() {
		// _bodyMenu = new HimMaleBodyMenu();
		this.hisSwatch = new Array<AlphaRGBObject>();
		this.hisSwatch[0] = new AlphaRGBObject(1, 22, 8, 0);
		this.hisSwatch[1] = new AlphaRGBObject(1, 82, 0, 6);
		this.hisSwatch[2] = new AlphaRGBObject(1, 255, 126, 167);
		this.hisSwatch[3] = new AlphaRGBObject(1, 0, 26, 114);
		this.hisSwatch[4] = new AlphaRGBObject(1, 63, 118, 162);
		this.hisSwatch[5] = new AlphaRGBObject(1, 238, 242, 245);
		this.hisSwatch[6] = new AlphaRGBObject(1, 27, 29, 29);
		this.hisSwatch[7] = new AlphaRGBObject(1, 0, 0, 0);
		this.hisSwatch[8] = new AlphaRGBObject(1, 255, 255, 255);
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
		this.rightLegIK.newTarget(G.animationControl.getHisRightFootTarget(), G.sceneLayer, true);
		this.leftLegIK.newTarget(G.animationControl.getHisLeftFootTarget(), G.sceneLayer, true);
		this.updateLegs();
	}

	override public function toggleBodySettings() {
		if (G.him.currentPenisID == 1) {
			if (this.currentSkinID == 1) {
				G.him.penisControl.select(0);
				this.setSkin(0);
			} else {
				this.setSkin(1);
			}
		} else if (this.currentSkinID == 1) {
			G.him.penisControl.select(1);
			this.setSkin(0);
		} else {
			this.setSkin(1);
		}
	}

	override public function shuffle() {
		var _loc1_:UInt = Math.floor(Math.random() * 2);
		G.him.penisControl.select(_loc1_);
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
		this.rightLegIK.newSegments(_him.rightLeg,_him.rightLeg.calf,_him.rightLeg.calf.foot);
		this.leftLegIK.newSegments(_him.leftLeg,_him.leftLeg.calf,_him.leftLeg.calf.foot);
		this.rightArmIK.newSegments(_him.armContainer.arm,_him.armContainer.arm.upperArm,_him.armContainer.arm.upperArm.shoulderPoint);
		this.leftArmIK.newSegments(_him.leftArmContainer.arm,_him.leftArmContainer.arm.foreArm,_him.leftArmContainer.arm.foreArm.hand);
	}

	override public function setupMenu() {}

	override public function breakdownBody() {}

	public function hisSkinLeftClicked(param1:MouseEvent) {
		var _loc2_:UInt = Std.int(Math.max(0, Math.min(this.skinNameList.length - 1, this.currentSkinID - 1)));
		this.setSkin(_loc2_);
		G.saveData.saveCharData();
	}

	public function hisSkinRightClicked(param1:MouseEvent) {
		var _loc2_:UInt = Std.int(Math.max(0, Math.min(this.skinNameList.length - 1, this.currentSkinID + 1)));
		this.setSkin(_loc2_);
		G.saveData.saveCharData();
	}

	public function updateSkinList() {
		// _bodyMenu.mlSkin.itemLabel.text = this.skinNameList[this.currentSkinID];
	}

	public function setSkin(param1:UInt) {
		this.currentSkinID = param1;
		G.himSkinType = "Male" + this.skinNameList[this.currentSkinID];
		G.him.updatePenis();
		G.him.balls.setSkin(G.himSkinType);
		G.him.updateArm();
		G.him.torsoLayer.torso.gotoAndStop(G.himSkinType);
		G.him.leftLeg.gotoAndStop(G.himSkinType);
		G.him.leftLeg.calf.gotoAndStop(G.himSkinType);
		G.him.leftLeg.calf.foot.gotoAndStop(G.himSkinType);
		G.him.rightLeg.gotoAndStop(G.himSkinType);
		G.him.rightLeg.calf.gotoAndStop(G.himSkinType);
		G.him.rightLeg.calf.foot.gotoAndStop(G.himSkinType);
		this.updateSkinList();
	}

	public function setTop(param1:UInt) {
		CharacterControl.tryToSetFrameLabel(G.him.topBack, this.topControl.selectedName);
		CharacterControl.tryToSetFrameLabel(G.him.overLayer.torso.costume,this.topControl.selectedName);
	}

	public function setTopFill(param1:ASObject, param2:String = "rgbFill") {
		var _loc3_ = new ColorTransform(1, 1, 1, param1.a, param1.r, param1.g, param1.b);
		CharacterControl.tryToSetFill(G.him.topBack, param2, _loc3_);
		CharacterControl.tryToSetFill(G.him.overLayer.torso.costume,param2,_loc3_);
	}

	public function setBottoms(param1:UInt) {
		CharacterControl.tryToSetFrameLabel(G.him.rightLegCostume,this.bottomsControl.selectedName);
		CharacterControl.tryToSetFrameLabel(G.him.rightLegCostume.calf,this.bottomsControl.selectedName);
		CharacterControl.tryToSetFrameLabel(G.him.leftLegCostume,this.bottomsControl.selectedName);
		CharacterControl.tryToSetFrameLabel(G.him.leftLegCostume.calf,this.bottomsControl.selectedName);
		CharacterControl.tryToSetFrameLabel(G.him.midLayer.hips,this.bottomsControl.selectedName);
	}

	public function setBottomsFill(param1:ASObject, param2:String = "rgbFill") {
		var _loc3_ = new ColorTransform(1, 1, 1, param1.a, param1.r, param1.g, param1.b);
		CharacterControl.tryToSetFill(G.him.rightLegCostume,param2,_loc3_);
		CharacterControl.tryToSetFill(G.him.rightLegCostume.calf,param2,_loc3_);
		CharacterControl.tryToSetFill(G.him.leftLegCostume,param2,_loc3_);
		CharacterControl.tryToSetFill(G.him.leftLegCostume.calf,param2,_loc3_);
		CharacterControl.tryToSetFill(G.him.midLayer.hips,param2,_loc3_);
	}

	public function setFootwear(param1:UInt) {
		CharacterControl.tryToSetFrameLabel(G.him.rightLegCostume.calf.foot,this.footwearControl.selectedName);
		CharacterControl.tryToSetFrameLabel(G.him.leftLegCostume.calf.foot,this.footwearControl.selectedName);
	}

	public function setFootwearFill(param1:ASObject, param2:String = "rgbFill") {
		var _loc3_ = new ColorTransform(1, 1, 1, param1.a, param1.r, param1.g, param1.b);
		CharacterControl.tryToSetFill(G.him.rightLegCostume.calf.foot,param2,_loc3_);
		CharacterControl.tryToSetFill(G.him.leftLegCostume.calf.foot,param2,_loc3_);
	}

	override function get_xDelta():Float {
		return this.xMovement;
	}
}
