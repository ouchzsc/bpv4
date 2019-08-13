-- test : 1wer
-- 字段定义
local fields = {
    id = 1, -- 主键
    ssd = 2, -- fwe
}

local cfgMgr = require("Config.cfgMgr")

-- ref
local refs = {
}

-- 所有原始数据
local test = {}

local cache = {}

local datas = {
    { 1, { "123", "123", "234" } },
}

-- 根据字段名查询
local find_by_field = function(row, key)
    local i = fields[key]
    if i then
        return row[i]
    else
        i = refs[key]
        if i then
            return test[key](row[i])
        else
            return nil
        end
    end
end

-- meta
local meta = { __index = find_by_field }
for i = 1, 1 do
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
function test.all()
    return datas
end

-- 根据主键查询数据
function test.get(id)
    return pool_id[id]
end

return test
