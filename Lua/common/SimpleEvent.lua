local Stream = require("common.Stream")
local SimpleEvent = {}

local all = {}
SimpleEvent._all = all

function SimpleEvent:New(name)
    local instance = {}
    setmetatable(instance, self)
    self.__index = self
    instance.name = name
    instance.listeners = Stream:New()
    instance.triggercnt = 0
    instance.handlerId2Arg1 = nil
    table.insert(all, instance)
    return instance
end

function SimpleEvent:Register(handler, arg1)
    local id = self.listeners:Add(handler)
    if arg1 then
        if self.handlerId2Arg1 == nil then
            self.handlerId2Arg1 = {}
        end
        self.handlerId2Arg1[id] = arg1
    end

    return function()
        self.listeners:Delete(id)
        if self.handlerId2Arg1 then
            self.handlerId2Arg1[id] = nil
        end
    end
end

function SimpleEvent:Unregister(id)
    self.listeners:Delete(id)
    if self.handlerId2Arg1 then
        self.handlerId2Arg1[id] = nil
    end
end


local function SafeTriggerEach(handler, id, self, ...)
    local arg1
    if self.handlerId2Arg1 then
        arg1 = self.handlerId2Arg1[id]
    end
    if arg1 then
        handler(arg1, ...)
    else
        handler(...)
    end
end

function SimpleEvent:trigger(...)
    --    logger.Event(self.name, ...)
    self.triggercnt = self.triggercnt + 1
    self.listeners:ForEach(SafeTriggerEach, self, ...)
end

function SimpleEvent.dumpAll(print)
    print("======== SimpleEvent.dumpAll")
    for _, e in ipairs(all) do
        print("evt=" .. e.name .. ",listencnt=" .. e.listeners:Size() .. ",triggercnt=" .. e.triggercnt)
    end
end


return SimpleEvent
