local cfgMgr = {}

function cfgMgr.init()
    cfgMgr.assets = require("Config.assets")
    cfgMgr.npc = require("Config.npc")
end

return cfgMgr
