local boot = {}
local module = require("module.module")

function boot.start()
    module.uiMgr.panelStart:show()
end

return boot