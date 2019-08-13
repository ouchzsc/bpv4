-- npc : npc
-- 字段定义
local fields = {
    id = 1, -- 主键
    asset = 2, -- 资产引用
    name = 3, -- 名字
    clips = 4, -- 动作clips
}

local cfgMgr = require("Config.cfgMgr")

-- ref
local refs = {
    assetRef = 2, -- 资产引用
    clipsRef = 4, -- 动作clips
}

-- 所有原始数据
local npc = {}

local cache = {}

local datas = {
    { 1, "Assets/Game/Content/Prefab/RedDragon/RedDragon.prefab", "红龙", {  } },
    { 2, "Assets/Game/Content/Prefab/RedDragon/RedDragon.prefab", nil, { "Assets/Game/Content/Animations/Dragon/Basic Attack.anim", "Assets/Game/Content/Animations/Dragon/Flame Attack.anim" } },
}

-- 根据字段名查询
local find_by_field = function(row, key)
    local i = fields[key]
    if i then
        return row[i]
    else
        i = refs[key]
        if i then
            return npc[key](row[i])
        else
            return nil
        end
    end
end

-- meta
local meta = { __index = find_by_field }
for i = 1, 2 do
    setmetatable(datas[i], meta)
end

-- 初始化索引
local rows_to_table = function(...)
    local indexes = { ... }
    local top = {}
    for i, row in ipairs(datas) do
        local current = top
        for j, index in ipairs(indexes) do
            local value = row[fields[index]]
            if (j < #indexes) then
                local sub = current[value]
                if (not (sub)) then
                    sub = {}
                    current[value] = sub
                end
                current = sub
            else
                current[value] = row
            end
        end
    end
    return top
end

-- 主键映射
local pool_id = rows_to_table("id")

-- 查询所有数据
function npc.all()
    return datas
end

-- 根据主键查询数据
function npc.get(id)
    return pool_id[id]
end

function npc.assetRef(param)
    return cfgMgr.assets.get(param)
end

function npc.clipsRef(param)
    if cache[param] then
        return cache[param]
    end

    local re = {}
    for i, v in ipairs(param) do
        table.insert(re, cfgMgr.assets.get(v))
    end
    cache[param] = re
    return re
end

return npc
