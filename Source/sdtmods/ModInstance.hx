package sdtmods;

import haxe.io.Path;
import openfl.Assets;
import yaml.Yaml;
import utils.TypeUtils;

class ModInstance
{
    /*
     * User mod class for running logic.
     *
     * If null this mod has no code and was created
     * without compiling anything
     */
    public var userMod: Null<Mod> = null;

    @:save public var name: String = "";

    public var dependencies: Array<String> = [];

    /*
     * Path of the user mod class to instantiate.
     */
    @:save public var userModClass: Null<String> = null;

    /*
     * Directory path containing the "mod.yml" for this mod.
     */
    public var path: String = "";

    public function new()
    {
    }

    /*
     * assetPath is the "mod.yml" manifest
     */
    public static function loadFromYaml(assetPath: String): ModInstance
    {
        var s = Assets.getBytes(assetPath).toString();
        var yaml = Yaml.parse(s);
        var mod = new ModInstance();
        mod.fromYaml(yaml.get("mod"));
        mod.path = Path.normalize(Path.directory(assetPath));
        return mod;
    }

    public function fromYaml(yaml: Dynamic)
    {
        obj.serial.Serial.fromYaml(yaml);

        if (yaml.exists("dependencies")) {
            var deps = cast(yaml.get("dependencies"), Array<Dynamic>);

            for (d in deps) {
                this.dependencies.push(cast(d, String));
            }
        }

        if (this.userModClass != null) {
            this.userMod = TypeUtils.tryInstantiate(this.userModClass, Mod);
        }
    }
}
