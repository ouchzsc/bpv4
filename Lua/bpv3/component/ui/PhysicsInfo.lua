local PhysicsInfo = Component:extends()

function PhysicsInfo:onEnable()
    self:reg(event.onDrawUi, function()
        local hero = heroModule.getHero()
        if hero == nil then
            return
        end
        local s1 = string.format("jumpEngergy:%d", hero.jumpEnergy or 0)
        local s2 = string.format("jumpTime:%d", hero.jumpTime or 0)
        local s3 = string.format("CmdY:%2d", hero.cmdY or 0)
        --        local s4 = string.format("axis1:%2d", hero.ayMap.axis1 or 0)
        local s5 = string.format("vy:%2d", hero.vy or 0)
        local s6 = string.format("released:%s", hero.released)
        local s7 = string.format("isGrounded:%s", hero.isGrounded)
        local s8 = string.format("vx:%2d", hero.vx or 0)
        local s9 = string.format("axMap.fraction:%s", hero.axMap.fraction)
        local s = string.format("%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",
                s7, s3, s1, s2, s5, s8, s6, s9)

        local oldColor = utils.getColor()
        utils.setColor({ 0, 0, 0, 0.8 })
        love.graphics.rectangle("fill", 10, 40, 100, 200)
        utils.setColor({ 1, 1, 1, 1 })
        love.graphics.print(s, 10, 40)
        utils.setColor(oldColor)
    end)
end

return PhysicsInfo