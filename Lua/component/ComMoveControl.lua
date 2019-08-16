local Component = require("common.Component")
local ComMoveControl = Component:extends()
local module = require("module.module")

function ComMoveControl:onEnable()
    self:reg(module.event.onUpdate, self.onUpdate)
end

function ComMoveControl:onUpdate()
    local x, y = module.input.axisX, module.input.axisY
    self.entity.x = self.entity.x + x * 0.01
    self.entity.y = self.entity.y + y * 0.01
end

return ComMoveControl