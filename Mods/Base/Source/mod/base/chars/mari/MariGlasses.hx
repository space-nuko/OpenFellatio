package mod.base.chars.mari;

@:access(swf.exporters.animate)
class MariGlasses extends obj.CostumeElement
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdt");
		var symbol = library.symbols.get(2122);
		symbol.__init(library);

		super();
	}
}
