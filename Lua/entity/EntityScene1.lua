local EntityScene = require("common.EntityScene")
local EntityScene1 = EntityScene:extends()
local module = require("module.module")


function EntityScene1:onEnable()
    print("EntityScene1:onEnable()")
    --module.world.curScene:hide()
end



return EntityScene1