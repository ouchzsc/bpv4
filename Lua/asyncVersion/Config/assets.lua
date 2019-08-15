-- assets : 资源列表
-- 字段定义
local fields = {
    id = 1, -- 主键
    bundle = 2, -- bundle名字
    asset = 3, -- 资产命名
    type = 4, -- 资产类型
}

local cfgMgr = require("Config.cfgMgr")

-- ref
local refs = {
}

-- 所有原始数据
local assets = {}

local cache = {}

local datas = {
    { "Assets/Game/UIs/Views/Setting/SettingView.prefab", "uis/views/setting", "SettingView", ".prefab" },
}

-- 根据字段名查询
local find_by_field = function(row, key)
    local i = fields[key]
    if i then
        return row[i]
    else
        i = refs[key]
        if i then
            return assets[key](row[i])
        else
            return nil
        end
    end
end

-- meta
local meta = { __index = find_by_field }
for i = 1, 555 do
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
function assets.all()
    return datas
end

-- 根据主键查询数据
function assets.get(id)
    return pool_id[id]
end

return assets
