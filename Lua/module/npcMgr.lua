local module = require("module.module")
local Npc = require("world.Npc")
local npcMgr = {}

-- key:guid value:Npc
npcMgr.allNpc = {}

function npcMgr.getOrCreate(guid, npcId)
    local npc = npcMgr.allNpc[guid]
    if npc then
        return npc
    end
    local npc = Npc:new({ guid = guid, npcId = npcId, parentTransform = module.boot.worldRoot.transform })
    npcMgr.allNpc[guid] = npc
    return npc
end

function npcMgr.destroy(guid)
    local npc = npcMgr.allNpc[guid]
    if npc then
        npc:hide()
        npcMgr.allNpc[guid] = nil
    end
end

return npcMgr
