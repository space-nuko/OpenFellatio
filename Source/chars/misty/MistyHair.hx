package chars.misty;

import obj.CostumeElement;
import chars.CharacterElement;

class MistyHair extends CharacterElement {
	public function new() {}

	override public function get_type() {
		return "hair";
	}

	override public function generateElements():Array<CostumeElement> {
		var ponytail = new MistyPonytail();
		ponytail.x = -196.85;
		ponytail.y = -262.05;
		G.hairTop.addChild(ponytail);

		return [ponytail];
	}
}
