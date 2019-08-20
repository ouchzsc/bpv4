local EntityPrefab = require("common.EntityPrefab")
local module = require("module.module")
local EntityScene1 = require("entity.EntityScene1")
local cfg = require "cfg._cfgs"

local PanelStart = EntityPrefab:extends()

function PanelStart:onAwake()
    local gameObject = self.gameObject
    self.Button_Start = gameObject.transform:Find("Button_Start"):GetComponent("Button")
    self.Button_Start.onClick:AddListener(function()
        self:OnButton_Start()
    end)
end

function PanelStart:OnButton_Start()
    module.boot.curScene = EntityScene1:new({ assetInfo = cfg.asset.assets.get("Assets/Game/Scenes/s1.unity") })
    module.boot.curScene:show()
    self:hide()
end

return PanelStart