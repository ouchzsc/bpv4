local main = {}

function main.start()
    print('start')
    local bump = require 'bpv3.lib.bump'
    local world = bump.newWorld(10)
    local ComPrefab = require("Common.ComPrefab")
    print(world)
    CS.UnityEngine.Debug.Log("hello unity")
end

function main.update()
    print('update')
end

return main