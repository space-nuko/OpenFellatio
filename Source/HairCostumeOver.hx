package;

import openfl.display.MovieClip;

@:rtti
class HairCostumeOverHeadwear extends MovieClip
{
	@:keep public var landingPoint(default, null): Null<MovieClip>;
}

@:rtti
@:access(swf.exporters.animate)
class HairCostumeOver extends MovieClip
{
	@:keep public var headwear(default, null):HairCostumeOverHeadwear;

	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdthx-lib");
		var symbol = library.symbols.get(2455);
		symbol.__init(library);

		super();
	}
}
