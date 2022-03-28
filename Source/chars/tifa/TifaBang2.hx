package chars.tifa;

@:access(swf.exporters.animate)
class TifaBang2 extends openfl.display.MovieClip
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdthx-lib");
		var symbol = library.symbols.get(34);
		symbol.__init(library);

		super();
	}
}
