package mod.base.chars.rikku;

@:access(swf.exporters.animate)
class RikkuBraidFrontRightExtend extends obj.CostumeElement
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdt");
		var symbol = library.symbols.get(2349);
		symbol.__init(library);

		super();
	}
}
