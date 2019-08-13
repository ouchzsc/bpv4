local HideDashBoard = Component:extends()

function HideDashBoard:onEnable()
    ui.panelDashBoard:hide()
end

function HideDashBoard:onDisable()
    ui.panelDashBoard:show()
end

return HideDashBoard