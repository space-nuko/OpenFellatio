package mod.base.chars.zelda_tp;

@:access(swf.exporters.animate)
class ZeldaTPTail extends openfl.display.MovieClip
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdt");
		var symbol = library.symbols.get(2304);
		symbol.__init(library);

		super();
	}
}
