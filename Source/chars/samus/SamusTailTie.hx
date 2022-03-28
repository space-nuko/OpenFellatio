package chars.samus;

@:access(swf.exporters.animate)
class SamusTailTie extends obj.CostumeElement
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdthx-lib");
		var symbol = library.symbols.get(2);
		symbol.__init(library);

		super();
	}
}
