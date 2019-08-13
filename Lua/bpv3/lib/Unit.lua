local Unit = Entity:extends()

function Unit:addAbility(ability_cls)
    self:addComponent(ability_cls)
end

function Unit:removeAbility(ability_cls)
    self:removeComponent(ability_cls)
end

return Unit