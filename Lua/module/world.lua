local world = {}
local EntityPlayer = require("logic.Player.EntityPlayer")
local cfg = require "cfg._cfgs"

function world.start()
    world.hero = EntityPlayer:new({ assetInfo = cfg.npc.npc.get(1).RefAsset })
    world.hero:show()
end

return world