local SelectItem = Component:extends()

function SelectItem:onEnable()
    self:reg(event.onDrawUi, function()
        self:onRender()
    end)
end
function SelectItem:onRender()
    local entity = self.entity
    local x, y, w, h = entity.x, entity.y, entity.w, entity.h
    local lineWidth = love.graphics.getLineWidth()
    if self.getSelect() == entity.id then
        love.graphics.setLineWidth(2)
    else
        love.graphics.setLineWidth(1)
    end
    love.graphics.rectangle("line", x, y, w, h)
    love.graphics.print(entity.text, x, y)
    love.graphics.setLineWidth(lineWidth)
end

return SelectItem