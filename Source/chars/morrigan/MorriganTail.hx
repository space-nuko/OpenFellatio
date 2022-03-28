package chars.morrigan;

@:access(swf.exporters.animate)
class MorriganTail extends openfl.display.MovieClip
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdthx-lib");
		var symbol = library.symbols.get(166);
		symbol.__init(library);

		super();
	}
}
