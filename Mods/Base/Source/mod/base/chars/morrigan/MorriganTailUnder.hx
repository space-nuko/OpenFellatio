package mod.base.chars.morrigan;

@:access(swf.exporters.animate)
class MorriganTailUnder extends obj.CostumeElement
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdt");
		var symbol = library.symbols.get(153);
		symbol.__init(library);

		super();
	}
}
