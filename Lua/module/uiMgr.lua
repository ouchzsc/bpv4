local uiMgr = {}
local cfg = require "cfg._cfgs"
local PanelHeroInfo = require("entity.ui.PanelHeroInfo")
local PanelStart = require("entity.ui.PanelStart")
local module = require("module.module")
local GameObject = CS.UnityEngine.GameObject

function uiMgr.init()
    local canvas = GameObject.Find("Canvas")
    uiMgr.panelStart = PanelStart:new({ assetInfo = cfg.asset.assets.get("Assets/Game/UIRes/Start/PanelStart.prefab"),
                                        parentTransform = canvas.transform })
    uiMgr.panelHeroInfo = PanelHeroInfo:new({ assetInfo = cfg.asset.assets.get("Assets/Game/UIRes/Info/PanelHeroInfo.prefab"),
                                              parentTransform = canvas.transform })
end

return uiMgr