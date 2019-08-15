local ComBehavior = require("common.ComBehavior")
local BehvAnimator = ComBehavior:extends()
local module = require("module.module")
local AssetManager = CS.Oasis.Unity.AssetManager
local AssetLoadFlag = CS.Oasis.Unity.AssetLoadFlag
local blendTime = 0.2
function BehvAnimator:onAwake()
    self.animator = self.parent.gameObject:GetComponent("Animator")
    self.plMedia = module.playableMgr.createAnim(self.animator)
    self.clips = {}
end

function BehvAnimator:trigger(clipAsset)
    self.targetClipAsset = clipAsset
    local clip = self.clips[clipAsset]
    if clip then
        self.plMedia:playAnimation(clip, blendTime)
    else
        AssetManager.LoadObject(
            clipAsset.bundle,
            clipAsset.asset,
            typeof(CS.UnityEngine.Object),
            AssetLoadFlag.Default,
            function(_, clip)
                if not clip then
                    module.logger.error("load clip error:" .. clipAsset.id)
                    return
                end
                self.clips[clipAsset] = clip
                if clipAsset == self.targetClipAsset then
                    self.targetClipAsset = nil
                    self.plMedia:playAnimation(clip, blendTime)
                end
            end
        )
    end
end

function BehvAnimator:onDestroy()
    self.clips = nil
    self.plMedia = nil
    self.animator = nil
end

return BehvAnimator
