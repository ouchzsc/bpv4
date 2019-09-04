local module = {}

function module.init()
    module.logger = require("module.logger")
    module.assetMgr = require("module.assetMgr")
    module.cacheMgr = require("module.cacheMgr")
    module.input = require("module.input")
    module.event = require("module.event")
    module.boot = require("module.boot")
    module.layerMask = require("module.layerMask")
    module.bumpWorld = require("module.bumpWorld")
    module.playerMgr = require("module.playerMgr")
    module.uiMgr = require("module.uiMgr")
    module.scene = require("module.scene")
    module.cfg = require("cfg._cfgs")
    module.event.init()
    module.input.init()
    module.cacheMgr.init()
    module.layerMask.init()
    module.uiMgr.init()

    -----------------
    --module.cfgMgr = require("Config.cfgMgr")
    --module.cfgMgr.init()
    --module.scene = require("module.scene")
    --module.boot = require("module.boot")
    --module.playerMgr = require("module.playerMgr")
    --module.worldEvent = require("module.worldEvent")
    --module.timer = require("module.timer")
    --module.npcMgr = require("module.npcMgr")
    --module.playableMgr = require("module.playableMgr")
    --module.timer.init()
    --module.boot.init()
end

return module
