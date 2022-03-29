package chars.miku;

@:access(swf.exporters.animate)
class MikuHairRibbon extends obj.CostumeElement
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdt");
		var symbol = library.symbols.get(2387);
		symbol.__init(library);

		super();
	}
}
