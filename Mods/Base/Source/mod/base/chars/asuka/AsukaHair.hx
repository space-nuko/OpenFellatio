package mod.base.chars.asuka;

import openfl.geom.Point;
import obj.Rope;
import obj.CostumeElement;
import chars.CharacterElement;

class AsukaHair extends CharacterElement {
	public function new() {}

	override public function get_type() {
		return "hair";
	}

	override public function generateElements():Array<CostumeElement> {
		var tail1 = new AsukaTail1();
		var tail1Rope = new Rope(tail1, G.hairUnderLayer, new Point(-100, -240), null, 5, "right", 0, 0);
		tail1Rope.lockTop(0.5);

		var tail2 = new AsukaTail2();
		var tail2Rope = new Rope(tail2, G.hairBackLayer, new Point(-60, -80), null, 20, "right", 0, 1);
		tail1Rope.linkTo(tail2Rope);
		tail2Rope.makeUnToggleable();

		var hairClip = new AsukaHairClip();
		hairClip.x = -165.7;
		hairClip.y = -270.95;
		G.hairCostumeUnder.addChild(hairClip);

		return [tail1Rope, tail2Rope, hairClip];
    }
}
