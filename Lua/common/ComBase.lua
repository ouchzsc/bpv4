local Object = require("common.Object")
local Stream = require("common.Stream")
local module = require("module.module")
local ComBase = Object:extends()

function ComBase:onAwake()

end

function ComBase:onEnable()

end

function ComBase:onShow()

end

function ComBase:onDisable()

end

function ComBase:onDestroy()

end

local function unregisterEvtHandlerEach(unreg)
    unreg()
end

function ComBase:unRegAllEvent()
    if self.__evthandlers ~= nil then
        self.__evthandlers:ForEach(unregisterEvtHandlerEach)
        self.__evthandlers:Clear()
    end
end

function ComBase:reg(simpleevt, handler)
    if self.__evthandlers == nil then
        self.__evthandlers = Stream:New()
    end

    local unreg = simpleevt:Register(handler, self)
    local id = self.__evthandlers:Add(unreg)
    return function()
        local old = self.__evthandlers:Delete(id)
        if old then
            old()
        end
    end
end

function ComBase:unScheduleAllTimer()
    if self.__timer_fixedids then
        for _, id in pairs(self.__timer_fixedids) do
            module.timer.globalTimer:Unschedule(id)
        end
        self.__timer_fixedids = nil
    end
end

function ComBase:scheduleTimer(fixid, delay, task, ...)
    local id
    if self.__timer_fixedids == nil then
        self.__timer_fixedids = {}
    else
        id = self.__timer_fixedids[fixid]
    end

    id = module.timer.globalTimer:Schedule(id, delay, task, self, ...) --- 这里不用在timer结束的时候清除，是因为这个id是自增的，不考虑回绕
    self.__timer_fixedids[fixid] = id
end

function ComBase:scheduleTimerAtFixedRate(fixid, delay, period, task, ...)
    local id
    if self.__timer_fixedids == nil then
        self.__timer_fixedids = {}
    else
        id = self.__timer_fixedids[fixid]
    end

    id = module.timer.globalTimer:scheduleAtFixedRate(id, delay, period, task, self, ...)
    self.__timer_fixedids[fixid] = id
end

function ComBase:unscheduleTimer(fixid)
    if self.__timer_fixedids then
        local id = self.__timer_fixedids[fixid]
        if id then
            self.__timer_fixedids[fixid] = nil
            module.timer.globalTimer:Unschedule(id)
        end
    end
end

function ComBase:addChild(GoComClass, gameObject)
    self.children = self.children or {}
    local com = GoComClass:new({ gameObject = gameObject })
    gameObject:SetActive(false)
    com.isEnable = false
    self.children[com] = true
    return com
end

function ComBase:addBehavior(BeComClass)
    self.children = self.children or {}
    local com = BeComClass:new({ parent = self })
    com.isEnable = false
    self.children[com] = true
    return com
end

function ComBase:hideChildren()
    self.children = self.children or {}
    for child, _ in pairs(self.children) do
        child:hide()
    end
end

function ComBase:removeChildren()
    self.children = self.children or {}
    for child, _ in pairs(self.children) do
        child:removeChildren()
        child:onDestroy()
        child.gameObject = nil
    end
    self.children = {}
end

return ComBase
