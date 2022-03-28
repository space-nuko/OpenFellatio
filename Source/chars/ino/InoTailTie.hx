package chars.ino;

@:access(swf.exporters.animate)
class InoTailTie extends obj.CostumeElement
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdthx-lib");
		var symbol = library.symbols.get(2169);
		symbol.__init(library);

		super();
	}
}
