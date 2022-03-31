package mod.base.chars.zelda_tp;

@:access(swf.exporters.animate)
class ZeldaTPHairMask extends obj.CostumeElement
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdt");
		var symbol = library.symbols.get(2306);
		symbol.__init(library);

		super();
	}
}
