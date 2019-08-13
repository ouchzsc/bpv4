local Ability_NearAttack = Ability:extends()

function Ability_NearAttack:onSpellStart()
    local entity = self.entity
    local dir = entity.dir
    local x, y
    if dir > 0 then
        x = entity.x + entity.w
    else
        x = entity.x - animations.effect_attack.width * animations.effect_attack.scale/2
    end
    y = entity.y
    local bullet = effectFactory.createStill({
        animcfg = animations.effect_attack,
        caster = entity,
        x = x,
        y = y,
        w = animations.effect_attack.width * animations.effect_attack.scale/2,
        h = entity.h,
        timeLife = 1,
        dir = dir,
        color = { 1, 0.5, 0.6, 1 },
        layerMask = layerMask.bullet,
        teamId = entity.teamId,
    })
    bullet:showBy(sceneModule.curScene)
end

function Ability_NearAttack:onGetAbilityCastAnimation()
    return "ACT_CAST_ABILITY_1"
end

function Ability_NearAttack:onProjectileHit(data)
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

return Ability_NearAttack