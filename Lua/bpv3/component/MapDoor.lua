local MapDoor = Component:extends()

function MapDoor:onPopEvent(type, data)
    if type == "onTrigger" then
        local other = data.other
        if other.name == "hero" then
            sceneModule.load(Scene1, self.entity.mapPath)
        end
    end
end

return MapDoor