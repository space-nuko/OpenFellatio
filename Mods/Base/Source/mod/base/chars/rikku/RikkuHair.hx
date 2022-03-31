package mod.base.chars.rikku;

import openfl.geom.Point;
import obj.Rope;
import obj.CostumeElement;
import chars.CharacterElement;

class RikkuHair extends CharacterElement {
	public function new() {}

	override public function get_type() {
		return "hair";
	}

	override public function generateElements():Array<CostumeElement> {
		var bang1 = new RikkuBang1();
		var bang1Rope = new Rope(bang1, G.hairUnderLayer, new Point(58, -261.6), null, 10);
		bang1Rope.lockTopRotation();

		var bang2 = new RikkuBang2();
		var bang2Rope = new Rope(bang2, G.hairUnderLayer, new Point(79.2, -250.75), null, 10);
		bang2Rope.lockTopRotation();

		var bandanaBack = new RikkuBandanaBack();
		bandanaBack.x = -17.55;
		bandanaBack.y = -144;
		G.hairCostumeBack.addChild(bandanaBack);
		bandanaBack.makeUnToggleable();

		var bandana = new RikkuBandana();
		bandana.x = -30.2;
		bandana.y = -191.7;
		G.hairCostumeUnder.addChild(bandana);

		var braidBackRight = new RikkuBraidBackRight();
		var braidBackRightRope = new Rope(braidBackRight, G.hairUnderLayer, new Point(-89.75, -254.65));
		braidBackRightRope.makeUnToggleable();

		var braidFrontRight = new RikkuBraidFrontRight();
		var braidFrontRightRope = new Rope(braidFrontRight, G.hairOverLayer, new Point(25.4, -220));
		braidFrontRightRope.makeUnToggleable();

		var braidFrontRightExtend = new RikkuBraidFrontRightExtend();
		braidFrontRightExtend.dynamicAnchor(25.4, -220, G.her);
		G.hairOverLayer.addChild(braidFrontRightExtend);
		braidFrontRightExtend.makeUnToggleable();

		var braidFrontLeft = new RikkuBraidFrontLeft();
		var braidFrontLeftRope = new Rope(braidFrontLeft, G.hairBackLayer, new Point(55.4, -270));
		braidFrontLeftRope.makeUnToggleable();

		var braidLoops = new RikkuBraidLoops();
		braidLoops.dynamicAnchor(-56.25, -222.2, G.her);
		G.hairOverLayer.addChild(braidLoops);
		braidLoops.makeUnToggleable();

		bandana.linkTo(bandanaBack, true);
		bandana.linkTo(braidBackRightRope, true);
		bandana.linkTo(braidFrontRightRope, true);
		bandana.linkTo(braidFrontLeftRope, true);
		bandana.linkTo(braidLoops, true);
		bandana.linkTo(braidFrontRightExtend, true);

		var tail = new RikkuTail();
		var tailRope = new Rope(tail, G.hairOverLayer, new Point(-223.55, -305.15));
		tailRope.lockTopRotation();

		var top = new RikkuHairTop();
		top.dynamicAnchor(-133.7, -298.2, G.her);
		G.hairOverLayer.addChild(top);

		return [braidBackRightRope, bandanaBack, bandana, braidFrontLeftRope, braidFrontRightRope, braidFrontRightExtend, braidLoops, tailRope, top, bang1Rope, bang2Rope];
	}
}
