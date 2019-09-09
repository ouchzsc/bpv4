local Component = require("component.Component")
local module = require("module.module")
local Gravity = Component:extends()

local defaultgravityY = -50

function Gravity:onEnable()
    self:reg(module.event.onFixedUpdate, self.onFixedUpdate)
end

function Gravity:onFixedUpdate(dt)
    local entity = self.entity
    entity.ayMap = entity.ayMap or {}
    entity.ayMap.gravityY = defaultgravityY
end

function Gravity:onDisable()
    if self.entity.ayMap then
        self.entity.ayMap.gravityY = nil
    end
end

return Gravity