local Object = require("common.Object")
local Stream = require("common.Stream")
local module = require("module.module")
local Entity = Object:extends()

function Entity:onAwake()

end

function Entity:onEnable()

end

function Entity:onShow()

end

function Entity:onDisable()

end

function Entity:onDestroy()

end

local function unregisterEvtHandlerEach(unreg)
    unreg()
end

function Entity:unRegAllEvent()
    if self.__evthandlers ~= nil then
        self.__evthandlers:ForEach(unregisterEvtHandlerEach)
        self.__evthandlers:Clear()
    end
end

function Entity:reg(simpleevt, handler)
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

function Entity:unScheduleAllTimer()
    if self.__timer_fixedids then
        for _, id in pairs(self.__timer_fixedids) do
            module.timer.globalTimer:Unschedule(id)
        end
        self.__timer_fixedids = nil
    end
end

function Entity:scheduleTimer(fixid, delay, task, ...)
    local id
    if self.__timer_fixedids == nil then
        self.__timer_fixedids = {}
    else
        id = self.__timer_fixedids[fixid]
    end

    id = module.timer.globalTimer:Schedule(id, delay, task, self, ...) --- 这里不用在timer结束的时候清除，是因为这个id是自增的，不考虑回绕
    self.__timer_fixedids[fixid] = id
end

function Entity:scheduleTimerAtFixedRate(fixid, delay, period, task, ...)
    local id
    if self.__timer_fixedids == nil then
        self.__timer_fixedids = {}
    else
        id = self.__timer_fixedids[fixid]
    end

    id = module.timer.globalTimer:scheduleAtFixedRate(id, delay, period, task, self, ...)
    self.__timer_fixedids[fixid] = id
end

function Entity:unscheduleTimer(fixid)
    if self.__timer_fixedids then
        local id = self.__timer_fixedids[fixid]
        if id then
            self.__timer_fixedids[fixid] = nil
            module.timer.globalTimer:Unschedule(id)
        end
    end
end

function Entity:addEntityGo(EntityCls, gameObject)
    self.children = self.children or {}
    local com = EntityCls:new({ gameObject = gameObject })
    gameObject:SetActive(false)
    com.isEnable = false
    self.children[com] = true
    return com
end

function Entity:addComponent(BeComClass)
    self.children = self.children or {}
    local com = BeComClass:new({ entity = self })
    com.isEnable = false
    self.children[com] = true
    return com
end

function Entity:hideChildren()
    self.children = self.children or {}
    for child, _ in pairs(self.children) do
        child:hide()
    end
end

function Entity:removeChildren()
    self.children = self.children or {}
    for child, _ in pairs(self.children) do
        child:removeChildren()
        child:onDestroy()
        child.gameObject = nil
    end
    self.children = {}
end

return Entity
