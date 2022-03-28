package chars.zelda_ss;

@:access(swf.exporters.animate)
class ZeldaSSTail extends openfl.display.MovieClip
{
    public function new()
    {
        var library = swf.exporters.animate.AnimateLibrary.get("sdthx-lib");
        var symbol = library.symbols.get(2278);
        symbol.__init(library);

        super();
    }
}
