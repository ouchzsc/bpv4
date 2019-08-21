local Component = require("common.Component")
local utils = require("common.utils")
local module = require("module.module")
local ComCollider = Component:extends()

function ComCollider:onEnable()
    local world = module.bumpWorld.world
    local entity = self.entity
    entity.x = entity.x or 0
    entity.y = entity.y or 0
    entity.w = entity.w or 10
    entity.h = entity.h or 10
    local filter = function(other)
        return module.layerMask.collideWith(entity.layerMask, other.layerMask)
    end
    local items, len = world:queryRect(entity.x, entity.y, entity.w, entity.h, filter)

    if len > 0 then
        self.oldLayerMask = entity.layerMask
        entity.layerMask = module.layerMask.trigger
    end
    world:add(entity, entity.x, entity.y, entity.w, entity.h)
    self:reg(module.event.onFixedUpdate, self.onFixedUpdate)
    self:reg(module.event.onLateUpdate, self.onLateUpdate)
end

function ComCollider:onFixedUpdate()
    local world = module.bumpWorld.world
    if not self.createSuccess then
        local filter = function(other)
            return module.layerMask.collideWith(self.oldLayerMask, other.layerMask)
        end
        local entity = self.entity
        local items, len = world:queryRect(entity.x, entity.y, entity.w, entity.h, filter)
        if len == 0 and self.oldLayerMask then
            self.entity.layerMask = self.oldLayerMask
            self.createSuccess = true
            self.oldLayerMask = nil
        end
    end
end

function ComCollider:onLateUpdate()
    local world = module.bumpWorld.world
    local entity = self.entity
    utils.assertType('number', entity.x, entity.name .. ' x')
    utils.assertType('number', entity.x, entity.name .. ' x')
    local nx, ny = entity.nextX or entity.x, entity.nextY or entity.y
    local actualX, actualY, cols, len = world:move(self.entity, nx, ny, module.layerMask.filter)
    entity.x = actualX
    entity.y = actualY
    entity.vy = entity.vy or 0
    entity.vx = entity.vx or 0
    for i = 1, len do
        local col = cols[i]
        if col.type == 'slide' then
            --垂直阻挡
            if entity.vy > 0 and col.normal.y < 0 then
                entity.vy = 0
            elseif entity.vy < 0 and col.normal.y > 0 then
                entity.vy = 0
            end
            -- 水平阻挡
            if entity.vx > 0 and col.normal.x < 0 then
                entity.vx = 0
            elseif entity.vx < 0 and col.normal.x > 0 then
                entity.vx = 0
            end
            col.item:popEvent("onCollision", { col = col, other = col.other })
            col.other:popEvent("onCollision", { col = col, other = col.item })
        elseif col.type == 'cross' then
            col.item:popEvent("onTrigger", { col = col, other = col.other })
            col.other:popEvent("onTrigger", { col = col, other = col.item })
        end
    end
end

function ComCollider:onDisable()
    local world = module.bumpWorld.world
    local entity = self.entity
    world:remove(entity)
end

return ComCollider