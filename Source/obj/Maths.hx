package obj;
import openfl.geom.Point;

class Maths
{
   public static function getCMFMatrix(param1:Float, param2:Float, param3:Float, param4:Float) : Array<Float>
   {
        var _loc5_ = param3 * param2 * Math.cos(param1 * Math.PI / 180);
        var _loc6_ = param3 * param2 * Math.sin(param1 * Math.PI / 180);
        var _loc7_ = (0.299 * param3 + 0.701 * _loc5_ + 0.168 * _loc6_) * param4;
        var _loc8_ = (0.587 * param3 - 0.587 * _loc5_ + 0.33 * _loc6_) * param4;
        var _loc9_ = (0.114 * param3 - 0.114 * _loc5_ - 0.497 * _loc6_) * param4;
        var _loc10_ = (0.299 * param3 - 0.299 * _loc5_ - 0.328 * _loc6_) * param4;
        var _loc11_ = (0.587 * param3 + 0.413 * _loc5_ + 0.035 * _loc6_) * param4;
        var _loc12_ = (0.114 * param3 - 0.114 * _loc5_ + 0.292 * _loc6_) * param4;
        var _loc13_ = (0.299 * param3 - 0.3 * _loc5_ + 1.25 * _loc6_) * param4;
        var _loc14_ = (0.587 * param3 - 0.588 * _loc5_ - 1.05 * _loc6_) * param4;
        var _loc15_ = (0.114 * param3 + 0.886 * _loc5_ - 0.203 * _loc6_) * param4;
        var m:Array<Float> = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
        m[0] = _loc7_;
        m[1] = _loc8_;
        m[2] = _loc9_;
        m[5] = _loc10_;
        m[6] = _loc11_;
        m[7] = _loc12_;
        m[10] = _loc13_;
        m[11] = _loc14_;
        m[12] = _loc15_;
        var _loc17_ = 128 - param4 * 128;
        m[4] = _loc17_;
        m[9] = _loc17_;
        m[14] = _loc17_;
        return m;
    }

   public static function getUnitVector(param1:Float) : Point
   {
      return new Point(Math.sin(param1),-Math.cos(param1));
   }

   public static function getVector(param1:Float, param2:Float) : Point
   {
      return new Point(Math.sin(param2) * param1,-Math.cos(param2) * param1);
   }

   public static function getAngle(param1:Float, param2:Float) : Float
   {
      return radToDeg(Math.atan2(param2,param1)) + 90;
   }

   public static function getRadAngle(param1:Float, param2:Float) : Float
   {
      return Math.atan2(param2,param1) + Math.PI * 0.5;
   }

   public static function getDist(param1:Float, param2:Float) : Float
   {
      return Math.sqrt(param1 * param1 + param2 * param2);
   }

   public static function degToRad(param1:Float) : Float
   {
      return param1 / 180 * Math.PI;
   }

   public static function radToDeg(param1:Float) : Float
   {
      return param1 / Math.PI * 180;
   }

   public static function angleDiff(param1:Float, param2:Float) : Float
   {
      var _loc3_= param1 - param2;
      if(_loc3_ < -180)
      {
         _loc3_ += 360;
      }
      else if(_loc3_ > 180)
      {
         _loc3_ -= 360;
      }
      return _loc3_;
   }

   public static function normaliseAngle(param1:Float) : Float
   {
      while(param1 >= 180)
      {
         param1 -= 360;
      }
      while(param1 <= -180)
      {
         param1 += 180;
      }
      return param1;
   }

   public static function cross(param1:Point, param2:Point) : Float
   {
      return param1.x * param2.y - param1.y * param2.x;
   }

   public static function dot(param1:Point, param2:Point) : Float
   {
      return param1.x * param2.x + param1.y * param2.y;
   }

   public static function vectorLength(param1:Point) : Float
   {
      return Math.sqrt(param1.x * param1.x + param1.y * param1.y);
   }

   public static function sigRound(param1:UInt, param2:Float) : Float
   {
      param2 *= Math.pow(10,param1);
      param2 = Math.fround(param2);
      return param2 / Math.pow(10,param1);
   }

   public static function intersect(param1:Line, param2:Line) : ASObject
   {
      var _loc4_= Math.NaN;
      var _loc5_= Math.NaN;
      var _loc6_= false;
      var _loc7_= false;
      var _loc3_:ASAny = param1.A * param2.B - param2.A * param1.B;
      if(_loc3_ == 0)
      {
         return {"intersect":false};
      }
      _loc4_ = (param2.B * param1.C - param1.B * param2.C) / _loc3_;
      _loc5_ = (param1.A * param2.C - param2.A * param1.C) / _loc3_;
      _loc6_ = false;
      _loc7_ = false;
      if(_loc4_ >= Math.min(param1.x1,param1.x2) && _loc4_ < Math.max(param1.x1,param1.x2))
      {
         _loc6_ = true;
      }
      else if(_loc5_ >= Math.min(param1.y1,param1.y2) && _loc5_ < Math.max(param1.y1,param1.y2))
      {
         _loc6_ = true;
      }
      if(_loc4_ >= Math.min(param2.x1,param2.x2) && _loc4_ < Math.max(param2.x1,param2.x2))
      {
         _loc7_ = true;
      }
      else if(_loc5_ >= Math.min(param2.y1,param2.y2) && _loc5_ < Math.max(param2.y1,param2.y2))
      {
         _loc7_ = true;
      }
      return {
         "intersect":true,
         "d":_loc3_,
         "x":_loc4_,
         "y":_loc5_,
         "onLine1":_loc6_,
         "onLine2":_loc7_
      };
   }

   public static function pointDot(param1:Point, param2:Point, param3:Point) : Float
   {
      var _loc4_= new Point(param2.x - param1.x,param2.y - param1.y);
      var _loc5_= new Point(param3.x - param1.x,param3.y - param1.y);
      return dot(_loc4_,_loc5_);
   }

   public static function normal(param1:Point, param2:Point, param3:Point) : Point
   {
      var _loc4_= new Point(param2.x - param1.x,param2.y - param1.y);
      var _loc5_= new Point(param3.x - param1.x,param3.y - param1.y);
      var _loc6_= dot(_loc4_,_loc5_) / (_loc4_.x * _loc4_.x + _loc4_.y * _loc4_.y);
      return new Point(param1.x + _loc4_.x * _loc6_,param1.y + _loc4_.y * _loc6_);
   }

   public static function mirrorPoint(param1:Point, param2:Point, param3:Point) : Point
   {
      var _loc4_:Point = normal(param1,param2,param3);
      var _loc5_= param3.x - _loc4_.x;
      var _loc6_= param3.y - _loc4_.y;
      return new Point(_loc4_.x - _loc5_,_loc4_.y - _loc6_);
   }

   public static function generateEdges(param1:Array<Point>) : Array<Line>
   {
      var startPos:Point = null;
      var endPos:Point = null;
      var result= new Array<Line>();
      var pointCount:UInt = param1.length;
      var i:UInt = 0;
      while(i < pointCount)
      {
         startPos = new Point(param1[i].x,param1[i].y);
         if(i == pointCount - 1)
         {
            endPos = new Point(param1[0].x,param1[0].y);
         }
         else
         {
            endPos = new Point(param1[i + 1].x,param1[i + 1].y);
         }
         result[i] = new Line(startPos,endPos);
         i++;
      }
      return result;
   }

	public static inline function clamp(v: Int, min: Int, max: Int): Int {
		return Std.int(Math.min(max, Math.max(min, v)));
	}

	public static inline function clampf(v: Float, min: Float, max: Float): Float {
		return Math.min(max, Math.max(min, v));
	}
}
