local Camera = Component:extends()

function Camera:onEnable()
    local entity = self.entity
    self:reg(event.onDraw, function()
        local x, y, w, h = entity.x or 0, entity.y or 0, entity.w, entity.h
        local scaleX = love.graphics.getWidth() / w
        local scaleY = love.graphics.getHeight() / h
        local scale = math.min(scaleX, scaleY)
        entity.scale = scale
        local tx, ty = -x + (love.graphics.getWidth() / scale - w) / 2, -y + (love.graphics.getHeight() / scale - h) / 2
        love.graphics.push()
        love.graphics.scale(scale, scale)
        love.graphics.translate(tx , ty )
        love.graphics.rectangle("line", x, y, w, h)
        local gameObjects, len = world:queryRect(x, y, w, h)
        table.sort(gameObjects, function(a, b)
            local sort_a = a.sortingOrder or 0
            local sort_b = b.sortingOrder or 0
            if sort_a == sort_b then
                return false
            end
            return sort_a < sort_b
        end)
        for i = 1, len do
            gameObjects[i]:popEvent("beforeCameraDraw")
            gameObjects[i]:popEvent("cameraDraw")
            gameObjects[i]:popEvent("cameraDrawUI")
            gameObjects[i]:popEvent("afterCameraDraw")
        end
        love.graphics.pop()
    end)
end

return Camera