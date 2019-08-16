local cfg = require "cfg._cfgs"

local this = cfg.npc.npc

local mk = cfg._mk.table(this, { { "all", "get", 1 }, }, nil, { 
    { "RefAsset", false, cfg.asset.assets, "get", 2 }, }, 
    "id", -- int, #id
    "asset"  -- string, asset
    )

mk(1, "Assets/Game/Art/Assassin/Prefab/vampire_a_lusth.prefab")
mk(2, "Assets/Game/Art/Brick/Prefab/Bricks.prefab")

return this
