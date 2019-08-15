local ComSimpScene = require("common.ComSimpScene")
local ComOpenWorld = ComSimpScene:extends()
local module = require("module.module")
local GameObject = CS.UnityEngine.GameObject
local ComGo = require("common.ComGo")
local ComChunk = require("World.ComChunk")
local ComFreeLook = require("World.ComFreeLook")
local Vector3 = CS.UnityEngine.Vector3

local GridW = 512
local GridH = 512

function ComOpenWorld:onAwake()
    self:createBasicScenes(18, 14)
    self:createLods()
    self.freeLook = self:addChild(ComFreeLook, GameObject.Find("Player VCamera"))
    module.boot.worldRoot = GameObject.Find("worldRoot")
    module.boot.mainCam = GameObject.Find("Main Camera")
end

function ComOpenWorld:onEnable()
    self:reg(module.event.enterArea, function(_, x, y)
        self:enterArea(x, y)
    end)
    self:reg(module.event.onChunkEnable, function(_, x, y)
        self:showLodMeshes(x, y, false)
    end)
    self:reg(module.event.onChunkDisable, function(_, x, y)
        self:showLodMeshes(x, y, true)
    end)
    self:reg(module.event.updatePlayerPos, function(_, pos)
        self:updatePlayerPos(pos)
    end)
    module.playerMgr.createPlayer()

    --local npc = module.npcMgr.getOrCreate("123",1)
    --npc:setData({pos = Vector3(2502,100,3006)})
    --npc:show()
end

function ComOpenWorld:onShow()
    self.freeLook:show()
    for k, v in pairs(self.lods) do
        v:show()
    end
end

function ComOpenWorld:onDestroy()
    module.boot.worldRoot = nil
    module.boot.mainCam = nil
end

function ComOpenWorld:createLods()
    self.lods = {}
    local LodMeshes = GameObject.Find("Lod Meshes")
    for i = 0, LodMeshes.transform.childCount - 1 do
        local child = LodMeshes.transform:GetChild(i)
        local childCom = self:addChild(ComGo, child.gameObject)
        self.lods[child.gameObject.name] = childCom
    end
end

function ComOpenWorld:createBasicScenes(w, h)
    self.allScene = {}
    self.w = w
    self.h = h
    for i = 0, w - 1 do
        for j = 0, h - 1 do
            local obj = ComChunk:new({ x = i, y = j })
            self.allScene[i + j * w] = obj
        end
    end
end

function ComOpenWorld:getNeighbors(x, y)
    local neighbors = {}
    if x == nil or y == nil then
        return neighbors
    end
    for i = x - 1, x + 1 do
        for j = y - 1, y + 1 do
            if i >= 0 and i < self.w and j >= 0 and j < self.h then
                local area = self.allScene[i + j * self.w]
                neighbors[area] = true
            end
        end
    end
    return neighbors
end


-- 还可以优化，目前，要避免抖动，缓存要设置成5，如果把一个cell分成4份，缓存只用设置成3
-- 最大内存从12个cell降低到7个cell
function ComOpenWorld:enterArea(newCellX, newCellY)
    if newCellX == self.oldCellX and newCellY == self.oldCellY then
        return
    end
    print("enter area:", newCellX, newCellY)
    local oldAreas = self:getNeighbors(self.oldCellX, self.oldCellY)
    local newAreas = self:getNeighbors(newCellX, newCellY)
    for area, _ in pairs(newAreas) do
        area:show()
        oldAreas[area] = nil
    end
    for area, _ in pairs(oldAreas) do
        area:hide()
    end
    self.oldCellX, self.oldCellY = newCellX, newCellY
end

function ComOpenWorld:getCellXY(pos)
    local cellX, cellY = pos.x, pos.z
    cellX = math.floor(cellX / GridW)
    cellY = math.floor(cellY / GridH)
    return cellX, cellY
end

function ComOpenWorld:updatePlayerPos(pos)
    local cellX, cellY = self:getCellXY(pos)
    self:enterArea(cellX, cellY)
end

function ComOpenWorld:showLodMeshes(x, y, invisible)
    local name = string.format("Terrain_Chunk_Mesh_%s_%s", x, y)
    local lodMesh = self.lods[name]
    if lodMesh then
        if invisible then
            lodMesh:show()
        else
            lodMesh:hide()
        end
    end
end

return ComOpenWorld
