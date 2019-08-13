local HitBack = Component:extends()
local time = 0.2
local backVx, backVy = 800, -50
function HitBack:onPopEvent(type, data)
    local entity = self.entity
    if type == "HitBack" then

        local src = data.src
        local cd = data.cd or 1
        entity.hitBackSources = entity.hitBackSources or {}
        if entity.hitBackSources[src] then
            return
        end
        entity.hitBackSources[src] = true
        self:scheduleTimer("removeSrc", cd, function()
            entity.hitBackSources[src] = nil
        end)

        local other = data.other
        if other.x > entity.x then
            self.vx = -backVx
        else
            self.vx = backVx
        end
        self.vy = backVy
        self:scheduleTimer("cancle", time, function()
            self.vx = nil
            self.vy = nil
        end)
    end
end

function HitBack:onEnable()
    self:reg(event.onAfterLateUpdate, function(dt)
        if self.vx and self.vy then
            self.entity.vx = self.vx
            self.entity.vy = self.vy
        end
    end)
end

return HitBack