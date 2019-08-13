local brickFactory = {}

function brickFactory.create()
    local brick = Entity:new()
    brick:addComponent(GameObject)
    brick:addComponent(RenderRect)
    brick:setData({
        name = 'brick',
        layerMask = layerMask.brick,
        w = gVariables.worldCellSize,
        h = gVariables.worldCellSize
    })
    return brick
end

return brickFactory