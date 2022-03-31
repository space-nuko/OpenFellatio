package mod.base.chars.rikku;

@:access(swf.exporters.animate)

class RikkuBang1 extends openfl.display.MovieClip
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdt");
		var symbol = library.symbols.get(2317);
		symbol.__init(library);

		super();
	}
}
