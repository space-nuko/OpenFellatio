package ;

import openfl.display.MovieClip;

@:rtti
class HimLeftForeArm extends MovieClip
{
	@:keep public var hand(default, null): MovieClip;
}

@:rtti
class HimLeftArm extends MovieClip
{
	@:keep public var foreArm(default, null): HimLeftForeArm;
}

@:rtti
@:access(swf.exporters.animate)
class HimLeftArmContainer extends MovieClip
{
	@:keep public var arm(default, null): HimLeftArm;

	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("a8olP6aXvP6aAaPJMwlV");
		var symbol = library.symbols.get(514);
		symbol.__init(library);

		super();
	}
}
