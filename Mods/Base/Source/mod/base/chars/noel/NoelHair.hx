package mod.base.chars.noel;

import openfl.geom.Point;
import obj.Rope;
import obj.CostumeElement;
import chars.CharacterElement;

class NoelHair extends CharacterElement {
	public function new() {}

	override public function get_type() {
		return "hair";
	}

	override public function generateElements():Array<CostumeElement> {
         var side = new NoelHairSide();
         var sideRope = new Rope(side,G.hairOverLayer,new Point(40,-227),null,5);
         sideRope.damping = 0.425;

         var front = new NoelHairFront();
         var frontRope = new Rope(front,G.hairBackLayer,new Point(120,-200),null,-5);
         frontRope.lockTop(0.1);

         return [sideRope, frontRope];
	}
}
