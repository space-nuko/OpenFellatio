package obj;

import openfl.display.DisplayObject;
import openfl.geom.Point;

class InterPoints {
	public var inside:Point;
	public var outside:Point;

	public function new(_inside:Point, _outside:Point) {
		inside = _inside;
		outside = _outside;
	}
}

class StrandLink extends Point {
	public var speed:Point;
	public var mass:Float = Math.NaN;
	public var density:Float = Math.NaN;
	public var minMass:Float = 0.01;
	public var minDensity:Float = 0.2;
	public var anchorAge:UInt = 0;
	public var collisionFree:UInt = 0;
	public var onEye:Bool = false;
	public var anchorObject:AnchorProp = new AnchorProp();
	public var anchored:Bool = false;
	public var anchorDelay:Int = 0;
	public var isJustAnchored:Bool = false;
	public var sourceLink:Bool = false;
	public var onTongue:Bool = false;
	public var freed:Bool = false;
	public var globalAnchorPoint:Point;
	public var slideOnAnchor:Bool = false;
	public var anchorSliding:Bool = false;
	public var anchorSlideCounter:UInt = 0;
	public var anchorSlideMax:UInt = 45;
	public var smearCounter:UInt = 0;
	public var maxSmear:UInt = 150;
	public var storedInterPoints:InterPoints;
	public var hasStoredInterPoints:Bool = false;
	public var generateMass:Bool = false;
	public var neighbour1:StrandLink;
	public var neighbour2:StrandLink;
	public var neighbourVec:Point = new Point();
	public var neighbourAng:Float = Math.NaN;
	public var flowMult:Float = Math.NaN;
	public var isExpanded:Bool = false;

	public function new(param1:Float, param2:Float, param3:Point = null, param4:UInt = 0, param5:Bool = false) {
		super();
		param1 = Math.max(this.minMass, param1);
		this.mass = param1;
		this.density = param2;
		this.slideOnAnchor = param5;
		this.generateMass = false;
		if (param3 == null) {
			param3 = new Point(0, 0);
		}
		this.speed = param3.clone();
		this.collisionFree = param4;
		this.anchorAge = 0;
	}

	@:flash.property public var anchorContainer(get, never):DisplayObject;

	function get_anchorContainer():DisplayObject {
		return this.anchorObject != null ? this.anchorObject.container : null;
	}

	@:flash.property public var anchor(get, never):Point;

	function get_anchor():Point {
		return this.anchorObject != null ? this.anchorObject.localPoint : null;
	}

	@:flash.property public var globalAnchor(get, never):Point;

	function get_globalAnchor():Point {
		if (this.globalAnchorPoint == null) {
			this.globalAnchorPoint = this.anchorObject.container.localToGlobal(this.anchorObject.localPoint);
		}
		return this.globalAnchorPoint;
	}

	public function clearGlobalAnchor() {
		this.globalAnchorPoint = null;
	}

	public function anchorTo(param1:AnchorProp, param2:Bool = false, param3:Bool = true, param4:Int = -1) {
		if (this.anchored) {
			this.detachAnchor(false, param3);
		}
		if (param1.eyeHit) {
			this.onEye = true;
		}
		this.anchorObject = param1;
		this.anchorAge = 0;
		this.anchored = true;
		if (this.slideOnAnchor) {
			this.speed.x *= 0.7;
			this.speed.y *= 0.7;
			if (param4 == -1) {
				this.anchorSlideCounter = Math.floor(Math.random() * this.anchorSlideMax);
			} else {
				param4 = this.anchorSlideCounter;
			}
			this.anchorSliding = true;
		} else {
			this.speed.x = 0;
			this.speed.y = 0;
		}
		this.isJustAnchored = true;
		this.sourceLink = param2;
		this.freed = false;
		// if(this.anchorObject.container == G.her.tongueContainer.tongue.tipPoint)
		// {
		//    this.onTongue = true;
		//    this.speed.x *= 0.5;
		//    this.speed.y *= 0.5;
		//    this.anchorSlideCounter += int(this.anchorSlideMax - this.anchorSlideCounter) * 0.5;
		// }
		if (this.anchorObject.container == G.sceneLayer) {
			if (this.neighbour1 != null) {
				this.neighbour1.neighbourHitFloor();
			}
			if (this.neighbour2 != null) {
				this.neighbour2.neighbourHitFloor();
			}
		}
	}

	public function neighbourHitFloor() {
		this.speed.y *= 0.2;
		this.speed.x += Math.random() * 20 - 10;
	}

	public function smear(param1:Point, param2:Float = 25):Bool {
		var _loc3_ = Math.NaN;
		var _loc4_:Point = null;
		var _loc5_ = Math.NaN;
		var _loc6_:DisplayObject = null;
		var _loc7_ = Math.NaN;
		var _loc8_:Point = null;
		if (this.anchored) {
			_loc3_ = param2 * param2;
			(_loc4_ = new Point()).x = this.globalAnchor.x - param1.x;
			_loc4_.y = this.globalAnchor.y - param1.y;
			if ((_loc5_ = Math.max(2, _loc4_.x * _loc4_.x + _loc4_.y * _loc4_.y)) < _loc3_) {
				++this.smearCounter;
				this.mass = Math.max(this.minMass, this.mass - 0.05);
				this.density = Math.max(0.05, this.density - 0.05);
				if (this.smearCounter < this.maxSmear) {
					_loc6_ = this.anchorObject.container;
					_loc7_ = Math.max(0, Math.min(0.1, (_loc3_ - _loc5_) / _loc3_)) * (1 - this.smearCounter / this.maxSmear);

					if (!G.smudgeCache.exists(_loc6_)) {
						G.smudgeCache[_loc6_] = new CachedSmudge();
					}
                    var smudge = G.smudgeCache[_loc6_];
					if (!smudge.updated) {
						smudge.localPoint = _loc6_.globalToLocal(param1);
						if (smudge.lastPoint == null) {
							smudge.lastPoint = smudge.localPoint;
						}
						smudge.localVector = new Point(smudge.localPoint.x - smudge.lastPoint.x,
							smudge.localPoint.y - smudge.lastPoint.y);
						smudge.updated = true;
					}

					_loc8_ = smudge.localVector;
					this.anchorObject.localPoint.x += _loc8_.x * _loc7_;
					this.anchorObject.localPoint.y += _loc8_.y * _loc7_;
					this.recheckAnchor();
					return true;
				}
			}
		}
		return false;
	}

	public function recheckAnchor() {
		// if(this.anchorObject.hitTarget != G.sceneLayer)
		// {
		//    if(!this.anchorObject.hitTarget.hitTestPoint(this.globalAnchor.x,this.globalAnchor.y,true))
		//    {
		//       if(this.anchorObject.hitTarget == G.her.head.face)
		//       {
		//          if(G.her.head.jaw.hitTestPoint(this.globalAnchor.x,this.globalAnchor.y,true))
		//          {
		//             this.anchorObject.localPoint = G.her.head.jaw.globalToLocal(this.globalAnchor);
		//             this.anchorObject.setContainer(G.her.head.jaw);
		//             return;
		//          }
		//       }
		//       if(this.anchorObject.hitTarget == G.her.head.jaw)
		//       {
		//          if(G.her.head.face.hitTestPoint(this.globalAnchor.x,this.globalAnchor.y,true))
		//          {
		//             this.anchorObject.localPoint = G.her.head.face.globalToLocal(this.globalAnchor);
		//             this.anchorObject.setContainer(G.her.head.face);
		//             return;
		//          }
		//       }
		//       if(this.onEye)
		//       {
		//          if(!G.her.eye.hitBox.hitTestPoint(this.globalAnchor.x,this.globalAnchor.y,true))
		//          {
		//             G.her.eyeClearHit();
		//          }
		//       }
		//       this.detachAnchor(false);
		//    }
		// }
	}

	public function tryToAnchorTo(param1:AnchorProp):Bool {
		if (this.anchorDelay > 0) {
			--this.anchorDelay;
			return false;
		}
		this.anchorTo(param1);
		return true;
	}

	public function detachAnchor(param1:Bool = true, param2:Bool = true) {
		if (this.anchored) {
			this.anchored = false;
			this.isJustAnchored = false;
			this.anchorSliding = false;
			this.unstoreInterPoints();
			if (param1) {
				this.freed = true;
			} else if (param2) {
				this.anchorDelay = 2;
			}
		}
	}

	@:flash.property public var justAnchored(get, never):Bool;

	function get_justAnchored():Bool {
		if (this.isJustAnchored) {
			this.isJustAnchored = false;
			return true;
		}
		return false;
	}

	@:flash.property public var anchorable(get, never):Bool;

	function get_anchorable():Bool {
		if (!this.anchored && !this.freed && this.collisionFree == 0) {
			return true;
		}
		if (this.anchored && (this.anchorObject.container == G.him || this.anchorObject.container == G.him.penis) && !this.sourceLink) {
			return true;
		}
		return false;
	}

	public function storeInterPoints(param1:ASObject) {
		this.storedInterPoints = new InterPoints(new Point(), new Point());
		this.storedInterPoints.inside = this.anchorObject.container.globalToLocal(G.sceneLayer.localToGlobal(param1.inside.clone()));
		this.storedInterPoints.outside = this.anchorObject.container.globalToLocal(G.sceneLayer.localToGlobal(param1.outside.clone()));
		this.hasStoredInterPoints = true;
	}

	public function getStoredInterPoints():ASObject {
		var _loc1_ = G.sceneLayer.globalToLocal(this.anchorObject.container.localToGlobal(this.storedInterPoints.inside));
		var _loc2_ = G.sceneLayer.globalToLocal(this.anchorObject.container.localToGlobal(this.storedInterPoints.outside));
		return new InterPoints(_loc1_, _loc2_);
	}

	public function unstoreInterPoints() {
		this.storedInterPoints = null;
		this.hasStoredInterPoints = false;
	}

	public function accelerate(param1:Float, param2:Float) {
		var _loc3_ = Math.NaN;
		if (!this.anchored) {
			if (this.anchorSliding) {
				_loc3_ = 0.5 - 0.5 * this.anchorSlideCounter / this.anchorSlideMax;
				param1 *= _loc3_;
				param2 *= _loc3_;
			}
			this.speed.x += param1;
			this.speed.y += param2;
		}
	}

	public function move(param1:Float) {
		if (!this.anchored || this.anchorSliding) {
			this.x += this.speed.x;
			this.y += this.speed.y;
			this.speed.x /= param1;
			this.speed.y /= param1;
		}
	}

	public function setNeighbours(param1:StrandLink, param2:StrandLink = null) {
		this.neighbour1 = param1;
		this.neighbour2 = param2;
	}

	public function giveMass(param1:ASAny):Float {
		if (this.anchored) {
			return 0;
		}
		this.mass += param1;
		return param1;
	}

	public function giveDensity(param1:Float, param2:Float = 1):Float {
		var _loc3_ = Math.min(1 - this.density, Math.min(Math.max(0.05, param1 * 0.1), param1 - this.minDensity) * param2);
		this.density += _loc3_;
		return _loc3_;
	}

	public function halveMass() {
		this.mass = Math.max(this.minMass, this.mass * 0.5);
	}

	public function massGenerator() {
		this.generateMass = true;
	}

	public function cloneLink():StrandLink {
		var _loc1_ = new StrandLink(this.mass, this.density, this.speed.clone(), this.collisionFree);
		if (this.anchored) {
			_loc1_.anchorTo(this.anchorObject.clone(), false, false, this.anchorSlideCounter);
			_loc1_.anchorAge = this.anchorAge;
			_loc1_.anchorDelay = this.anchorDelay;
			_loc1_.onTongue = this.onTongue;
		}
		if (this.hasStoredInterPoints) {
			_loc1_.storedInterPoints = new InterPoints(this.storedInterPoints.inside, this.storedInterPoints.outside);
		}
		_loc1_.generateMass = this.generateMass;
		_loc1_.isExpanded = this.isExpanded;
		_loc1_.x = this.x;
		_loc1_.y = this.y;
		return _loc1_;
	}

	public function tick(param1:Float) {
		var _loc2_:Point = null;
		if (this.anchored) {
			++this.anchorAge;
			if (this.anchorSliding) {
				this.speed.x *= 0.6;
				this.speed.y = this.speed.y * 0.5 + param1 * this.mass * this.density * (1 - this.anchorSlideCounter / this.anchorSlideMax) * 0.5;
				++this.anchorSlideCounter;
				if (this.anchorSlideCounter >= this.anchorSlideMax) {
					this.anchorSliding = false;
				}
				_loc2_ = this.globalAnchor.clone();
				_loc2_.x += this.speed.x;
				_loc2_.y += this.speed.y;
				this.anchorObject.localPoint = this.anchorObject.container.globalToLocal(_loc2_);
				this.recheckAnchor();
				if (Math.abs(this.speed.x) < 0.01 && Math.abs(this.speed.y) < 0.01) {
					this.anchorSliding = false;
				}
			}
		}
		if (this.collisionFree > 0) {
			--this.collisionFree;
		}
		if (this.generateMass) {
			this.mass += G.massGenerateSpeed;
		}
		if (this.neighbour1 != null) {
			if (this.neighbour1.y > this.y) {
				this.neighbourVec.x = this.neighbour1.x - x;
				this.neighbourVec.y = this.neighbour1.y - y;
				this.neighbourAng = Math.atan2(this.neighbourVec.y, this.neighbourVec.x);
				this.flowMult = Math.max(0, Math.sin(this.neighbourAng));
				if (this.mass > this.minMass) {
					this.mass -= this.neighbour1.giveMass(Math.min(G.massFlow, this.mass - this.minMass) * this.flowMult);
				}
				this.density -= this.neighbour1.giveDensity(this.density, this.flowMult);
			}
		}
		if (this.neighbour2 != null) {
			if (this.neighbour2.y > this.y) {
				this.neighbourVec.x = this.neighbour2.x - x;
				this.neighbourVec.y = this.neighbour2.y - y;
				this.neighbourAng = Math.atan2(this.neighbourVec.y, this.neighbourVec.x);
				this.flowMult = Math.max(0, Math.sin(this.neighbourAng));
				if (this.mass > this.minMass) {
					this.mass -= this.neighbour2.giveMass(Math.min(G.massFlow, this.mass - this.minMass) * this.flowMult);
				}
				this.density -= this.neighbour2.giveDensity(this.density, this.flowMult);
			}
		}
	}
}
