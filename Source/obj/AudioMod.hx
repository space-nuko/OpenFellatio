package obj;

import openfl.media.Sound;

class AudioMod
{
   public var audio(default, null):Sound;
   public var volume(default, null):Float;

   public function new(_audio:Sound, _volume:Float)
   {
      // super();
      this.audio = _audio;
      this.volume = MathHelpers.clamp(_volume, 0, 1);
   }
}
