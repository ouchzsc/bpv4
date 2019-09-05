local Component = require("component.Component")
local JumpEnergy = Component:extends()
local defaultJumpEnergyMax = 0.3
local module = require("module.module")

function JumpEnergy:onPopEvent(type, data)
    local entity = self.entity
    entity.jumpEnergyMax = entity.jumpEnergyMax or defaultJumpEnergyMax
    entity.jumpEnergy = entity.jumpEnergy or entity.jumpEnergyMax
    if type == "onCollision" then
        local col = data.col
        if col.normal.y ~= 0 and entity.y > data.other.y then
            if module.input.axisY <= 0 then
                if entity.jumpEnergy < entity.jumpEnergyMax then
                    entity.jumpEnergy = entity.jumpEnergyMax
                end
            end
        end
    end
end

return JumpEnergy