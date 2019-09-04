local EntityPrefab = require("entity.EntityPrefab")
local ComGameObject = require("component.ComGameObject")
local ComCollider = require("component.ComCollider")

local ComGravity = require("component.ComGravity")
local ComPhysicsMove = require("component.ComPhysicsMove")
local ComAccSystem = require("component.ComAccSystem")
local ComPlayerCmd = require("component.ComPlayerCmd")

local EntityPlayer = EntityPrefab:extends()

function EntityPlayer:onAwake()
    self.go = self:addComponent(ComGameObject)
    self.col = self:addComponent(ComCollider)
    self.gravity = self:addComponent(ComGravity)
    self.phyMove = self:addComponent(ComPhysicsMove)
    self.acc = self:addComponent(ComAccSystem)
    self.playerCmd = self:addComponent(ComPlayerCmd)
    self:setData({ x = 0, y = 5, name = "player", speedPer = 1, speedBase = 1, w = 1, h = 2 })
end

function EntityPlayer:onShow()
    self.go:show()
    self.col:show()

    self.gravity:show()
    self.phyMove:show()
    self.acc:show()
    self.playerCmd:show()

end

return EntityPlayer