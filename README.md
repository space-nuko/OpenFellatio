# OpenFellatio

*OpenFellatio* is a port of the adult Flash game Super Deepthroat to Haxe and OpenFL (pun intended)

## Development

First checkout the forked versions of these dependencies:

- [openfl](https://github.com/space-nuko/openfl/tree/blendmode-erase) at the `blendmode-erase` branch
- [swf](https://github.com/space-nuko/swf/tree/persist-uuids) at the `persist-uuids` branch
- [lime](https://github.com/space-nuko/lime/tree/mod-system) at the `mod-system` branch

```
git clone https://github.com/space-nuko/openfl -b blendmode-erase
git clone https://github.com/space-nuko/swf -b persist-uuids
git clone https://github.com/space-nuko/lime -b mod-system
```

Then setup the dependencies:

```
haxelib install yaml
haxelib install haxe-ws

haxelib dev openfl path/to/openfl
haxelib dev swf path/to/swf
haxelib dev lime path/to/lime
```

Afterwards run the `openfl` setup:

```
haxelib run openfl setup
openfl rebuild tools
lime rebuild tools
```

And then you can test out the project:

```
openfl test html5
```

### NOTE

Because openfl's `cpp` target is kinda buggy (see [hxcpp#986](https://github.com/HaxeFoundation/hxcpp/issues/986)) only the `html5` target works right now

## Credits

Super Deepthroat was originally developed by Konashion.
