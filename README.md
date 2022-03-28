# OpenFellatio

*OpenFellatio* is a port of the adult Flash game Super Deepthroat to Haxe and OpenFL (pun intended)

## Development

First checkout the forked versions of these dependencies:

- [openfl](https://github.com/space-nuko/openfl/tree/blendmode-erase) at the `blendmode-erase` branch
- [swf](https://github.com/space-nuko/swf/tree/animate-morph-shapes) at the `animate-morph-shapes` branch

```
git checkout https://github.com/space-nuko/openfl -b blendmode-erase
git checkout https://github.com/space-nuko/swf -b animate-morph-shapes
```

Then setup the dependencies:

```
haxelib install yaml

haxelib dev openfl path/to/openfl
haxelib dev swf path/to/swf
```

Afterwards run the `openfl` setup:

```
haxelib run openfl setup
openfl rebuild tools
```

And then you can test out the project:

```
openfl test html5
```

### NOTE

Because openfl's `cpp` target is kinda buggy (see [hxcpp#986](https://github.com/HaxeFoundation/hxcpp/issues/986)) only the `html5` target works right now

## Credits

Super Deepthroat was originally developed by Konashion.
