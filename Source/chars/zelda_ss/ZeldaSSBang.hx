package chars.zelda_ss;

@:access(swf.exporters.animate)
class ZeldaSSBang extends openfl.display.MovieClip
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdthx-lib");
		var symbol = library.symbols.get(2267);
		symbol.__init(library);

		super();
	}
}
