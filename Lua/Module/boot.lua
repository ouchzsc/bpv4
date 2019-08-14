local GameObject = CS.UnityEngine.GameObject
local module = require("Module.module")
local ComOpenWorld = require("World.ComOpenWorld")
local boot = {}

boot.worldRoot =nil
boot.mainCam = nil

function boot.init()
    local openWorld = ComOpenWorld:new({
        sceneBundleName="scenes",
        sceneName="OpenWorld",
    })
    openWorld:show()
    boot.openWorld = openWorld
end

return boot
