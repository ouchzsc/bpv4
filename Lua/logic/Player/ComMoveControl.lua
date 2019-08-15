local Component = require("common.Component")
local ComMoveControl = Component:extends()
local module = require("module.module")
local Vector3 = CS.UnityEngine.Vector3

function ComMoveControl:onAwake()
    self.gameObject = self.entity.gameObject
end

function ComMoveControl:onEnable()
    self:reg(module.event.onUpdate, self.onUpdate)
end

function ComMoveControl:onUpdate()
    local x, y = module.input.axisX, module.input.axisY
    local oldPos = self.gameObject.transform.position
    oldPos = oldPos + Vector3(x * 0.01, y * 0.01, 0)
    self.gameObject.transform.position = oldPos
end

return ComMoveControl