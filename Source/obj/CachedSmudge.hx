package obj;

import openfl.geom.Point;

class CachedSmudge
{
    public var lastPoint: Null<Point>;
    public var localPoint: Null<Point>;
    public var localVector: Null<Point>;
    public var updated: Bool;

    public function new()
    {
        updated = false;
    }
}
