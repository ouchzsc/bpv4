local system = {}
local path = 'lua.module.test'
function system.init()
    event.onKeyPressed:Register(function(key)
        if key == 'f6' then
            package.loaded[path] = nil
            local test = require(path)
            test.f6()
        elseif key == 'f7' then
            package.loaded[path] = nil
            local test = require(path)
            test.f7()
        end
    end)
    event.onKeyPressed:Register(function(key)
        if key == "p" then
            pause = not pause
        end
        if key == "f1" then
            local b = love.window.getFullscreen()
            love.window.setFullscreen(not b)
        end
        if key == "escape" then
            love.event.quit()
        end
    end)
    event.onCamDraw:Register(function()
        if love.mouse.isDown(1) then
            local mx, my = utils.getMouseWorldPos()
            local x1, x2, y1, y2 = mx, mx, my, my + 200
            local iteminfos, len = world:querySegmentWithCoords(x1, y1, x2, y2, function(item)
                return item.layerMask == layerMask.brick
            end)
            if len > 0 then
                local oldColor = utils.getColor()
                utils.setColor({ 1, 0, 0, 1 })
                love.graphics.line(x1, y1, x2, y2)
                utils.setColor(oldColor)

                for k, iteminfo in ipairs(iteminfos) do
                    love.graphics.circle("fill",iteminfo.x1, iteminfo.y1,3)
                    love.graphics.circle("fill",iteminfo.x2, iteminfo.y2,3)
                    love.graphics.line(iteminfo.x1, iteminfo.y1, iteminfo.x2, iteminfo.y2)
                end
            else
                love.graphics.line(x1, y1, x2, y2)
            end

        end
    end)
end

return system