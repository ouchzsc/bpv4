local RenderImg = Component:extends()

function RenderImg:onPopEvent(type)
    if type == "cameraDraw" then
        local entity = self.entity
        if self.img == nil then
            self.img = love.graphics.newImage(entity.imgPath)
        end
        if self.img then
            love.graphics.draw(self.img, entity.x, entity.y)
        end
    end
end