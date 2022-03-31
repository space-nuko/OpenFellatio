package mod.base.chars.jill_valentine;

@:access(swf.exporters.animate)
class JillValentineHairHighlight extends obj.CostumeElement
{


	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdt");
		var symbol = library.symbols.get(2188);
		symbol.__init(library);

		super();
	}
}
