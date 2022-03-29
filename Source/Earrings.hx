package;

@:rtti
@:access(swf.exporters.animate)
class Earrings extends obj.RigidBody
{
	public function new()
	{
		var library = swf.exporters.animate.AnimateLibrary.get("sdt");
		var symbol = library.symbols.get(1965);
		symbol.__init(library);

		super();
	}
}
