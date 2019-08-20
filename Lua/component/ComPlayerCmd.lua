local Component = require("common.Component")
local module = require("module.module")

local ComPlayerCmd = Component:extends()

function ComPlayerCmd:onEnable()
    local entity = self.entity
    self:reg(module.event.onUpdate, function(dt)
        entity.cmdX, entity.cmdY = module.input.axisX, module.input.axisY
        local x = module.input.mouseX
        entity.dir = 1
        if x < entity.x then
            entity.dir = -1
        end
    end)
end

return ComPlayerCmd