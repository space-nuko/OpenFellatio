package mod.base.chars.rei;

@:access(swf.exporters.animate)
class ReiHairClip extends obj.CostumeElement
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdt");
		var symbol = library.symbols.get(2102);
		symbol.__init(library);

		super();
	}
}
