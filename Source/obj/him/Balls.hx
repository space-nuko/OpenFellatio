package obj.him;

@:access(swf.exporters.animate)

class Balls extends openfl.display.MovieClip
{
	@:keep @:noCompletion @:dox(hide) public var rightOutline(default, null):openfl.display.MovieClip;
	@:keep @:noCompletion @:dox(hide) public var leftOutline(default, null):openfl.display.MovieClip;
	@:keep @:noCompletion @:dox(hide) public var rightFill(default, null):openfl.display.MovieClip;
	@:keep @:noCompletion @:dox(hide) public var leftFill(default, null):openfl.display.MovieClip;
	@:keep @:noCompletion @:dox(hide) public var rightHighlight(default, null):openfl.display.MovieClip;
	@:keep @:noCompletion @:dox(hide) public var leftHighlight(default, null):openfl.display.MovieClip;


	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("FYA8BqNO2PenTmHMYgDK");
		var symbol = library.symbols.get(265);
		symbol.__init(library);

		super();
	}
}
