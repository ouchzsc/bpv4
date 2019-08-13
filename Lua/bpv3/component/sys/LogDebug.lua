local LogDebug = Component:extends()

function LogDebug:onEnable()
    self.debug = false
    self:reg(event.onKeyPressed, function(key)
        if key == "`" then
            self.debug = not self.debug
        end
    end)
    self:reg(event.onDraw, function()
        if self.debug then
            love.graphics.print(love.timer.getFPS(),200,50)
        end
    end)
end

return LogDebug