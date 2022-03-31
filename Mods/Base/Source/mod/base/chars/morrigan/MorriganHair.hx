package mod.base.chars.morrigan;

import openfl.geom.Point;
import obj.Rope;
import obj.CostumeElement;
import chars.CharacterElement;

class MorriganHair extends CharacterElement {
	public function new() {}

	override public function get_type() {
		return "hair";
	}

	override public function generateElements():Array<CostumeElement> {
		var tailUnder = new MorriganTailUnder();
		tailUnder.dynamicAnchor(-134.95, -194.1, G.her);
		tailUnder.makeUnToggleable();
		G.hairUnderLayer.addChild(tailUnder);

		var tail = new MorriganTail();
		var tailRope = new Rope(tail, G.hairUnderLayer, new Point(-131.95, -168.4), null, 5, "right", 0, 0);
		var tailHighlight:MorriganTailHighlight;
		(tailHighlight = new MorriganTailHighlight()).dynamicAnchor(-28.55, -243.15, G.her);
		tailHighlight.makeUnToggleable();
		G.hairOverLayer.addChild(tailHighlight);
		tailRope.linkTo(tailUnder);
		tailRope.linkTo(tailHighlight);

		var bang = new MorriganBang();
		var bangRope = new Rope(bang, G.hairOverLayer, new Point(-25.8, -208.1));
		var hairOver = new MorriganHairOver();
		hairOver.dynamicAnchor(-28.55, -243.15, G.her);
		hairOver.makeUnToggleable();
		G.hairOverLayer.addChild(hairOver);

		return [tailRope, bangRope, tailUnder, tailHighlight, hairOver];
	}
}
