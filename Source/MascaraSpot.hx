package ;

@:rtti
@:access(swf.exporters.animate)
class MascaraSpot extends openfl.display.MovieClip
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdt");
		var symbol = library.symbols.get(2066);
		symbol.__init(library);

		super();
	}
}
