local module = require("module.module")
local Player = require("World.Player")
local Vector3 = CS.UnityEngine.Vector3

local playerMgr = {}

function playerMgr.createPlayer()
    if playerMgr.player == nil then
        playerMgr.player = Player:new({
            assetInfo = module.cfgMgr.assets.get("Assets/Game/Content/Prefab/Knight/ToonRTS_demo_Knight.prefab"),
            parentTransform = module.boot.worldRoot.transform, })
    end
    playerMgr.player:setData({ pos = Vector3(2502, 100, 3002) })
    playerMgr.player:show()
end

return playerMgr
