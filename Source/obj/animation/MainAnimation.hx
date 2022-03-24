package obj.animation;

import openfl.geom.Matrix;
import openfl.geom.Point;
import obj.Maths;

class MainAnimation {
	public var herTween:LinearTween;
	public var herKneeTarget:Point;
	public var altVector:Point;
	public var altRange:Float = Math.NaN;
	public var torsoMinAng:Float = Math.NaN;
	public var torsoStartAng:Float = Math.NaN;
	public var torsoAngMultiplier:Float = Math.NaN;
	public var torsoMinDist:Float = Math.NaN;
	public var torsoStartDist:Float = Math.NaN;
	public var torsoDistMultiplier:Float = Math.NaN;
	public var hisTween:LinearTween;
	public var hisLeftFootTarget:Point;
	public var hisRightFootTarget:Point;
	public var posScaling:ASFunction;
	public var tipPosEstimate:Float = 0.15;
	public var penisLength:Float = -1;

	public function new() {
		getHerMatrix = getHerMatrix_l;
		getHisMatrix = getHisMatrix_l;
		noScaling = noScaling_l;
		this.posScaling = this.noScaling;
	}

	public function getHerMatrix_l(param1:Float, param2:Float):Matrix {
		param1 = this.posScaling(param1);
		var _loc3_:Matrix = this.herTween.tween(param1);
		var _loc4_:Point;
		(_loc4_ = new Point()).x = this.altVector.x * this.altRange * param2;
		_loc4_.y = this.altVector.y * this.altRange * param2;
		_loc3_.translate(_loc4_.x, _loc4_.y);
		return _loc3_;
	}

	public function getHisMatrix_l(param1:Float):Matrix {
		param1 = this.posScaling(param1);
		return this.hisTween.tween(param1);
	}

	@:flash.property public var estimateTipPos(get, never):Float;

	function get_estimateTipPos():Float {
		var _loc1_ = Math.NaN;
		var _loc2_ = Math.NaN;
		var _loc3_ = Math.NaN;
		var _loc4_:Point = null;
		var _loc5_:Point = null;
		var _loc6_ = Math.NaN;
		if (this.penisLength != g.him.currentPenisLength) {
			_loc6_ = g.him.currentPenisLength;
			_loc1_ = this.herTween.translationLength;
			_loc2_ = this.hisTween.translationLength;
			_loc3_ = _loc1_ + _loc2_;
			_loc4_ = g.sceneLayer.globalToLocal(g.him.getPenisTipPoint());
			_loc5_ = g.sceneLayer.globalToLocal(g.him.getPenisBasePoint());
			_loc6_ = (_loc6_ = Maths.vectorLength(new Point(_loc4_.x - _loc5_.x, _loc4_.y - _loc5_.x))) - 65;
			this.tipPosEstimate = (_loc3_ - _loc6_) / _loc3_;
		}
		return this.tipPosEstimate;
	}

	public function noScaling_l(param1:Float):Float {
		return param1;
	}
}
