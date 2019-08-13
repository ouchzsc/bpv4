local camModule = {}

function camModule.get()
    if camModule.cam == nil then
        camModule.cam = camFactory:create()
    end
    return camModule.cam
end

return camModule