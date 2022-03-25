package obj;

import openfl.display.DisplayObject;
import openfl.display.GradientType;
import openfl.display.MovieClip;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.geom.Matrix;
import openfl.geom.Point;
import obj.dialogue.Dialogue;

class Strand extends MovieClip {
	public var layer:Sprite;
	public var strandLength:Float = Math.NaN;
	public var links:Array<ASAny>;
	public var alive:Bool = false;
	public var age:UInt = 0;
	public var ageMax:UInt = 600;
	public var myGravity:Float = Math.NaN;
	public var interPoints:Array<ASAny>;
	public var offsetPoints:Array<ASAny>;
	public var topCap:Point;
	public var bottomCap:Point;
	public var maxInterpDist:Float = 1000;
	public var topAnchor:ASObject;
	public var topAttached:Bool = false;
	public var bottomAnchor:ASObject;
	public var bottomAttached:Bool = false;
	public var topSource:Bool = false;
	public var lM:Float = Math.NaN;
	public var disappearOnAllAnchor:Bool = false;
	public var sourceLink:StrandLink;
	public var cumStrand:Bool = false;
	public var moveSmoothing:Float = 8;
	public var maxDist:Float = 120;
	public var distSplitDelay:UInt = 0;
	public var collisionFree:UInt = 0;

	public function new(param1:Sprite, param2:UInt = 0, param3:Float = 0, param4:ASObject = null, param5:ASObject = null, param6:Bool = false,
			param7:Bool = false) {
		super();
		this.disappearOnAllAnchor = param7;
		this.layer = param1;
		this.strandLength = param2;
		this.lM = param3;
		if (param4 != null) {
			this.topAnchor = param4;
			this.topAttached = true;
		} else {
			this.topAttached = false;
		}
		if (param5 != null) {
			this.bottomAnchor = param5;
			this.bottomAttached = true;
		} else {
			this.bottomAttached = false;
		}
		this.topSource = param6;
		this.age = 0;
		this.alive = false;
		this.myGravity = G.gravity;
		this.maxDist *= this.maxDist;
		this.addEventListener(Event.ENTER_FRAME, this.tick);
	}

	public function insertLink(param1:Point, param2:UInt, param3:Float) {
		var _loc4_ = new StrandLink(param3, Math.min(1, Math.random() * 3), param1, this.collisionFree, this.cumStrand);
		this.links.insert(Std.int(this.strandLength - 1), _loc4_);
		_loc4_.x = this.sourceLink.x;
		_loc4_.y = this.sourceLink.y;
		_loc4_.anchorDelay = param2;
		this.strandLength = this.links.length;
		this.setNeighbours();
	}

	public function detachSourceLink(param1:Point, param2:UInt = 0) {
		this.sourceLink.detachAnchor(false);
		this.sourceLink.speed = param1.clone();
		this.sourceLink.anchorDelay = param2;
		this.sourceLink.collisionFree = this.collisionFree;
		this.sourceLink.slideOnAnchor = this.cumStrand;
	}

	public function checkElementAnchors(param1:DisplayObject) {
		var _loc2_:UInt = 0;
		while (_loc2_ < this.strandLength) {
			if (this.links[_loc2_].anchored && this.links[_loc2_].anchorContainer == param1) {
				this.links[_loc2_].detachAnchor(false);
			}
			_loc2_++;
		}
	}

	public function checkCostumeAnchors() {
		var _loc3_:UInt = 0;
		var _loc1_:UInt = G.costumeHitElements.length;
		var _loc2_:UInt = 0;
		while (_loc2_ < this.strandLength) {
			_loc3_ = 0;
			while (_loc3_ < _loc1_) {
				if (this.links[_loc2_].anchored && this.links[_loc2_].anchorContainer == G.costumeHitElements[_loc3_]) {
					this.links[_loc2_].detachAnchor(false);
				}
				_loc3_++;
			}
			_loc2_++;
		}
	}

	public function delayCollisions(param1:UInt) {
		var _loc2_:UInt = !!this.topAttached ? 1 : 0;
		var _loc3_:UInt = !!this.bottomAttached ? Std.int(this.strandLength - 1) : Std.int(this.strandLength);
		var _loc4_ = _loc2_;
		while (_loc4_ < _loc3_) {
			this.links[_loc4_].detachAnchor(false);
			this.links[_loc4_].anchorDelay += param1;
			_loc4_++;
		}
	}

	public function detachTop() {
		this.links[0].detachAnchor();
	}

	public function detachBottom() {
		this.links[this.links.length - 1].detachAnchor();
	}

	public function instancePoints(param1:Point) {
		var _loc3_:StrandLink = null;
		var _loc4_:Point = null;
		var _loc5_:Point = null;
		this.links = new Array<ASAny>();
		var _loc2_:UInt = 0;
		while (_loc2_ < this.strandLength) {
			_loc3_ = new StrandLink(this.lM, 1, param1, this.collisionFree, this.cumStrand);
			if (this.topAttached && this.bottomAttached) {
				_loc4_ = G.sceneLayer.globalToLocal(this.topAnchor.container.localToGlobal(this.topAnchor.localPoint));
				_loc5_ = G.sceneLayer.globalToLocal(this.bottomAnchor.container.localToGlobal(this.bottomAnchor.localPoint));
				_loc3_.x = _loc4_.x + _loc2_ * (_loc5_.x - _loc4_.x) / this.strandLength;
				_loc3_.y = _loc4_.y + _loc2_ * (_loc5_.y - _loc4_.y) / this.strandLength;
			} else if (this.topAttached) {
				_loc4_ = G.sceneLayer.globalToLocal(this.topAnchor.container.localToGlobal(this.topAnchor.localPoint));
				_loc3_.x = _loc4_.x;
				_loc3_.y = _loc4_.y;
			}
			this.links.push(_loc3_);
			_loc2_++;
		}
		if (this.topSource) {
			this.links[0].massGenerator();
		}
		if (this.topAttached) {
			this.links[0].anchorTo(this.topAnchor);
		}
		if (this.bottomAttached) {
			this.links[this.links.length - 1].anchorTo(this.bottomAnchor);
		}
		this.strandLength = this.links.length;
		this.setNeighbours();
		this.alive = true;
	}

	public function giveLinks(param1:Array<ASAny>) {
		this.links = new Array<ASAny>();
		var _loc2_:UInt = param1.length;
		var _loc3_:UInt = 0;
		while (_loc3_ < _loc2_) {
			this.links[_loc3_] = param1[_loc3_].cloneLink();
			_loc3_++;
		}
		this.strandLength = this.links.length;
		this.setNeighbours();
		this.alive = true;
	}

	public function addSourceLink(param1:Point, param2:DisplayObject, param3:Bool = true) {
		if (param3) {
			this.cumStrand = true;
			this.ageMax = 1500;
		}
		this.links = new Array<ASAny>();
		this.sourceLink = new StrandLink(this.lM, 1, new Point(), this.collisionFree, false);
		this.sourceLink.anchorTo(new AnchorProp(param1, param2), true);
		var _loc4_ = G.sceneLayer.globalToLocal(param2.localToGlobal(param1));
		this.links.push(this.sourceLink);
		this.collisionFree = 2;
		this.strandLength = this.links.length;
		this.alive = true;
	}

	public function setNeighbours() {
		var _loc1_:UInt = 0;
		if (this.strandLength > 1) {
			this.links[0].setNeighbours(this.links[1]);
			_loc1_ = 1;
			while (_loc1_ < this.strandLength - 2) {
				this.links[_loc1_].setNeighbours(this.links[_loc1_ - 1], this.links[_loc1_ + 1]);
				_loc1_++;
			}
			this.links[Std.int(this.strandLength - 1)].setNeighbours(this.links[Std.int(this.strandLength - 2)]);
		}
	}

	public function tick(param1:Event) {
		this.updateStrand();
	}

	public function updateStrand() {
		var _loc1_ = Math.NaN;
		var _loc2_:Point = null;
		var _loc3_ = Math.NaN;
		var _loc4_:Point = null;
		var _loc5_:StrandLink = null;
		var _loc6_:StrandLink = null;
		var _loc7_:Point = null;
		var _loc8_:UInt = 0;
		var _loc9_:ASAny = /*undefined*/ null;
		var _loc10_:AnchorProp = null;
		var _loc11_:UInt = 0;
		if (this.alive && !G.gamePaused) {
			++this.age;
			this.maxDist = Math.max(30, this.maxDist - 0.2);
			_loc1_ = ASCompat.MAX_FLOAT;
			_loc8_ = 0;
			while (true) {
				if (_loc8_ >= this.strandLength) {
					if (_loc1_ > G.screenSize.y * (1 / G.sceneZoom) + 10) {
						this.killMe();
						break;
					}
					for (_tmp_ in this.links) {
						_loc9_ = _tmp_;
						_loc9_.tick(this.myGravity);
						_loc9_.clearGlobalAnchor();
					}
					if (!this.cumStrand && this.strandLength > G.maxStrandLength) {
						_loc11_ = Math.floor(Math.random() * this.strandLength / 3 + this.strandLength / 3);
						if (this.splitStrand(_loc11_)) {
							break;
						}
					}
					if (this.getAlpha() == 0) {
						this.killMe();
						break;
					}
					this.renderStrand();
					break;
				}
				_loc5_ = this.links[_loc8_];
				_loc6_ = this.links[_loc8_ - 1];
				if (_loc5_.onTongue) {
					if (this.tongueCollide(_loc8_)) {
						if (_loc8_ > 0) {
							this.splitStrand(_loc8_, true, true);
						} else {
							this.splitStrand(_loc8_, false, true);
						}
						if (this.cumStrand) {
							// G.her.tongueContainer.tongue.cumRemoved();
							G.her.fillMouth(true);
						}
					}
				} else if (_loc5_.anchorable) {
					if ((_loc10_ = this.collide(_loc8_)) != null) {
						if (_loc10_.forceHit) {
							_loc5_.anchorTo(_loc10_);
							if (this.cumStrand && G.her.head.contains(_loc10_.container) && G.him.isEjaculating()) {
								G.her.cumOnFace();
							}
							if (_loc10_.eyeHit) {
								G.dialogueControl.triggerState(Dialogue.CUM_IN_EYE);
								G.her.eyeHit();
							}
						} else if (_loc5_.tryToAnchorTo(_loc10_)) {
							if (this.cumStrand && G.her.head.contains(_loc10_.container) && G.him.isEjaculating()) {
								G.her.cumOnFace();
							}
							if (_loc10_.eyeHit) {
								G.dialogueControl.triggerState(Dialogue.CUM_IN_EYE);
								G.her.eyeHit();
							}
						}
						if (this.disappearOnAllAnchor) {
							if (this.checkAllAnchored()) {
								this.killMe();
								break;
							}
						}
					}
				}
				if (_loc5_.anchored) {
					_loc7_ = G.sceneLayer.globalToLocal(_loc5_.globalAnchor);
					_loc5_.x = _loc7_.x;
					_loc5_.y = _loc7_.y;
					if (!this.cumStrand && _loc5_.anchorAge > this.ageMax) {
						_loc5_.detachAnchor();
					}
				}
				if (_loc8_ > 0) {
					_loc2_ = new Point(_loc6_.x - _loc5_.x, _loc6_.y - _loc5_.y);
					_loc3_ = _loc2_.x * _loc2_.x + _loc2_.y * _loc2_.y;
				} else {
					_loc2_ = new Point(0, 0);
					_loc3_ = 0;
				}
				if (_loc8_ < this.strandLength - 1) {
					_loc4_ = new Point(this.links[_loc8_ + 1].x - _loc5_.x, this.links[_loc8_ + 1].y - _loc5_.y);
				} else {
					_loc4_ = new Point(0, 0);
				}
				_loc5_.accelerate((_loc2_.x + _loc4_.x) / this.moveSmoothing, (_loc2_.y + _loc4_.y) / this.moveSmoothing + this.myGravity * _loc5_.mass);
				_loc5_.move(G.friction);
				if (_loc3_ > this.maxDist && _loc8_ > 0) {
					if (this.distSplitDelay == 0) {
						this.distSplitDelay = 10;
						this.splitStrand(_loc8_);
					}
				}
				if (_loc8_ < this.strandLength) {
					if (_loc5_.y < _loc1_) {
						_loc1_ = _loc5_.y;
					}
					if (_loc5_.mass >= G.maxMass) {
						this.expandStrand(_loc8_);
					}
				}
				_loc8_++;
			}
			if (this.distSplitDelay > 0) {
				--this.distSplitDelay;
			}
		}
	}

	public function smear(param1:Point, param2:Float) {
		var _loc3_:StrandLink = null;
		for (_tmp_ in this.links) {
			_loc3_ = _tmp_;
			_loc3_.smear(param1, param2);
		}
	}

	public function splitStrandAtAnchorChange() {
		var _loc1_:String = null;
		// if(this.links[0].anchorContainer == G.her.head.face || this.links[0].anchorContainer == G.her.head.jaw)
		// {
		//    _loc1_ == "face";
		// }
		// else if(this.links[0].anchorContainer == G.her.torso.midLayer.rightBreast)
		// {
		//    _loc1_ == "breast";
		// }
		// var _loc2_:uint = 1;
		// while(_loc2_ < this.strandLength)
		// {
		//    if(this.links[0].anchorContainer == G.her.head.face || this.links[0].anchorContainer == G.her.head.jaw)
		//    {
		//       if(_loc1_ == "breast")
		//       {
		//          this.splitStrand(_loc2_,false);
		//          break;
		//       }
		//    }
		//    else if(this.links[0].anchorContainer == G.her.torso.midLayer.rightBreast)
		//    {
		//       if(_loc1_ == "face")
		//       {
		//          this.splitStrand(_loc2_,false);
		//          break;
		//       }
		//    }
		//    _loc2_++;
		// }
	}

	public function splitStrandAtOffAnchor() {
		var _loc2_ = false;
		var _loc1_:Bool = this.links[0].anchored;
		var _loc3_:UInt = 1;
		while (_loc3_ < this.strandLength) {
			_loc2_ = this.links[_loc3_].anchored;
			if (_loc1_) {
				if (!_loc2_) {
					this.splitStrand(_loc3_, false);
					break;
				}
			} else if (_loc2_) {
				this.splitStrand(_loc3_, false);
				break;
			}
			_loc1_ = _loc2_;
			_loc3_++;
		}
	}

	public function collide(param1:UInt):AnchorProp {
		var _loc4_:AnchorProp = null;
		var _loc5_:ASAny = /*undefined*/ null;
		var _loc2_ = G.strandBackLayer.localToGlobal(new Point(this.links[param1].x, this.links[param1].y));
		var _loc3_ = _loc2_.clone();
		// for each(_loc5_ in G.costumeHitElements)
		// {
		//    if(_loc5_.showing)
		//    {
		//       if(_loc5_.hitTestPoint(_loc2_.x,_loc2_.y,false))
		//       {
		//          if(_loc5_.hitTestPoint(_loc2_.x,_loc2_.y,true))
		//          {
		//             return new AnchorProp(_loc5_.globalToLocal(_loc3_),_loc5_);
		//          }
		//       }
		//    }
		// }
		// if(G.her.eyewear.hitTestPoint(_loc2_.x,_loc2_.y,false))
		// {
		//    if(G.her.eyewear.hitTestPoint(_loc2_.x,_loc2_.y,true))
		//    {
		//       return new AnchorProp(G.her.eyewear.globalToLocal(_loc3_),G.her.eyewear);
		//    }
		// }
		// if(G.her.head.face.hitTestPoint(_loc2_.x,_loc2_.y,false))
		// {
		//    if(G.her.head.face.hitTestPoint(_loc2_.x,_loc2_.y,true))
		//    {
		//       _loc4_ = new AnchorProp(G.her.head.face.globalToLocal(_loc3_),G.her.head.face,false);
		//       if(this.cumStrand)
		//       {
		//          if(G.her.eye.hitBox.hitTestPoint(_loc2_.x,_loc2_.y,false))
		//          {
		//             _loc4_.setEyeHit();
		//          }
		//       }
		//       return _loc4_;
		//    }
		// }
		// if(G.her.head.jaw.hitTestPoint(_loc2_.x,_loc2_.y,false))
		// {
		//    if(G.her.head.jaw.hitTestPoint(_loc2_.x,_loc2_.y,true))
		//    {
		//       return new AnchorProp(G.her.head.jaw.globalToLocal(_loc3_),G.her.head.jaw,false);
		//    }
		// }
		// if(G.her.tongueContainer.tongue.okayToHit())
		// {
		//    if(G.her.tongueContainer.tongue.hitTestPoint(_loc2_.x,_loc2_.y,false))
		//    {
		//       if(G.her.tongueContainer.tongue.hitTestPoint(_loc2_.x,_loc2_.y,true))
		//       {
		//          if(this.cumStrand)
		//          {
		//             G.her.tongueContainer.tongue.cumHit();
		//          }
		//          (_loc4_ = new AnchorProp(G.her.tongueContainer.tongue.tipPoint.globalToLocal(_loc3_),G.her.tongueContainer.tongue.tipPoint,true)).setOriginalHitTarget(G.her.tongueContainer.tongue);
		//          return _loc4_;
		//       }
		//    }
		// }
		// if(G.her.torso.midLayer.rightBreast.hitTestPoint(_loc2_.x,_loc2_.y,false))
		// {
		//    if(G.her.torso.midLayer.rightBreast.hitArea.hitTestPoint(_loc2_.x,_loc2_.y,true))
		//    {
		//       return new AnchorProp(G.her.torso.midLayer.rightBreast.globalToLocal(_loc3_),G.her.torso.midLayer.rightBreast,false);
		//    }
		// }
		// if(G.her.torso.hitTestPoint(_loc2_.x,_loc2_.y,false))
		// {
		//    if(G.her.torso.leg.hitTestPoint(_loc2_.x,_loc2_.y,false))
		//    {
		//       if(G.her.torso.leg.hitTestPoint(_loc2_.x,_loc2_.y,true) && !G.her.torso.rightCalfContainer.calf.hitTestPoint(_loc2_.x,_loc2_.y,true))
		//       {
		//          return new AnchorProp(G.her.torso.leg.globalToLocal(_loc3_),G.her.torso.leg,false);
		//       }
		//    }
		//    if(G.her.torso.midLayer.chest.hitTestPoint(_loc2_.x,_loc2_.y,true))
		//    {
		//       return new AnchorProp(G.her.torso.midLayer.chest.globalToLocal(_loc3_),G.her.torso.midLayer.chest,false);
		//    }
		//    if(G.her.torso.back.hitTestPoint(_loc2_.x,_loc2_.y,true))
		//    {
		//       return new AnchorProp(G.her.torso.back.globalToLocal(_loc3_),G.her.torso.back,false);
		//    }
		//    if(G.her.penisOn && G.her.torso.penisContainer.hitTestPoint(_loc2_.x,_loc2_.y,true))
		//    {
		//       return new AnchorProp(G.her.torso.penisContainer.globalToLocal(_loc3_),G.her.torso.penisContainer,false);
		//    }
		// }
		// if(G.sceneLayer.globalToLocal(_loc2_).y > 1220 + Math.random() * 65)
		// {
		//    return new AnchorProp(G.sceneLayer.globalToLocal(_loc3_),G.sceneLayer);
		// }
		return null;
	}

	public function tongueCollide(param1:UInt):Bool {
		var _loc3_ = false;
		var _loc2_ = G.strandBackLayer.localToGlobal(new Point(this.links[param1].x, this.links[param1].y));
		// _loc3_ = G.her.head.face.hitTestPoint(_loc2_.x,_loc2_.y,false);
		// if(_loc3_)
		// {
		//    _loc3_ = G.her.head.face.hitTestPoint(_loc2_.x,_loc2_.y,true);
		//    if(_loc3_)
		//    {
		//       return true;
		//    }
		// }
		// _loc3_ = G.her.head.jaw.hitTestPoint(_loc2_.x,_loc2_.y,false);
		// if(_loc3_)
		// {
		//    _loc3_ = G.her.head.jaw.hitTestPoint(_loc2_.x,_loc2_.y,true);
		//    if(_loc3_)
		//    {
		//       return true;
		//    }
		// }
		return false;
	}

	public function checkAllAnchored():Bool {
		var _loc2_:ASAny = /*undefined*/ null;
		var _loc1_ = true;
		for (_tmp_ in this.links) {
			_loc2_ = _tmp_;
			if (!_loc2_.anchored) {
				_loc1_ = false;
			}
		}
		return _loc1_;
	}

	public function renderStrand() {
		var _loc1_:ASObject = null;
		var _loc2_:StrandLink = null;
		var _loc3_:StrandLink = null;
		var _loc4_:ASObject = null;
		var _loc5_:ASObject = null;
		var _loc8_ = Math.NaN;
		this.generateInterpolationPoints();
		this.graphics.clear();
		var _loc6_:UInt = this.getRGB();
		var _loc7_:Float = this.getAlpha();
		var _loc9_ = new Point();
		var _loc10_ = new Point();
		var _loc11_ = new Matrix();
		var _loc12_:UInt = 1;
		while (_loc12_ < this.strandLength) {
			_loc2_ = this.links[_loc12_];
			_loc3_ = this.links[_loc12_ - 1];
			_loc4_ = this.offsetPoints[_loc12_];
			_loc5_ = this.offsetPoints[_loc12_ - 1];
			_loc9_.x = _loc2_.x - _loc3_.x;
			_loc9_.y = _loc2_.y - _loc3_.y;
			_loc10_.x = _loc3_.x + _loc9_.x * 0.5;
			_loc10_.y = _loc3_.y + _loc9_.y * 0.5;
			_loc8_ = Math.max(Math.abs(_loc9_.x), Math.abs(_loc9_.y));
			_loc11_.createGradientBox(_loc8_, _loc8_, Math.atan2(_loc9_.y, _loc9_.x), Math.min(_loc2_.x, _loc3_.x), Math.min(_loc2_.y, _loc3_.y));
			this.graphics.beginGradientFill(GradientType.LINEAR, [_loc6_, _loc6_],
				[Math.min(1, _loc3_.density) * _loc7_, Math.min(1, _loc2_.density) * _loc7_], [100, 155], _loc11_);
			if (_loc3_.hasStoredInterPoints) {
				_loc1_ = _loc3_.getStoredInterPoints();
			} else {
				_loc1_ = this.interPoints[_loc12_ - 1];
			}
			this.graphics.moveTo(_loc5_.inside.x, _loc5_.inside.y);
			this.graphics.curveTo(_loc1_.inside.x, _loc1_.inside.y, _loc4_.inside.x, _loc4_.inside.y);
			if (_loc12_ == this.strandLength - 1) {
				this.graphics.curveTo(this.bottomCap.x, this.bottomCap.y, _loc4_.outside.x, _loc4_.outside.y);
			} else {
				this.graphics.lineTo(_loc4_.outside.x, _loc4_.outside.y);
			}
			this.graphics.curveTo(_loc1_.outside.x, _loc1_.outside.y, _loc5_.outside.x, _loc5_.outside.y);
			if (_loc12_ == 1) {
				this.graphics.curveTo(this.topCap.x, this.topCap.y, this.offsetPoints[0].inside.x, this.offsetPoints[0].inside.y);
			}
			_loc12_++;
		}
	}

	public function getAlpha():Float {
		if (this.cumStrand) {
			return 0.95 - Math.max(0, Math.min(1.9, 1.2 * this.age / this.ageMax - 0.2)) / 2;
		}
		return 1 - Math.max(0, Math.min(1, 1.2 * this.age / this.ageMax - 0.2));
	}

	public function getRGB():UInt {
		if (this.cumStrand) {
			return G.cumRGB;
		}
		return 16777215;
	}

	public function getLinkThickness(param1:UInt):Float {
		var _loc2_ = Math.max(1, Math.pow(this.links[param1].mass * 2, 1.5));
		if (this.links[param1].anchored) {
			_loc2_ *= 1.5;
		}
		if (this.cumStrand) {
			_loc2_ *= 1.3;
		}
		return _loc2_;
	}

	public function generateInterpolationPoints() {
		var _loc1_:StrandLink = null;
		var _loc2_:StrandLink = null;
		var _loc7_:Point = null;
		var _loc8_:Point = null;
		var _loc9_:Point = null;
		var _loc10_:Line = null;
		var _loc11_:Line = null;
		var _loc12_:Point = null;
		var _loc13_:Point = null;
		var _loc14_:Point = null;
		var _loc15_:Point = null;
		var _loc16_ = Math.NaN;
		var _loc17_:Point = null;
		var _loc18_ = Math.NaN;
		var _loc19_ = Math.NaN;
		var _loc20_:ASObject = null;
		var _loc21_:ASObject = null;
		var _loc22_:Point = null;
		var _loc23_:Point = null;
		this.interPoints = new Array<ASAny>();
		this.offsetPoints = new Array<ASAny>();
		var _loc3_ = new Array<ASAny>();
		var _loc4_ = new Array<ASAny>();
		var _loc5_ = new Array<ASAny>();
		var _loc6_:UInt = 0;
		while (_loc6_ < this.strandLength - 1) {
			_loc1_ = this.links[_loc6_];
			_loc2_ = this.links[_loc6_ + 1];
			if (!((_loc17_ = new Point(_loc2_.x - _loc1_.x, _loc2_.y - _loc1_.y)).x == 0 && _loc17_.y == 0)) {
				_loc18_ = Math.sqrt(_loc17_.x * _loc17_.x + _loc17_.y * _loc17_.y);
				_loc17_.x /= _loc18_;
				_loc17_.y /= _loc18_;
			}
			_loc3_[_loc6_ + 1] = _loc17_;
			_loc6_++;
		}
		if (this.strandLength > 1) {
			_loc3_[0] = new Point(_loc3_[1].x, _loc3_[1].y);
			_loc3_[Std.int(this.strandLength)] = new Point(_loc3_[Std.int(this.strandLength - 1)].x, _loc3_[Std.int(this.strandLength - 1)].y);
		} else {
			_loc3_[0] = new Point(0, 1);
			_loc3_[1] = new Point(0, 1);
		}
		_loc6_ = 0;
		while (_loc6_ < this.strandLength) {
			_loc1_ = this.links[_loc6_];
			if ((_loc7_ = new Point(_loc3_[_loc6_ + 1].x + _loc3_[_loc6_].x, _loc3_[_loc6_ + 1].y + _loc3_[_loc6_].y)).x == 0 && _loc7_.y == 0) {
				_loc7_ = new Point(_loc3_[_loc6_].x, _loc3_[_loc6_].y);
			}
			_loc4_[_loc6_] = _loc7_;
			_loc19_ = this.getLinkThickness(_loc6_);
			_loc8_ = new Point(_loc1_.x - _loc7_.y * _loc19_, _loc1_.y + _loc7_.x * _loc19_);
			_loc9_ = new Point(_loc1_.x + _loc7_.y * _loc19_, _loc1_.y - _loc7_.x * _loc19_);
			if (_loc6_ == 0) {
				this.topCap = new Point(_loc1_.x - _loc7_.x * _loc19_ * 2, _loc1_.y - _loc7_.y * _loc19_ * 2);
			} else if (_loc6_ == this.strandLength - 1) {
				this.bottomCap = new Point(_loc1_.x + _loc7_.x * _loc19_ * 2, _loc1_.y + _loc7_.y * _loc19_ * 2);
			}
			this.offsetPoints[_loc6_] = {
				"inside": _loc8_,
				"outside": _loc9_
			};
			_loc11_ = new Line(new Point(_loc8_.x + _loc7_.x, _loc8_.y + _loc7_.y), new Point(_loc8_.x - _loc7_.x, _loc8_.y - _loc7_.y));
			_loc10_ = new Line(new Point(_loc9_.x + _loc7_.x, _loc9_.y + _loc7_.y), new Point(_loc9_.x - _loc7_.x, _loc9_.y - _loc7_.y));
			_loc5_[_loc6_] = {
				"inside": _loc11_,
				"outside": _loc10_
			};
			_loc6_++;
		}
		_loc6_ = 0;
		while (_loc6_ < this.strandLength - 1) {
			_loc1_ = this.links[_loc6_];
			_loc2_ = this.links[_loc6_ + 1];
			if (_loc1_.hasStoredInterPoints && (!_loc1_.anchored || !_loc2_.anchored)) {
				_loc1_.unstoreInterPoints();
			}
			if (!_loc1_.hasStoredInterPoints) {
				_loc14_ = new Point((_loc1_.x + _loc2_.x) / 2, (_loc1_.y + _loc2_.y) / 2);
				if (_loc6_ > 0 && _loc6_ < this.strandLength - 2) {
					if ((_loc20_ = Maths.intersect(_loc5_[_loc6_].inside, _loc5_[_loc6_ + 1].inside)).intersect == true) {
						if ((_loc16_ = (_loc15_ = new Point(_loc20_.x - _loc14_.x, _loc20_.y - _loc14_.y)).x * _loc15_.x
							+ _loc15_.y * _loc15_.y) > this.maxInterpDist) {
							_loc15_.x *= this.maxInterpDist / _loc16_;
							_loc15_.y *= this.maxInterpDist / _loc16_;
							_loc20_.x = _loc14_.x + _loc15_.x;
							_loc20_.y = _loc14_.y + _loc15_.y;
						}
						_loc12_ = new Point(_loc20_.x, _loc20_.y);
					} else {
						_loc22_ = new Point(this.offsetPoints[_loc6_ + 1].inside.x - this.offsetPoints[_loc6_].inside.x,
							this.offsetPoints[_loc6_ + 1].inside.y - this.offsetPoints[_loc6_].inside.y);
						_loc12_ = new Point(this.offsetPoints[_loc6_].inside.x + _loc22_.x / 2, this.offsetPoints[_loc6_].inside.y + _loc22_.y / 2);
					}
					if ((_loc21_ = Maths.intersect(_loc5_[_loc6_].outside, _loc5_[_loc6_ + 1].outside)).intersect == true) {
						if ((_loc16_ = (_loc15_ = new Point(_loc21_.x - _loc14_.x, _loc21_.y - _loc14_.y)).x * _loc15_.x
							+ _loc15_.y * _loc15_.y) > this.maxInterpDist) {
							_loc15_.x *= this.maxInterpDist / _loc16_;
							_loc15_.y *= this.maxInterpDist / _loc16_;
							_loc21_.x = _loc14_.x + _loc15_.x;
							_loc21_.y = _loc14_.y + _loc15_.y;
						}
						_loc13_ = new Point(_loc21_.x, _loc21_.y);
					} else {
						_loc23_ = new Point(this.offsetPoints[_loc6_ + 1].outside.x - this.offsetPoints[_loc6_].outside.x,
							this.offsetPoints[_loc6_ + 1].outside.y - this.offsetPoints[_loc6_].outside.y);
						_loc13_ = new Point(this.offsetPoints[_loc6_].outside.x + _loc23_.x / 2, this.offsetPoints[_loc6_].outside.y + _loc23_.y / 2);
					}
				} else if (_loc6_ == 0) {
					_loc12_ = Maths.normal(_loc5_[1].inside.p1, _loc5_[1].inside.p2, _loc14_);
					_loc13_ = Maths.normal(_loc5_[1].outside.p1, _loc5_[1].outside.p2, _loc14_);
				} else if (_loc6_ == this.strandLength - 2) {
					_loc12_ = Maths.normal(_loc5_[Std.int(this.strandLength - 2)].inside.p1, _loc5_[Std.int(this.strandLength - 2)].inside.p2, _loc14_);
					_loc13_ = Maths.normal(_loc5_[Std.int(this.strandLength - 2)].outside.p1, _loc5_[Std.int(this.strandLength - 2)].outside.p2, _loc14_);
				}
				this.interPoints[_loc6_] = {
					"inside": _loc12_,
					"outside": _loc13_
				};
			}
			_loc6_++;
		}
	}

	public function expandStrand(param1:UInt) {
		var _loc2_:Float = this.links[param1].mass;
		var _loc3_:Float = this.links[param1].density;
		this.links[param1].mass = _loc2_ / 2;
		this.links[param1].density = _loc3_ / 2;
		var _loc4_:StrandLink = this.links[param1].cloneLink();
		_loc4_.x += 1;
		_loc4_.isExpanded = true;
		this.links.insert(param1, _loc4_);
		this.strandLength = this.links.length;
		var _loc5_ = new Droplet(this.links[param1], this.links[param1].speed, 1, 0.02, this.getAlpha(), this.cumStrand);
		if (this.cumStrand) {
			G.cumLayer.addChild(_loc5_);
		} else {
			G.strandFrontLayer.addChild(_loc5_);
		}
		this.setNeighbours();
	}

	public function splitStrand(param1:UInt, param2:Bool = true, param3:Bool = false):Bool {
		var _loc5_:StrandLink = null;
		var _loc6_:StrandLink = null;
		var _loc7_:StrandLink = null;
		if (param2) {
			_loc5_ = this.links[param1 - 1];
			_loc6_ = this.links[param1];
			(_loc7_ = new StrandLink(0, (_loc5_.density + _loc6_.density) * 0.5, new Point())).x = _loc6_.x + (_loc5_.x - _loc6_.x) / 2;
			_loc7_.y = _loc6_.y + (_loc5_.y - _loc6_.y) / 2;
			_loc7_.speed.x = _loc6_.speed.x + (_loc5_.speed.x - _loc6_.speed.x) / 2;
			_loc7_.speed.y = _loc6_.speed.y + (_loc5_.speed.y - _loc6_.speed.y) / 2;
		}
		var _loc4_ = this.links.splice(0, param1);
		if (param3) {
			this.links.splice(0, 1);
		}
		if (param2) {
			_loc4_.push(_loc7_);
			if (!param3) {
				this.links.unshift(_loc7_);
			}
		}
		if (_loc4_.length > 1) {
			G.strandControl.addStrand(this, _loc4_, this.lM);
		}
		this.strandLength = this.links.length;
		this.setNeighbours();
		if (this.strandLength <= 1) {
			this.killMe();
			return true;
		}
		return false;
	}

	public function killMe() {
		var _loc1_:StrandLink = null;
		if (this.alive) {
			for (_tmp_ in this.links) {
				_loc1_ = _tmp_;
				if (_loc1_.onEye) {
					G.her.eyeClearHit();
				}
			}
			G.strandControl.delistStrand(this);
			this.alive = false;
			this.removeEventListener(Event.ENTER_FRAME, this.tick);
			this.parent.removeChild(this);
		}
	}
   }
