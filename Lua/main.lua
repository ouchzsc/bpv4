local main = {}
local module = require "module.module"

function main.start()
    module.init()
    module.world.start()
end

function main.update()
    module.event.onUpdate:trigger()
end

return main