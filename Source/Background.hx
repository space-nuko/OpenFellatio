package;

@:rtti
@:access(swf.exporters.animate)
class Background extends openfl.display.MovieClip
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdt");
		var symbol = library.symbols.get(189);
		symbol.__init(library);

		super();
	}
}
