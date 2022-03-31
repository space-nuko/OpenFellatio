package mod.base.chars.mari;

@:access(swf.exporters.animate)
class MariBang extends openfl.display.MovieClip
{
	@:keep @:noCompletion @:dox(hide) public var segment3(default, null):openfl.display.MovieClip;
	@:keep @:noCompletion @:dox(hide) public var segment2(default, null):openfl.display.MovieClip;
	@:keep @:noCompletion @:dox(hide) public var segment1(default, null):openfl.display.MovieClip;
	@:keep @:noCompletion @:dox(hide) public var segment0(default, null):openfl.display.MovieClip;

	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdt");
		var symbol = library.symbols.get(2111);
		symbol.__init(library);

		super();
	}
}
