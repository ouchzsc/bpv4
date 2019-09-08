local EntityScene = require("entity.scene.EntityScene")
local EntityScene1 = EntityScene:extends()
local module = require("module.module")
local cfg = require "cfg._cfgs"
local EntityPlayer = require("entity.player.EntityPlayer")
local EntityBrick = require("entity.obj.EntityBrick")
local bump = require("common.bump")

function EntityScene1:onAwake()
    module.bumpWorld.create()
    module.playerMgr.createPlayer()
    module.uiMgr.panelHeroInfo:show()

    for y, row in pairs(cfg.map.map1.all) do
        for x, v in ipairs(row.cList) do
            if v == 1 then
                local brick = EntityBrick:new({ assetInfo = cfg.npc.npc.get(2).RefAsset })
                brick:setData({ x = x, y = y })
                brick:show()
            end
        end
    end


    --local brick = EntityBrick:new({ assetInfo = cfg.npc.npc.get(2).RefAsset })
    --brick:setData({ x = -1, y = -1 })
    --brick:show()
    --local brick = EntityBrick:new({ assetInfo = cfg.npc.npc.get(2).RefAsset })
    --brick:setData({ x = 1, y = -1 })
    --brick:show()
end

function EntityScene1:onEnable()
    print("EntityScene1:onEnable()")
    --module.world.curScene:hide()
end

return EntityScene1