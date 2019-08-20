local Cache = require("common.Cache")
local cacheMgr = {}

function cacheMgr.init()
    cacheMgr.defaultCache = Cache:new({ maxSize = 1 })
    cacheMgr.sceneCache = Cache:new({ maxSize = 0 })
    cacheMgr.prefabCache = Cache:new({ maxSize = 1 })
end

return cacheMgr
