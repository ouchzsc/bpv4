local Entity = Object:extends()

function Entity:onNew()
    self.components = Stream:New()
    self.children = {}
end

function Entity:addChild(child)
    self.children[child] = true
end

function Entity:removeChild(child)
    self.children[child] = nil
end

function Entity:show()
    self.isEnable = true
    self.components:ForEach(function(com, id)
        com:showCom()
    end)
end

function Entity:showBy(parent)
    self:show()
    if parent then
        self.parent = parent
        parent:addChild(self)
    end
end

function Entity:hide()
    if not self.isEnable then
        return
    end
    self.isEnable = false
    -- disable components
    self.components:ForEach(function(com, id)
        com:hideCom()
    end)
    -- hide my children
    for child, _ in pairs(self.children) do
        child:hide()
    end
    self.children = {}

    --remove from parent
    if self.parent then
        self.parent:removeChild(self)
        self.parent = nil
    end
end

function Entity:addComponent(comCls)
    local com = comCls:new({ entity = self })
    self.components:Add(com)
    if self.isEnable then
        com:showCom()
    end
    return com
end

function Entity:removeComponent(comCls)
    self.components:ForEach(function(com, id)
        if getmetatable(com) == comCls then
            com:hideCom()
            com.entity = nil
            self.components:Delete(id)
        end
    end)
end

function Entity:removeComponentInst(instance)
    self.components:ForEach(function(com, id)
        if com == instance then
            com:hideCom()
            com.entity = nil
            self.components:Delete(id)
        end
    end)
end

function Entity:removeOtherComponentInst(instance)
    self.components:ForEach(function(com, id)
        if getmetatable(com) == getmetatable(instance) and com ~= instance then
            com:hideCom()
            com.entity = nil
            self.components:Delete(id)
        end
    end)
end

function Entity:getComponent(comCls)
    local targetCom = nil
    self.components:ForEach(function(com, id)
        if getmetatable(com) == comCls then
            targetCom = com
        end
    end)
    return targetCom
end

function Entity:popEvent(eventtype, data)
    self.components:ForEach(function(com, id)
        if com.isActive and com.onPopEvent then
            com:onPopEvent(eventtype, data)
        end
    end)
end

return Entity