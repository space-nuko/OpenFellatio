package chars.android_18;

import openfl.geom.Point;
import obj.Rope;
import obj.CostumeElement;
import chars.CharacterElement;

class Android18Hair extends CharacterElement {
	public function new() {}

	override public function get_type() {
		return "hair";
	}

	override public function generateElements():Array<CostumeElement> {
         var back = new Android18HairBack();
         var backRope = new Rope(back,G.hairOverLayer,new Point(-94,-212));
         backRope.damping = 0.255;

         var front= new Android18HairFront();
         var frontRope = new Rope(front,G.hairOverLayer,new Point(11,-241));
         frontRope.damping = 0.255;

         var mask = new Android18HairMask();
         mask.dynamicAnchor(49,-235,G.her);
         mask.makeUnToggleable();
         G.hairOverLayer.addChild(mask);
         frontRope.linkTo(mask);

         return [backRope,frontRope,mask];
	}
}
