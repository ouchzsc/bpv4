local event = {}
function event.init()
    event.onCmdUpdate = SimpleEvent:New("onCmdUpdate")
    event.onPhysicsUpdate = SimpleEvent:New("onPhysicsUpdate")
    event.onAccSystemUpdate = SimpleEvent:New("onAccSystemUpdate")
    event.onLateUpdate = SimpleEvent:New("onLateUpdate")
    event.onAfterLateUpdate = SimpleEvent:New("onAfterLateUpdate")
    event.onCamDraw = SimpleEvent:New("onCamDraw")
    event.resize = SimpleEvent:New("resize")
    event.onDraw = SimpleEvent:New("onDraw")
    event.onDrawUi = SimpleEvent:New("onDrawUi")
    event.onKeyPressed = SimpleEvent:New("onKeyPressed")
    event.onDoShake = SimpleEvent:New("onDoShake")
end
return event