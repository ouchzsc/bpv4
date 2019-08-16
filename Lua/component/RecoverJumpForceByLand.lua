local RecoverJumpForceByLand = Component:extends()
local defaultJumpEnergyMax = 10

function RecoverJumpForceByLand:onPopEvent(type, data)
    local entity = self.entity
    entity.jumpEnergyMax = entity.jumpEnergyMax or defaultJumpEnergyMax
    entity.jumpEnergy = entity.jumpEnergy or entity.jumpEnergyMax
    if type == "onCollision" then
        local col = data.col
        if col.normal.y ~= 0 and entity.y < data.other.y then
            if not love.keyboard.isDown("w") then
                if entity.jumpEnergy < entity.jumpEnergyMax then
                    entity.jumpEnergy = entity.jumpEnergyMax
                end
            end
        end
    end
end

return RecoverJumpForceByLand