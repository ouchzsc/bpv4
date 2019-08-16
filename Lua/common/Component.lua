local Entity = require("common.Entity")
local module = require("module.module")
local Component = Entity:extends() --这里偷懒了，想让Component和Entity一样强大，继承了Entity的方法。

function Component:addChild()
    module.logger.error("behavior can not add child com")
end

function Component:addBehavior()
    module.logger.error("behavior can not add behavior")
end

function Component:onNew()
    self:onAwake()
end

function Component:show()
    if not self.isEnable then
        self.isEnable = true
        self:onEnable()
    end
    self:onShow()
end

function Component:hide()
    if self.isEnable then
        self.isEnable = false
        self:onDisable()
        self:unRegAllEvent()
        self:unScheduleAllTimer()
    end
end

return Component
