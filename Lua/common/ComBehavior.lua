local ComBase = require("common.ComBase")
local module = require("module.module")
local ComBehavior = ComBase:extends()

function ComBehavior:addChild()
    module.logger.error("behavior can not add child com")
end

function ComBehavior:onNew()
    self:onAwake()
end

function ComBehavior:show()
    if not self.isEnable then
        self.isEnable = true
        self:onEnable()
    end
    self:onShow()
end

function ComBehavior:hide()
    if self.isEnable then
        self.isEnable = false
        self:hideChildren()
        self:onDisable()
        self:unRegAllEvent()
        self:unScheduleAllTimer()
    end
end

return ComBehavior
