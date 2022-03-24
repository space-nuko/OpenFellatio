package chars;

import openfl.display.MovieClip;
import openfl.geom.Point;
import obj.Rope;
import obj.AlphaRGBObject;
import chars.sdchan.SDCHairLong;
import chars.sdchan.SDCHairLong2;

class SDChan extends Character {
	public function new() {
		super();
		charName = "SD chan";
		charShortName = "SD chan";
		skinType = 0;
		iris = "normal";
		breastSize = 70;
		hairTop = "SDChan";
		hairUnder = "SDChan";
		hairBack = "SDChan";
		hairBottom = "SDChan";
		costume = "nude";
		irisFill = new AlphaRGBObject(1, 56, 100, 137);
		eyebrowFill = new AlphaRGBObject(1, 89, 67, 51);
		eyebrowLine = new AlphaRGBObject(1, 0, 0, 0);
		scalpFill = new AlphaRGBObject(1, 211, 158, 90);
		eyeShadow.a = 1;
		bg = 3;
	}

	override public function generateElements():Array<MovieClip> {
		var hair1:ASAny = new Rope(new SDCHairLong(), G.hairUnderLayer, new Point(-105, -193), null, 0, "right", 0, 0);
		var hair2:ASAny = new Rope(new SDCHairLong2(), G.hairBackLayer, new Point(-50, -140));
		return [hair1, hair2];
	}
}
