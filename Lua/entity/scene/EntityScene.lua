local EntityRes = require("entity.EntityRes")
local EntityScene = EntityRes:extends()
local SceneManager = CS.UnityEngine.SceneManagement.SceneManager

local module = require("module.module")

function EntityScene:startLoad()
    self.loader = module.assetMgr.create(self.assetInfo)
    self.loader:Load(function(sceneName)
        self:onLoaded(sceneName)
    end)
end

function EntityScene:getCache()
    return module.cacheMgr.sceneCache
end

function EntityScene:afterOnDestroy()
    SceneManager.UnloadSceneAsync(self.resObj)
    self.loader:Release()
end

return EntityScene