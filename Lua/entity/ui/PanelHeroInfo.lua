local EntityPrefab = require("entity.EntityPrefab")
local module = require("module.module")
local cfg = require "cfg._cfgs"

local PanelHeroInfo = EntityPrefab:extends()

function PanelHeroInfo:onAwake()
    local gameObject = self.gameObject
    self.Text_info = gameObject.transform:Find("Text_info"):GetComponent("Text")
end

function PanelHeroInfo:onEnable()
    self:reg(module.event.onUpdate, self.show)
end

function PanelHeroInfo:onShow()
    local hero = module.playerMgr.player
    if hero == nil then
        return
    end
    local s1 = string.format("jumpEngergy:%0.2f", hero.jumpEnergy or 0)
    local s2 = string.format("jumpTime:%s", hero.jumpTime or 0)
    local s3 = string.format("CmdY:%0.2f", hero.cmdY or 0)
    --        local s4 = string.format("axis1:%2d", hero.ayMap.axis1 or 0)
    local s5 = string.format("vy:%0.2f", hero.realVy or 0)
    local s6 = string.format("released:%s", hero.released)
    local s7 = string.format("isGrounded:%s", hero.isGrounded)
    local s8 = string.format("vx:%0.2f", hero.vx or 0)
    local s9 = string.format("axMap.fraction:%s", 0)--hero.axMap.fraction
    local s = string.format("%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s",
            s7, s3, s1, s2, s5, s8, s6, s9)
    self.Text_info.text = s
end

return PanelHeroInfo