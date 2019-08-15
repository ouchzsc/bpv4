local world = {}
local ComPrefab = require("common.ComPrefab")
local cfg = require "cfg._cfgs"

function world.start()
    world.hero = ComPrefab:new({ assetInfo = cfg.npc.npc.get(1).RefAsset })
    world.hero:show()
end

return world