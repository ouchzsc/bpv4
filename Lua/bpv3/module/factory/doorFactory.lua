local doorFactory = {}
function doorFactory.create()
    local entity = Entity:new()
    entity:addComponent(GameObject)
    entity:addComponent(RenderRect)
    entity:addComponent(MapDoor)
    entity:setData({
        name = "door",
        layerMask = layerMask.trigger,
        mapPath = mapPath,
    })
    return entity
end
return doorFactory