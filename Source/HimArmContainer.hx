package ;

import openfl.display.MovieClip;

@:rtti
class HimUpperArm extends MovieClip
{
	@:keep public var shoulderPoint(default, null): MovieClip;
}

@:rtti
class HimArm extends MovieClip
{
	@:keep public var hand(default, null): MovieClip;
	@:keep public var upperArm(default, null): HimUpperArm;
	@:keep public var lowerArm(default, null): MovieClip;
}

@:rtti
@:access(swf.exporters.animate)
class HimArmContainer extends MovieClip
{
	@:keep public var arm(default, null): HimArm;

	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("Ld39TJPQZsVJfqCLrG3m");
		var symbol = library.symbols.get(481);
		symbol.__init(library);

		super();
	}
}
