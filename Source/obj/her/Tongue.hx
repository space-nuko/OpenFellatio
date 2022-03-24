package obj.her;

@:access(swf.exporters.animate)

class Tongue extends #if flash flash.display.MovieClip.MovieClip2 #else openfl.display.MovieClip #end
{
	@:keep @:noCompletion @:dox(hide) public var piercingBack(default, null):openfl.display.MovieClip;
	@:keep @:noCompletion @:dox(hide) public var tipPoint(default, null):openfl.display.MovieClip;
	@:keep @:noCompletion @:dox(hide) public var piercing(default, null):openfl.display.MovieClip;


	public function new()
	{
		super();

		var library = swf.exporters.animate.AnimateLibrary.get("FYA8BqNO2PenTmHMYgDK");
		var symbol = library.symbols.get(975);
		symbol.__initObject(library, this);
	}
}
