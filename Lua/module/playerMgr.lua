local module = require("module.module")
local EntityPlayer = require("entity.player.EntityPlayer")
local Vector3 = CS.UnityEngine.Vector3
local cfg = require "cfg._cfgs"

local playerMgr = {}

function playerMgr.createPlayer()
    if playerMgr.player == nil then
        --playerMgr.player = Player:new({
        --    assetInfo = module.cfgMgr.assets.get("Assets/Game/Content/Prefab/Knight/ToonRTS_demo_Knight.prefab"),
        --    parentTransform = module.boot.worldRoot.transform, })
        local hero = EntityPlayer:new({ assetInfo = cfg.npc.npc.get(1).RefAsset })
        hero:setData({ w = 1, h = 2 })
        hero:show()
        playerMgr.player = hero
    end
    playerMgr.player:show()
end

return playerMgr
