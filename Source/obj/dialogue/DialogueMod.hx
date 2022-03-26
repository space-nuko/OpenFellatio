package obj.dialogue;

import openfl.media.Sound;

class DialogueMod
{
    public var lineType: String;
    public var dialogueLine: String;
    public var audio: Null<Sound>;
    public var volume: Float;

    public function new(lineType: String, dialogueLine: String, audio: Null<Sound> = null, volume: Float = 0)
    {
        this.lineType = lineType;
        this.dialogueLine = dialogueLine;
        this.audio = audio;
        this.volume = volume;
    }
}
