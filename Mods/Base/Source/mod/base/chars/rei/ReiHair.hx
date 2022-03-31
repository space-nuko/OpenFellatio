package mod.base.chars.rei;

import obj.CostumeElement;
import chars.CharacterElement;

class ReiHair extends CharacterElement {
	public function new() {}

	override public function get_type() {
		return "hair";
	}

	override public function generateElements():Array<CostumeElement> {
		var hairClip = new ReiHairClip();
		hairClip.x = -23.4;
		hairClip.y = -270.85;
		G.hairCostumeOver.addChild(hairClip);
		return [hairClip];
	}
}
