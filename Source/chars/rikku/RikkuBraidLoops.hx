package chars.rikku;

@:access(swf.exporters.animate)
class RikkuBraidLoops extends obj.CostumeElement
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdt");
		var symbol = library.symbols.get(2336);
		symbol.__init(library);

		super();
	}
}
