package;

@:rtti
@:access(swf.exporters.animate)
class Freckle extends openfl.display.MovieClip
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdthx-lib");
		var symbol = library.symbols.get(133);
		symbol.__init(library);

		super();
	}
}
