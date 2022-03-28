package chars.seras;

@:access(swf.exporters.animate)
class SerasBang2 extends openfl.display.MovieClip
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdthx-lib");
		var symbol = library.symbols.get(2243);
		symbol.__init(library);

		super();
	}
}
