package chars.misato;

import openfl.geom.Point;
import obj.Rope;
import obj.CostumeElement;
import chars.CharacterElement;

class MisatoHair extends CharacterElement {
	public function new() {}

	override public function get_type() {
		return "hair";
	}

	override public function generateElements():Array<CostumeElement> {
		var back = new MisatoBack();
		var backRope = new Rope(back, G.hairUnderLayer, new Point(-136, -145), null, 0, "right", 0, 0);
		var side = new MisatoSide();
		var sideRope = new Rope(side, G.hairOverLayer, new Point(-76, -78), null, -30, "left", 0, 2);
		var necklace = new MisatoNecklace();
		var necklaceRope = new Rope(necklace, G.hairUnderLayer, new Point(-65, 60), null, -35, "left", 0, 2);
		return [backRope, sideRope, necklaceRope];
	}
}
