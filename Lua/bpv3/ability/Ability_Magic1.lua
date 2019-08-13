local Ability_Magic1 = Ability:extends()

function Ability_Magic1:onSpellStart()
    local entity = self.entity

    local mx, my = utils.getMouseWorldPos()
    local iteminfo, len = world:querySegmentWithCoords(mx, my, mx, my + 2000, function(item)
        return item.layerMask == layerMask.brick
    end)
    local x, y
    if len > 0 then
        x = iteminfo[1].x1
        y = iteminfo[1].y1
        local w = animations.effect1.width * animations.effect1.scale
        local h = animations.effect1.height * animations.effect1.scale
        local effect = effectFactory.createStill({
            animcfg = animations.effect1,
            x = x - w / 2,
            y = y - h,
            w = w,
            h = h,
            timeLife = 1,
            layerMask = layerMask.bullet,
            teamId = self.entity.teamId,
            caster = self.entity,
            sortingOrder = 2,
            name = "Ability_Magic1_effect"
        })
        effect:showBy(sceneModule.curScene)
    end
end

function Ability_Magic1:onGetName()
    return "MagicAb"
end

function Ability_Magic1:onGetCd()
    return 0.4
end

function Ability_Magic1:onGetAbilityCastPoint()
    return 0
end

function Ability_Magic1:onProjectileHit(data)
    local target = data.target
    local projectile = data.projectile

    if target.layerMask == layerMask.brick then
        return true
    end

    if target.layerMask == layerMask.trigger then
        return false
    end

    --击中敌人
    if target.layerMask == layerMask.player and self.entity.teamId ~= target.teamId then
        target:popEvent("Hp_Damage", { damage = 1, src = projectile })
        target:popEvent("HitBack", { other = projectile, src = projectile })
    end
    return false
end

return Ability_Magic1