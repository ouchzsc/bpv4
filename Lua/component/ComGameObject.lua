local Component = require("common.Component")
local ComGameObject = Component:extends()
local Vector3 = CS.UnityEngine.Vector3
local module = require("module.module")

function ComGameObject:onAwake()
    self.gameObject = self.entity.gameObject
end

function ComGameObject:onEnable()
    self:reg(module.event.onLateUpdate, self.onShow)
end

function ComGameObject:onShow()
    self.gameObject.transform.position = Vector3(self.entity.x, self.entity.y, 0)
end

return ComGameObject