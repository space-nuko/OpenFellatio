package sdtmods;

/*
 * Represents user-addable mod code. This is what modders
 * will inherit from when they want to run startup hooks.
 */
abstract class Mod
{
    public function init()
    {
    }

    public function tick(deltaTime:Float)
    {
    }
}
