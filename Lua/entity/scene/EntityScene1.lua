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
    local brick = EntityBrick:new({ assetInfo = cfg.npc.npc.get(2).RefAsset })
    brick:setData({ x = 0, y = -5 })
    brick:show()
end

function EntityScene1:onEnable()
    print("EntityScene1:onEnable()")
    --module.world.curScene:hide()
end



return EntityScene1