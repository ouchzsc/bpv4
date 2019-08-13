local zombieFactory = {}

function zombieFactory.create()
    local zombie = Entity:new()
    --zombie:addComponent(RenderRect)
    zombie:addComponent(RecoverJumpForceByLand)
    zombie:addComponent(Gravity)
    zombie:addComponent(AccSystem)
    zombie:addComponent(GameObject)
    zombie:addComponent(PhysicsMove)
    zombie:addComponent(ZombieAI)
    zombie:addComponent(RenderHitting)
    zombie:addComponent(HitBack)
    zombie:addComponent(Ability_NearAttack)
    zombie:addComponent(EnemyHp)
    zombie:addComponent(Animator)
    zombie:addComponent(Hp)
    zombie:setData({
        name = "zombie",
        hp = 4,
        maxHp = 4,
        teamId = 2,
        dir = 1,
        w = 30,
        h = 50,
        speedBase = 50,
        speedPer = 1,
        layerMask = layerMask.player,
        ACT_IDLE = animations.zombie_attack,
        ACT_CAST_ABILITY_1 = animations.zombie_attack,
    })
    return zombie
end

return zombieFactory