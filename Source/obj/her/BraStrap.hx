package obj.her;

import openfl.display.DisplayObject;
import openfl.geom.Matrix;
import openfl.geom.Point;
import obj.CharacterElementHelper;
import obj.Maths;

class BraStrap {
	public var showingStrap:Bool = false;
	public var strap:DisplayObject;
	public var strapContainer:DisplayObject;
	public var endObject:DisplayObject;
	public var targetObject:DisplayObject;
	public var targetPointName:String;
	public var startPoint:Point;
	public var endPoint:Point;
	public var targetPoint:Point;
	public var strapAng:Float = Math.NaN;
	public var strapLength:Float = Math.NaN;
	public var strapStartPos:Point;
	public var strapStartAng:Float = Math.NaN;

	public function new(param1:DisplayObject, param2:DisplayObject, param3:String, param4:CharacterElementHelper = null) {
		this.strap = param1;
		this.targetObject = param2;
		this.targetPointName = param3;
		this.strapContainer = param1.parent;
		this.strapStartPos = new Point(this.strap.x, this.strap.y);
		this.strapStartAng = Maths.degToRad(this.strap.rotation);
		if (param4 != null) {
			param4.registerListener(this.braChanged);
		}
		G.characterControl.addBreastSizeChangeListener(this.breastSizeChanged);
		this.startPoint = new Point(this.strap.x, this.strap.y);
		this.updatePoints();
	}

	public function braChanged(param1:String) {
		// this.showingStrap = false;
		// if ((this.targetObject : ASAny)["rgbFill"] && (this.strap : ASAny)["rgbFill"]) {
		// 	if ((this.targetObject : ASAny)["rgbFill"][this.targetPointName] && (this.strap : ASAny)["rgbFill"]["endPoint"]) {
		// 		this.showingStrap = true;
		// 		this.updatePoints();
		// 		this.update();
		// 	}
		// }
	}

	public function breastSizeChanged() {
		this.updatePoints();
		this.update();
	}

	public function updatePoints() {
		// if (this.showingStrap) {
		// 	this.endPoint = new Point((this.strap : ASAny)["rgbFill"]["endPoint"].x, (this.strap : ASAny)["rgbFill"]["endPoint"].y);
		// 	this.targetPoint = new Point((this.targetObject : ASAny)["rgbFill"][this.targetPointName].x,
		// 		(this.targetObject : ASAny)["rgbFill"][this.targetPointName].y);
		// 	this.strapAng = g.getRadAngle(this.endPoint.x, this.endPoint.y);
		// 	this.strapLength = Math.sqrt(this.endPoint.x * this.endPoint.x + this.endPoint.y * this.endPoint.y);
		// }
	}

	public function update() {
		// var _loc1_:Point = null;
		// var _loc2_:Matrix = null;
		// var _loc3_:Point = null;
		// var _loc4_ = Math.NaN;
		// var _loc5_ = Math.NaN;
		// if (this.showingStrap) {
		// 	_loc1_ = this.strapContainer.globalToLocal(this.targetObject.localToGlobal(this.targetPoint));
		// 	_loc2_ = new Matrix();
		// 	_loc3_ = new Point(_loc1_.x - this.startPoint.x, _loc1_.y - this.startPoint.y);
		// 	_loc4_ = (_loc4_ = (_loc4_ = g.getRadAngle(_loc3_.x, _loc3_.y)) - this.strapAng) - this.strapStartAng;
		// 	_loc5_ = Maths.dot(g.getUnitVector(this.strapStartAng + this.strapAng), _loc3_);
		// 	_loc2_.scale(_loc5_ / this.strapLength, 1);
		// 	_loc2_.b = Math.tan(_loc4_) * _loc5_ / this.strapLength;
		// 	_loc2_.rotate(this.strapStartAng);
		// 	_loc2_.translate(this.strapStartPos.x, this.strapStartPos.y);
		// 	this.strap.transform.matrix = _loc2_;
		// }
	}
}
