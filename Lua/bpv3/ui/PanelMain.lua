local PanelMain = Component:extends()
local NewSelectItem = SelectItem:extends()

function PanelMain:onEnable()
    local entity = self.entity
    NewSelectItem.getSelect = function()
        return heroModule.abilityIndex
    end
    self.entity.selection = 1
    entity.gridView = Entity:new()
    entity.gridView:addComponent(GridView)
    self:reg(event.onKeyPressed, function(key)
        if key == 'q' then
            heroModule.selectPreAbility()
        elseif key == "e" then
            heroModule.selectNextAbility()
        end
    end)
end

function PanelMain:onRender()
    local entity = self.entity
    local dataList = {}
    for k, ab in ipairs(heroModule.abilityList) do
        local data = {}
        data.text = ab.onGetName()
        data.id = k
        table.insert(dataList, data)
    end
    entity.gridView:setData({ ItemCls = NewSelectItem, dataList = dataList })
    entity.gridView:showBy(entity)
end

return PanelMain