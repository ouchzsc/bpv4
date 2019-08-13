local GameObject = UnityEngine.GameObject
local module = {}

function module.init()
    GameObject.Find("Canvas/Text"):GetComponent("Text").text="Hello Lua"
end

return module