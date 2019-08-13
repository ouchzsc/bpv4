local EnemyHp = Component:extends()
local barHeight = 5
function EnemyHp:onPopEvent(type, data)
    local entity = self.entity
    if type == "cameraDrawUI" then
        local hp = entity.hp or 1
        local maxHp = entity.maxHp or 4
        local w = entity.w or 10
        local x = entity.x
        local y = entity.y
        if maxHp <= 0 then
            return
        end
        local itemw = w / maxHp

        local oldColor = utils.getColor()
        utils.setColor({ 1, 1, 1, 1 })
        love.graphics.rectangle("fill", x, y - 20, itemw * hp, barHeight)
        utils.setColor(oldColor)


        for i = 1, maxHp do
            love.graphics.rectangle("line", x + itemw * (i - 1), y - 20, itemw, barHeight)
        end
    end
end

return EnemyHp