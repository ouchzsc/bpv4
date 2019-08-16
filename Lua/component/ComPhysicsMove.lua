-- 接收Axis命令来控制速度和加速度
-- entity 中读cmdX cmdY
-- entity 写 v axMap ayMap
local Component = require("common.Component")
local module = require("module.module")

local PhysicsMove = Component:extends()
local ax, ay = 300, 10000
local maxJumpEnergy, defaulMaxJumpTime = 0.1, 1
local checkY = 1
local littlehelp = 300
local umbrellaInitFallSpeed = 100
local defaultFriction = 10
local jumpXSpeed = 100

function PhysicsMove:onEnable()
    self:reg(module.event.onFixedUpdate, function(dt)
        local entity = self.entity
        local _, _, cols, len =module.world.bumpWorld:check(entity, entity.x, entity.y + checkY, module.layerMask.filter)
        entity.isGrounded = false
        local groundCol = nil
        for i = 1, len do
            local col = cols[i]
            if col.type == "slide" and col.normal.y ~= 0 and entity.y < col.other.y then
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

        if not entity.isGrounded then
            -- 在空中
            if y < 0 then
                --向上
                if not entity.released then
                    -- 之前没松手
                    if entity.jumpEnergy > 0 then
                        --还有能量
                        entity.released = false
                        entity.jumpEnergy = entity.jumpEnergy - dt
                        entity.jumpTime = entity.jumpTime
                        entity.ayMap.axis1 = -ay
                        entity.vy = entity.vy or 0
                    else
                        --没有能量
                        entity.released = false
                        entity.jumpEnergy = 0
                        entity.jumpTime = entity.jumpTime
                        entity.vy = entity.vy or 0
                        if entity.vy > 0 then
                            if entity.vy > umbrellaInitFallSpeed then
                                entity.vy = umbrellaInitFallSpeed
                            end
                            entity.ayMap.axis1 = -littlehelp
                        else
                            entity.ayMap.axis1 = 0
                        end
                    end
                else
                    --之前松过手
                    if entity.jumpTime > 0 then
                        -- 还能跳
                        entity.jumpEnergy = maxJumpEnergy
                        entity.jumpTime = entity.jumpTime - 1
                        entity.released = false
                        entity.ayMap.axis1 = -ay
                        entity.vy = 0
                        if x ~= 0 then
                            entity.vx = jumpXSpeed * x
                        end
                    else
                        --没有跳跃次数
                        entity.jumpEnergy = 0
                        entity.jumpTime = 0
                        entity.released = false
                        entity.vy = entity.vy
                        if entity.vy > 0 then
                            if entity.vy > umbrellaInitFallSpeed then
                                entity.vy = umbrellaInitFallSpeed
                            end
                            entity.ayMap.axis1 = -littlehelp
                        else
                            entity.ayMap.axis1 = 0
                        end
                    end
                end
            elseif y == 0 then
                --y方向没按
                entity.jumpEnergy = 0
                entity.jumpTime = entity.jumpTime
                entity.released = true
                entity.ayMap.axis1 = 0
                entity.vy = entity.vy
            else
                -- y<0 向下加速，这个可以是技能
                entity.jumpEnergy = 0
                entity.jumpTime = entity.jumpTime
                entity.released = true
                entity.ayMap.axis1 = ay
                entity.vy = entity.vy
            end
        else
            -- 在地上
            if y < 0 then
                --按上
                if entity.released then
                    --之前松手了
                    if entity.jumpTime > 0 then
                        entity.jumpTime = entity.jumpTime - 1
                        entity.jumpEnergy = maxJumpEnergy
                        entity.released = false
                        entity.ayMap.axis1 = -ay
                        entity.vy = 0
                        if x ~= 0 then
                            entity.vx = jumpXSpeed * x
                        end
                    else
                        entity.jumpTime = 0
                        entity.jumpEnergy = 0
                        entity.released = false
                        entity.ayMap.axis1 = 0
                        entity.vy = entity.vy
                    end
                else
                    --之前没松手
                    if entity.jumpEnergy > 0 then
                        entity.jumpTime = entity.jumpTime
                        entity.jumpEnergy = entity.jumpEnergy - dt
                        entity.released = false
                        entity.ayMap.axis1 = -ay
                        entity.vy = entity.vy
                    else
                        entity.jumpTime = entity.jumpTime
                        entity.jumpEnergy = 0
                        entity.released = false
                        entity.ayMap.axis1 = 0
                        entity.vy = entity.vy
                    end
                end
            else
                --没按上
                entity.jumpTime = entity.maxJumpTime or defaulMaxJumpTime
                entity.jumpEnergy = 0
                entity.released = true
                entity.ayMap.axis1 = 0
                entity.vy = 0
            end
        end

        entity.axMap = entity.axMap or {}
        entity.axMap.fraction = entity.axMap.fraction or 0
        entity.axMap.axis1 = x * ax
        if entity.isGrounded then
            local vx = entity.vx or 0
            -- 地板摩擦力
            local otherFriction = groundCol.other.friction or defaultFriction
            local entityFriction = entity.friction or defaultFriction
            local friction = otherFriction * entityFriction
            if vx > 1 then
                entity.axMap.fraction = math.min(entity.axMap.fraction, -friction)
            elseif vx < -1 then
                entity.axMap.fraction = math.max(entity.axMap.fraction, friction)
            else
                entity.axMap.fraction = 0
                entity.vx = 0
            end
        else
            entity.axMap.fraction = nil
        end

        --  for infomation display use only
        entity.realVx, entity.realVy = entity.vx, entity.vy
    end)
end

return PhysicsMove