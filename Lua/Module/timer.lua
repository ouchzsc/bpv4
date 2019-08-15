local Timer= require("common.Timer")
local timer = {}

function timer.init()
    timer.globalTimer = Timer:New()
    timer.now = 0
end

function timer.onUpdate(dt)
    timer.globalTimer:Update(dt)
    timer.now = timer.now + dt
end

return timer
