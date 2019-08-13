local Modifier_Slow = Modifier:extends()

function Modifier_Slow:onEnable()
    self.effect = effectFactory.createAttachEffect({
        animcfg = animations.effect_slow,
        targetEntity = self.entity
    })
    self.effect:showBy(self.entity)
end

function Modifier_Slow:onDisable()
    self.effect:hide()
end

function Modifier_Slow:onGetModifierMoveSpeedBonus_Constant()
    return 0
end

function Modifier_Slow:onGetModifierMoveSpeedBonus_Percentage()
    return 0.5
end

function Modifier_Slow:onGetDuration()
    return 2
end

return Modifier_Slow