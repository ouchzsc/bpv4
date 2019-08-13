local CmdMove = Component:extends()

function CmdMove:onEnable()
    self:reg(event.onLateUpdate, function(dt)
        local entity = self.entity
        entity.x = entity.x or 0
        entity.y = entity.y or 0
        entity.v = entity.v or 500
        local x, y = entity.cmdX or 0, entity.cmdY or 0
        entity.x, entity.y = entity.x + x * entity.v * dt, entity.y + y * entity.v * dt
    end)
end

return CmdMove