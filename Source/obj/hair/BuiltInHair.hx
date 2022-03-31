package obj.hair;

import chars.Character;

class BuiltInHair implements IHair
{
    @:save public var hairTop(default, null): String;
    @:save public var hairUnder(default, null): String;
    @:save public var hairBottom(default, null): String;
    @:save public var hairBack(default, null): String;

    public function new(hairTop:String = "", hairUnder:String = null, hairBottom:String = null, hairBack:String = null)
    {
        this.hairTop = hairTop;

        this.hairUnder = hairUnder;
        if (this.hairUnder == null)
            this.hairUnder = this.hairTop;

        this.hairBottom = hairBottom;
        if (this.hairBottom == null)
            this.hairBottom = this.hairTop;

        this.hairBack = hairBack;
        if (this.hairBack == null)
            this.hairBack = this.hairTop;
    }

    public function fromYaml(yaml: Dynamic)
    {
        if (yaml.exists("frame"))
            this.hairTop = cast(yaml.get("frame"), String);

        if (yaml.exists("hairTop"))
            this.hairTop = cast(yaml.get("hairTop"), String);

        if (yaml.exists("hairUnder"))
            this.hairUnder = cast(yaml.get("hairUnder"), String);
        else
            this.hairUnder = this.hairTop;

        if (yaml.exists("hairBottom"))
            this.hairBottom = cast(yaml.get("hairBottom"), String);
        else
            this.hairBottom = this.hairTop;

        if (yaml.exists("hairBack"))
            this.hairBack = cast(yaml.get("hairBack"), String);
        else
            this.hairBack = this.hairTop;
    }

    public function toYaml(): Dynamic
    {
        var yaml: Dynamic = { type: Type.getClassName(BuiltInHair) };

        obj.serial.Serial.toYaml();

        return yaml;
    }

    public function apply(char: Character)
    {
        char.hairTop = this.hairTop;
        char.hairUnder = this.hairUnder;
        char.hairBottom = this.hairBottom;
        char.hairBack = this.hairBack;

		G.her.hairTop.gotoAndStop(char.hairTop);
		G.her.hairMidContainer.hairUnder.gotoAndStop(char.hairUnder);
		G.her.hairMidContainer.hairBottom.gotoAndStop(char.hairBottom);
		G.her.hairBackContainer.hairBack.gotoAndStop(char.hairBack);
    }

    public function unapply(char: Character)
    {
    }
}
