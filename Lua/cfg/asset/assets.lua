local cfg = require "cfg._cfgs"

local this = cfg.asset.assets

local mk = cfg._mk.table(this, { { "all", "get", 1 }, }, nil, nil, 
    "assetpath", -- string, assetpath
    "bundle", -- string, bundle
    "asset", -- string, asset
    "type"  -- string, type
    )

mk("Assets/Game/Art/Assassin/Animations/standing idle 01.anim", "assassin", "standing idle 01", ".anim")
mk("Assets/Game/Art/Assassin/Animations/standing run back.anim", "assassin", "standing run back", ".anim")
mk("Assets/Game/Art/Assassin/Animations/standing run forward stop.anim", "assassin", "standing run forward stop", ".anim")
mk("Assets/Game/Art/Assassin/Animations/standing run forward.anim", "assassin", "standing run forward", ".anim")
mk("Assets/Game/Art/Assassin/Animations/standing run left.anim", "assassin", "standing run left", ".anim")
mk("Assets/Game/Art/Assassin/Animations/standing run right.anim", "assassin", "standing run right", ".anim")
mk("Assets/Game/Art/Assassin/Animations/standing turn 90 left.anim", "assassin", "standing turn 90 left", ".anim")
mk("Assets/Game/Art/Assassin/Animations/standing turn 90 right.anim", "assassin", "standing turn 90 right", ".anim")
mk("Assets/Game/Art/Assassin/Animations/standing walk back.anim", "assassin", "standing walk back", ".anim")
mk("Assets/Game/Art/Assassin/Animations/standing walk forward.anim", "assassin", "standing walk forward", ".anim")
mk("Assets/Game/Art/Assassin/Animations/standing walk left.anim", "assassin", "standing walk left", ".anim")
mk("Assets/Game/Art/Assassin/Animations/standing walk right.anim", "assassin", "standing walk right", ".anim")
mk("Assets/Game/Art/Assassin/Animations/vampire_a_lusth.anim", "assassin", "vampire_a_lusth", ".anim")
mk("Assets/Game/Art/Assassin/Animator/as_animator.controller", "assassin", "as_animator", ".controller")
mk("Assets/Game/Art/Assassin/Materials/Vampire_MAT.mat", "assassin", "Vampire_MAT", ".mat")
mk("Assets/Game/Art/Assassin/Model/Vampire.mesh", "assassin", "Vampire", ".mesh")
mk("Assets/Game/Art/Assassin/Model/vampire_a_lusthAvatar.asset", "assassin", "vampire_a_lusthAvatar", ".asset")
mk("Assets/Game/Art/Assassin/Prefab/vampire_a_lusth.prefab", "assassin", "vampire_a_lusth", ".prefab")
mk("Assets/Game/Art/Assassin/Textures/Vampire_diffuse.png", "assassin", "Vampire_diffuse", ".png")
mk("Assets/Game/Art/Assassin/Textures/Vampire_emission.png", "assassin", "Vampire_emission", ".png")
mk("Assets/Game/Art/Assassin/Textures/Vampire_normal.png", "assassin", "Vampire_normal", ".png")
mk("Assets/Game/Art/Assassin/Textures/Vampire_specular.png", "assassin", "Vampire_specular", ".png")

return this
