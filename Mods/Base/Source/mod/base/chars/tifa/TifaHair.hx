package mod.base.chars.tifa;

import openfl.geom.Point;
import obj.Rope;
import obj.CostumeElement;
import chars.CharacterElement;

class TifaHair extends CharacterElement {
	public function new() {}

	override public function get_type() {
		return "hair";
	}

	override public function generateElements():Array<CostumeElement> {
		var tail = new TifaTail();
		var tailRope = new Rope(tail, G.hairUnderLayer, new Point(-91.35, -224.05), null, 10, "right", 0, 0);

		var bang1 = new TifaBang1();
		var bang1Rope = new Rope(bang1, G.hairOverLayer, new Point(11.9, -255.5), null, -10);

		var bang2 = new TifaBang2();
		var bang2Rope = new Rope(bang2, G.hairOverLayer, new Point(-17.3, -202.8), null, 18, "right", 0, 0);

		return [tailRope, bang1Rope, bang2Rope];
	}
}
