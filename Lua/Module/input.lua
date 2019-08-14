local module = require("Module.module")
local Input = CS.UnityEngine.Input
local KeyCode = CS.UnityEngine.KeyCode
local testFile = 'Test'

local input = {}

function input.init()
    module.event.onUpdate:Register(input.update)
end

function input.update()
    if Input.GetKeyDown(KeyCode.F6) then
        package.loaded[testFile] = nil
        local test = require(testFile)
        if test.f6 then
            pcall(test.f6)
        end
    end

    if Input.GetKeyDown(KeyCode.F7) then
        package.loaded[testFile] = nil
        local test = require(testFile)
        if test.f7 then
            xpcall(test.f7, function(err)
                module.logger.error(err .. debug.traceback())
            end)
        end
    end
end

return input
