local boot = {}

function boot.start()
    love.graphics.setDefaultFilter('nearest')
    love.graphics.setLineStyle("rough")
    world = bump.newWorld(gVariables.worldCellSize)
    gVariables.init()
    layerMask.init()
    event.init()
    timer.init()
    animations.init()
    system.init()
    heroModule.init()
    local cam = camModule.get()
    cam:show()
    sceneModule.load(Scene1, "config/map1.csv")

    ui = {}
    ui.panelMain = Entity:new()
    ui.panelMain:addComponent(PanelMain)
    ui.panelMain:show()
end

return boot