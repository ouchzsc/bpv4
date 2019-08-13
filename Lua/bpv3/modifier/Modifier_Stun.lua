local Modifier_Stun = Modifier:extends()

function Modifier_Stun:onGetStun()
    return true
end

function Modifier_Stun:onGetDuration()
    return 2
end

function Modifier_Stun:onGetIsMultiple()
    return false
end

return Modifier_Stun