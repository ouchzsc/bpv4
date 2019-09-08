local cfg = {}

cfg._mk = require "common.mkcfg"
local pre = cfg._mk.pretable

cfg.asset = {}
cfg.asset.assets = pre("cfg.asset.assets")
cfg.map = {}
cfg.map.map1 = pre("cfg.map.map1")
cfg.npc = {}
cfg.npc.npc = pre("cfg.npc.npc")

return cfg
