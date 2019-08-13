local SlimeAI = Component:extends()
local defaultViewWidth, defaultViewHeight = 600, 300
function SlimeAI:onEnable()
    local entity = self.entity
    self:scheduleTimerAtFixedRate("slimecmd", 0, 2, function()
        self.targetEntity = utils.findTarget(entity.x, entity.y, defaultViewWidth, defaultViewHeight, function(item)
            return item.layerMask == layerMask.player and item.teamId ~= entity.teamId
        end)
        if self.targetEntity then
            local x, y = entity.x or 0, entity.y or 0
            local tx, ty = self.targetEntity.x or 0, self.targetEntity.y or 0
            entity.cmdX, entity.cmdY = 0, -1
            if x < tx - 5 then
                entity.cmdX = 1
                entity.dir = 1
            elseif x > tx + 5 then
                entity.cmdX = -1
                entity.dir = -1
            else
                entity.cmdX = 0
            end
            self:scheduleTimer("releaseY", 0.2, function()
                entity.cmdY = 0
            end)
            self:scheduleTimer("releaseX", 0.8, function()
                entity.cmdX = 0
            end)
        end
    end)
end

return SlimeAI