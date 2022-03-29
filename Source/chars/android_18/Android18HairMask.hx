package chars.android_18;

@:access(swf.exporters.animate)
class Android18HairMask extends obj.CostumeElement
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdt");
		var symbol = library.symbols.get(2237);
		symbol.__init(library);

		super();
	}
}
