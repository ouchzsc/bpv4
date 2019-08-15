local ComBehavior = require("common.ComBehavior")
local module = require("module.module")
local BehvAttackControl = ComBehavior:extends()

function BehvAttackControl:onAwake()
    self.animator = self.parent.gameObject:GetComponent("Animator")
end

function BehvAttackControl:onEnable()
    self:reg(module.event.onUpdate, self.onUpdate)
end

function BehvAttackControl:onUpdate()
    local Input = CS.UnityEngine.Input
    if Input.GetMouseButtonDown(0) then
        self.animator:SetTrigger("t_attack")
    end
end

return BehvAttackControl
