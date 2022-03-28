package chars.rikku;

@:access(swf.exporters.animate)
class RikkuHairTop extends obj.CostumeElement
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdthx-lib");
		var symbol = library.symbols.get(2338);
		symbol.__init(library);

		super();
	}
}
