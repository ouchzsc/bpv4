local Component = require("component.Component")
local module = require("module.module")

local ComPlayerCmd = Component:extends()

function ComPlayerCmd:onEnable()
    self:reg(module.event.onUpdate, self.onUpdate)
end

function ComPlayerCmd:onUpdate(dt)
    local entity = self.entity
    entity.cmdX, entity.cmdY = module.input.axisX, module.input.axisY
    local x = module.input.mouseX
    entity.dir = 1
    if x < entity.x then
        entity.dir = -1
    end
end

return ComPlayerCmd