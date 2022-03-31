package mod.base.chars.samus;

import openfl.geom.Point;
import obj.Rope;
import obj.CostumeElement;
import chars.CharacterElement;

class SamusHair extends CharacterElement {
	public function new() {}

	override public function get_type() {
		return "hair";
	}

	override public function generateElements():Array<CostumeElement> {
		var bang = new SamusHairBang();
		var bangRope = new Rope(bang, G.hairOverLayer, new Point(10, -315), null, -5);
		bangRope.damping = 0.425;
		bangRope.lockTop(0.25);

		var backBang = new SamusHairBackBang();
		var backBangRope = new Rope(backBang, G.hairBackLayer, new Point(55, -300), null, -5);
		backBangRope.damping = 0.425;
		backBangRope.lockTop(0.25);

		var ponyTail = new SamusHairPonytail();
		var ponyTailRope = new Rope(ponyTail, G.hairBackLayer, new Point(-218, -318));
		ponyTailRope.damping = 0.425;
		ponyTailRope.lockTop(0.25);

		var tailTie = new SamusTailTie();
		tailTie.x = -149.2;
		tailTie.y = -266.95;
		G.hairCostumeUnderOver.addChild(tailTie);

		return [bangRope, backBangRope, ponyTailRope, tailTie];
	}
}
