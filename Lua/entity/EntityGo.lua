local Entity = require("entity.Entity")
local EntityGo = Entity:extends()

function EntityGo:onNew()
    self:onAwake()
end

function EntityGo:show()
    if not self.isEnable then
        self.isEnable = true
        self.gameObject:SetActive(true)
        self:onEnable()
    end
    self:onShow()
end

function EntityGo:hide()
    if self.isEnable then
        self.isEnable = false
        self:hideChildren()
        self:onDisable()
        self:unRegAllEvent()
        self:unScheduleAllTimer()
        self.gameObject:SetActive(false)
    end
end

return EntityGo
