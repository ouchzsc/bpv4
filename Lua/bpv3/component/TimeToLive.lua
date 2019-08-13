local TimeToLive = Component:extends()
local defaultTtl = 3
function TimeToLive:onEnable()
    local entity = self.entity
    self:scheduleTimer("timeToLive", entity.timeLife or defaultTtl, function()
        entity:hide()
    end)
end

return TimeToLive