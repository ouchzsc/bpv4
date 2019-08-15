local ComRes = require("common.ComRes")
local AssetLoadFlag = CS.Oasis.Unity.AssetLoadFlag
local AssetManager = CS.Oasis.Unity.AssetManager
local SceneManager = CS.UnityEngine.SceneManagement.SceneManager
local module = require("module.module")

local ComWorldChunkBase = ComRes:extends()

function ComWorldChunkBase:startLoad()
    AssetManager.LoadScene(
        string.format("scenebasics/scene_basic_%s_%s", self.x, self.y),
        string.format("Scene_Basic_%s_%s", self.x, self.y),
        AssetLoadFlag.DefaultAdditive,
        function(err, scene)
            self:onLoaded(scene)
        end)
end

function ComWorldChunkBase:getCache()
    return module.cacheMgr.sceneCache
end

function ComWorldChunkBase:onResEnable()
    local rootGos = self.resObj:GetRootGameObjects()
    for i = 0, rootGos.Length - 1 do
        rootGos[i]:SetActive(true)
    end
end

function ComWorldChunkBase:onResDisable()
    local rootGos = self.resObj:GetRootGameObjects()
    for i = 0, rootGos.Length - 1 do
        rootGos[i]:SetActive(false)
    end
end

function ComWorldChunkBase:onResDestroy()
    local rootGos = self.resObj:GetRootGameObjects()
    for i = 0, rootGos.Length - 1 do
        rootGos[i]:SetActive(false)
    end
    module.logger.info(string.format("awake chunk %s %s", self.x, self.y))
    SceneManager.UnloadSceneAsync(self.resObj)
    self.rootGos = nil
end

return ComWorldChunkBase

