package chars.morrigan;

@:access(swf.exporters.animate)
class MorriganTailHighlight extends obj.CostumeElement
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdthx-lib");
		var symbol = library.symbols.get(155);
		symbol.__init(library);

		super();
	}
}
