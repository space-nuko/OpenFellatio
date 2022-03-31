package chars;

import obj.Her;
import obj.AlphaRGBObject;
import obj.CostumeElement;
import openfl.Assets;
import yaml.Yaml;
import obj.hair.IHair;
import obj.hair.BuiltInHair;
import utils.TypeUtils;
using ArrayTools;

class Character {
	@:save public var charName:String = "xxx";
	@:save public var charShortName:String = "xxx";
	@:save public var mood:String = Her.NORMAL_MOOD;
	@:save public var skinType:UInt = 0;
	@:save public var noseType:UInt = 0;
	@:save public var eyebrowType:UInt = 0;
	@:save public var earType:String = "normal";
	@:save public var iris:String = "normal";
	@:save public var breastSize:UInt = 70;
	public var hair:IHair = new BuiltInHair("SDChan");
	@:save public var hairTop:String = "SDChan";
	@:save public var hairUnder:String = "SDChan";
	@:save public var hairBack:String = "SDChan";
	@:save public var hairBottom:String = "SDChan";
	@:save public var costume:String = "SDChan";
	@:save public var collar:UInt = 1;
	@:save public var collarFill:AlphaRGBObject = new AlphaRGBObject(1, 0, 0, 0);
	@:save public var collarFill2:Null<AlphaRGBObject>;
	@:save public var cuffs:UInt = 1;
	@:save public var cuffsFill:AlphaRGBObject = new AlphaRGBObject(1, 0, 0, 0);
	@:save public var headwear:String = "None";
	@:save public var headwearFill:AlphaRGBObject;
	@:save public var headwearFill2:AlphaRGBObject;
	@:save public var earring:String = "None";
	@:save public var earringFill:AlphaRGBObject;
	@:save public var bodyScale:Float = 1.0;
	@:save public var armPos:String = "Back";
	@:save public var irisFill:AlphaRGBObject = new AlphaRGBObject(1, 56, 100, 137);
	@:save public var eyebrowFill:AlphaRGBObject = new AlphaRGBObject(1, 89, 67, 51);
	@:save public var eyebrowLine:AlphaRGBObject = new AlphaRGBObject(0, 0, 0, 0);
	@:save public var scalpFill:AlphaRGBObject = new AlphaRGBObject(1, 211, 158, 90);
	@:save public var lipstickFill:AlphaRGBObject = new AlphaRGBObject(0, 0, 0, 0);
	@:save public var eyeShadow:AlphaRGBObject = new AlphaRGBObject(1, 55, 26, 99);
	@:save public var sclera:AlphaRGBObject = new AlphaRGBObject(1, 255, 255, 255);
	@:save public var blush:AlphaRGBObject = new AlphaRGBObject(0.35, 196, 80, 77);
	@:save public var freckles:AlphaRGBObject = new AlphaRGBObject(0.8, 60, 24, 24);
	@:save public var freckleAmount:Float = 0;
	@:save public var mascara:AlphaRGBObject = new AlphaRGBObject(1, 0, 0, 0);
	@:save public var bg:UInt = 3;
	@:save public var gag:String = "None";
	@:save public var armwearFill:AlphaRGBObject = new AlphaRGBObject(1, 0, 0, 0);
	@:save public var armwear:String = "None";
	@:save public var legwearFill:AlphaRGBObject = new AlphaRGBObject(1, 0, 0, 0);
	@:save public var legwear:String = "None";
	@:save public var footwearFill:AlphaRGBObject = new AlphaRGBObject(1, 0, 0, 0);
	@:save public var footwear:String = "None";
	@:save public var pantiesFill:AlphaRGBObject = new AlphaRGBObject(1, 255, 255, 255);
	@:save public var panties:String = "None";
	@:save public var braFill:AlphaRGBObject = new AlphaRGBObject(1, 255, 255, 255);
	@:save public var bra:String = "None";
	@:save public var eyewear:String = "None";
	@:save public var eyewearFill:AlphaRGBObject = new AlphaRGBObject(1, 0, 0, 0);
	@:save public var defaultCostume:String = "";
	@:save public var altCostume:String = "";

    // TODO: elements are defined separately, then this list will hold their IDs
    public var elements: Array<CharacterElement> = [];

    @:save public var ordering: Int = 0;
    @:save public var extraData: Null<Dynamic>;

    // TODO
    // @:nosave public var dialogue: Map<String, Array<String>>;
    public var dialogue: String = "";

    public function new() {}

    public static function loadFromYaml(assetPath: String): Character {
        var s = Assets.getBytes(assetPath).toString();
        var yaml = Yaml.parse(s);
        var chara = new Character();
        chara.fromYaml(yaml.get("char"));
        return chara;
    }

    public function fromYaml(yaml: Dynamic)
    {
        obj.serial.Serial.fromYaml(yaml);

        if (yaml.exists("hair")) {
            var hairDict = yaml.get("hair");
            var klassName = cast(hairDict.get("type"), String);
            this.hair = cast(TypeUtils.tryInstantiate(klassName, IHair), IHair);
            this.hair.fromYaml(hairDict);
        }

        this.elements.resize(0);

        if (yaml.exists("elements")) {
            var types = cast(yaml.get("elements"), Array<Dynamic>);

            for (v in types) {
                var klassName = cast(v, String);
                this.elements.push(TypeUtils.tryInstantiate(klassName, CharacterElement));
            }
        }

        // if (yaml.exists("dialogue")) {
        //     var dialogueMap = cast(yaml.get("dialogue"), ObjectMap);

        //     for (k in dialogueMap.keys()) {
        //     }
        // }
    }

    public function toYaml(): Dynamic
    {
        var yaml: Dynamic = {};

        obj.serial.Serial.toYaml();

        if (this.elements.length > 0) {
            var elements: Array<String> = [];
            for (elem in this.elements) {
                elements.push(Type.getClassName(Type.getClass(elem)));
            }
            yaml.elements = elements;
        }

        return yaml;
    }

    public function generateElements(): Array<CostumeElement>
    {
        var result: Array<CostumeElement> = [];

        for (elem in this.elements) {
            result.append(elem.generateElements());
        }

        return result;
    }
}
