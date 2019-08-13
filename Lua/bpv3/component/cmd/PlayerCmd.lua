local PlayerCmd = Component:extends()

function PlayerCmd:onEnable()
    local entity = self.entity
    self:reg(event.onCmdUpdate, function(dt)
        if love.mouse.isDown(1) then
            self.entity:popEvent("attack")
        end
        entity.cmdX, entity.cmdY = utils.getAxisWasd()
        local x, y = utils.getMouseWorldPos()
        entity.dir = 1
        if x < entity.x then
            entity.dir = -1
        end
    end)
end

return PlayerCmd