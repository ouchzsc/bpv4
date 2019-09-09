local module = require("module.module")
local Animator = require("component.Component"):extends()

local idle = "idle"
local run = "run"

function Animator:onAwake()
    self.anim = self.entity.gameObject:GetComponent("Animator")
    self.state = "idle"
end

function Animator:onEnable()
    self:reg(module.event.onUpdate, self.onUpdate)
end

function Animator:onUpdate()
    if self.entity.vx > 1 or self.entity.vx < -1 then
        self:trigger(run)
    else
        self:trigger(idle)
    end
end

function Animator:trigger(state)
    if self.state ~= state then
        self.state = state
        self.anim:SetTrigger(state)
    end
end

return Animator