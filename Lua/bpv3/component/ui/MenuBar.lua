local MenuBar = Component:extends()
local radius = 8
local arrowImgPath = "img/arrow.png"
function MenuBar:onEnable()
    local entity = self.entity
    local parent = entity.parent
    self:reg(event.onDrawUi, function()
        self.img = self.img or love.graphics.newImage(arrowImgPath)
        if parent.index == entity.index then
            love.graphics.draw(self.img, entity.x, entity.y, 0, 1, 1, 22, 0)
        end
        love.graphics.print(entity.text, entity.x, entity.y, 0, 1, 1)
    end)
    self:reg(event.onKeyPressed, function(key)
        if (key == "return" or key == "space") and parent.index == entity.index then
            if entity.callback then
                entity.callback()
            end
            parent:hide()
        end
    end)
end

return MenuBar