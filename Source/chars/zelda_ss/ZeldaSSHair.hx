package chars.zelda_ss;

import openfl.geom.Point;
import obj.Rope;
import obj.CostumeElement;
import chars.CharacterElement;

class ZeldaSSHair extends CharacterElement {
	public function new() {}

	override public function get_type() {
		return "hair";
	}

	override public function generateElements():Array<CostumeElement> {
       var tail = new ZeldaSSTail();
       var tailRope= new Rope(tail,G.hairUnderLayer,new Point(-64.45,-251.05),null,10,"right",0,0);

       var bang1 = new ZeldaSSBang();
       var bang1Rope= new Rope(bang1,G.hairOverLayer,new Point(-8.45,-298.6));

       var bang2 = new ZeldaSSBang();
       var bang2Rope = new Rope(bang2,G.hairBackLayer,new Point(56.8,-285.85));
       bang2Rope.setScaling(-0.9,0.9);

       var highlights = new ZeldaSSHighlights();
       highlights.dynamicAnchor(-19.2,-317.65,G.her);
       highlights.makeUnToggleable();
       G.hairOverLayer.addChild(highlights);

       return [tailRope,bang1Rope,bang2Rope,highlights];
	}
}
