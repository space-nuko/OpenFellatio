package;

@:rtti
@:access(swf.exporters.animate)
class HairBackContainer extends openfl.display.MovieClip
{
	@:keep public var hairBack(default, null):openfl.display.MovieClip;
	@:keep public var hairBackLayer(default, null):openfl.display.MovieClip;

	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdthx-lib");
		var symbol = library.symbols.get(598);
		symbol.__init(library);

		super();
	}
}
