package chars.misty;

@:access(swf.exporters.animate)
class MistyPonytail extends obj.CostumeElement
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdt");
		var symbol = library.symbols.get(2126);
		symbol.__init(library);

		super();
	}
}
