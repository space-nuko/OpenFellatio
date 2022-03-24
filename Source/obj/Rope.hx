package obj;

   import openfl.display.DisplayObjectContainer;
   import openfl.display.MovieClip;
   import openfl.events.Event;
   import openfl.geom.Point;
   import obj.Maths;

    class Rope extends CostumeElement
   {
      public var ropeGraphic:MovieClip;
      public var ropeLength:UInt = 0;
      public var segLength:Array<ASAny>;
      public var segNum:Float = 4;
      public var links:Array<ASAny>;
      public var segments:Array<ASAny>;
      public var widthEstimates:Array<ASAny>;
      public var mass:Float = 20;
      public var friction:Float = 0.9;
      public var damping:Float = 0.595;
      public var topLocked:Bool = false;
      public var topDamping:Float = Math.NaN;
      public var topRotationLocked:Bool = false;
      public var topRotationTarget:DisplayObjectContainer;
      public var subScaling:Point;
      public var lastAnchor:Point;
      public var impulse:Point;
      public var collisionImpulse:Point;
      public var gOffset:Float = Math.NaN;
      public var gravityDirection:Point;
      public var leftLimited:Bool = false;
      public var leftLimitedMultiplier:Float = 0;
      public var rightLimited:Bool = false;
      public var rightLimitedMultiplier:Float = 0;
      public var collisionImpulses:Array<ASAny>;
      public var leftLimit:UInt = 0;
      public var rightLimit:UInt = 0;
      public var hairCollisionTest:Bool = false;

      public function new(param1:MovieClip, param2:ASObject, param3:Point = null, param4:DisplayObjectContainer = null, param5:Float = 0, param6:String = "none", param7:UInt = 0, param8:UInt = 0, param9:UInt = 0, param10:Array<ASAny> = null)
      {
         var _loc14_:UInt = 0;
         var _loc15_:UInt = 0;
         var _loc16_= Math.NaN;
         var _loc17_:UInt = 0;
         var _loc18_:ASAny = /*undefined*/null;
         this.segLength = new Array<ASAny>();
         this.links = new Array<ASAny>();
         this.segments = new Array<ASAny>();
         this.widthEstimates = new Array<ASAny>();
         this.subScaling = new Point(1,1);
         this.impulse = new Point();
         this.collisionImpulse = new Point();
         this.gravityDirection = new Point();
         this.collisionImpulses = new Array<ASAny>();
         super();
         this.ropeGraphic = param1;
         this.ropeGraphic.x = 0;
         this.ropeGraphic.y = 0;
         this.ropeGraphic.scaleX = 1;
         this.ropeGraphic.scaleY = 1;
         this.ropeGraphic.alpha = 1;
         this.addChild(this.ropeGraphic);
         this.gOffset = param5;
         if(param6 == "left")
         {
            this.leftLimited = true;
         }
         else if(param6 == "right")
         {
            this.rightLimited = true;
         }
         else if(param6 == "both")
         {
            this.leftLimited = true;
            this.rightLimited = true;
         }
         this.leftLimit = param7;
         this.rightLimit = param8;
         var _loc11_= 180 + this.gOffset * (Math.PI / 180);
         this.gravityDirection = new Point(Math.sin(_loc11_) * 1.2,-Math.cos(_loc11_) * 1.2);
         if(param10 == null)
         {
            this.segLength = new Array<ASAny>();
            this.segments = new Array<ASAny>();
            this.ropeLength = this.ropeGraphic.numChildren;
            _loc14_ = 0;
            while(_loc14_ < this.ropeLength)
            {
               if(Std.is((_loc18_ = this.ropeGraphic.getChildAt(_loc14_)) , DisplayObjectContainer))
               {
                  this.segments.push(_loc18_);
               }
               _loc14_++;
            }
            ASCompat.ASArray.sortOn(this.segments, "y",ASCompat.ASArray.NUMERIC);
            this.ropeLength = this.segments.length;
            _loc15_ = 0;
            while(_loc15_ < this.ropeLength)
            {
               this.ropeGraphic.setChildIndex(this.segments[_loc15_],0);
               _loc15_++;
            }
            _loc16_ = 0;
            _loc17_ = 0;
            while(_loc17_ < this.ropeLength)
            {
               this.widthEstimates[_loc17_] = this.segments[_loc17_].width * 0.25;
               this.collisionImpulses[_loc17_] = new Point();
               if(_loc17_ < this.ropeLength - 1)
               {
                  this.segLength[_loc17_] = this.segments[_loc17_ + 1].y - this.segments[_loc17_].y;
               }
               else
               {
                  this.segLength[_loc17_] = this.segments[_loc17_].getBounds(this.ropeGraphic).bottom - this.segments[_loc17_].y;
               }
               _loc17_++;
            }
         }
         else
         {
            this.ropeLength = param9;
            this.segLength = param10;
         }
         if(param3 == null)
         {
            param3 = new Point(this.segments[0].x,this.segments[0].y);
         }
         this.anchorContainer = if (param4 != null) param4 else G.her;
         this.anchorPoint = param3;
         this.currentAnchor = G.sceneLayer.globalToLocal(this.anchorContainer.localToGlobal(this.anchorPoint));
         var _loc12_:Float = 0;
         this.links = new Array<ASAny>();
         this.links[0] = new RopeLink(this.currentAnchor.x,this.currentAnchor.y,this.friction,this.mass);
         var _loc13_:UInt = 1;
         while(_loc13_ < this.ropeLength + 1)
         {
            this.links[_loc13_] = new RopeLink(this.currentAnchor.x + (_loc12_ + this.segLength[_loc13_ - 1]) * this.gravityDirection.x,this.currentAnchor.y + (_loc12_ + this.segLength[_loc13_ - 1]) * this.gravityDirection.y,this.friction,this.mass);
            _loc12_ += this.segLength[_loc13_ - 1];
            _loc13_++;
         }
         this.addEventListener(Event.ENTER_FRAME,this.move,false,0,true);
         param2.addChild(this);
      }

      public function setScaling(param1:Float, param2:Float)
      {
         this.subScaling.x = param1;
         this.subScaling.y = param2;
         var _loc3_:UInt = 0;
         while(_loc3_ < this.ropeLength)
         {
            this.segments[_loc3_].scaleX = this.subScaling.x;
            this.segments[_loc3_].scaleY = this.subScaling.y;
            this.segLength[_loc3_] *= this.subScaling.y;
            _loc3_++;
         }
      }

      public function lockTop(param1:Float)
      {
         this.topLocked = true;
         this.topDamping = param1;
      }

      public function lockTopRotation(param1:DisplayObjectContainer = null)
      {
         this.topRotationLocked = true;
         this.topRotationTarget = if (param1 != null) param1 else G.her;
      }

      override public function kill()
      {
         this.removeEventListener(Event.ENTER_FRAME,this.move);
         this.parent.removeChild(this);
      }

      public function move(param1:Event)
      {
         var _loc3_= Math.NaN;
         var _loc4_= Math.NaN;
         var _loc7_:Point = null;
         var _loc2_= 180 + this.gOffset;
         _loc2_ *= Math.PI / 180;
         this.gravityDirection.x = Math.sin(_loc2_);
         this.gravityDirection.y = -Math.cos(_loc2_);
         this.lastAnchor = this.currentAnchor;
         this.currentAnchor = G.sceneLayer.globalToLocal(this.anchorContainer.localToGlobal(this.anchorPoint));
         this.impulse.x = (this.currentAnchor.x - this.lastAnchor.x) * (1 - this.damping);
         this.impulse.y = (this.currentAnchor.y - this.lastAnchor.y) * (1 - this.damping);
         if(this.topRotationLocked)
         {
            _loc7_ = this.topRotationTarget.transform.concatenatedMatrix.deltaTransformPoint(new Point(0,1));
         }
         this.links[0].x = this.currentAnchor.x;
         this.links[0].y = this.currentAnchor.y;
         var _loc5_:UInt = 1;
         while(_loc5_ < this.ropeLength + 1)
         {
            this.links[_loc5_].move(this.gravityDirection);
            if(this.topLocked && _loc5_ == 1)
            {
               this.links[_loc5_].x += (this.currentAnchor.x - this.lastAnchor.x) * (1 - this.topDamping * this.damping);
               this.links[_loc5_].y += (this.currentAnchor.y - this.lastAnchor.y) * (1 - this.topDamping * this.damping);
            }
            else
            {
               this.links[_loc5_].x += this.impulse.x;
               this.links[_loc5_].y += this.impulse.y;
            }
            if(this.topRotationLocked)
            {
               this.links[_loc5_].x += (this.links[_loc5_ - 1].x + _loc7_.x * this.segLength[_loc5_ - 1] - this.links[_loc5_].x) * 0.5 * (1 - _loc5_ / this.ropeLength);
               this.links[_loc5_].y += (this.links[_loc5_ - 1].y + _loc7_.y * this.segLength[_loc5_ - 1] - this.links[_loc5_].y) * 0.5 * (1 - _loc5_ / this.ropeLength);
            }
            _loc5_++;
         }
         var _loc6_= new Point();
         _loc5_ = 0;
         while(_loc5_ < this.ropeLength)
         {
            this.impulse.x = this.links[_loc5_].x - this.links[_loc5_ + 1].x;
            this.impulse.y = this.links[_loc5_].y - this.links[_loc5_ + 1].y;
            _loc3_ = Math.sqrt(this.impulse.x * this.impulse.x + this.impulse.y * this.impulse.y);
            this.impulse.x /= _loc3_;
            this.impulse.y /= _loc3_;
            _loc4_ = this.impulse.x / this.impulse.y;
            if(!this.hairCollisionTest)
            {
               if(this.leftLimited)
               {
                  if(_loc4_ < G.her.hairLimits[this.leftLimit])
                  {
                     this.impulse.x -= (_loc4_ - G.her.hairLimits[this.leftLimit]) * -this.impulse.y * 0.5;
                     this.impulse.y -= (_loc4_ - G.her.hairLimits[this.leftLimit]) * this.impulse.x * 0.5;
                  }
               }
               if(this.rightLimited)
               {
                  if(_loc4_ > G.her.hairLimits[this.rightLimit])
                  {
                     this.impulse.x -= (_loc4_ - G.her.hairLimits[this.rightLimit]) * -this.impulse.y * 0.5;
                     this.impulse.y -= (_loc4_ - G.her.hairLimits[this.rightLimit]) * this.impulse.x * 0.5;
                  }
               }
            }
            this.links[_loc5_ + 1].x += this.impulse.x * (_loc3_ - this.segLength[_loc5_]) * 0.825;
            this.links[_loc5_ + 1].y += this.impulse.y * (_loc3_ - this.segLength[_loc5_]) * 0.825;
            this.links[_loc5_].x -= this.impulse.x * (_loc3_ - this.segLength[_loc5_]) * 0.25;
            this.links[_loc5_].y -= this.impulse.y * (_loc3_ - this.segLength[_loc5_]) * 0.25;
            this.links[_loc5_].x += this.collisionImpulses[_loc5_].x;
            this.links[_loc5_].y += this.collisionImpulses[_loc5_].y;
            _loc5_++;
         }
         this.updateRopeGraphic();
      }

      public function updateRopeGraphic()
      {
         var _loc2_:Point = null;
         var _loc3_= Math.NaN;
         var _loc4_= Math.NaN;
         var _loc1_:UInt = 0;
         while(_loc1_ < this.ropeLength)
         {
            this.segments[_loc1_].x = this.links[_loc1_].x;
            this.segments[_loc1_].y = this.links[_loc1_].y;
            _loc2_ = new Point();
            _loc2_.x = this.links[_loc1_ + 1].x - this.links[_loc1_].x;
            _loc2_.y = this.links[_loc1_ + 1].y - this.links[_loc1_].y;
            _loc3_ = Math.sqrt(_loc2_.x * _loc2_.x + _loc2_.y * _loc2_.y);
            _loc4_ = Maths.getAngle(_loc2_.x,_loc2_.y) + 180;
            this.segments[_loc1_].rotation = _loc4_;
            this.segments[_loc1_].scaleY = _loc3_ / this.segLength[_loc1_];
            _loc1_++;
         }
      }
   }
