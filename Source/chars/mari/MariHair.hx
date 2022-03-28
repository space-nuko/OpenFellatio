package chars.mari;

import openfl.geom.Point;
import obj.Rope;
import obj.CostumeElement;
import chars.CharacterElement;

class MariHair extends CharacterElement {
	public function new() {}

	override public function get_type() {
		return "hair";
	}

	override public function generateElements():Array<CostumeElement> {
         var hairClip = new MariHairClip();
         hairClip.x = -21.25;
         hairClip.y = -235.8;
         G.hairCostumeUnderOver.addChild(hairClip);
         var bang = new MariBang();
         var bangRope = new Rope(bang,G.hairOverLayer,new Point(28,-268));
         var ponyTail = new MariPonyTail();
         var ponyTailRope = new Rope(ponyTail,G.hairUnderLayer,new Point(-120,-55),null,15,"right",0,1);
         return [hairClip,bangRope,ponyTailRope];
	}
}
