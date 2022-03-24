package obj.him.bodies;

import flash.geom.Point;

interface IHimBody {
	function setup():Void;

	function breakdown():Void;

	function animationChanged():Void;

	function toggleBodySettings():Void;

	function shuffle():Void;

	function move(param1:Float, param2:Float, param3:Float):Void;

	function redoLastMove():Void;

	function loadDataPairs(param1:Array<ASAny>):Void;

	function getDataString():String;

	function debugMove(param1:Point):Void;

	@:flash.property var xDelta(get, never):Float;
}
