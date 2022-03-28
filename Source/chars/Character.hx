package chars;

import openfl.display.MovieClip;
import obj.Her;
import obj.AlphaRGBObject;
import obj.CostumeElement;
import openfl.Assets;
import yaml.util.ObjectMap;
import yaml.Yaml;
using ArrayTools;

class Character {
	public var charName:String = "xxx";
	public var charShortName:String = "xxx";
	public var mood:String = Her.NORMAL_MOOD;
	public var skinType:UInt = 0;
	public var noseType:UInt = 0;
	public var eyebrowType:UInt = 0;
	public var earType:String = "normal";
	public var iris:String = "normal";
	public var breastSize:UInt = 70;
	public var hairTop:String = "SDChan";
	public var hairUnder:String = "SDChan";
	public var hairBack:String = "SDChan";
	public var hairBottom:String = "SDChan";
	public var costume:String = "SDChan";
	public var collar:UInt = 1;
	public var collarFill:AlphaRGBObject = new AlphaRGBObject(1, 0, 0, 0);
	public var collarFill2:Null<AlphaRGBObject>;
	public var cuffs:UInt = 1;
	public var cuffsFill:AlphaRGBObject = new AlphaRGBObject(1, 0, 0, 0);
	public var headwear:String = "None";
	public var headwearFill:AlphaRGBObject;
	public var headwearFill2:AlphaRGBObject;
	public var earring:String = "None";
	public var earringFill:AlphaRGBObject;
	public var bodyScale:Float = 1.0;
	public var armPos:String = "Back";
	public var irisFill:AlphaRGBObject = new AlphaRGBObject(1, 56, 100, 137);
	public var eyebrowFill:AlphaRGBObject = new AlphaRGBObject(1, 89, 67, 51);
	public var eyebrowLine:AlphaRGBObject = new AlphaRGBObject(0, 0, 0, 0);
	public var scalpFill:AlphaRGBObject = new AlphaRGBObject(1, 211, 158, 90);
	public var lipstickFill:AlphaRGBObject = new AlphaRGBObject(0, 0, 0, 0);
	public var eyeShadow:AlphaRGBObject = new AlphaRGBObject(1, 55, 26, 99);
	public var sclera:AlphaRGBObject = new AlphaRGBObject(1, 255, 255, 255);
	public var blush:AlphaRGBObject = new AlphaRGBObject(0.35, 196, 80, 77);
	public var freckles:AlphaRGBObject = new AlphaRGBObject(0.8, 60, 24, 24);
	public var freckleAmount:Float = 0;
	public var mascara:AlphaRGBObject = new AlphaRGBObject(1, 0, 0, 0);
	public var bg:UInt = 3;
	public var gag:String = "None";
	public var armwearFill:AlphaRGBObject = new AlphaRGBObject(1, 0, 0, 0);
	public var armwear:String = "None";
	public var legwearFill:AlphaRGBObject = new AlphaRGBObject(1, 0, 0, 0);
	public var legwear:String = "None";
	public var footwearFill:AlphaRGBObject = new AlphaRGBObject(1, 0, 0, 0);
	public var footwear:String = "None";
	public var pantiesFill:AlphaRGBObject = new AlphaRGBObject(1, 255, 255, 255);
	public var panties:String = "None";
	public var braFill:AlphaRGBObject = new AlphaRGBObject(1, 255, 255, 255);
	public var bra:String = "None";
	public var eyewear:String = "None";
	public var eyewearFill:AlphaRGBObject = new AlphaRGBObject(1, 0, 0, 0);
	public var defaultCostume:String = "";
	public var altCostume:String = "";

    // TODO: elements are defined separately, then this list will hold their IDs
    @:nosave public var elements: Array<CharacterElement> = [];

    public var ordering: Int = 0;
    public var extraData: Null<Dynamic>;

    // TODO
    // @:nosave public var dialogue: Map<String, Array<String>>;
    @:nosave public var dialogue: String = "";

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

        this.elements.resize(0);

        if (yaml.exists("elements")) {
            var types = cast(yaml.get("elements"), Array<Dynamic>);

            for (v in types) {
                var klassName = cast(v, String);

                try {
                    var klass = Type.resolveClass(klassName);
                    var value = Type.createInstance(klass, []);

                    if (Std.isOfType(value, CharacterElement)) {
                        this.elements.push(cast(value, CharacterElement));
                    } else {
                        throw "Type " + klassName + " is not a subclass of CharacterElement";
                    }
                } catch (e) {
                    throw "Could not instantiate type " + klassName + ": " + e;
                }
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
