local defaulViewWidth = 600
local defaulViewHeight = 600
local attackDisX = 30
local attackDisY = 10
local findTargetPeriod = 1
local checkAttackRangePeriod = 0.06
local jumpPeriod = 4
local attackCd = 1

local ZombieAI = Component:extends()

function ZombieAI:onEnable()
    self:scheduleTimerAtFixedRate("findTarget", 0, findTargetPeriod, self.findTarget)
    self:scheduleTimerAtFixedRate("walkToTarget", 0, 0.2, self.walkToTarget)
    self:scheduleTimerAtFixedRate("jumpToTarget", 0, jumpPeriod, self.jumpToTarget)
    self:scheduleTimerAtFixedRate("checkAttackRange", 0, checkAttackRangePeriod, self.checkAttackRange)
end

function ZombieAI:findTarget()
    local entity = self.entity
    local viewWidth = entity.viewWidth or defaulViewWidth
    local viewHeight = entity.viewHeight or defaulViewHeight
    entity.attackTarget = utils.findTarget(entity.x, entity.y, viewWidth, viewHeight, function(item)
        return item.layerMask == layerMask.player and item.teamId ~= entity.teamId
    end)
end

function ZombieAI:walkToTarget()
    --如果在攻击cd中，返回
    --如果有目标
    -- 目标很远，靠近，设置方向
    -- 在攻击范围内，攻击，进入攻击状态，开始cd
    local entity = self.entity
    if entity.isAttacking then
        return
    end
    if not entity.attackTarget then
        return
    end
    local target = entity.attackTarget
    if target.x > entity.x then
        entity.dir = 1
    else
        entity.dir = -1
    end
    local dis = target.x - entity.x
    if math.abs(dis) > attackDisX then
        entity.cmdX = entity.dir
    else
        entity.cmdX = 0
    end
end

function ZombieAI:jumpToTarget()
    local entity = self.entity
    local target = entity.attackTarget
    if entity.isAttacking then
        return
    end
    if not target then
        return
    end
    if target.y >= entity.y then
        return
    end
    if entity.cmdY == -1 then
        return
    end
    entity.cmdY = -1
    self:scheduleTimer("releaseJump", 0.2, function()
        entity.cmdY = 0
    end)
end

function ZombieAI:checkAttackRange()
    local entity = self.entity
    local target = entity.attackTarget
    if target == nil then
        return
    end
    if entity.isAttacking then
        return
    end
    local items, len = world:queryRect(entity.x, entity.y, entity.w, entity.h, function(item)
        return item == target
    end)
    if len <= 0 then
        return
    end
    self:attack()
end

function ZombieAI:attack()
    local entity = self.entity
    entity.isAttacking = true
    entity.cmdX = 0
    entity.cmdY = 0
    entity:popEvent("attack")
    self:scheduleTimer("attacking", attackCd, function()
        entity.isAttacking = false
        entity:popEvent("stopAttacking")
    end)
end

return ZombieAI