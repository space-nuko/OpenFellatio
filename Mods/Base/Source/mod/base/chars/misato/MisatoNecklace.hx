package mod.base.chars.misato;

@:access(swf.exporters.animate)
class MisatoNecklace extends openfl.display.MovieClip
{
	@:keep @:noCompletion @:dox(hide) public var segment0(default, null):openfl.display.MovieClip;
	@:keep @:noCompletion @:dox(hide) public var segment1(default, null):openfl.display.MovieClip;

	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdt");
		var symbol = library.symbols.get(2147);
		symbol.__init(library);

		super();
	}
}
