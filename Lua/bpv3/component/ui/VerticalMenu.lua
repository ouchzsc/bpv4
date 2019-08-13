local VerticalMenu = Component:extends()
local barWidth, barHeight = 100, 40
local startY = 200

function VerticalMenu:onEnable()
    _G.pause = true
    local entity = self.entity
    local barNum = #entity.bars
    self:reg(event.onKeyPressed, function(key)
        if key == "s" or key == "down" then
            entity.index = entity.index % barNum + 1
        elseif key == "w" or key == "up" then
            entity.index = entity.index - 1
            if entity.index <= 0 then
                entity.index = barNum
            end
        end
    end)
    self:reg(event.resize, function()
        self:onRender()
    end)
    self:onRender()
    camModule:get():hide()
end

function VerticalMenu:onRender()
    if self.entity.bars then
        local width, _, _ = love.window.getMode()
        self.startX = width / 2 - barWidth / 2
        for i, bar in pairs(self.entity.bars) do
            bar.x = self.startX
            bar.y = startY + (i - 1) * (barHeight + 5)
            bar:show()
        end
    end
end

function VerticalMenu:onDisable()
    if self.entity.bars then
        for _, bar in pairs(self.entity.bars) do
            bar:hide()
        end
    end
    camModule:get():show()
--    hero:addComponent(HeroHp)
    _G.pause = false
end

return VerticalMenu