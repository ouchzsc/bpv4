local slimeFactory = {}

function slimeFactory:create()
    local entity = Entity:new()
    entity:addComponent(RenderRect)
    entity:addComponent(RecoverJumpForceByLand)
    entity:addComponent(Gravity)
    entity:addComponent(AccSystem)
    entity:addComponent(GameObject)
    entity:addComponent(PhysicsMove)
    entity:addComponent(SlimeAI)
    entity:addComponent(RenderHitting)
    entity:addComponent(HitBack)
    entity:addComponent(EnemyHp)
    entity:addComponent(Hp)
    entity:setData({
        name = "slime",
        hp = 10,
        maxHp = 10,
        teamId = 2,
        w = 25,
        h = 25,
        speedBase = 150,
        speedPer = 1,
        friction = 50,
        color = { 1, 0.5, 0.5, 1 },
        layerMask = layerMask.player,
    })
    return entity
end

return slimeFactory