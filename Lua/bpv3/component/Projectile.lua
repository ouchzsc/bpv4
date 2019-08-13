local Projectile = Component:extends()

function Projectile:onPopEvent(type, data)
    if type == "onTrigger" then
        local caster = self.entity.caster
        local target = data.other
        if caster then
            caster:popEvent("Ability_onProjectileHit", { projectile = self.entity, target = target })
        end
    end
end

return Projectile