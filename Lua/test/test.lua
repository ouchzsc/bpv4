local module = require("module.module")
--local Vector3 = CS.UnityEngine.Vector3

local test = {}

local function reload(filepath, field)
    local old = package.loaded[filepath]
    package.loaded[filepath] = nil
    local new = require(filepath)
    old[field] = new[field]
    package.loaded[filepath] = old
end

local function unitTest_Player()
    module.playerMgr.player:hide()
    --reload('world.Player', 'onFixedUpdate')
    module.playerMgr.player:show()
end

local function unitTest_FreeLook()
    reload('world.ComFreeLook', 'onUpdate')
    local freeLook = module.boot.openWorld.freeLook
    freeLook:hide()
    freeLook:show()
end

local function unitTest_CreateNpc()
    local npc = module.npcMgr.getOrCreate("dragon_001", 1)
    npc:setData({ pos = Vector3(2502, 100, 3006) })
    npc:show()
end

local function unitTest_Playable()
    local npc = module.npcMgr.getOrCreate("dragon_001", 2)
    npc:setData({ clipAsset = module.cfgMgr.npc.get(2).clipsRef[2] })
    npc:show()
end

function test.f6()
    print("f6")
    module.world.hero:show()
end

function test.f7()
    print("f7")
    module.world.hero:hide()
end

return test
