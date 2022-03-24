package obj.her;

import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.display.MovieClip;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.filters.ColorMatrixFilter;
import obj.CharacterControl;
// import obj.Slider;

 class Tan
{
   public var _standardTanItems:Array<DisplayObject>;
   public var _multiPartTanItems:Array<DisplayObject>;
   public var _skinAlphaScaling:ASDictionary<String, Float>;
   public var _tanNameList:Array<String> = ["None","Full","Bikini","Swimsuit","Swimsuit-T"];
   public var _currentTanID:UInt = 0;
   public var _preModTanID:UInt = 0;
   public var _currentAlphaScaling:Float = 1;
   public var _currentTanAlpha:Float = 0;
   public var _menuList:Sprite;
   // public var _alphaSlider:Slider;

   public function new()
   {
      // super();
      this.prepItems();
      this.prepScalingDictionary();
   }

   public function registerMenuItems(param1:Sprite, param2:Slider)
   {
      this._menuList = param1;
      // (this._menuList : ASAny)["leftArrow"].addEventListener(MouseEvent.CLICK,this.tanLeftClicked);
      // (this._menuList : ASAny)["rightArrow"].addEventListener(MouseEvent.CLICK,this.tanRightClicked);
      this._alphaSlider = param2;
      this._alphaSlider.setRangeEnd(119);
      this._alphaSlider.addEventListener("handleReleased",this.alphaSliderReleased);
      this._alphaSlider.addEventListener("sliderChanged",this.alphaSliderChanged);
      this.updateMenuList();
      this.updateAlphaSlider();
   }

   public function updateSkin(param1:String = "")
   {
      if(ASCompat.stringAsBool(param1))
      {
         this._currentAlphaScaling = ASCompat.thisOrDefault(ASCompat.toNumber(this._skinAlphaScaling[param1]) , 0);
      }
      this.setTan();
   }

   public function hideForMods()
   {
      this.setTan(0,false);
   }

   public function getDataString() : String
   {
      return "herTan:" + G.dataName(this._tanNameList[this._currentTanID]) + "," + this._currentTanAlpha;
   }

   public function loadDataPairs(csvPairs:Array<String>)
   {
      var _loc3_:Array<String> = null;
      var _loc4_:Array<String> = null;
      var _loc5_= Math.NaN;
      var _loc2_= false;
      for (_tmp_ in csvPairs)
      {
          c3_  = _tmp_;
         switch(_loc3_[0])
         {
            case "herTan":
               if((_loc4_ = _loc3_[1].split(",")).length == 2)
               {
                  CharacterControl.findName(_loc4_[0],this._tanNameList,this.setTan);
                  this.updateMenuList();
                  _loc5_ = ASCompat.toNumber(_loc4_[1]);
                  if(!Math.isNaN(_loc5_))
                  {
                     this.setTanAlpha(Math.max(0,Math.min(1,_loc5_)));
                     this.updateAlphaSlider();
                  }
                  _loc2_ = true;
               }

         }
      }
      if(!_loc2_)
      {
         this.setTan(0);
      }
   }

   public function setTan(param1:Int = -1, param2:Bool = true)
   {
      var _loc3_:DisplayObjectContainer = null;
      if(param1 != -1 && param2)
      {
         this._currentTanID = param1;
      }
      for (_tmp_ in this._standardTanItems)
      {
c3_  = _tmp_;
         if((_loc3_ : ASAny)["tan"])
         {
            CharacterControl.tryToSetFrameLabel(ASCompat.dynamicAs((_loc3_ : ASAny)["tan"] , MovieClip),this._tanNameList[this._currentTanID]);
            if(this._currentTanID == 0)
            {
               (_loc3_ : ASAny)["tan"].visible = false;
            }
            else
            {
               (_loc3_ : ASAny)["tan"].visible = true;
            }
         }
      }
      if(this._currentTanID == 0)
      {
         // G.her.ear.tan.visible = false;
      }
      else
      {
         // G.her.ear.tan.visible = true;
      }
      for (_tmp_ in this._multiPartTanItems)
      {
c3_  = _tmp_;
         if(this._currentTanID == 0)
         {
            _loc3_.visible = false;
         }
         else
         {
            _loc3_.visible = true;
         }
      }
      G.characterControl.setBreasts();
      this.setTanAlpha();
      this.updateMenuList();
   }

   public function setTanAlpha(param1:Float = -1)
   {
      var _loc4_:DisplayObjectContainer = null;
      if(param1 != -1)
      {
         this._currentTanAlpha = param1;
      }
      var _loc2_= this._currentTanAlpha * this._currentAlphaScaling;
      var _loc3_= new ColorMatrixFilter([1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,_loc2_,0]);
      for (_tmp_ in this._standardTanItems)
      {
c4_  = _tmp_;
         if((_loc4_ : ASAny)["tan"])
         {
            if(_loc2_ > 0 && this._currentTanID != 0)
            {
               (_loc4_ : ASAny)["tan"].visible = true;
               (_loc4_ : ASAny)["tan"].alpha = _loc2_;
            }
            else
            {
               (_loc4_ : ASAny)["tan"].visible = false;
            }
         }
      }
      // G.her.ear.tan.alpha = _loc2_;
      for (_tmp_ in this._multiPartTanItems)
      {
c4_  = _tmp_;
         if(_loc2_ > 0 && this._currentTanID != 0)
         {
            _loc4_.filters = [_loc3_];
            _loc4_.visible = true;
         }
         else
         {
            _loc4_.filters = [];
            _loc4_.visible = false;
         }
      }
   }

   public function tanLeftClicked(param1:MouseEvent)
   {
      var _loc2_:UInt = Std.int(Math.max(0,Math.min(this._tanNameList.length - 1,this._currentTanID - 1)));
      this.setTan(_loc2_);
      G.saveData.saveCharData();
   }

   public function tanRightClicked(param1:MouseEvent)
   {
      var _loc2_:UInt = Std.int(Math.max(0,Math.min(this._tanNameList.length - 1,this._currentTanID + 1)));
      this.setTan(_loc2_);
      G.saveData.saveCharData();
   }

   public function updateMenuList()
   {
      if(this._menuList != null)
      {
         (this._menuList : ASAny)["itemLabel"]["text"] = this._tanNameList[this._currentTanID];
      }
   }

   public function alphaSliderReleased(param1:Event)
   {
      G.saveData.saveCharData();
   }

   public function alphaSliderChanged(param1:Event)
   {
      this.setTanAlpha(this._alphaSlider.currentValue(100) * 0.01);
   }

   public function updateAlphaSlider()
   {
      if(this._alphaSlider != null)
      {
         this._alphaSlider.setPos(this._currentTanAlpha);
      }
   }

   public function prepItems()
   {
      this._standardTanItems = new Array<DisplayObject>();
      this._standardTanItems.push(G.her.leftLegContainer.leg.calf);
      this._standardTanItems.push(G.her.leftLegContainer.leg.thigh);
      this._standardTanItems.push(G.her.torsoBack.leftShoulder);
      this._standardTanItems.push(G.her.torsoBack.chestBack);
      this._standardTanItems.push(G.her.torsoBack.leftBreast);
      this._standardTanItems.push(G.her.torsoBack.leftBreast.nipple);
      this._standardTanItems.push(G.her.eye.eyebrowUnderMask);
      this._standardTanItems.push(G.her.torso.midLayer.chest);
      this._standardTanItems.push(G.her.torso.midLayer.rightBreast);
      this._standardTanItems.push(G.her.torso.midLayer.rightBreast.nipple);
      this._standardTanItems.push(G.her.torso.midLayer.leftArm);
      this._standardTanItems.push(G.her.torso.behindBackRightArm);
      this._standardTanItems.push(G.her.torso.leg.thigh);
      this._standardTanItems.push(G.her.torso.back);
      this._standardTanItems.push(G.her.torso.rightCalfContainer.calf);
      this._standardTanItems.push(G.her.rightArmContainer.upperArm);
      this._standardTanItems.push(G.her.rightForeArmContainer.upperArm.foreArm.hand);
      this._standardTanItems.push(G.her.rightForeArmContainer.upperArm.foreArm);
      this._standardTanItems.push(G.her.leftArmContainer.upperArm.foreArm.hand);
      this._standardTanItems.push(G.her.leftArmContainer.upperArm.foreArm);
      this._standardTanItems.push(G.her.leftArmContainer.upperArm);
      this._standardTanItems.push(G.her.leftHandOver.hand.grip);
      this._standardTanItems.push(G.her.head.neck);
      this._standardTanItems.push(G.her.torsoBack.backside);
      this._standardTanItems.push(G.her.torso.backside);
      G.her.torso.back.tan.blendMode = "overlay";
      this._multiPartTanItems = new Array();
      this._multiPartTanItems.push(G.her.head.headTan);
   }

   public function prepScalingDictionary()
   {
      this._skinAlphaScaling = new ASDictionary<String, Float>();
      this._skinAlphaScaling[SkinPalette.LIGHT_SKIN] = 0.995;
      this._skinAlphaScaling[SkinPalette.PALE_SKIN] = 0.995;
      this._skinAlphaScaling[SkinPalette.TAN_SKIN] = 0.6;
      this._skinAlphaScaling[SkinPalette.DARK_SKIN] = 0.5;
   }
}
