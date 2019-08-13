local Ability_Bullet = Ability:extends()

function Ability_Bullet:onSpellStart()
    local entity = self.entity
    local dir = entity.dir
    local x, y
    if dir > 0 then
        x = entity.x + entity.w + 3
    else
        x = entity.x - entity.w - 3
    end
    y = entity.y + entity.h / 2
    local bullet = effectFactory.createProjectile({
        caster = entity,
        x = x,
        y = y,
        w = 20,
        h = 5,
        timerLife = 3,
        v = 800,
        dir = dir,
        color = { 0, 0.5, 0.6, 1 },
        layerMask = layerMask.bullet,
    })
    bullet:showBy(sceneModule.curScene)
end

function Ability_Bullet:onGetCd()
    return 0.2
end

function Ability_Bullet:onGetAbilityCastPoint()
    return 0.1
end

function Ability_Bullet:onGetAbilityCastAnimation()
    return "ACT_CAST_ABILITY_1"
end

function Ability_Bullet:onGetName()
    return "BulletAb"
end

function Ability_Bullet:onProjectileHit(data)
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
        target:addComponent(Modifier_Slow)
        return true
    end
    return false
end

return Ability_Bullet