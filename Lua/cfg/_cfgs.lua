local cfg = {}

cfg._mk = require "common.mkcfg"
local pre = cfg._mk.pretable

cfg.asset = {}
cfg.asset.assets = pre("cfg.asset.assets")
cfg.npc = {}
cfg.npc.npc = pre("cfg.npc.npc")

return cfg
