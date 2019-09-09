local EntityPrefab = require("entity.EntityPrefab")
local ComGameObject = require("component.ComGameObject")
local ComCollider = require("component.ComCollider")

local ComGravity = require("component.ComGravity")
local ComPhysicsMove = require("component.ComPhysicsMove")
local ComAccSystem = require("component.ComAccSystem")
local ComPlayerCmd = require("component.ComPlayerCmd")
local ComAnimator = require("component.ComAnimator")

local EntityPlayer = EntityPrefab:extends()

function EntityPlayer:onAwake()
    self.go = self:addComponent(ComGameObject)
    self.col = self:addComponent(ComCollider)
    self.gravity = self:addComponent(ComGravity)
    self.phyMove = self:addComponent(ComPhysicsMove)
    self.acc = self:addComponent(ComAccSystem)
    self.playerCmd = self:addComponent(ComPlayerCmd)
    self.animator = self:addComponent(ComAnimator)
    self:setData({ x = 2, y = 7, name = "player", speedPer = 1, speedBase = 10, w = 1, h = 2, vx = 0, vy = 0, dir = 1 })
end

function EntityPlayer:onShow()
    self.go:show()
    self.col:show()
    self.gravity:show()
    self.phyMove:show()
    self.acc:show()
    self.playerCmd:show()
    self.animator:show()
end

return EntityPlayer