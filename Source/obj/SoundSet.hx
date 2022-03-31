package obj;

import haxe.io.Path;
import openfl.Assets;
import openfl.media.Sound;
import yaml.Yaml;

class SoundSet
{
    public var name: String;
	public var normalBreath:Array<Sound>;
	public var breatheIn:Array<Sound>;
	public var fastBreath:Array<Sound>;
	public var suddenBreath:Array<Sound>;
	public var quietBreath:Array<Sound>;
	public var down:Array<Sound>;
	public var gag:Array<Sound>;
	public var suck:Array<Sound>;
	public var touch:Array<Sound>;
	public var splat:Array<Sound>;
	public var cough:Array<Sound>;
	public var openCough:Array<Sound>;
	public var held:Array<Sound>;
	public var passOut:Array<Sound>;
	public var swallow:Array<Sound>;
	public var lick:Array<Sound>;
	public var cum:Array<Sound>;
	public var cumInside:Array<Sound>;
	public var grab:Array<Sound>;
	public var rub:Sound;
	public var intro:Sound;

    public function new()
    {
    }

	private static inline function sound(yaml:Dynamic, name:String):Sound {
        return Assets.getSound(cast(yaml.get(name), String));
    }

	private static inline function soundArray(yaml:Dynamic, name:String):Array<Sound> {
        if (!yaml.exists(name))
            return [];

		var result:Array<Sound> = [];
        var arr = cast(yaml.get(name), Array<Dynamic>);
		for (v in arr) {
			result.push(Assets.getSound(cast(v, String)));
		}
		return result;
	}

    public static function loadFromYaml(assetPath: String): SoundSet
    {
        var s = Assets.getBytes(assetPath).toString();
        var yaml = Yaml.parse(s);
        var soundSet = new SoundSet();
        soundSet.fromYaml(yaml.get("soundSet"));
        return soundSet;
    }

    public function fromYaml(yaml:Dynamic) {
        this.name = cast(yaml.get("name"), String);
        this.normalBreath = soundArray(yaml, "normalBreath");
        this.breatheIn = soundArray(yaml, "breatheIn");
        this.fastBreath = soundArray(yaml, "fastBreath");
        this.suddenBreath = soundArray(yaml, "suddenBreath");
        this.quietBreath = soundArray(yaml, "quietBreath");
        this.down = soundArray(yaml, "down");
        this.gag = soundArray(yaml, "gag");
        this.suck = soundArray(yaml, "suck");
        this.touch = soundArray(yaml, "touch");
        this.splat = soundArray(yaml, "splat");
        this.cough = soundArray(yaml, "cough");
        this.openCough = soundArray(yaml, "openCough");
        this.held = soundArray(yaml, "held");
        this.passOut = soundArray(yaml, "passOut");
        this.swallow = soundArray(yaml, "swallow");
        this.lick = soundArray(yaml, "lick");
        this.cum = soundArray(yaml, "cum");
        this.cumInside = soundArray(yaml, "cumInside");
        this.grab = soundArray(yaml, "grab");
        this.rub = sound(yaml, "rub");
        this.intro = sound(yaml, "intro");
	}
}
