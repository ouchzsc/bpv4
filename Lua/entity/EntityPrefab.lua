local GameObject = CS.UnityEngine.GameObject
local module = require("module.module")
local EntityRes = require("entity.EntityRes")
local EntityPrefab = EntityRes:extends()

function EntityPrefab:startLoad()
    self.loader = module.assetMgr.create(self.assetInfo)
    self.loader:Load(function(asset)
        if asset == nil then
            module.logger.error("load prefab error:" .. self.assetInfo.id)
        end
        local gameObject
        if self.parentTransform then
            gameObject = GameObject.Instantiate(asset, self.parentTransform, false)
        else
            gameObject = GameObject.Instantiate(asset)
        end
        self.gameObject = gameObject
        self.gameObject.name = self.assetInfo.asset
        self:onLoaded(gameObject)
    end)
end

function EntityPrefab:getCache()
    return module.cacheMgr.prefabCache
end

function EntityPrefab:onResEnable()
    self.resObj:SetActive(true)
end

function EntityPrefab:onResDisable()
    self.resObj:SetActive(false)
end

function EntityPrefab:afterOnDestroy()
    if self.resObj then
        GameObject.Destroy(self.resObj)
    end
    self.resObj = nil
    self.gameObject = nil
    self.loader:Release()
end

return EntityPrefab
