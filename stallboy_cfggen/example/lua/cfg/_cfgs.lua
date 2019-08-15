local cfg = {}

cfg._mk = require "common.mkcfg"
local pre = cfg._mk.pretable

cfg.equip = {}
cfg.equip.ability = pre("cfg.equip.ability")
cfg.equip.jewelry = pre("cfg.equip.jewelry")
cfg.equip.jewelryrandom = pre("cfg.equip.jewelryrandom")
cfg.equip.jewelrysuit = pre("cfg.equip.jewelrysuit")
cfg.equip.jewelrytype = pre("cfg.equip.jewelrytype")
cfg.equip.rank = pre("cfg.equip.rank")
cfg.lootitem = pre("cfg.lootitem")
cfg.monster = pre("cfg.monster")
cfg.rw = {}
cfg.rw.loot = pre("cfg.rw.loot")
cfg.signin = pre("cfg.signin")
cfg.task = {}
cfg.task.completeconditiontype = pre("cfg.task.completeconditiontype")
cfg.task.task = pre("cfg.task.task")
cfg.task.taskextraexp = pre("cfg.task.taskextraexp")

return cfg
