package mod.base.chars.rikku;

@:access(swf.exporters.animate)
class RikkuBandana extends obj.CostumeElement
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdt");
		var symbol = library.symbols.get(2308);
		symbol.__init(library);

		super();
	}
}
