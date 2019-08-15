local SimpleEvent = require("common.SimpleEvent")
local event = {}

function event:init()
    event.onUpdate = SimpleEvent:New("onUpdate")
    event.onFixedUpdate = SimpleEvent:New("onFixedUpdate")
    event.onLateUpdate = SimpleEvent:New("onLateUpdate")
    event.onInputX = SimpleEvent:New("onInputX")
    event.onInputY = SimpleEvent:New("onInputY")
end

return event
