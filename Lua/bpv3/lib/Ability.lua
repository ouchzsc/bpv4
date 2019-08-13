local Ability = Component:extends()

function Ability:setAnimation(animCfg)

end

function Ability:onPopEvent(type, data)
    if type == "attack" then
        -- todo 如果有其他的技能在施法中，要么不让施法，要么先打断其他施法
        if self:getLeftCd() > 0 then
            return
        else
            self:setLastTime(timer.now)
            self:_startPlayAnim()
            if self.onAbilityPhaseStart then
                self:onAbilityPhaseStart()
            end
        end
    end
    if type == "Ability_onProjectileHit" then
        if self:onProjectileHit({ target = data.target, projectile = data.projectile }) then
            data.projectile:hide()
        end
    end
end

function Ability:onProjectileHit(data)
    return false
end

function Ability:onGetAbilityCastPoint()
    return 0.02
end

function Ability:onGetAbilityCastAnimation()
    return "ACT_CAST_ABILITY_1"
end

function Ability:onGetCd()
    return 2
end

function Ability:getLeftCd()
    if self.lastTime == nil then
        return 0
    else
        return self:onGetCd() - (timer.now - self.lastTime)
    end
end

function Ability:onGetName()
    return "Unnamed Ability"
end

function Ability:setLastTime(time)
    self.lastTime = time
end

function Ability:_startPlayAnim()
    local entity = self.entity
    local animationKey = self:onGetAbilityCastAnimation()
    local animcfg = entity[animationKey]
    self.entity:popEvent("Aniamtor_Play", animcfg)
    local animtime = self:onGetCd() --or animcfg.loopTime
    animcfg.animloop = animtime
    self:scheduleTimer("anim_duration", animtime, function()
        self:_stopPlayAnim()
    end)
    self:scheduleTimer("to_spellstart", self:onGetAbilityCastPoint(), function()
        self:onSpellStart()
    end)
end

function Ability:_stopPlayAnim()
    local entity = self.entity
    self.entity:popEvent("Aniamtor_Play", entity.ACT_IDLE)
end

function Ability:addModifier(cls)
    if self.entity.modifiers == nil then
        self.entity.modifiers = Stream:New()
    end
    self.entity.modifiers:Put(cls)
end

return Ability