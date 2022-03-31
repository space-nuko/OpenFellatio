package sdtmods;

import haxe.Log;
import haxe.io.Path;
import openfl.Assets;
import openfl.utils.AssetType;
import bguiz.struct.graph.AdjacencyGraph;
import bguiz.struct.graph.TopologicalSortGraph;
import chars.Character;

class ModControl
{
    private static var MOD_YML_REGEX = new EReg(".*/mod\\.yml$", "g");

    /*
     * Sorted in dependency order.
     */
    public var loadedMods:Array<ModInstance> = [];

    public var loadStage:LoadStage = LoadStage.NotLoaded;

    public function new()
    {
    }

    public function scanMods()
    {
        if (loadStage != NotLoaded)
            throw "Mods have already been loaded!";

        var graph: AdjacencyGraph<ModInstance> = { vertices: [], adjacents: [] };

        var i = 0;
        var nameToIdx = new Map<String, Int>();
        for (path in Assets.list(AssetType.TEXT)) {
            if (MOD_YML_REGEX.match(path)) {
                var mod = ModInstance.loadFromYaml(path);
                graph.vertices.push(mod);
                graph.adjacents.push([]);
                nameToIdx[mod.name] = i;
                i++;
            }
        }

        for (i in 0...graph.vertices.length) {
            var mod = graph.vertices[i];

            for (dep in mod.dependencies) {
                graph.adjacents[i].push(nameToIdx[dep]);
            }
        }

        var result = TopologicalSortGraph.topologicalSort(graph);
        for (i in result.reversePostOrderVertices) {
            var mod = graph.vertices[i];
            this.loadedMods.push(mod);
            trace("Loaded mod: " + mod.name);
        }

        this.loadStage = ModsScanned;
    }

    public function loadCharacters() {
        // TODO O(n^2)
        for (mod in this.loadedMods) {
            for (assetPath in Assets.list(AssetType.TEXT)) {
                var regex = new EReg(Path.join([mod.path, "Chars"]) + "/.*\\.yml$", "g");
                trace(mod.path + " " + assetPath);
                if (StringTools.startsWith(assetPath, mod.path) && regex.match(assetPath)) {
                    G.characterControl.characters.push(Character.loadFromYaml(assetPath));
                }
            }
        }
        G.characterControl.characters.sort(function(a, b) {
            return Std.int(a.ordering - b.ordering);
        });
        G.baseCharNum = G.characterControl.characters.length;
    }
}

enum LoadStage {
  NotLoaded;
  ModsScanned;
  FullyLoaded;
}
