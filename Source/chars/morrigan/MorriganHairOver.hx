package chars.morrigan;

@:access(swf.exporters.animate)
class MorriganHairOver extends obj.CostumeElement
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdthx-lib");
		var symbol = library.symbols.get(179);
		symbol.__init(library);

		super();
	}
}
