local boot = {}
local EntityPlayer = require("entity.EntityPlayer")
local EntityBrick = require("entity.EntityBrick")
local bump = require("common.bump")
local PanelStart = require("entity.ui.PanelStart")
local cfg = require "cfg._cfgs"
local GameObject = CS.UnityEngine.GameObject

function boot.start()
    --world.bumpWorld = bump.newWorld(1)
    --world.hero = EntityPlayer:new({ assetInfo = cfg.npc.npc.get(1).RefAsset })
    --world.hero:show()
    --
    --local brick = EntityBrick:new({ assetInfo = cfg.npc.npc.get(2).RefAsset })
    --brick:setData({ x = 0, y = -5 })
    --brick:show()
    boot.canvas = GameObject.Find("Canvas")
    local panelStart = PanelStart:new({ assetInfo = cfg.asset.assets.get("Assets/Game/UIRes/Start/PanelStart.prefab"),
                                        parentTransform = boot.canvas.transform })
    panelStart:show()
end

return boot