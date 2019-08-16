local world = {}
local EntityPlayer = require("entity.EntityPlayer")
local EntityBrick = require("entity.EntityBrick")
local cfg = require "cfg._cfgs"
local bump = require("common.bump")
function world.start()
    world.bumpWorld = bump.newWorld(1)
    world.hero = EntityPlayer:new({ assetInfo = cfg.npc.npc.get(1).RefAsset })
    world.hero:show()

    local brick = EntityBrick:new({ assetInfo = cfg.npc.npc.get(2).RefAsset })
    brick:setData({ x = 0, y = -5 })
    brick:show()
end

return world