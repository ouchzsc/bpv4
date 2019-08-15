local ComGo = require("common.ComGo")
local module = require("module.module")
local GameObject = CS.UnityEngine.GameObject

local Input = CS.UnityEngine.Input

local ComFreeLook = ComGo:extends()

function ComFreeLook:onAwake()
    self.freelook = self.gameObject:GetComponent("Cinemachine.CinemachineFreeLook")
end

function ComFreeLook:onEnable()
    self:reg(module.event.onUpdate, self.onUpdate)
    self:reg(module.event.onHeroEnable, function(_, hero)
        self:onHeroEnable(hero)
    end)
end

function ComFreeLook:onHeroEnable(hero)
    self.freelook.LookAt = hero.gameObject.transform
    self.freelook.Follow = hero.gameObject.transform
end

function ComFreeLook:onUpdate()
    if Input.GetMouseButton(1) then
        local old = self.freelook.m_YAxis
        old.m_InputAxisValue = Input.GetAxis("Mouse Y")
        self.freelook.m_YAxis = old
    else
        local old = self.freelook.m_YAxis
        old.m_InputAxisValue = 0
        self.freelook.m_YAxis = old
    end
end

function ComFreeLook:onDestroy()
    self.freelook = nil
end

return ComFreeLook
