package obj;

import openfl.display.BlendMode;
import openfl.display.DisplayObjectContainer;
import openfl.display.Sprite;
import openfl.display.Stage;
import openfl.events.Event;
import openfl.geom.Point;

@:rtti
@:access(swf.exporters.animate)
class Sweat extends openfl.display.Sprite {
	public static var debug:Sprite;
	public static var MAX_DROPLETS:UInt = 50;
	public static var currentDroplets:UInt = 0;
	public static var parentPos:ASDictionary<DisplayObjectContainer, Point>;
	public static var parentLastPos:ASDictionary<DisplayObjectContainer, Point>;
	public static var parentSpeed:ASDictionary<DisplayObjectContainer, Point>;
	public static var parentLastSpeed:ASDictionary<DisplayObjectContainer, Point>;
	public static var parentAccel:ASDictionary<DisplayObjectContainer, Point>;
	public static var parentDown:ASDictionary<DisplayObjectContainer, Float>;
	public static var sweatGroups:ASDictionary<DisplayObjectContainer, Array<Sweat>>;
	public static var staticPrepComplete:Bool = false;
	public static var staticTickDone:Bool = false;

	public var nearDist:Float = 4;
	public var freeGravity:Float = 3;
	public var attachedGravity:Float = 0.15;
	public var friction:Float = 0.9;
	public var predictDist:Float = 0.8;
	public var sweatParent:DisplayObjectContainer;
	public var parentsToCheck:Array<DisplayObjectContainer>;
	public var parentChildren:Array<DisplayObjectContainer>;
	public var onChild:DisplayObjectContainer;
	public var notOnParent:Bool = false;
	public var attached:Bool = false;
	public var dripping:Bool = false;
	public var justDetached:Bool = false;
	public var localPoint:Point = new Point();
	public var speed:Point = new Point();
	public var globalPoint:Point = new Point();
	public var predictToggle:UInt = 0;
	public var gVec:Point;
	public var sVec:Point;
	public var lastVelocity:Float = 0;
	public var velocity:Float = Math.NaN;
	public var mass:Float = 0.1;
	public var maxMass:Float = 1.2;
	public var leftPush:Float = 0;
	public var rightPush:Float = 0;

	public function new(param1:DisplayObjectContainer, param2:Point, param3:Point, param4:Null<Array<DisplayObjectContainer>> = null) {
		var library = swf.exporters.animate.AnimateLibrary.get("FYA8BqNO2PenTmHMYgDK");
		var symbol = library.symbols.get(37);
		symbol.__init(library);

		super();

		if (currentDroplets < MAX_DROPLETS && G.sweat) {
			++currentDroplets;
			this.parentsToCheck = if (param4 != null) param4 else [];
			param2.x += ((Math.random() + Math.random() + Math.random()) / 3 - 0.5) * param3.x;
			param2.y += ((Math.random() + Math.random() + Math.random()) / 3 - 0.5) * param3.y;
			x = param2.x;
			y = param2.y;
			this.localPoint = new Point(x, y);
			alpha = 0;
			this.predictDist = 7 + Math.random() * 6;
			this.maxMass = 0.8 + Math.random() * 0.4;
			blendMode = BlendMode.OVERLAY;
			addEventListener(Event.ENTER_FRAME, this.tick);
			if (!staticPrepComplete) {
				parentPos = new ASDictionary<DisplayObjectContainer, Point>();
				parentLastPos = new ASDictionary<DisplayObjectContainer, Point>();
				parentSpeed = new ASDictionary<DisplayObjectContainer, Point>();
				parentLastSpeed = new ASDictionary<DisplayObjectContainer, Point>();
				parentAccel = new ASDictionary<DisplayObjectContainer, Point>();
				parentDown = new ASDictionary<DisplayObjectContainer, Float>();
				sweatGroups = new ASDictionary<DisplayObjectContainer, Array<Sweat>>();
				staticPrepComplete = true;
			}
			this.addToParent(param1);
		}
	}

	public static function clearDroplets() {
		for (group in sweatGroups) {
			for (sweat in group) {
				sweat.kill();
			}
		}
		sweatGroups = new ASDictionary<DisplayObjectContainer, Array<Sweat>>();
	}

	public static function staticTick() {
		parentAccel = new ASDictionary<DisplayObjectContainer, Point>();
		parentDown = new ASDictionary<DisplayObjectContainer, Float>();
		staticTickDone = true;
	}

	public function addToParent(param1:DisplayObjectContainer) {
		this.sweatParent = param1;
		this.sweatParent.addChild(this);
		this.parentChildren = new Array<DisplayObjectContainer>();
		var numChildren:UInt = this.sweatParent.numChildren;
		var i:UInt = 0;
		while (i < numChildren) {
            var child = this.sweatParent.getChildAt(i);
			if (Std.isOfType(child, DisplayObjectContainer) && !Std.isOfType(child, Sweat)) {
				this.parentChildren.push(cast(child, DisplayObjectContainer));
			}
			i++;
		}
		this.onChild = this.sweatParent;
		this.jumpToChild();
		if (!sweatGroups.exists(this.sweatParent)) {
			sweatGroups[this.sweatParent] = new Array<Sweat>();
		}
		sweatGroups[this.sweatParent].push(this);
	}

	public function kill() {
		if (sweatGroups[this.sweatParent].indexOf(this) != -1) {
			removeEventListener(Event.ENTER_FRAME, this.tick);
			parent.removeChild(this);
			sweatGroups[this.sweatParent].splice(sweatGroups[this.sweatParent].indexOf(this), 1);
			--currentDroplets;
		}
	}

	public function jumpToChild() {
		var _loc2_:DisplayObjectContainer = null;
		this.globalPoint.x = x;
		this.globalPoint.y = y;
		this.globalPoint = this.sweatParent.localToGlobal(this.globalPoint);
		var _loc1_ = new Point(this.localPoint.x + this.speed.x, this.localPoint.y + this.speed.y);
		_loc1_ = this.onChild.localToGlobal(_loc1_);
		for (_tmp_ in this.parentChildren) {
			_loc2_ = _tmp_;
			if (_loc2_.hitTestPoint(this.globalPoint.x, this.globalPoint.y, false)) {
				if (_loc2_.hitTestPoint(this.globalPoint.x, this.globalPoint.y, true)) {
					this.onChild = _loc2_;
					_loc1_ = this.onChild.globalToLocal(_loc1_);
					this.localPoint = this.onChild.globalToLocal(this.globalPoint);
					this.speed.x = _loc1_.x - this.localPoint.x;
					this.speed.y = _loc1_.y - this.localPoint.y;
					this.notOnParent = true;
					return;
				}
			}
		}
		this.onChild = this.sweatParent;
		this.notOnParent = false;
		this.localPoint = new Point(x, y);
		_loc1_ = this.onChild.globalToLocal(_loc1_);
		this.speed.x = _loc1_.x - this.localPoint.x;
		this.speed.y = _loc1_.y - this.localPoint.y;
	}

	@:flash.property public var currentMass(get, never):Float;

	function get_currentMass():Float {
		return this.mass;
	}

	public function isNear(param1:Sweat):Bool {
		if (param1.x >= x - this.nearDist * this.mass && param1.x <= x + this.nearDist * this.mass) {
			if (param1.y >= y - this.nearDist * this.mass && param1.y <= y + this.nearDist * this.mass) {
				return true;
			}
		}
		return false;
	}

	public function absorb(param1:Sweat) {
		this.mass = Math.min(this.maxMass, this.mass + param1.currentMass);
		param1.kill();
	}

	public function tick(param1:Event) {
		var _loc2_:DisplayObjectContainer = null;
		var _loc3_ = Math.NaN;
		var _loc4_:Array<Sweat> = null;
		var _loc5_:Sweat = null;
		var _loc6_ = Math.NaN;
		var _loc7_:Point = null;
		var _loc8_ = Math.NaN;
		var _loc9_ = Math.NaN;
		var _loc10_ = Math.NaN;
		var _loc11_:Array<DisplayObjectContainer> = null;
		var _loc12_:DisplayObjectContainer = null;
		var _loc13_:Point = null;
		if (!G.gamePaused) {
			if (parentAccel[this.sweatParent] == null) {
				parentLastPos[this.sweatParent] = if (parentPos.exists(this.sweatParent)) parentPos[this.sweatParent] else new Point();
				parentPos[this.sweatParent] = new Point(this.sweatParent.x, this.sweatParent.y);
				parentLastSpeed[this.sweatParent] = if (parentSpeed.exists(this.sweatParent)) parentSpeed[this.sweatParent] else new Point();
				parentSpeed[this.sweatParent] = new Point(parentPos[this.sweatParent].x - parentLastPos[this.sweatParent].x,
					parentPos[this.sweatParent].y - parentLastPos[this.sweatParent].y);
				parentAccel[this.sweatParent] = new Point(parentSpeed[this.sweatParent].x - parentLastSpeed[this.sweatParent].x,
					parentSpeed[this.sweatParent].y - parentLastSpeed[this.sweatParent].y);
			}
			if (!parentDown.exists(this.sweatParent)) {
				_loc3_ = 180;
				_loc2_ = this.sweatParent;
				while (_loc2_ != null && !Std.isOfType(_loc2_, Stage)) {
					_loc3_ -= _loc2_.rotation;
					_loc2_ = _loc2_.parent;
				}
				parentDown[this.sweatParent] = _loc3_;
			}
			if (!parentDown.exists(this.onChild)) {
				if (Std.isOfType(this.onChild, Stage)) {
					parentDown[this.onChild] = 180;
				} else {
					parentDown[this.onChild] = parentDown[this.sweatParent] - this.onChild.rotation;
				}
			}
			_loc4_ = sweatGroups[this.sweatParent].copy();
			for (_tmp_ in _loc4_) {
				_loc5_ = _tmp_;
				if (_loc5_ != this) {
					if (this.isNear(_loc5_)) {
						if (_loc5_.currentMass > this.mass) {
							_loc5_.absorb(this);
							return;
						}
						this.absorb(_loc5_);
					}
				}
			}
			rotation = parentDown[this.sweatParent] + 180;
			_loc6_ = parentDown[this.onChild] * Math.PI / 180;
			this.gVec = new Point(Math.sin(_loc6_), -Math.cos(_loc6_));
			this.localPoint.x += this.speed.x;
			this.localPoint.y += this.speed.y;
			this.speed.x *= this.friction;
			this.speed.y *= this.friction;
			this.globalPoint.x = this.localPoint.x;
			this.globalPoint.y = this.localPoint.y;
			this.globalPoint = this.onChild.localToGlobal(this.globalPoint);
			if (this.notOnParent) {
				_loc7_ = this.sweatParent.globalToLocal(this.globalPoint);
				x = _loc7_.x;
				y = _loc7_.y;
			} else {
				x = this.localPoint.x;
				y = this.localPoint.y;
			}
			if (this.globalPoint.y > 1000) {
				this.kill();
				return;
			}
			this.lastVelocity = this.velocity;
			this.velocity = Math.sqrt(this.speed.x * this.speed.x + this.speed.y * this.speed.y);
			this.sVec = new Point(this.speed.x / this.velocity, this.speed.y / this.velocity);
			if (parent != null) {
				parent.removeChild(this);
			}
			if (this.attached) {
				scaleY = 1 + Math.max(-0.3, Math.min(0.3, (this.velocity - this.lastVelocity) * 0.5));
				scaleX = 1 / scaleY;
				scaleY *= this.mass;
				scaleX *= this.mass;
				alpha = this.mass + 0.5;
				this.mass = Math.min(this.maxMass, this.mass + Math.random() * 0.01);
				this.speed.x += this.attachedGravity * this.gVec.x * Math.max(0, this.mass - 0.5);
				this.speed.y += this.attachedGravity * this.gVec.y * Math.max(0, this.mass - 0.5);
				if (this.sweatParent.hitTestPoint(this.globalPoint.x, this.globalPoint.y, true)) {
					this.leftPush *= 0.8;
					this.rightPush *= 0.8;
					if (this.predictToggle < 1) {
						++this.predictToggle;
					} else {
						this.predictToggle = 0;
						if (!this.sweatParent.hitTestPoint(this.globalPoint.x - this.sVec.y * this.predictDist * 2,
							this.globalPoint.y + this.sVec.x * this.predictDist * 2, true)) {
							this.rightPush = Math.min(this.velocity * 0.4, this.leftPush + 0.08);
						}
						if (!this.sweatParent.hitTestPoint(this.globalPoint.x + this.sVec.y * this.predictDist * 2,
							this.globalPoint.y - this.sVec.x * this.predictDist * 2, true)) {
							this.leftPush = Math.min(this.velocity * 0.4, this.rightPush + 0.08);
						}
						if (!this.sweatParent.hitTestPoint(this.globalPoint.x
							+ this.sVec.x * 8 * this.predictDist
							- this.sVec.y * this.predictDist,
							this.globalPoint.y
							+ this.sVec.y * 8 * this.predictDist
							+ this.sVec.x * this.predictDist, true)) {
							this.leftPush = Math.min(this.velocity * 0.2, this.leftPush + 0.08);
						}
						if (!this.sweatParent.hitTestPoint(this.globalPoint.x
							+ this.sVec.x * 8 * this.predictDist
							+ this.sVec.y * this.predictDist,
							this.globalPoint.y
							+ this.sVec.y * 8 * this.predictDist
							- this.sVec.x * this.predictDist, true)) {
							this.rightPush = Math.min(this.velocity * 0.2, this.rightPush + 0.08);
						}
						if (this.notOnParent) {
							if (!this.onChild.hitTestPoint(this.globalPoint.x, this.globalPoint.y, true)) {
								this.jumpToChild();
							}
						} else {
							this.jumpToChild();
						}
					}
					this.speed.x += this.leftPush * this.sVec.y - this.rightPush * this.sVec.y;
					this.speed.y += this.rightPush * this.sVec.x - this.leftPush * this.sVec.x;
				} else {
					_loc8_ = 1;
					_loc9_ = Math.min(8, Math.abs(this.speed.y * 2));
					while (this.attached) {
						if (Math.abs(_loc8_) > _loc9_) {
							this.leftPush = 0;
							this.rightPush = 0;
							this.attached = false;
							this.localPoint = this.onChild.stage.globalToLocal(this.globalPoint);
							this.onChild = this.onChild.stage;
							this.notOnParent = true;
							this.justDetached = true;
						} else {
							if (this.sweatParent.hitTestPoint(this.globalPoint.x + this.gVec.y * _loc8_, this.globalPoint.y + this.gVec.x * _loc8_, true)) {
								this.speed.x += this.gVec.y * _loc8_ * 0.8;
								this.speed.y += this.gVec.x * _loc8_ * 0.8;
								_loc10_ = Math.sqrt(this.speed.x * this.speed.x + this.speed.y * this.speed.y);
								this.speed.x *= this.velocity / _loc10_;
								this.speed.y *= this.velocity / _loc10_;
								break;
							}
							if (_loc8_ > 0) {
								_loc8_ = -_loc8_;
							} else {
								_loc8_ = -_loc8_ + 1;
							}
						}
					}
				}
			} else {
				this.speed.x += this.freeGravity * this.gVec.x;
				this.speed.y += this.freeGravity * this.gVec.y;
				if (this.sweatParent.hitTestPoint(this.globalPoint.x, this.globalPoint.y, true)) {
					this.attached = true;
					this.speed.x *= 0.4;
					this.speed.y *= 0.4;
				} else {
					_loc11_ = this.parentsToCheck.copy();
					for (_tmp_ in _loc11_) {
						_loc12_ = _tmp_;
						if (_loc12_.hitTestPoint(this.globalPoint.x, this.globalPoint.y, true)) {
							if (!this.justDetached) {
								_loc13_ = new Point(this.localPoint.x + this.speed.x, this.localPoint.y + this.speed.y);
								_loc13_ = this.onChild.localToGlobal(_loc13_);
								_loc13_ = _loc12_.globalToLocal(_loc13_);
								this.localPoint = _loc12_.globalToLocal(this.globalPoint);
								this.speed.x = _loc13_.x - this.localPoint.x;
								this.speed.y = _loc13_.y - this.localPoint.y;
								x = this.localPoint.x;
								y = this.localPoint.y;
							}
							if (this.sweatParent.parent == _loc12_.parent
								&& this.sweatParent.parent.getChildIndex(this.sweatParent) < this.sweatParent.parent.getChildIndex(_loc12_)) {
								this.parentsToCheck.splice(this.parentsToCheck.indexOf(_loc12_), 1);
							}
							continue;
							this.attached = true;
							this.speed.x *= 0.4;
							this.speed.y *= 0.4;
							sweatGroups[this.sweatParent].splice(sweatGroups[this.sweatParent].indexOf(this), 1);
							this.addToParent(_loc12_);
							break;
						}
					}
				}
				this.justDetached = false;
			}
			this.sweatParent.addChild(this);
		}
    }
}
