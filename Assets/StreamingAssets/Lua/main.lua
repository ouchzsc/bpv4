local main = {}
local cfg = require "cfg._cfgs"
local module = require "module.module"

function main.start()
    print('start')
    local bump = require 'bpv3.lib.bump'
    local world = bump.newWorld(10)
    local ComPrefab = require("common.ComPrefab")
    print(world)
    CS.UnityEngine.Debug.Log("hello unity")
    print("abMgr", CS.Res.AbMgr)
    print(cfg.asset.assets.get("Assets/Game/Art/Assassin/Animations/standing idle 01.anim"))
    local modelAst = cfg.npc.npc.get(1).RefAsset
    print(table.unpack(modelAst))
    module.init()
    local user = module.assetMgr.create(modelAst)
    user:Load(function(asset)
        local go = CS.UnityEngine.GameObject.Instantiate(asset)
        go.name = asset.name
    end)
end

function main.update()
    --print('update')
end

return main