package chars.rikku;

@:access(swf.exporters.animate)
class RikkuBraidFrontRight extends openfl.display.MovieClip
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdt");
		var symbol = library.symbols.get(2334);
		symbol.__init(library);

		super();
	}
}
