local Component = require("component.Component")
local module = require("module.module")
local Gravity = Component:extends()

local gravityRatio = -10
local defaultWeight = 10

function Gravity:onEnable()
    self:reg(module.event.onFixedUpdate, self.onFixedUpdate)
    self.entity.weight = self.entity.weight or defaultWeight
end

function Gravity:onFixedUpdate(dt)
    local entity = self.entity
    entity.ayMap = entity.ayMap or {}
    entity.ayMap.gravityY = gravityRatio * self.entity.weight
end

function Gravity:onDisable()
    if self.entity.ayMap then
        self.entity.ayMap.gravityY = nil
    end
end

return Gravity