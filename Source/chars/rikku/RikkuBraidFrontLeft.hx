package chars.rikku;

@:access(swf.exporters.animate)
class RikkuBraidFrontLeft extends openfl.display.MovieClip
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdthx-lib");
		var symbol = library.symbols.get(14);
		symbol.__init(library);

		super();
	}
}
