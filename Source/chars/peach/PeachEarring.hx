package chars.peach;

@:access(swf.exporters.animate)
class PeachEarring extends obj.CostumeElement
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdthx-lib");
		var symbol = library.symbols.get(2209);
		symbol.__init(library);

		super();
	}
}
