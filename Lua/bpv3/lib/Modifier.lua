local Modifier = Component:extends()

function Modifier:_onModifierEnable()
    -- speed X
    self.entity.speedBase = self.entity.speedBase + self:onGetModifierMoveSpeedBonus_Constant()
    self.entity.speedPer = self.entity.speedPer * self:onGetModifierMoveSpeedBonus_Percentage()

    --stun
    if self:onGetStun() then
        self.entity.stunCnt = self.entity.stunCnt or 0
        self.entity.stunCnt = self.entity.stunCnt + 1
    end

    -- duration
    local duration = self:onGetDuration()
    if duration > 0 then
        self:scheduleTimer("modifier_duration", duration, function()
            self.entity:removeComponentInst(self)
        end)
    end

    --not multiple
    local canMulti = self:onGetIsMultiple()
    if not canMulti then
        self.entity:removeOtherComponentInst(self)
    end
end

function Modifier:_onModifierDisable()
    self.entity.speedBase = self.entity.speedBase - self:onGetModifierMoveSpeedBonus_Constant()
    self.entity.speedPer = self.entity.speedPer / self:onGetModifierMoveSpeedBonus_Percentage()
    if self:onGetStun() then
        self.entity.stunCnt = self.entity.stunCnt - 1
    end
end

function Modifier:onGetModifierMoveSpeedBonus_Constant()
    return 0
end

function Modifier:onGetModifierMoveSpeedBonus_Percentage()
    return 1
end

function Modifier:onGetStun()
    return false
end

function Modifier:onGetIsMultiple()
    return false
end

function Modifier:onGetDuration()
    return 1
end

return Modifier