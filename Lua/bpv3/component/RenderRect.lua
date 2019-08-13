local RenderRect = Component:extends()
local defaultColor = { 1, 1, 1, 1 }
function RenderRect:onPopEvent(type)
    if type == "cameraDraw" then
        local entity = self.entity
--        local x, y, w, h = entity.x or 10, entity.y or 10, entity.w or 10, entity.h or 10
        local x, y, w, h = entity.x , entity.y , entity.w , entity.h
        local dir = entity.dir
        local oldColor = utils.getColor()
        utils.setColor(entity.color or defaultColor)
        love.graphics.setLineWidth(3)
        love.graphics.rectangle("line", x, y, w, h)
        if dir == 1 then
            love.graphics.rectangle("line", x + w / 2, y, w / 2, h / 2)
        elseif dir == -1 then
            love.graphics.rectangle("line", x, y, w / 2, h / 2)
        end
        love.graphics.setLineWidth(1)
        utils.setColor(oldColor)
    end
end

return RenderRect