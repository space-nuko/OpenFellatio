package chars.jill_valentine;

@:access(swf.exporters.animate)
class JillValentineHairBack extends openfl.display.MovieClip
{
	@:keep @:noCompletion @:dox(hide) public var segment1(default, null):openfl.display.MovieClip;
	@:keep @:noCompletion @:dox(hide) public var segment0(default, null):openfl.display.MovieClip;

	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdthx-lib");
		var symbol = library.symbols.get(2174);
		symbol.__init(library);

		super();
	}
}
