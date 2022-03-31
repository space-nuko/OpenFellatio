package mod.base.chars.asuka;

@:access(swf.exporters.animate)
class AsukaHairClip extends obj.CostumeElement
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdt");
		var symbol = library.symbols.get(2100);
		symbol.__init(library);

		super();
	}
}
