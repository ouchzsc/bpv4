local EntityPrefab = require("common.EntityPrefab")
local ComMoveControl = require("logic.Player.ComMoveControl")
local EntityPlayer = EntityPrefab:extends()

function EntityPlayer:onAwake()
    self.move = self:addComponent(ComMoveControl)
end

function EntityPlayer:onShow()
    self.move:show()
end

return EntityPlayer