package obj.hair;

import chars.Character;

interface IHair
{
	function apply(char:Character):Void;
	function unapply(char:Character):Void;
	function fromYaml(yaml:Dynamic):Void;
	function toYaml(): Dynamic;
}
