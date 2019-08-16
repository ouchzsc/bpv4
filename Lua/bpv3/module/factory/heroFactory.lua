local heroFactory = {}

function heroFactory.create()
    local entity = Entity:new()
    entity:addComponent(GameObject)
    entity:addComponent(PlayerCmd)
    entity:addComponent(PhysicsMove)
    entity:addComponent(Gravity)
    entity:addComponent(AccSystem)
    entity:addComponent(RecoverJumpForceByLand)
    entity:addComponent(RenderHitting)
    entity:addComponent(HitBack)
    entity:addComponent(Animator)
    entity:addComponent(Hp)
    entity:addComponent(HeroHp)

    entity:setData({
        name = 'hero',
        hp = 5,
        w = 22,
        h = 50,
        teamId = 1,
        dir = 1,
        speedBase = 300,
        speedPer = 1,
        friction = 15,
        layerMask = layerMask.player,
        maxJumpTime = 3,
        axMap = {},
        ayMap = {},
        ACT_IDLE = animations.hero_idle,
        ACT_CAST_ABILITY_1 = animations.hero_attack1,
    })
    return entity
end

return heroFactory