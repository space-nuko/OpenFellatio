package ;

import openfl.display.MovieClip;

@:rtti
class HimOverLayerTorso extends MovieClip
{
	@:keep public var costume(default, null):MovieClip;
}

@:rtti
@:access(swf.exporters.animate)
class HimOverLayer extends MovieClip
{
	@:keep public var torso(default, null):HimOverLayerTorso;

	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("a8olP6aXvP6aAaPJMwlV");
		var symbol = library.symbols.get(487);
		symbol.__init(library);

		super();
	}
}
