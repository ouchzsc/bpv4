local cfg = require "cfg._cfgs"

local this = cfg.rw.loot

local mk = cfg._mk.table(this, { { "all", "get", 1 }, }, nil, nil, 
    "lootid", -- int, 序号
    "ename", -- string
    "name", -- string, 名字
    "chanceList"  -- list,int,7, 掉落0件物品的概率
    )

mk(1, "", "测试掉落", {100, 200, 200, 200, 200, 50, 50})
mk(2, "combo1", "小宝箱", {0, 100, 0, 0, 0, 0, 0})
mk(3, "combo2", "中宝箱", {0, 100, 0, 0, 0, 0, 0})
mk(4, "combo3", "大宝箱", {0, 100, 0, 0, 0, 0, 0})
mk(5, "", "测试掉落2", {20, 10, 10, 20, 20, 10, 10})
mk(6, "", "剧情任务测试1", {0, 100, 0, 0, 0, 0, 0})
mk(7, "", "剧情任务测试2", {0, 100, 0, 0, 0, 0, 0})
mk(8, "", "通告栏掉落染色模板1", {80, 20, 0, 0, 0, 0, 0})
mk(9, "", "通告栏掉落染色模板2", {80, 20, 0, 0, 0, 0, 0})
mk(10, "", "通告栏掉落染色模板3", {80, 20, 0, 0, 0, 0, 0})

return this
