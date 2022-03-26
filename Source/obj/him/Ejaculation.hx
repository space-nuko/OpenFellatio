package obj.him;

class Ejaculation {
    public var spurtTimer:UInt;
    public var spurtTimerStart:UInt;
    public var randomSpurtAngle:Float;
    public var randomSpurtAngleRange:Float;
    public var randomSpurtSpeed:Float;
    public var randomSpurtCollisionDelay:UInt;
    public var pauseTimer:UInt;

    public function new(spurtTimer:UInt, spurtTimerStart:UInt, randomSpurtAngle:Float, randomSpurtAngleRange:Float, randomSpurtSpeed:Float,
            randomSpurtCollisionDelay:UInt, pauseTimer:UInt) {
        this.spurtTimer = spurtTimer;
        this.spurtTimerStart = spurtTimerStart;
        this.randomSpurtAngle = randomSpurtAngle;
        this.randomSpurtAngleRange = randomSpurtAngleRange;
        this.randomSpurtSpeed = randomSpurtSpeed;
        this.randomSpurtCollisionDelay = randomSpurtCollisionDelay;
        this.pauseTimer = pauseTimer;
    }
}
