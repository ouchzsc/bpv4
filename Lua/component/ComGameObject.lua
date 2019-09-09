local Component = require("component.Component")
local ComGameObject = Component:extends()
local Vector3 = CS.UnityEngine.Vector3
local module = require("module.module")

function ComGameObject:onAwake()
    self.gameObject = self.entity.gameObject
    self.transform = self.gameObject.transform
end

function ComGameObject:onEnable()
    self:reg(module.event.onLateUpdate, self.onShow)
end
local right = Vector3(0, 90, 0)
local left = Vector3(0, -90, 0)

function ComGameObject:onShow()
    self.gameObject.transform.position = Vector3(self.entity.x, self.entity.y, 0)

    if self.entity.dir then
        if self.entity.dir > 0 then
            self.transform.eulerAngles = right
        elseif self.entity.dir < 0 then
            self.transform.eulerAngles = left
        end
    else
        --self.transform.eulerAngles = Vector3.zero
    end
end

return ComGameObject