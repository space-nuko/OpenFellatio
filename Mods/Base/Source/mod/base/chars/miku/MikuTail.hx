package mod.base.chars.miku;

@:access(swf.exporters.animate)
class MikuTail extends openfl.display.MovieClip
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdt");
		var symbol = library.symbols.get(2385);
		symbol.__init(library);

		super();
	}
}
