package chars.seras;

import obj.CostumeElement;
import chars.CharacterElement;

class SerasHair extends CharacterElement {
	public function new() {}

	override public function get_type() {
		return "hair";
	}

	override public function generateElements():Array<CostumeElement> {
        return [];
	}
}
