local assetMgr = {}
local abInst = CS.Res.AbMgr.instance

function assetMgr.create(assetInfo)
    return abInst:Create(assetInfo.assetpath, assetInfo.bundle, assetInfo.asset, assetInfo.type)
end

return assetMgr