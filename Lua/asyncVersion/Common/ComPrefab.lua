local AssetLoadFlag = CS.Oasis.Unity.AssetLoadFlag
local AssetManager = CS.Oasis.Unity.AssetManager
local GameObject = CS.UnityEngine.GameObject
local module = require("Module.module")
local ComRes = require("Common.ComRes")
local ComPrefab = ComRes:extends()

function ComPrefab:startLoad()
    AssetManager.LoadObject(
        self.assetInfo.bundle,
        self.assetInfo.asset,
        typeof(CS.UnityEngine.GameObject),
        AssetLoadFlag.Default,
        function(_, obj)
            if obj == nil then
                module.logger.error("load prefab error:" .. self.assetInfo.id)
            end
            local gameObject
            if self.parentTransform then
                gameObject = GameObject.Instantiate(obj, self.parentTransform, false)
            else
                gameObject = GameObject.Instantiate(obj)
            end
            self.gameObject = gameObject
            self.gameObject.name = self.assetInfo.asset
            self:onLoaded(gameObject)
        end)
end

function ComPrefab:getCache()
    return module.cacheMgr.prefabCache
end

function ComPrefab:onResEnable()
    self.resObj:SetActive(true)
end

function ComPrefab:onResDisable()
    self.resObj:SetActive(false)
end

function ComPrefab:onResDestroy()
    if self.resObj then
        GameObject.Destroy(self.resObj)
    end
    self.resObj = nil
    self.gameObject = nil
end

return ComPrefab
