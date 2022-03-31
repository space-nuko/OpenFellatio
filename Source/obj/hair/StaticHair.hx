package obj.hair;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.PixelSnapping;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.Assets;
import chars.Character;

class StaticHair implements IHair {
	@:save public var assetPath(default, null):String;

	private var hairOverLayer:Bitmap;
	private var hairUnderLayer:Bitmap;
	private var hairBackLayer:Bitmap;

	public function new(assetPath:String = "") {
		this.assetPath = assetPath;
	}

	public function fromYaml(yaml:Dynamic) {
		obj.serial.Serial.fromYaml(yaml);
	}

	public function toYaml():Dynamic {
		var yaml:Dynamic = {type: Type.getClassName(BuiltInHair)};

		obj.serial.Serial.toYaml();

		return yaml;
	}

	public function apply(char:Character) {
        var asset = Assets.getBitmapData(this.assetPath);

        var hairWidth = Std.int(Math.ceil(Math.max(asset.width, 1200) * 0.5));
        var hairHeight = Std.int(Math.ceil(Math.max(asset.height, 1200) * 0.5));

        var hairImportSource = new BitmapData(asset.width, asset.height, true, 0);
		hairImportSource.draw(asset);

		var _loc_1 = new Rectangle(0, 0, hairWidth, hairHeight);

		var hairOverData = new BitmapData(hairWidth, hairHeight, true, 0);
		hairOverLayer = new Bitmap(hairOverData, PixelSnapping.AUTO, true);
		hairOverData.copyPixels(hairImportSource, _loc_1, new Point());
		_loc_1.x = hairWidth;

		var hairUnderData = new BitmapData(hairWidth, hairHeight, true, 0);
		hairUnderLayer = new Bitmap(hairUnderData, PixelSnapping.AUTO, true);
		hairUnderData.copyPixels(hairImportSource, _loc_1, new Point());
		_loc_1.x = 0;
		_loc_1.y = hairHeight;

		var hairBackData = new BitmapData(hairWidth, hairHeight, true, 0);
		hairBackLayer = new Bitmap(hairBackData, PixelSnapping.AUTO, true);
		hairBackData.copyPixels(hairImportSource, _loc_1, new Point());

		var scale = 1 / 0.85;
		hairOverLayer.x = -360;
		hairOverLayer.y = -560;
		hairOverLayer.rotation = 15;
		hairOverLayer.scaleX = scale;
		hairOverLayer.scaleY = scale;
		hairUnderLayer.x = -360;
		hairUnderLayer.y = -560;
		hairUnderLayer.rotation = 15;
		hairUnderLayer.scaleX = scale;
		hairUnderLayer.scaleY = scale;
		hairBackLayer.x = -360;
		hairBackLayer.y = -560;
		hairBackLayer.rotation = 15;
		hairBackLayer.scaleX = scale;
		hairBackLayer.scaleY = scale;

        G.characterControl.clearHair();
        G.hairTop.addChild(this.hairOverLayer);
        G.hairUnder.addChild(this.hairUnderLayer);
        G.hairBack.addChild(this.hairBackLayer);
	}

	public function unapply(char:Character) {
        if (this.hairOverLayer != null) {
            G.hairTop.removeChild(this.hairOverLayer);
            G.hairUnder.removeChild(this.hairUnderLayer);
            G.hairBack.removeChild(this.hairBackLayer);
        }
    }
}
