local EntityPrefab = require("entity.EntityPrefab")
local ComGameObject = require("component.ComGameObject")
local ComCollider = require("component.ComCollider")
local EntityBrick = EntityPrefab:extends()
local module = require("module.module")

function EntityBrick:onAwake()
    self.comGo = self:addComponent(ComGameObject)
    self.comCol = self:addComponent(ComCollider)
    self:setData({
        name = 'brick',
        layerMask = module.layerMask.brick,
        w = 1,
        h = 1
    })
end

function EntityBrick:onShow()
    self.comGo:show()
    self.comCol:show()
end

return EntityBrick