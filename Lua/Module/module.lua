local module = {}

function module.init()
    module.cfgMgr = require("Config.cfgMgr")
    module.cfgMgr.init()

    module.scene = require("Module.scene")
    module.cacheMgr = require("Module.cacheMgr")
    module.logger= require("Module.logger")
    module.boot = require("Module.boot")
    module.playerMgr = require("Module.playerMgr")
    module.worldEvent = require("Module.worldEvent")
    module.event = require("Module.event")
    module.timer = require("Module.timer")
    module.input = require("Module.input")
    module.npcMgr = require("Module.npcMgr")
    module.playableMgr = require("Module.playableMgr")
    module.event.init()
    module.timer.init()
    module.input.init()
    module.cacheMgr.init()
    module.boot.init()
end

return module
