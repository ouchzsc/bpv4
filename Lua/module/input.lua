local module = require("module.module")
local Input = CS.UnityEngine.Input
local KeyCode = CS.UnityEngine.KeyCode
local testFile = 'test.test'

local input = {}

input.axisX = 0
input.axisY = 0

function input.init()
    module.event.onUpdate:Register(input.update)
end

function input.update()
    input.axisX = Input.GetAxis("Horizontal")
    input.axisY = Input.GetAxis("Vertical")

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
