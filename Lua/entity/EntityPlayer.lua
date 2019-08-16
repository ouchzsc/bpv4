local EntityPrefab = require("common.EntityPrefab")
local ComMoveControl = require("component.ComMoveControl")
local ComGameObject = require("component.ComGameObject")
local ComCollider = require("component.ComCollider")

local ComGravity = require("component.ComGravity")
local ComPhysicsMove = require("component.ComPhysicsMove")
local ComAccSystem = require("component.ComAccSystem")
local EntityPlayer = EntityPrefab:extends()

function EntityPlayer:onAwake()
    --self.move = self:addComponent(ComMoveControl)
    self.go = self:addComponent(ComGameObject)
    self.col = self:addComponent(ComCollider)

    self.gravity = self:addComponent(ComGravity)
    self.phyMove = self:addComponent(ComPhysicsMove)
    self.acc = self:addComponent(ComAccSystem)

    self:setData({ x = 0, y = 0, name = "player", speedPer = 1 ,speedBase = 50})
end

function EntityPlayer:onShow()
    --self.move:show()
    self.go:show()
    self.col:show()

    self.gravity:show()
    self.phyMove:show()
    self.acc:show()
end

return EntityPlayer