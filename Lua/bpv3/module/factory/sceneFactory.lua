local sceneFactory = {}

function sceneFactory:create(SceneCls, mapPath)
    local entity = Entity:new()
    entity:setData({ mapPath = mapPath })
    entity:addComponent(SceneCls)
    return entity
end

return sceneFactory