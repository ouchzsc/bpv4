local bump = require("common.bump")

local bumpWorld = {}

bumpWorld.world = nil

function bumpWorld.create()
    bumpWorld.world = bump.newWorld(1)
end

return bumpWorld