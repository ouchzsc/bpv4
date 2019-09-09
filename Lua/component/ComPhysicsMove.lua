-- 接收Axis命令来控制速度和加速度
-- entity 中读cmdX cmdY
-- entity 写 v axMap ayMap
local Component = require("component.Component")
local module = require("module.module")

local PhysicsMove = Component:extends()
local ax, ay = 300, 180
local defaultJumpEnergyMax, defaulMaxJumpTime = 0.1, 2
local checkY = -0.01
local littlehelp = 3
local umbrellaInitFallSpeed = 1
local defaultFriction = 1.5
local jumpXSpeed = 1

function PhysicsMove:onEnable()
    self:reg(module.event.onFixedUpdate, self.onFixedUpdate)
end

function PhysicsMove:onFixedUpdate(dt)
    self.dt = dt
    local entity = self.entity
    local _, _, cols, len = module.bumpWorld.world:check(entity, entity.x, entity.y + checkY, module.layerMask.filter)
    entity.isGrounded = false
    local groundCol = nil
    for i = 1, len do
        local col = cols[i]
        if col.type == "slide" and col.normal.y ~= 0 and entity.y > col.other.y then
            entity.isGrounded = true
            groundCol = col
            break
        end
    end
    entity.jumpEnergy = entity.jumpEnergy or 0
    entity.jumpTime = entity.jumpTime or 0
    entity.ayMap = entity.ayMap or {}
    entity.vy = entity.vy or 0

    local x, y = entity.cmdX or 0, entity.cmdY or 0
    if self.entity.stunCnt and self.entity.stunCnt > 0 then
        x, y = 0, 0
    end
    self:processY(y)
    self:processX(self.entity, x, groundCol)
end

function PhysicsMove:processX(entity, x, groundCol)
    entity.axMap = entity.axMap or {}
    entity.axMap.fraction = entity.axMap.fraction or 0
    entity.axMap.axis1 = x * ax
    if entity.isGrounded then
        local vx = entity.vx or 0
        -- 地板摩擦力
        local otherFriction = groundCol.other.friction or defaultFriction
        local entityFriction = entity.friction or defaultFriction
        local friction = otherFriction * entityFriction
        if vx > 0.1 then
            entity.axMap.fraction = math.min(entity.axMap.fraction, -friction)
        elseif vx < -0.1 then
            entity.axMap.fraction = math.max(entity.axMap.fraction, friction)
        else
            entity.axMap.fraction = 0
            entity.vx = 0
        end
    else
        entity.axMap.fraction = nil
    end
end

function PhysicsMove:processY(y)
    if y > 0 then
        self:pressUp()
    elseif y == 0 then
        self:pressNoneY()
    else
        self:pressDown()
    end
    self.entity.released = (y <= 0)
    if self.entity.released and self.entity.isGrounded then
        self.entity.jumpTime = defaulMaxJumpTime
    end
end

function PhysicsMove:pressUp()
    if self.entity.jumpEnergy > 0 then
        self:jumping()
    elseif self.entity.jumpTime > 0 then
        if self.entity.released then
            self:resetEnergy()
            self:jumping()
        else
            self:umbrella()
        end
    else
        self:umbrella()
    end
end

function PhysicsMove:jumping()
    if self.entity.released then
        self.entity.vy = 0
    end
    self.entity.ayMap.axis1 = ay
    self.entity.jumpEnergy = self.entity.jumpEnergy - self.dt
end

function PhysicsMove:umbrella()
    if self.entity.vy < -umbrellaInitFallSpeed then
        self.entity.vy = -umbrellaInitFallSpeed
    end
    self.entity.ayMap.axis1 = littlehelp
end

function PhysicsMove:resetEnergy()
    self.entity.jumpTime = self.entity.jumpTime - 1
    self.entity.jumpEnergy = defaultJumpEnergyMax
end

function PhysicsMove:pressNoneY()
    if self.entity.jumpEnergy>0 then
        self.entity.jumpEnergy = self.entity.jumpEnergy - self.dt
        self.entity.ayMap.axis1 = ay
    else
        self.entity.ayMap.axis1 = 0
        self.entity.jumpEnergy = 0
    end

end

function PhysicsMove:pressDown()
    self.entity.ayMap.axis1 = -ay
    self.entity.jumpEnergy = 0
end

return PhysicsMove