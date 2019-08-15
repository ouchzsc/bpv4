local ComBehavior = require("common.ComBehavior")
local BehvMoveControl = ComBehavior:extends()
local InputManager = CS.Game.InputManager
local module = require("module.module")
local Input = CS.UnityEngine.Input

function BehvMoveControl:onAwake()
    self.gameObject = self.parent.gameObject
    self.animator = self.gameObject:GetComponent("Animator")
end

function BehvMoveControl:onEnable()
    self:reg(module.event.onUpdate, self.onUpdate)
end

function BehvMoveControl:onUpdate()
    if Input.GetMouseButton(1) then
        local transform = self.gameObject.transform
        local x = Input.GetAxis("Mouse X")
        transform:Rotate(0, x * 4, 0)
    end

    local h = InputManager.Instance:GetAxis("Horizontal");
    local v = InputManager.Instance:GetAxis("Vertical");
    if h == 0 and v == 0 then
        self.animator:SetFloat("f_speed", 0);
        return
    end

    self.animator:SetFloat("f_speed", 1.1);
    local oldPos = self.gameObject.transform.position
    oldPos = oldPos + self.gameObject.transform.forward * v * 0.1 + self.gameObject.transform.right * h * 0.1
    self.gameObject.transform.position = oldPos
end

return BehvMoveControl
