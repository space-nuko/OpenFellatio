package mod.base.chars.ino;

@:access(swf.exporters.animate)
class InoHairTail extends openfl.display.MovieClip
{
	@:keep @:noCompletion @:dox(hide) public var segment4(default, null):openfl.display.MovieClip;
	@:keep @:noCompletion @:dox(hide) public var segment3(default, null):openfl.display.MovieClip;
	@:keep @:noCompletion @:dox(hide) public var segment2(default, null):openfl.display.MovieClip;
	@:keep @:noCompletion @:dox(hide) public var segment1(default, null):openfl.display.MovieClip;
	@:keep @:noCompletion @:dox(hide) public var segment0(default, null):openfl.display.MovieClip;

	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdt");
		var symbol = library.symbols.get(2158);
		symbol.__init(library);

		super();
	}
}
