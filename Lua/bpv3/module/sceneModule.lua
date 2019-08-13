local sceneModule = {}

function sceneModule.load(cls, path)
    if sceneModule.curScene then
        sceneModule.curScene:hide()
    end
    local sceneEntity = Entity:new()
    sceneEntity:addComponent(cls)
    sceneEntity:setData({ mapPath = path })
    sceneEntity:show()
    sceneModule.curScene = sceneEntity
end

return sceneModule