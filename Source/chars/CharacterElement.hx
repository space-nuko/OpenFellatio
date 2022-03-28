package chars;

import obj.CostumeElement;

@:keepSub
abstract class CharacterElement
{
    public var type(get, never): String;

    public function get_type(): String { return "__unknown__"; }
    public function generateElements(): Array<CostumeElement> { return []; }
}
