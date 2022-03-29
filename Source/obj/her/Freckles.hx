package obj.her;

import openfl.display.Sprite;
import openfl.geom.Point;
import openfl.Vector;

@:rtti
@:access(swf.exporters.animate)
class Freckles extends openfl.display.MovieClip {
	public var targetOrigin:Point = new Point(-13, 0);
	public var targetSize:Point = new Point(160, 100);
	public var freckles:Vector<Freckle> = new Vector<Freckle>();

	public function new() {
		var library = swf.exporters.animate.AnimateLibrary.get("sdt");
		var symbol = library.symbols.get(1143);
		symbol.__init(library);

		super();
	}

	public function setFreckleAmount(_amount:Float) {
        var amount: UInt = Std.int(_amount * 1.2);

        if (amount < freckles.length)
        {
            var i = amount;
            while (i < freckles.length) {
                var randomID = Std.int(Math.random() * freckles.length);
                var freckle = freckles[randomID];
                removeChild(freckle);
                freckles.splice(randomID, 1);
                i++;
            }
        }
        else if (amount > freckles.length)
        {
            var i = amount;
            while (i > freckles.length) {
                var freckle = new Freckle();
                freckle.x = targetOrigin.x - targetSize.x * 0.5 + randomDist() * targetSize.x;
                freckle.y = targetOrigin.y - targetSize.y * 0.5 + randomDist() * targetSize.y;
                freckle.alpha = Math.random() * 0.4 + 0.6;
                var size = Math.random() * 0.5 + 0.5;
                freckle.scaleX = size;
                freckle.scaleY = size;
                addChild(freckle);
                freckles.push(freckle);
                i--;
            }
        }
	}

	public static function randomDist():Float {
		return (Math.random() + Math.random() + Math.random()) / 3;
	}
}
