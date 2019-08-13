local ComBehavior = require("Common.ComBehavior")
local module = require("Module.module")
local Vector3 = CS.UnityEngine.Vector3
local BehvTransform = ComBehavior:extends()

function BehvTransform:onAwake()
    self.gameObject = self.parent.gameObject
end

function BehvTransform:onShow()
    self.gameObject.transform.position = self.parent.pos or Vector3(1024, 100, 1024)
end

return BehvTransform
