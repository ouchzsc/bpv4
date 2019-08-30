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

function Entity:addEntity(entityId, entityType, entityData)
    self.entities = self.entities or {}
    local entity = self.entities[entityId]
    if entity then
        module.logger.info("entity id existed: %s", entityId)
        return entity
    end
    entity = entityType:new({ parent = self })
    entity:setData(entityData)
    self.entities[entityId] = entity
    return entity
end


function Entity:removeEntity(entityId)
    self.entities = self.entities or {}
    local entity = self.entities[entityId]
    if entity then
        entity.parent = nil
        self.entities[entityId] = nil
        entity:hide()
    else
        module.logger.info("remove entity id not existed: %s", entityId)
    end
end

function Entity:addEntityGo(GoComClass, gameObject)
    self.entityGos = self.entityGos or {}
    local com = GoComClass:new({ gameObject = gameObject, parent = self })
    gameObject:SetActive(false)
    self.entityGos[com] = true
    return com
end

function Entity:addComponent(BeComClass)
    self.components = self.components or Stream:New()
    local com = BeComClass:new({ entity = self })
    com.isEnable = false
    self.components:Add(com)
    return com
end

function Entity:hideChildren()
    if self.entityGos then
        for entityGo, _ in pairs(self.entityGos) do
            entityGo:hide()
        end
    end
    if self.entities then
        for id, entity in pairs(self.entities) do
            entity:hide()
        end
    end
    if self.components then
        for com, _ in pairs(self.components) do
            com:hide()
        end
    end
end

function Entity:removeChildren()
    -- ☆ 目前的设计方案，在这里清理父子关系，即父子关系维持在Awake和Destroy之间
    -- 所以不支持创建archetype的写法，添加儿子都写到生命周期里

    -- entityGOs 和 components没有自己的cache，随父cache，Destroy需要父亲调用
    if self.entityGos then
        for entityGo, _ in pairs(self.entityGos) do
            entityGo:removeChildren()
            entityGo:onDestroy()
            entityGo.gameObject = nil
            entityGo.parent = nil
        end
        self.entityGos = nil
    end
    if self.components then
        for com, _ in pairs(self.components) do
            --component没有子，不需要调用removeChildren
            com:onDestroy()
            com.entity = nil
        end
        self.components = nil
    end

    -- entities 有自己的cache管理Destroy，不用父亲管理Destroy,但还需要清理父子关系
    if self.entities then
        for id, entity in pairs(self.entities) do
            entity.parent = nil
        end
        self.entities = nil
    end
end

function Entity:popEvent(eventtype, data)
    if self.components == nil then
        return
    end
    self.components:ForEach(function(com, id)
        if com.isEnable and com.onPopEvent then
            com:onPopEvent(eventtype, data)
        end
    end)
end

return Entity
