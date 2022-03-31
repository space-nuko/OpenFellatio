package mod.base.chars.miku;

import openfl.geom.Point;
import obj.Rope;
import obj.CostumeElement;
import chars.CharacterElement;

class MikuHair extends CharacterElement {
	public function new() {}

	override public function get_type() {
		return "hair";
	}

	override public function generateElements():Array<CostumeElement> {
		var bang = new MikuBang();
		var bangRope = new Rope(bang, G.hairOverLayer, new Point(4.45, -320.65));
		bangRope.lockTopRotation();

		var hairRibbon1 = new MikuHairRibbon();
		hairRibbon1.dynamicAnchor(-129.3, -237.45, G.her);
		G.hairUnderLayer.addChild(hairRibbon1);

		var tail1 = new MikuTail();
		var tail1Rope = new Rope(tail1, G.hairUnderLayer, new Point(-143.85, -221.15), null, 10, "right", 0, 0);

		var tail2 = new MikuTail();
		var tail2Rope = new Rope(tail2, G.hairBackLayer, new Point(-43.85, -261.15), null, 10, "right", 0, 0);

		var hairRibbon2 = new MikuHairRibbon();
		hairRibbon2.x = -29.3;
		hairRibbon2.y = -277.45;
		G.hairCostumeBack.addChild(hairRibbon2);

		return [bangRope, tail1Rope, hairRibbon1, tail2Rope, hairRibbon2];
	}
}
