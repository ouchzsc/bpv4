local ComPrefab = require("common.ComPrefab")
local Npc = ComPrefab:extends()
local module = require("module.module")
local BehvTransform = require("World.BehvTransform")
local BehvAnimator = require("World.BehvAnimator")

function Npc:onNew()
    ComPrefab.onNew(self)
    self.assetInfo = module.cfgMgr.npc.get(self.npcId).assetRef
end

function Npc:onAwake()
    self.beTrans = self:addBehavior(BehvTransform)
    self.beAnimator = self:addBehavior(BehvAnimator)
end

function Npc:onShow()
    self.beTrans:show()
    self.beAnimator:show()
    if self.clipAsset then
        self.beAnimator:trigger(self.clipAsset)
    end
end

return Npc

