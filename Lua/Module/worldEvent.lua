local SimpleClass = require("Core.SimpleClass")
local module = require("Module.module")
local Time = CS.UnityEngine.Time
local worldEvent = SimpleClass()

function worldEvent:Update()
    local dt = Time.deltaTime
    module.timer.onUpdate(dt)
    module.event.onUpdate:trigger(dt)
end

function worldEvent:FixedUpdate()
    local dt = Time.fixedDeltaTime
    module.event.onFixedUpdate:trigger(dt)
end

function worldEvent:LateUpdate()
    module.event.onLateUpdate:trigger(Time.deltaTime)
end

return worldEvent