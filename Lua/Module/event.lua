local SimpleEvent = require("Common.SimpleEvent")
local event = {}

function event:init()
    event.onUpdate = SimpleEvent:New("onUpdate")
    event.onFixedUpdate = SimpleEvent:New("onFixedUpdate")
    event.onLateUpdate = SimpleEvent:New("onLateUpdate")
    event.enterArea = SimpleEvent:New("enterArea")
    event.onChunkEnable = SimpleEvent:New("onChunkEnable")
    event.onChunkDisable = SimpleEvent:New("onChunkDisable")
    event.updatePlayerPos = SimpleEvent:New("updatePlayerPos")
    event.onHeroEnable = SimpleEvent:New("onHeroEnable")
end

return event
