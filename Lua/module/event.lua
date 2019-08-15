local SimpleEvent = require("common.SimpleEvent")
local event = {}

function event:init()
    event.onUpdate = SimpleEvent:New("onUpdate")
    event.onFixedUpdate = SimpleEvent:New("onFixedUpdate")
    event.onLateUpdate = SimpleEvent:New("onLateUpdate")
end

return event
