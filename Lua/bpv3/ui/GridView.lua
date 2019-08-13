local GridView = Component:extends()

function GridView:onRender()
    local entity = self.entity
    if entity.items then
        for k, item in ipairs(entity.items) do
            item:hide()
        end
        entity.items = nil
    end
    if self.entity.dataList then
        entity.items = {}
        for k, data in ipairs(self.entity.dataList) do
            --local item = self:addChild(self.entity.ItemCls)
            local item = Entity:new()
            item:addComponent(self.entity.ItemCls)
            item:setData({ id = k, x = k * 50, y = 10, w = 50, h = 50 })
            item:setData(data)
            item:showBy(entity)
            table.insert(entity.items, item)
        end
    end
end

function GridView:onDataChange()

end

return GridView