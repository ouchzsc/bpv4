local effectFactory = {}

function effectFactory.createAttachEffect(data)
    local entity = Entity:new()
    entity:addComponent(Animator)
    entity:addComponent(GameObject)
    entity:addComponent(Attach)
    entity.x = data.targetEntity.x
    entity.y = data.targetEntity.y
    entity.ACT_IDLE = data.animcfg
    entity.w = data.animcfg.width * data.animcfg.scale
    entity.h = data.animcfg.height * data.animcfg.scale
    entity.offsetX = data.offsetX or 0
    entity.offsetY = data.offsetY or 0
    entity.sortingOrder = 1
    entity.name = "effect"
    entity.targetEntity = data.targetEntity
    entity.layerMask = layerMask.trigger
    return entity
end

function effectFactory.createProjectile(data)
    local bulletEntity = Entity:new()
    bulletEntity:addComponent(GameObject)
    bulletEntity:addComponent(RenderRect)
    bulletEntity:addComponent(TimeToLive)
    bulletEntity:addComponent(CmdMove)
    bulletEntity:addComponent(BulletAI)
    bulletEntity:addComponent(Projectile)
    bulletEntity:setData({
        name = "bullet",
        x = data.x,
        y = data.y,
        w = data.w,
        h = data.h,
        timeLife = data.timeLife,
        v = data.v,
        dir = data.dir,
        color = data.color,
        layerMask = layerMask.trigger,
        caster = data.caster,
    })
    return bulletEntity
end

function effectFactory.createStill(data)
    local entity = Entity:new()
    entity:addComponent(GameObject)
    entity:addComponent(RenderRect)
    entity:addComponent(TimeToLive)
    entity:addComponent(Projectile)
    entity:addComponent(Animator)
    entity:setData({
        name = data.name or "stillEffect",
        x = data.x,
        y = data.y,
        w = data.w,
        h = data.h,
        dir = data.dir,
        animcfg = data.animcfg,
        timeLife = data.timeLife,
        sortingOrder = data.sortingOrder or 2,
        layerMask = layerMask.trigger,
        teamId = data.teamId,
        caster = data.caster,
        ACT_IDLE = data.animcfg
    })
    return entity
end

return effectFactory