package obj.her;

import openfl.display.MovieClip;

@:rtti
class RGBFill
{
    public var endPoint(default, null): MovieClip;
}

interface IRGBFillable
{
    public var rgbFill(default, null): RGBFill;
}
