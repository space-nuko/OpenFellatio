package chars.peach;

import openfl.geom.Point;
import obj.Rope;
import obj.CostumeElement;
import chars.CharacterElement;

class PeachHair extends CharacterElement {
	public function new() {}

	override public function get_type() {
		return "hair";
	}

	override public function generateElements():Array<CostumeElement> {
         var hairTail = new PeachHairTail();
         var hairTailRope = new Rope(hairTail,G.hairUnderLayer,new Point(-116,-132),null,15,"right",0,1);
         hairTailRope.lockTop(0.2);

         return [hairTailRope];
	}
}
