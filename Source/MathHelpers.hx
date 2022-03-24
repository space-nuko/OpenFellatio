package;

class MathHelpers
{
	public static inline function getRadAngle(vecX: Float, vecY: Float): Float
	{
		return Math.atan2(vecY, vecX) + Math.PI * 0.5;
	}

	public static inline function clamp(v: Float, min: Float, max: Float): Float {
		return Math.min(max, Math.max(min, v));
	}
}
