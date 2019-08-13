local Object = {}

function Object:extends()
    local instance = {}
    setmetatable(instance, self)
    self.__index = self
    return instance
end

function Object:new(o)
    local instance = o or {}
    setmetatable(instance, self)
    self.__index = self
    instance:onNew()
    return instance
end


function Object:onNew()
end

function Object:setData(data)
    for k, v in pairs(data) do
        self[k] = v
    end
end


return Object