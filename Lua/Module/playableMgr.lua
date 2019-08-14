local Stream = require("Common.Stream")
local module = require("Module.module")
local PlayableGraph = CS.UnityEngine.Playables.PlayableGraph
local DirectorUpdateMode = CS.UnityEngine.Playables.DirectorUpdateMode
local AnimationPlayableOutput = CS.UnityEngine.Animations.AnimationPlayableOutput
local AnimationClipPlayable = CS.UnityEngine.Animations.AnimationClipPlayable
local AnimatorControllerPlayable = CS.UnityEngine.Animations.AnimatorControllerPlayable
local AnimationMixerPlayable = CS.UnityEngine.Animations.AnimationMixerPlayable
local CSharpWrap = CS.Game.CSharpWrap

local Object = require("Common.Object")
local media = Object:extends()
local playableMgr = {}

local medias = Stream:New()

function playableMgr.init()
    module.event.onUpdate:Register(playableMgr.update)
end

function playableMgr.createAnim(animator, name)
    return media:new({animator= animator, name=name})
end

function playableMgr.regUpdate(anim)
    anim.id = medias:Add(anim)
end

function playableMgr.update(dt)
    medias:ForEach(
        function(e, id, ...)
            if e.task == nil then
                medias.Delete(e.id)
                e.id = nil
            else
                e:update(dt)
            end
        end
    )
end


function media:onNew()
    self.graph = PlayableGraph.Create(self.name)
    self.graph:SetTimeUpdateMode(DirectorUpdateMode.GameTime)
    local output = AnimationPlayableOutput.Create(self.graph, "Animation", self.animator)
    self.mixer = AnimationMixerPlayable.Create(self.graph)
    CSharpWrap.SetSourcePlayable(output, self.mixer)
end

function media:playAnimation(clip, blend)
    if (blend <= 0) then
        self:clear()
    end

    self.blend = blend
    self.cur = 0
    local p0 = AnimationClipPlayable.Create(self.graph, clip)
    local inputPort = CSharpWrap.AddInput(self.mixer, p0, 0, 1)
    self.graph:Play()

    self.task = {}
    local count = CSharpWrap.GetInputCount(self.mixer)
    for i = 1, count do
        weight = CSharpWrap.GetInputWeight(self.mixer, i - 1)
        table.insert(self.task, { port = i - 1, startWeight = weight })
    end
    self.next = inputPort

    playableMgr.regUpdate(self)
end

function media:playAnimator(controller, blend)
    if (blend <= 0) then
        self:clear()
    end

    self.blend = blend
    self.cur = 0
    local p0 = AnimatorControllerPlayable.Create(graph, controller)
    local inputPort = self.mixer:AddInput(p0, 0, 1)
    self.graph:Play()

    self.task = {}
    local count = self.mixer:GetInputCount()
    for i = 1, count do
        weight = self.mixer:GetInputWeight(i - 1)
        table.insert(self.task, { port = i - 1, startWeight = weight })
    end
    self.next = inputPort

    playableMgr.regUpdate(self)
end

function media:clear()
    local count = self.mixer:GetInputCount()
    for i = 1, count do
        self.mixer:GetInput(i - 1):Destroy()
        self.mixer:DisconnectInput(i - 1)
    end
    self.graph:Stop()
end

function media:destroy()
    self.graph:Destroy()
    self.graph = nil
    self.animator = nil
    self.mixer = nil
    self.task = nil
end

function media:update(dt)
    if task == nil then
        return
    end

    if self.cur >= self.blend then
        for i, v in ipairs(self.task) do
            self.mixer:GetInput(self.task.port):Destroy()
            self.mixer:DisconnectInput(self.task.port)
        end
        task = nil
        self.blend = 0
    end

    self.cur = dt + self.cur
    local t = self.cur / self.blend

    for i, v in ipairs(self.task) do
        self.mixer:SetInputWeight(self.task.port, (1 - t) * v.startWeight)
    end
    self.mixer:SetInputWeight(self.next, t)
end

return playableMgr
