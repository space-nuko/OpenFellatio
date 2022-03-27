package obj.her;

import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.MovieClip;
import openfl.display.Sprite;
import openfl.geom.ColorTransform;
import openfl.geom.Matrix;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import obj.ARGBObject;
import obj.AlphaRGBObject;
import openfl.Vector;

@:rtti
@:access(swf.exporters.animate)
class Tears extends openfl.display.MovieClip {
	public var tearArea:Rectangle = new Rectangle(0, 0, 120, 150);
	public var lowerEyelidArea:Rectangle = new Rectangle(0, 0, 50, 20);
	public var tearsData:BitmapData;
	public var tearsLayer:Bitmap;
	public var mascaraData:BitmapData;
	public var mascaraLayer:Bitmap;
	public var tearSpotsLayer:Sprite;
	public var lowerEyelidData:BitmapData;
	public var lowerEyelidLayer:Bitmap;
	public var lowerEyelidClear:Bool = true;
	public var oldDataBuffer:BitmapData;
	public var alphaBlendMult:UInt = 255;
	public var rgbBlendMult:UInt = 256;
	public var tearList:Array<TearPoint>;
	public var tearSpotList:Array<TearSpot>;
	public var tearGraphic:Tear;
	public var mascaraGraphic:MascaraSpot;
	public var maxTears:UInt = 8;
	public var speed:Float = 0.25;
	public var eyeA:Point = new Point(33, 1);
	public var eyeB:Point = new Point(40, 5);
	public var eyeC:Point = new Point(75, 4);
	public var eyeABVec:Point;
	public var eyeBCVec:Point;
	public var mascaraFadeTick:UInt = 0;
	public var mascaraFadeRate:UInt = 20;
	public var mascaraRGB:AlphaRGBObject = new AlphaRGBObject(1, 0, 0, 0);
	public var lastSmudgeTarget:Point = new Point(-1, -1);
	public var lastSmudge:Point = new Point(-1, -1);
	public var currentSmudge:Point;
	public var smudgeVec:Point;
	public var smudgeSteps:UInt = 0;
	public var smudgeToggle:Bool = false;
	public var smudgeBrush:Vector<Point> = new Vector<Point>();

	public function new() {
		var library = swf.exporters.animate.AnimateLibrary.get("sdthx-lib");
		var symbol = library.symbols.get(1240);
		symbol.__init(library);

		super();

		this.tearsData = new BitmapData(Std.int(this.tearArea.width), Std.int(this.tearArea.height), true, 0);
		this.oldDataBuffer = new BitmapData(Std.int(this.tearArea.width), Std.int(this.tearArea.height), true, 0);
		this.tearsLayer = new Bitmap(this.tearsData, "auto", true);
		this.tearsLayer.y = -this.tearArea.height;
		this.tearsLayer.alpha = 0.3;
		addChild(this.tearsLayer);

		this.mascaraData = new BitmapData(Std.int(this.tearArea.width), Std.int(this.tearArea.height), true, 0);
		this.mascaraLayer = new Bitmap(this.mascaraData, "auto", true);
		this.mascaraLayer.y = -this.tearArea.height;
		addChild(this.mascaraLayer);

		this.tearSpotsLayer = new Sprite();
		this.tearSpotsLayer.y = -this.tearArea.height;
		addChild(this.tearSpotsLayer);

		this.tearGraphic = new Tear();
		this.mascaraGraphic = new MascaraSpot();
		this.eyeABVec = new Point(this.eyeB.x - this.eyeA.x, this.eyeB.y - this.eyeA.y);
		this.eyeBCVec = new Point(this.eyeC.x - this.eyeB.x, this.eyeC.y - this.eyeB.y);
		this.tearList = new Array<TearPoint>();
		this.tearSpotList = new Array<TearSpot>();

		var i = 0;
		while (i < 2) {
			var j = -25;
			while (j <= 25) {
				if ((i + j) % 2 != 0) {
					this.smudgeBrush.push(new Point(i, j));
				}
				j++;
			}
			i++;
		}
	}

	public function addLowerEyelidMascaraLayer(param1:MovieClip) {
		this.lowerEyelidData = new BitmapData(Std.int(this.lowerEyelidArea.width), Std.int(this.lowerEyelidArea.height), true, 0);
		this.lowerEyelidLayer = new Bitmap(this.lowerEyelidData, "auto", true);
		param1.addChild(this.lowerEyelidLayer);
	}

	public function setMascaraRGB(param1:AlphaRGBObject) {
		this.mascaraRGB = param1;
	}

	public function clearMascara() {
		this.mascaraData.fillRect(this.tearArea, 0);
		this.tearsData.fillRect(this.tearArea, 0);
		this.lowerEyelidData.fillRect(this.lowerEyelidArea, 0);
		ASCompat.arraySpliceAll(this.tearList, 0);
	}

	public function clearTearSpots() {
		for (tearSpot in this.tearSpotList) {
			this.tearSpotsLayer.removeChild(tearSpot);
		}
		ASCompat.arraySpliceAll(this.tearSpotList, 0);
	}

	public function drawLowerEyelidMascara() {
		this.lowerEyelidData.fillRect(this.lowerEyelidArea, 0);
		var _loc1_ = new Rectangle(0, 0, 50, 20);
		var _loc2_ = new Matrix();
		_loc2_.translate(-33, -3);
		var _loc3_ = new ColorTransform();
		this.lowerEyelidData.draw(this.mascaraData, _loc2_, _loc3_, null, _loc1_, true);
		this.lowerEyelidClear = false;
	}

	public function clearLowerEyelid(param1:Float) {
		var _loc2_:Rectangle = null;
		if (!this.lowerEyelidClear) {
			param1 = Math.min(20, param1 * 0.4);
			_loc2_ = new Rectangle(0, 0, 50, param1);
			this.lowerEyelidData.fillRect(_loc2_, 0);
			if (param1 == 20) {
				this.lowerEyelidClear = true;
			}
		}
	}

	public function addTears() {
		var _loc1_:UInt = 0;
		while (_loc1_ < 3) {
			this.addTearSpot();
			_loc1_++;
		}
		G.her.blink();
	}

	public function addTearSpot() {
		var _loc1_ = Math.NaN;
		var _loc2_:TearSpot = null;
		if (G.tears && (this.tearSpotList.length + this.tearList.length:UInt) < this.maxTears) {
			_loc1_ = Math.random();
			_loc2_ = new TearSpot();
			if (Math.random() > 0.2) {
				_loc2_.x = this.eyeB.x + _loc1_ * this.eyeBCVec.x;
				_loc2_.y = this.eyeB.y + _loc1_ * this.eyeBCVec.y;
			} else {
				_loc2_.x = this.eyeA.x + _loc1_ * this.eyeABVec.x;
				_loc2_.y = this.eyeA.y + _loc1_ * this.eyeABVec.y;
			}
			_loc2_.scaleX = 0.5;
			_loc2_.scaleY = 0.5;
			this.tearSpotsLayer.addChild(_loc2_);
			this.tearSpotList.push(_loc2_);
		}
	}

	public function releaseTears() {
		var _loc1_:UInt = this.tearSpotList.length;
		var _loc2_:UInt = 0;
		while (_loc2_ < _loc1_) {
			if (Math.random() > 0.5) {
				this.releaseTear(_loc2_);
				_loc2_--;
				_loc1_--;
			}
			_loc2_++;
		}
	}

	public function releaseTear(param1:UInt) {
		var multiplier = Math.random() + 1.5;
		var tearPoint = new TearPoint(this.tearSpotList[param1].x, this.tearSpotList[param1].y, multiplier);
		tearPoint.scaling = this.tearSpotList[param1].scaleX;
		this.tearList.push(tearPoint);
		this.tearSpotsLayer.removeChild(this.tearSpotList[param1]);
		this.tearSpotList.splice(param1, 1);
	}

	public function tick(param1:Float) {
		var _loc4_:Point = null;
		var _loc5_ = Math.NaN;
		var _loc6_:Matrix = null;
		var _loc7_:ColorTransform = null;
		var _loc8_ = Math.NaN;
		this.tearsData.lock();
		this.mascaraData.lock();
		++this.mascaraFadeTick;
		if (this.mascaraFadeTick >= this.mascaraFadeRate) {
			this.mascaraFadeTick = 0;
			this.oldDataBuffer = this.mascaraData.clone();
			this.mascaraData.fillRect(this.tearArea, 0);
			this.mascaraData.merge(this.oldDataBuffer, this.tearArea, new Point(), this.rgbBlendMult, this.rgbBlendMult, this.rgbBlendMult,
				this.alphaBlendMult);
		}
		var _loc2_:UInt = this.tearSpotList.length;
		var _loc3_:UInt = 0;
		while (_loc3_ < _loc2_) {
			if (this.tearSpotList[_loc3_].scaleX < 1.5) {
				this.tearSpotList[_loc3_].scaleX *= 1.01;
				this.tearSpotList[_loc3_].scaleY *= 1.01;
			} else if (Math.random() > 0.01) {
				this.releaseTear(_loc3_);
				_loc3_--;
				_loc2_--;
			}
			_loc3_++;
		}
		param1 += this.rotation - 0.15;
		param1 = -param1 * Math.PI / 180;
		this.oldDataBuffer = this.tearsData.clone();
		this.tearsData.fillRect(this.tearArea, 0);
		this.tearsData.merge(this.oldDataBuffer, this.tearArea, new Point(), this.rgbBlendMult, this.rgbBlendMult, this.rgbBlendMult, this.alphaBlendMult);
		var _loc9_:UInt = this.tearList.length;
		var _loc10_:UInt = 0;
		while (_loc10_ < _loc9_) {
			if (this.tearList[_loc10_].tick()) {
				if (this.tearList[_loc10_].y < 20) {
					_loc5_ = param1 - Math.max(0, 20 - this.tearList[_loc10_].y) / 40;
				} else {
					_loc5_ = param1 - (30 - this.tearList[_loc10_].y) / 600;
				}
				_loc4_ = new Point(-Math.sin(_loc5_) * this.speed, Math.cos(_loc5_) * this.speed);
				this.tearList[_loc10_].x += _loc4_.x * this.tearList[_loc10_].speedMult;
				this.tearList[_loc10_].y += _loc4_.y * this.tearList[_loc10_].speedMult;
				if (this.tearList[_loc10_].y > this.tearArea.height) {
					this.tearList.splice(_loc10_, 1);
					_loc10_--;
					_loc9_--;
				} else {
					_loc6_ = new Matrix();
					_loc7_ = new ColorTransform(1, 1, 1, this.tearList[_loc10_].alphaMult);
					_loc6_.scale(this.tearList[_loc10_].scaling, this.tearList[_loc10_].scaling);
					_loc6_.rotate(-param1);
					_loc6_.translate(this.tearList[_loc10_].x, this.tearList[_loc10_].y);
					this.tearsData.draw(this.tearGraphic, _loc6_, _loc7_);
					_loc8_ = this.tearList[_loc10_].getAge();
					if (G.mascara && this.tearList[_loc10_].hasMascara) {
						if (Math.random() > Math.max(0.7 - G.mascaraAmount * 0.01, _loc8_)) {
							_loc6_.translate(Math.random() * 2 - 1, Math.random() * 2);
							_loc7_ = new ColorTransform(1, 1, 1, Math.max(0, 1 - _loc8_) * this.mascaraRGB.a, this.mascaraRGB.r, this.mascaraRGB.g,
								this.mascaraRGB.b);
							this.mascaraData.draw(this.mascaraGraphic, _loc6_, _loc7_);
						}
					}
				}
			} else {
				this.tearList.splice(_loc10_, 1);
				_loc10_--;
				_loc9_--;
			}
			_loc10_++;
		}
		this.tearsData.unlock();
		this.mascaraData.unlock();
	}

	public function smudge(param1:Point) {
		var smudgePoint:Point = null;
		param1 = this.mascaraLayer.globalToLocal(param1);
		if (this.lastSmudgeTarget == null) {
			this.lastSmudgeTarget = param1.clone();
		}
		this.smudgeVec = new Point(param1.x - this.lastSmudgeTarget.x, param1.y - this.lastSmudgeTarget.y);
		var smudgeLength = Math.sqrt(this.smudgeVec.x * this.smudgeVec.x + this.smudgeVec.y * this.smudgeVec.y);
		this.smudgeSteps = Std.int(Math.min(100, Math.ffloor(smudgeLength)));
		this.smudgeVec.x /= smudgeLength;
		this.smudgeVec.y /= smudgeLength;
		this.currentSmudge = this.lastSmudgeTarget.clone();

		var color1UInt:UInt = 0;
		var color1 = new ARGBObject();
		var color2UInt:UInt = 0;
		var color2 = new ARGBObject();

		this.lastSmudge.x = Math.fround(this.lastSmudgeTarget.x);
		this.lastSmudge.y = Math.fround(this.lastSmudgeTarget.y);
		this.smudgeToggle = true;

		this.mascaraData.lock();

		var currentStep:UInt = 0;
		while (currentStep < this.smudgeSteps) {
			this.currentSmudge.x = Math.fround(this.lastSmudgeTarget.x + this.smudgeVec.x * currentStep);
			this.currentSmudge.y = Math.fround(this.lastSmudgeTarget.y + this.smudgeVec.y * currentStep);
			if (this.currentSmudge.x != this.lastSmudge.x || this.currentSmudge.y != this.lastSmudge.y) {
				if (this.smudgeToggle) {
					for (smudgePoint in this.smudgeBrush) {
						color1UInt = this.mascaraData.getPixel32(Std.int(this.lastSmudge.x + smudgePoint.x), Std.int(this.lastSmudge.y + smudgePoint.y));
						color1.a = color1UInt >>> 24;
						color1.r = (color1UInt & 16711680) >>> 16;
						color1.g = (color1UInt & 65280) >>> 8;
						color1.b = color1UInt & 255;

						color2UInt = this.mascaraData.getPixel32(Std.int(this.currentSmudge.x + smudgePoint.x), Std.int(this.currentSmudge.y + smudgePoint.y));
						color2.a = color2UInt >>> 24;
						color2.r = (color2UInt & 16711680) >>> 16;
						color2.g = (color2UInt & 65280) >>> 8;
						color2.b = color2UInt & 255;

						var alphaBlend = color1.a / (color1.a + color2.a);
						color1.a = Std.int(Math.min(250, Math.ffloor((color2.a + color1.a) * 0.5)));
						color1.r = Math.round(alphaBlend * color1.r + (1 - alphaBlend) * color2.r);
						color1.g = Math.round(alphaBlend * color1.g + (1 - alphaBlend) * color2.g);
						color1.b = Math.round(alphaBlend * color1.b + (1 - alphaBlend) * color2.b);
						color1UInt = color1.a << 24 | color1.r << 16 | color1.g << 8 | color1.b;

						this.mascaraData.setPixel32(Std.int(this.currentSmudge.x + smudgePoint.x), Std.int(this.currentSmudge.y + smudgePoint.y), color1UInt);
					}
					this.lastSmudge.x = this.currentSmudge.x;
					this.lastSmudge.y = this.currentSmudge.y;
				}
				this.smudgeToggle = !this.smudgeToggle;
			}
			currentStep++;
		}
		this.lastSmudgeTarget = param1.clone();
		this.mascaraData.unlock();
	}
}
