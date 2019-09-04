local scene = {}
local EntityScene1 = require("entity.scene.EntityScene1")
local module = require("module.module")

function scene.enterScene(sceneId)
    scene.curScene = EntityScene1:new({ assetInfo = module.cfg.asset.assets.get("Assets/Game/Scenes/s1.unity") })
    scene.curScene:show()
end

return scene
