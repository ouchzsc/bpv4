local EntityPrefab = require("entity.EntityPrefab")
local ComGameObject = require("component.ComGameObject")
local ComCollider = require("component.ComCollider")
local EntityBrick = EntityPrefab:extends()
local module = require("module.module")

function EntityBrick:onAwake()
    self.comGo = self:addComponent(ComGameObject)
    self.comCol = self:addComponent(ComCollider)
    self.name = 'brick'
    self.layerMask = module.layerMask.brick
    self.w = 1
    self.h = 1
end

function EntityBrick:onShow()
    self.comGo:show()
    self.comCol:show()
end

return EntityBrick