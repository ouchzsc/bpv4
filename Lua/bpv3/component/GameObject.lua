local GameObject = Component:extends()

function GameObject:onEnable()
    local entity = self.entity
    entity.x = entity.x or 0
    entity.y = entity.y or 0
    entity.w = entity.w or 10
    entity.h = entity.h or 10
    local filter = function(other)
        return layerMask.collideWith(entity.layerMask, other.layerMask)
    end
    local items, len = world:queryRect(entity.x, entity.y, entity.w, entity.h, filter)

    if len > 0 then
        self.oldLayerMask = entity.layerMask
        entity.layerMask = layerMask.trigger
    end
    world:add(entity, entity.x, entity.y, entity.w, entity.h)
    self:reg(event.onFixedUpdate, function(dt)
        self:onFixedUpdate(dt)
    end)
    self:reg(event.onLateUpdate, function(dt)
        self:onLateUpdate(dt)
    end)
end

function GameObject:onFixedUpdate(dt)
    if not self.createSuccess then
        local filter = function(other)
            return layerMask.collideWith(self.oldLayerMask, other.layerMask)
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

function GameObject:onLateUpdate(dt)
    local entity = self.entity
    utils.assertType('number', entity.x, entity.name .. ' x')
    utils.assertType('number', entity.x, entity.name .. ' x')
    local nx, ny = entity.nextX or entity.x, entity.nextY or entity.y
    local actualX, actualY, cols, len = world:move(self.entity, nx, ny, layerMask.filter)
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

function GameObject:onDisable()
    local entity = self.entity
    world:remove(entity)
end

return GameObject