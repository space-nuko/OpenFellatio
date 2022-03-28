package chars.nami;

import openfl.geom.Point;
import obj.Rope;
import obj.CostumeElement;
import chars.CharacterElement;

class NamiHair extends CharacterElement {
	public function new() {}

	override public function get_type() {
		return "hair";
	}

	override public function generateElements():Array<CostumeElement> {
		var tailUnder = new NamiTailUnder();
		var tailUnderRope = new Rope(tailUnder, G.hairUnderLayer, new Point(-100, -175), null, 0, "right", 0, 0);
		tailUnderRope.makeUnToggleable();

		var tail = new NamiTail();
		var tailRope = new Rope(tail, G.hairUnderLayer, new Point(-126.25, -233.35), null, 7, "right", 0, 0);
		tailRope.linkTo(tailUnderRope);

		var bangBack = new NamiBangBack();
		var bangBackRope = new Rope(bangBack, G.hairBackLayer, new Point(57.35, -177.75));

		return [tailRope, tailUnderRope, bangBackRope];
	}
}
