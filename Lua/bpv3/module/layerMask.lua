local layerMask = {}

local player, bullet, brick, trigger = 0, 1, 2, 3

local function getLayerTag(layer)
    return bit.lshift(1, layer)
end

local function bitOrLayer(...)
    local c = 0
    for k, v in pairs({ ... }) do
        c = bit.bor(getLayerTag(v), c)
    end
    return c
end

function layerMask.init()
    layerMask.trigger = {}
    layerMask.trigger.tag = getLayerTag(trigger)
    layerMask.trigger.col = 0

    layerMask.player = {}
    layerMask.player.tag = getLayerTag(player)
    layerMask.player.col = bitOrLayer(brick)

    layerMask.bullet = {}
    layerMask.bullet.tag = getLayerTag(bullet)
    layerMask.bullet.col = bitOrLayer(brick)

    layerMask.brick = {}
    layerMask.brick.tag = getLayerTag(brick)
    layerMask.brick.col = bitOrLayer(player, bullet, brick)

end

function layerMask.collideWith(a, b)
    a, b = a or layerMask.brick, b or layerMask.brick
    return bit.band(a.tag, b.col) ~= 0
end

function layerMask.getLayer(name)
    local newlm = {}
    local oldlm = layerMask[name]
    for k, v in pairs(oldlm) do
        newlm[k] = v
    end
    return newlm
end

function layerMask.filter(item, other)
    if layerMask.collideWith(item.layerMask, other.layerMask) then
        return "slide"
    else
        return "cross"
    end
end

return layerMask