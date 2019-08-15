local ComPrefab = require("common.ComPrefab")
local Player = ComPrefab:extends()
local BehvAttackControl = require("world.BehvAttackControl")
local BehvMoveControl = require("world.BehvMoveControl")
local module = require("module.module")
local Vector3 = CS.UnityEngine.Vector3
local BehvTransform = require("world.BehvTransform")

function Player:onAwake()
    self.beAttack = self:addBehavior(BehvAttackControl)
    self.beMove = self:addBehavior(BehvMoveControl)
    self.beTrans = self:addBehavior(BehvTransform)
end

function Player:onEnable()
    module.logger.info("player onEnable")
    self:scheduleTimerAtFixedRate("hi", 0, 1, self.tick)
    module.event.onHeroEnable:trigger(self)
end

function Player:onShow()
    self.beAttack:show()
    self.beMove:show()
    self.beTrans:show()
end

function Player:tick()
    local pos = self.gameObject.transform.position
    module.event.updatePlayerPos:trigger(pos)
end

return Player
