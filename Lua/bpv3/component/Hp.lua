local Hp = Component:extends()

function Hp:onPopEvent(type, data)
    if type == "Hp_Damage" then
        local entity = self.entity
        local dmg = data.damage
        local src = data.src
        local cd = data.cd or 1
        entity.dmgSources = entity.dmgSources or {}
        if entity.dmgSources[src] then
            return
        end
        entity.dmgSources[src] = true
        self:scheduleTimer("removeSrc", cd, function()
            entity.dmgSources[src] = nil
        end)
        local hp = entity.hp - dmg
        if hp < 0 then
            hp = 0
        end
        entity.hp = hp
        if hp == 0 then
            entity:hide()
        end
    end
end

return Hp