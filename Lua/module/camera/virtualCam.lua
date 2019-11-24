local GameObject = CS.UnityEngine.GameObject
local CinemachineVirtualCamera = CS.Cinemachine.CinemachineVirtualCamera
local virtualCam ={}
local module = require("module.module")

function virtualCam.init()
    virtualCam.vcam = GameObject.Find("VirtualCam"):GetComponent(typeof(CinemachineVirtualCamera))

end

function virtualCam.setTarget(target)
    virtualCam.vcam.Follow = target
    virtualCam.vcam.LookAt = target
end

function virtualCam.clearTarget()
    virtualCam.vcam.follow = nil
    virtualCam.vcam.lookAt = nil
end



return virtualCam