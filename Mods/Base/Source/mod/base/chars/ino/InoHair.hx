package mod.base.chars.ino;

import openfl.geom.Point;
import obj.Rope;
import obj.CostumeElement;
import chars.CharacterElement;

class InoHair extends CharacterElement {
	public function new() {}

	override public function get_type() {
		return "hair";
	}

	override public function generateElements():Array<CostumeElement> {
         var front = new InoHairFront();
         var frontRope = new Rope(front,G.hairOverLayer,new Point(51,-286));
         var tail = new InoHairTail();
         var tailRope = new Rope(tail,G.hairBackLayer,new Point(-216,-272),null,5);
         G.hairBackLayer.setChildIndex(tailRope,0);
         var tailTie = new InoTailTie();
         tailTie.x = -148.15;
         tailTie.y = -268;
         G.hairCostumeOver.addChild(tailTie);
         return [frontRope,tailRope,tailTie];
	}
}
