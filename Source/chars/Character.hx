package chars;

import openfl.display.MovieClip;
import obj.Her;
import obj.AlphaRGBObject;
import obj.CostumeElement;

abstract class Character {
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
	public var collarFill:AlphaRGBObject;
	public var collarFill2:Null<AlphaRGBObject>;
	public var cuffs:UInt = 1;
	public var cuffsFill:AlphaRGBObject;
	public var headwear:String = "None";
	public var headwearFill:AlphaRGBObject;
	public var headwearFill2:AlphaRGBObject;
	public var earring:String = "None";
	public var earringFill:AlphaRGBObject;
	public var bodyScale:Float = 1.0;
	public var armPos:String = "Back";
	public var irisFill:AlphaRGBObject;
	public var eyebrowFill:AlphaRGBObject;
	public var eyebrowLine:AlphaRGBObject;
	public var scalpFill:AlphaRGBObject;
	public var lipstickFill:AlphaRGBObject;
	public var eyeShadow:AlphaRGBObject;
	public var sclera:AlphaRGBObject;
	public var blush:AlphaRGBObject;
	public var freckles:AlphaRGBObject;
	public var freckleAmount:Float = 0;
	public var mascara:ASObject;
	public var bg:UInt = 3;
	public var gag:String = "none";
	public var armwearFill:AlphaRGBObject;
	public var armwear:String = "none";
	public var legwearFill:AlphaRGBObject;
	public var legwear:String = "none";
	public var footwearFill:AlphaRGBObject;
	public var footwear:String = "none";
	public var pantiesFill:AlphaRGBObject;
	public var panties:String = "none";
	public var braFill:AlphaRGBObject;
	public var bra:String = "none";
	public var eyewear:String = "none";
	public var eyewearFill:AlphaRGBObject;
	public var dialogue:String = "";
	public var defaultCostume:String = "";
	public var altCostume:String = "";

	public function new() {
		this.collarFill = new AlphaRGBObject(1, 0, 0, 0);
		this.cuffsFill = new AlphaRGBObject(1, 0, 0, 0);
		this.irisFill = new AlphaRGBObject(1, 56, 100, 137);
		this.eyebrowFill = new AlphaRGBObject(1, 89, 67, 51);
		this.eyebrowLine = new AlphaRGBObject(0, 0, 0, 0);
		this.scalpFill = new AlphaRGBObject(1, 211, 158, 90);
		this.lipstickFill = new AlphaRGBObject(0, 0, 0, 0);
		this.eyeShadow = new AlphaRGBObject(1, 55, 26, 99);
		this.sclera = new AlphaRGBObject(1, 255, 255, 255);
		this.blush = new AlphaRGBObject(0.35, 196, 80, 77);
		this.freckles = new AlphaRGBObject(0.8, 60, 24, 24);
		this.mascara = new AlphaRGBObject(1, 0, 0, 0);
		this.armwearFill = new AlphaRGBObject(1, 0, 0, 0);
		this.legwearFill = new AlphaRGBObject(1, 0, 0, 0);
		this.footwearFill = new AlphaRGBObject(1, 0, 0, 0);
		this.pantiesFill = new AlphaRGBObject(1, 255, 255, 255);
		this.braFill = new AlphaRGBObject(1, 255, 255, 255);
		this.eyewearFill = new AlphaRGBObject(1, 0, 0, 0);
	}

	public function generateElements():Array<CostumeElement> {
		return [];
	}
}
