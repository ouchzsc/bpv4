local utils = {}

function utils.getAxisWasd()
    local x, y = 0, 0
    if love.keyboard.isDown("w") then
        y = -1
    end
    if love.keyboard.isDown("s") then
        y = 1
    end
    if love.keyboard.isDown("d") then
        x = 1
    end
    if love.keyboard.isDown("a") then
        x = -1
    end
    return x, y
end

function utils.getAxisArrow()
    local x, y = 0, 0
    if love.keyboard.isDown("up") then
        y = -1
    end
    if love.keyboard.isDown("down") then
        y = 1
    end
    if love.keyboard.isDown("right") then
        x = 1
    end
    if love.keyboard.isDown("left") then
        x = -1
    end
    return x, y
end

function utils.getMouseWorldPos()
    local cam = camModule.get()
    if cam then
        local x, y, w, h = cam.x or 0, cam.y or 0, cam.w, cam.h
        local screenW = love.graphics.getWidth()
        local screenH = love.graphics.getHeight()
        local scaleX = screenW / w
        local scaleY = screenH / h
        local scale = math.min(scaleX, scaleY)
        local mouseX, mouseY = love.mouse.getPosition()
        local px = (screenW - w * scale) / 2
        local py = (screenH - h * scale) / 2
        local mworldX = (mouseX - px) / scale + x
        local mworldY = (mouseY - py) / scale + y
        return mworldX, mworldY
    end
end

function utils.assertType(desiredType, value, name)
    if type(value) ~= desiredType then
        error(name .. ' must be a ' .. desiredType .. ', but was ' .. tostring(value) .. '(a ' .. type(value) .. ')')
    end
end

function utils.assetNotNil(value, name)
    if value == nil then
        name = name or "value"
        error(name .. " should not be nil")
    end
end

function utils.copy(t)
    local newtable = {}
    for k, v in pairs(t) do
        newtable[k] = v
    end
    return newtable
end

function utils.randomFrom(listTable)
    local count = #listTable
    if count > 0 then
        local idx = math.random(1, count)
        return listTable[idx]
    end
end

function utils.findTarget(x, y, w, h, filter)
    utils.assertType('number', x, ' x')
    utils.assertType('number', y, ' y')
    utils.assertType('number', w, ' w')
    utils.assertType('number', h, ' h')

    local items, len = world:queryRect(x - w / 2, y - h / 2, w, h, filter)
    if len > 0 then
        return items[1]
    else
        return nil
    end
end

function utils.setColor(color)
    love.graphics.setColor(color[1], color[2], color[3], color[4])
end

function utils.getColor()
    local r, g, b, a = love.graphics.getColor()
    return { r, g, b, a }
end

function utils.printt(t)
    print("<------------------")
    print(t)
    for k, v in pairs(t) do
        print(k, v)
    end
    print("------------------>")
end

function utils.print_r (t, indent, done)
    done = done or {}
    indent = indent or ''
    local nextIndent -- Storage for next indentation value
    for key, value in pairs(t) do
        if type(value) == "table" and not done[value] then
            nextIndent = nextIndent or
                    (indent .. string.rep(' ', string.len(tostring(key)) + 2))
            -- Shortcut conditional allocation
            done[value] = true
            print(indent .. "[" .. tostring(key) .. "] => Table {");
            print(nextIndent .. "{");
            utils.print_r(value, nextIndent .. string.rep(' ', 2), done)
            print(nextIndent .. "}");
        else
            print(indent .. "[" .. tostring(key) .. "] => " .. tostring(value) .. "")
        end
    end
end

function utils.split(str, pat)
    local t = {} -- NOTE: use {n = 0} in Lua-5.0
    local fpat = "(.-)" .. pat
    local last_end = 1
    local s, e, cap = str:find(fpat, 1)
    while s do
        if s ~= 1 or cap ~= "" then
            table.insert(t, cap)
        end
        last_end = e + 1
        s, e, cap = str:find(fpat, last_end)
    end
    if last_end <= #str then
        cap = str:sub(last_end)
        table.insert(t, cap)
    end
    return t
end

function utils.startwith(ori, target)
    local start, e = string.find(ori, target)
    return start == 1
end

function utils.getCenter(entity)
    utils.assetNotNil(entity.x, "x")
    utils.assetNotNil(entity.y, "y")
    utils.assetNotNil(entity.w, "w")
    utils.assetNotNil(entity.h, "h")
    return entity.x + entity.w / 2, entity.y + entity.h / 2
end

function utils.getTopLeft(centerX, centerY, w, h)
    return centerX - w / 2, centerY - h / 2
end

return utils