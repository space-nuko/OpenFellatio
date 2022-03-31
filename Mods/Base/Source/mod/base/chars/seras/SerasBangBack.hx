package mod.base.chars.seras;

@:access(swf.exporters.animate)
class SerasBangBack extends openfl.display.MovieClip
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdt");
		var symbol = library.symbols.get(2245);
		symbol.__init(library);

		super();
	}
}
