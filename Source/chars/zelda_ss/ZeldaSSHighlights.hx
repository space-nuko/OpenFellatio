package chars.zelda_ss;

@:access(swf.exporters.animate)
class ZeldaSSHighlights extends obj.CostumeElement
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdthx-lib");
		var symbol = library.symbols.get(2280);
		symbol.__init(library);

		super();
	}
}
