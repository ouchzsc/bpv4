local ComRes = require("Common.ComRes")
local AssetLoadFlag = CS.Oasis.Unity.AssetLoadFlag
local AssetManager = CS.Oasis.Unity.AssetManager
local SceneManager = CS.UnityEngine.SceneManagement.SceneManager
local module = require("Module.module")
local GameObject = CS.UnityEngine.GameObject
local ComSimpScene = ComRes:extends()

function ComSimpScene:startLoad()
    AssetManager.LoadScene(
        string.format(self.sceneBundleName),
        string.format(self.sceneName),
        AssetLoadFlag.Default,
        function(err, scene)
            self:onLoaded(scene)
        end)
end

function ComSimpScene:getCache()
    return module.cacheMgr.sceneCache
end

function ComSimpScene:onResDestroy()
    SceneManager.UnloadSceneAsync(self.resObj)
end

return ComSimpScene
