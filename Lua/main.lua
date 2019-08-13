local main = {}

function main.start()
    print('start')
    local bump = require 'lua.lib.bump'
    local world = bump.newWorld(10)
    print(world)
    CS.UnityEngine.Debug.Log("hello unity")
end

function main.update()
    print('update')
end

return main