package mod.base.chars.jill_valentine;

import openfl.geom.Point;
import obj.Rope;
import obj.CostumeElement;
import chars.CharacterElement;

class JillValentineHair extends CharacterElement {
	public function new() {}

	override public function get_type() {
		return "hair";
	}

	override public function generateElements():Array<CostumeElement> {
		var bang = new JillValentineHairBang();
		var bangRope = new Rope(bang, G.hairOverLayer, new Point(105, -265));
		bangRope.damping = 0.425;

		var back = new JillValentineHairBack();
		var backRope = new Rope(back, G.hairOverLayer, new Point(-61, -219), null, 10);
		backRope.damping = 0.255;

		var front = new JillValentineHairFront();
        var frontRope = new Rope(front, G.hairOverLayer, new Point(47, -252), null, 5);
		frontRope.damping = 0.255;

		var highlight:JillValentineHairHighlight = new JillValentineHairHighlight();
		highlight.dynamicAnchor(96, -250, G.her);
		highlight.makeUnToggleable();
		G.hairOverLayer.addChild(highlight);

		return [bangRope, backRope, frontRope, highlight];
	}
}
