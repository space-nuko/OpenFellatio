package chars.sdchan;

import openfl.geom.Point;
import obj.Rope;
import obj.CostumeElement;
import chars.CharacterElement;

@:keep
class SDChanHair extends CharacterElement {
    public function new() {}

    override public function get_type() {
        return "hair";
    }

	override public function generateElements():Array<CostumeElement> {
		var hair1 = new Rope(new SDCHairLong(), G.hairUnderLayer, new Point(-105, -193), null, 0, "right", 0, 0);
		var hair2 = new Rope(new SDCHairLong2(), G.hairBackLayer, new Point(-50, -140));
		return [hair1, hair2];
	}
}
