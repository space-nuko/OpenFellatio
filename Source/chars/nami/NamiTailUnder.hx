package chars.nami;

@:access(swf.exporters.animate)
class NamiTailUnder extends openfl.display.MovieClip
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdthx-lib");
		var symbol = library.symbols.get(2356);
		symbol.__init(library);

		super();
	}
}
