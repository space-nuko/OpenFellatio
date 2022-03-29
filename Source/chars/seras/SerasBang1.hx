package chars.seras;

@:access(swf.exporters.animate)
class SerasBang1 extends openfl.display.MovieClip
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdt");
		var symbol = library.symbols.get(2240);
		symbol.__init(library);

		super();
	}
}
