local ComBase = require("common.ComBase")
local ComGo = ComBase:extends()

function ComGo:onNew()
    self:onAwake()
end

function ComGo:show()
    if not self.isEnable then
        self.isEnable = true
        self.gameObject:SetActive(true)
        self:onEnable()
    end
    self:onShow()
end

function ComGo:hide()
    if self.isEnable then
        self.isEnable = false
        self:hideChildren()
        self:onDisable()
        self:unRegAllEvent()
        self:unScheduleAllTimer()
        self.gameObject:SetActive(false)
    end
end

return ComGo
