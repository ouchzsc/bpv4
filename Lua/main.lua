local main = {}
local module = require("module.module")
local Time = CS.UnityEngine.Time

function main.start()
    module.init()
    module.boot.start()
end

function main.update()
    module.event.onUpdate:trigger(Time.deltaTime)
end

function main.fixedUpdate()
    module.event.onFixedUpdate:trigger(Time.deltaTime)
end
function main.lateUpdate()
    module.event.onLateUpdate:trigger(Time.deltaTime)
end
return main