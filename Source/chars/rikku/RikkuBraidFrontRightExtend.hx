package chars.rikku;

@:access(swf.exporters.animate)
class RikkuBraidFrontRightExtend extends obj.CostumeElement
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdthx-lib");
		var symbol = library.symbols.get(2349);
		symbol.__init(library);

		super();
	}
}
