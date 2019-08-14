local ComWorldChunkBase = require("Common.ComWorldChunkBase")
local module = require("Module.module")
local ComChunk = ComWorldChunkBase:extends()

function ComChunk:onEnable()
    module.event.onChunkEnable:trigger(self.x, self.y)
end

function ComChunk:onDisable()
    module.event.onChunkDisable:trigger(self.x, self.y)
end

return ComChunk
