local heroModule = {}

function heroModule.init()
    heroModule.abilityIndex = 1
    heroModule.abilityList = { Ability_Bullet, Ability_Magic1 }
end

function heroModule.setHero(heroEntity)
    heroModule.hero = heroEntity
    heroEntity:addComponent(heroModule.getCurAbility())
end

function heroModule.getHero()
    return heroModule.hero
end

function heroModule.getCurAbility()
    return heroModule.abilityList[heroModule.abilityIndex]
end

function heroModule:selectPreAbility()
    heroModule.hero:removeComponent(heroModule.getCurAbility())
    heroModule.abilityIndex = heroModule.abilityIndex - 1
    if heroModule.abilityIndex < 1 then
        heroModule.abilityIndex = #heroModule.abilityList
    end
    heroModule.hero:addComponent(heroModule.getCurAbility())
end

function heroModule:selectNextAbility()
    heroModule.hero:removeComponent(heroModule.getCurAbility())
    heroModule.abilityIndex = heroModule.abilityIndex + 1
    if heroModule.abilityIndex > #heroModule.abilityList then
        heroModule.abilityIndex = 1
    end
    heroModule.hero:addComponent(heroModule.getCurAbility())

end
return heroModule