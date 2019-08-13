local BulletAI = Component:extends()
local defaultViewWidth, defaultViewHeight = 600, 300
function BulletAI:onEnable()
    local entity = self.entity
    self:scheduleTimerAtFixedRate("bullet_ai", 0, 0.2, function()
        entity.cmdX = entity.dir
    end)
end

return BulletAI