package;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.Sprite;
import openfl.display.MovieClip;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import motion.easing.Elastic;
import motion.Actuate;

class Main extends Sprite {
    var arrowKeyUp: Bool;
    var arrowKeyDown: Bool;
    var container: Sprite;

    public function new() {
        super();

        var fps_mem = new com.kircode.debug.FPS_Mem(10, 10, 0x0000FF);
        addChild(fps_mem);

        var bitmapData = Assets.getBitmapData("assets/rinari.png");
        var bitmap = new Bitmap(bitmapData);

        Assets.loadLibrary("sdt2").onComplete(function(_) {
            trace("SWF library loaded");
            initGame();
            var lib = G.her;

            var herLeftArm = new obj.Her.HerLeftArmContainer();
            var herRightArm = new obj.Her.HerRightArmContainer();
            var herRightArmErase = new obj.Her.HerRightArmEraseContainer();
            var herRightForeArmErase = new obj.Her.HerRightForeArmContainer();
            var leftHandOver = new obj.Her.LeftHandOver();
            lib.giveArmContainers(herLeftArm, herRightArm, herRightForeArmErase, herRightArmErase, leftHandOver);

            var hairBackContainer = new obj.Her.HairBackContainer();
            lib.giveHairBackContainer(hairBackContainer);

            trace(lib);
            trace(lib.rightForeArmContainer);
            trace(lib.rightForeArmContainer.upperArmCostume);
            trace(lib.rightForeArmContainer.upperArmCostume.foreArmCostume);
            trace(lib.rightForeArmContainer.upperArmCostume.foreArmCostume.cuff);

            // var a = [
            //     lib.collarContainer.collar,
            //     lib.gagFront,
            //     lib.gagBack,

            //     lib.torso.cuffs,
            //     lib.rightForeArmContainer.upperArmCostume.foreArmCostume.cuff,
            //     lib.leftArmContainer.upperArmCostume.foreArmCostume.cuff,

            //     lib.torso.rightCalfContainer.cuffs,
            //     lib.leftLegContainer.leg.cuffs,

            //     lib.eyewear,

            //     lib.torso.rightThighCostume.panties,
            //     lib.leftLegContainer.leg.leftThighCostume.panties,
            //     lib.torso.backUnderCostume.panties,
            //     lib.torso.chestUnderCostume.panties,
            //     lib.torsoBackCostume.backsideCostume.panties,

            //     lib.torso.leftGlove,
            //     lib.torso.rightGlove,
            //     lib.rightForeArmContainer.upperArmCostume.foreArmCostume.glove,
            //     lib.leftArmContainer.upperArmCostume.foreArmCostume.glove,
            //     lib.rightForeArmContainer.upperArmCostume.foreArmCostume.handCostume.glove,
            //     lib.leftArmContainer.upperArmCostume.foreArmCostume.handCostume.glove,
            //     lib.rightArmContainer.upperArmCostume.glove,
            //     lib.leftArmContainer.upperArmCostume.glove,
            //     lib.leftHandOver.hand.glove,

            //     lib.torso.rightThighStocking,
            //     lib.torso.rightCalfContainer.calfStocking,
            //     lib.leftLegContainer.leg.stocking,
            //     lib.leftLegContainer.leg.calfStocking,
            //     lib.torsoBackCostume.backsideCostume.stocking,

            //     lib.torso.rightThighStockingB,
            //     lib.torso.rightCalfContainer.calfStockingB,
            //     lib.leftLegContainer.leg.stockingB,
            //     lib.leftLegContainer.leg.calfStockingB,
            //     lib.torsoBackCostume.backsideCostume.stockingB,

            //     lib.torso.rightThighBottoms,
            //     lib.torso.rightThighBottomsOver,
            //     lib.torso.rightCalfContainer.bottoms,
            //     lib.torso.chestCostume.bottoms,
            //     lib.torso.backCostume.bottoms,
            //     lib.leftLegContainer.leg.leftThighBottoms,
            //     lib.leftLegContainer.leg.leftCalfBottoms,
            //     lib.torsoBackCostume.backsideCostume.bottoms,

            //     lib.torso.rightCalfContainer.footwear,
            //     lib.leftLegContainer.leg.footwear,

            //     lib.torso.topContainer.breastTop,
            //     lib.torso.topContainer.chestTop,
            //     lib.torso.topContainer.backTop,
            //     lib.torso.topContainer.topStrap,
            //     lib.torsoBackCostume.breastCostume.top,
            //     lib.torsoUnderCostume.top,
            //     lib.rightArmContainer.upperArmCostume.top,
            //     lib.leftArmContainer.upperArmCostume.top,

            //     lib.torso.breastCostume.bra,
            //     lib.torso.braStrap,
            //     lib.torso.shoulderStrap,
            //     lib.torso.upperChestCostume.bra,
            //     lib.torsoBackCostume.breastCostume.bra,

            //     // g.hairCostumeOver.headwear,
            //     // g.hairCostumeBack.headwear,

            //     lib.tongueContainer.tongue.piercing,
            //     lib.tongueContainer.tongue.piercingBack,
            //     lib.topLipTongue.piercing,
            //     lib.topLipTongue.piercingBack,

			// 	lib.torso.nipplePiercing,
			// 	lib.torso.leftNipplePiercing,

            // lib.torso.chestCostume.bellyPiercing,

            // lib.earrings];
            // for (f in a) {
            //     trace(f);
            //     if (f != null) {
            //     f.stop();
            //     }
            // }

         lib.hairTop.gotoAndStop("None");
         lib.hairMidContainer.hairUnder.gotoAndStop("None");
         lib.hairMidContainer.hairBottom.gotoAndStop("None");
         lib.hairBackContainer.hairBack.gotoAndStop("None");
            go(lib);

			container = new Sprite();
			// container.addChild(bitmap);
			container.addChild(lib);
			container.alpha = 0;
			container.scaleX = 0.5;
			container.scaleY = 0.5;
			container.x = stage.stageWidth / 2;
			container.y = stage.stageHeight / 2;

			addChild(container);

			Actuate.tween(container, 3, {alpha: 1});
			// Actuate.tween(container, 6, {scaleX: 1, scaleY: 1}).delay(0.4).ease(Elastic.easeOut);

			// lib.gotoAndPlay("InDone");
			// lib.tipPoint.stop();
			// lib.piercing.gotoAndStop("Barbell");
			// lib.piercingBack.gotoAndStop("Barbell");

            stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
            stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
		    this.addEventListener(Event.ENTER_FRAME, everyFrame);
		});
    }

	function go(lib: MovieClip) {
        lib.stop();
        var length = lib.numChildren;
        var i = 0;
		while (i < length) {
            var value = lib.getChildAt(i);
			if (Std.isOfType(value, MovieClip)) {
				trace(i + " " + value);
				go(cast(value, MovieClip));
			}
            i += 1;
		}
	}

	private function keyDown(event:KeyboardEvent) {
		if (event.keyCode == Keyboard.UP) {
			arrowKeyUp = true;
		}else if (event.keyCode == Keyboard.DOWN) {
			arrowKeyDown = true;
		}
	}

	private function keyUp(event:KeyboardEvent) {
		if (event.keyCode == Keyboard.UP) {
			arrowKeyUp = false;
		}else if (event.keyCode == Keyboard.DOWN) {
			arrowKeyDown = false;
		}
	}

    private function everyFrame(event:Event) {
        if (arrowKeyUp) {
            container.y += 5;
        }
        if (arrowKeyDown) {
            container.y -= 5;
        }
    }

	public function initGame() {
		G.initGlobals();
	}
}
