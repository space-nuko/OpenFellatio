package chars.zelda_tp;

import openfl.geom.Point;
import obj.Rope;
import obj.CostumeElement;
import chars.CharacterElement;

class ZeldaTPHair extends CharacterElement {
	public function new() {}

	override public function get_type() {
		return "hair";
	}

	override public function generateElements():Array<CostumeElement> {
         var tail = new ZeldaTPTail();
         var tailRope = new Rope(tail,G.hairUnderLayer,new Point(-117.25,-171.4),null,10,"right",0,0);

         var bang1 = new ZeldaTPBang();
         var bang1Rope = new Rope(bang1,G.hairOverLayer,new Point(-14.7,-202.4));

         var bang2 = new ZeldaTPBang();
         var bang2Rope = new Rope(bang2,G.hairBackLayer,new Point(1.55,-193.55));
         bang2Rope.setScaling(0.9,0.9);

         var hairMask = new ZeldaTPHairMask();
         hairMask.dynamicAnchor(-1.15,-223.35,G.her);
         hairMask.makeUnToggleable();
         G.hairOverLayer.addChild(hairMask);

         return [tailRope,bang1Rope,bang2Rope,hairMask];
	}
}
