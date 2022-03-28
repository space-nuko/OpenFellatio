package chars.mari;

@:access(swf.exporters.animate)
class MariHairClip extends obj.CostumeElement
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdthx-lib");
		var symbol = library.symbols.get(2124);
		symbol.__init(library);

		super();
	}
}
