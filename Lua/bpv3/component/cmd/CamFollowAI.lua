local CamFollowAI = Component:extends()

function CamFollowAI:onEnable()
    local entity = self.entity
    self:reg(event.onCmdUpdate, function(dt)
        local target = heroModule.getHero()
        if target == nil then
            return
        end
        local cx, cy = utils.getCenter(target)
        local x, y = utils.getTopLeft(cx, cy, entity.w, entity.h)
        entity.x = x
        entity.y = y
    end)
end

return CamFollowAI