package obj;

import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.geom.Point;

class StrandControl {
    public var strands:Array<Strand>;
    public var cumStrands:Array<Strand>;
    public var lockedStrands:Array<LockedStrand>;
    public var maxStrands:UInt = 20;

    public function new() {
        this.strands = new Array<Strand>();
        this.cumStrands = new Array<Strand>();
        this.lockedStrands = new Array<LockedStrand>();
    }

    public function newStrand(param1:Sprite, param2:UInt, param3:Float, param4:ASObject = null, param5:ASObject = null, param6:Bool = false,
            param7:Point = null, param8:Bool = false):Strand {
        var _loc9_ = new Strand(param1, param2, param3, param4, param5, param6, param8);
        _loc9_.instancePoints(param7);
        param1.addChild(_loc9_);
        this.strands.push(_loc9_);
        return _loc9_;
    }

    public function checkElementAnchors(param1:DisplayObject) {
        var _loc2_ = this.strands.concat(this.cumStrands);
        var _loc3_:UInt = _loc2_.length;
        var _loc4_:UInt = 0;
        while (_loc4_ < _loc3_) {
            _loc2_[_loc4_].checkElementAnchors(param1);
            _loc4_++;
        }
    }

    public function checkCostumeAnchors() {
        var _loc1_ = this.strands.concat(this.cumStrands);
        var _loc2_:UInt = _loc1_.length;
        var _loc3_:UInt = 0;
        while (_loc3_ < _loc2_) {
            _loc1_[_loc3_].checkCostumeAnchors();
            _loc3_++;
        }
    }

    public function clearSpitStrands() {
        var _loc1_:UInt = this.strands.length;
        var _loc2_:UInt = 0;
        while (_loc2_ < _loc1_) {
            this.strands[0].killMe();
            _loc2_++;
        }
    }

    public function clearCumStrands() {
        var _loc1_:UInt = this.cumStrands.length;
        var _loc2_:UInt = 0;
        while (_loc2_ < _loc1_) {
            this.cumStrands[0].killMe();
            _loc2_++;
        }
        var _loc3_:UInt = this.lockedStrands.length;
        _loc2_ = 0;
        while (_loc2_ < _loc3_) {
            this.lockedStrands[0].kill();
            _loc2_++;
        }
    }

    public function smearStrands(param1:Point, param2:Float = 25) {
        var _loc4_:Strand = null;
        var _loc3_ = this.strands.concat(this.cumStrands);
        for (_tmp_ in _loc3_) {
            _loc4_ = _tmp_;
            _loc4_.smear(param1, param2);
        }
    }

    public function newCumStrand(param1:Point, param2:DisplayObject):Strand {
        var _loc3_ = new Strand(G.cumLayer, 1, G.randomCumMass());
        _loc3_.addSourceLink(param1, param2);
        G.cumLayer.addChild(_loc3_);
        this.cumStrands.push(_loc3_);
        return _loc3_;
    }

    public function addStrand(param1:Strand, param2:Array<ASAny>, param3:Float) {
        var _loc4_:Strand;
        (_loc4_ = new Strand(param1.layer, 0, param3)).giveLinks(param2);
        _loc4_.age = param1.age;
        _loc4_.ageMax = param1.ageMax;
        _loc4_.cumStrand = param1.cumStrand;
        param1.layer.addChild(_loc4_);
        if (param1.cumStrand) {
            this.cumStrands.push(_loc4_);
        } else {
            this.strands.push(_loc4_);
        }
        _loc4_.distSplitDelay = 10;
        _loc4_.graphics.copyFrom(param1.graphics);
    }

    public function delistStrand(param1:Strand) {
        var _loc2_:UInt = 0;
        var _loc3_:UInt = 0;
        var _loc4_:UInt = 0;
        var _loc5_:UInt = 0;
        if (param1.cumStrand) {
            _loc2_ = this.cumStrands.length;
            _loc3_ = 0;
            while (_loc3_ < _loc2_) {
                if (this.cumStrands[_loc3_] == param1) {
                    this.cumStrands.splice(_loc3_, 1);
                    break;
                }
                _loc3_++;
            }
        } else {
            _loc4_ = this.strands.length;
            _loc5_ = 0;
            while (_loc5_ < _loc4_) {
                if (this.strands[_loc5_] == param1) {
                    this.strands.splice(_loc5_, 1);
                    break;
                }
                _loc5_++;
            }
        }
    }

    public function delistLockedStrand(param1:LockedStrand) {
        var _loc2_:UInt = this.lockedStrands.length;
        var _loc3_:UInt = 0;
        while (_loc3_ < _loc2_) {
            if (this.lockedStrands[_loc3_] == param1) {
                this.lockedStrands.splice(_loc3_, 1);
				break;
			}
			_loc3_++;
		}
	}

	public function maxPop():Bool {
		if ((this.strands.length : UInt) >= this.maxStrands) {
			return true;
		}
		return false;
	}
}
