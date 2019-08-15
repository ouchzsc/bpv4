local ipairs = ipairs
local rawget = rawget
local setmetatable = setmetatable
local unpack = table.unpack
local require = require

local mkcfg = {}

--- refs { {refname, islist, dsttable, dstgetname, keyidx1, keyidx2}, }
local function mkbean(refs, fields)
    local get = {}
    for i, f in ipairs(fields) do
        get[f] = function(t)
            return t[i]
        end
    end

    get.Fields = function()
        --- fields都小写，refs开头是Ref，NullableRef所以起名Fields不会重复
        return fields
    end

    if refs then
        for _, ref in ipairs(refs) do
            local refname, islist, dsttable, dstgetname, k1, k2 = unpack(ref)
            if k2 == nil then
                if islist then
                    get[refname] = function(t)
                        --- 只对list做cache，这样能避免频繁alloc，不对其他做，是因为非list的ref可能为nil，反正cache不住的
                        local cache = rawget(t, refname)
                        if cache then
                            return cache
                        end
                        cache = {}
                        for _, ele in ipairs(t[k1]) do
                            cache[#cache + 1] = dsttable[dstgetname](ele)
                        end
                        t[refname] = cache
                        return cache
                    end
                else
                    get[refname] = function(t)
                        return dsttable[dstgetname](t[k1])
                    end
                end
            else
                get[refname] = function(t)
                    return dsttable[dstgetname](t[k1], t[k2])
                end
            end
        end
    end

    return get
end

function mkcfg.copy(dst, bean)
    for i, f in ipairs(bean.Fields) do
        dst[f] = bean[i]
    end
end

function mkcfg.bean(refs, ...)
    local fields = { ... }
    local get = mkbean(refs, fields)

    local I = {}
    I.__index = function(t, k)
        local g = rawget(get, k)
        if g then
            return g(t)
        end
        return nil
    end

    local mk = function(...)
        local v = { ... }
        setmetatable(v, I)
        return v
    end
    return mk
end

function mkcfg.action(typeName, refs, ...)
    local fields = { ... }
    local get = mkbean(refs, fields)

    local I = {}
    I.type = function()
        return typeName
    end
    I.__index = function(t, k)
        local f = rawget(I, k)
        if f then
            return f
        end

        local g = rawget(get, k)
        if g then
            return g(t)
        end
        return nil
    end

    local mk = {}
    mk.type = function()
        return typeName
    end
    mk.__call = function(_, ...)
        local v = { ... }
        setmetatable(v, I)
        return v
    end
    setmetatable(mk, mk)
    return mk
end


local table2required = {}
mkcfg._table2required = table2required

function mkcfg.pretable(modname)
    local I = {}
    I.__index = function(t, k)
        if table2required[t] then
            return nil
        end

        --- 第一次请求
        table2required[t] = true
        require(modname)
        return rawget(t, k)
    end

    local v = {}
    setmetatable(v, I)
    return v
end

--- uniqkeys : {{allname, getname, keyidx1, keyidx2}, }
function mkcfg.table(self, uniqkeys, enumidx, refs, ...)
    local fields = { ... }
    local get = mkbean(refs, fields)
    for _, uk in ipairs(uniqkeys) do
        local allname, getname, _, k2 = unpack(uk)
        local map = {}
        self[allname] = map
        if k2 == nil then
            self[getname] = function(k)
                return map[k]
            end
        else
            --- 2个字段可以做为uniqkey，但都必须是数字，并且第一个<1千万，第二个<10万
            self[getname] = function(k, j)
                return map[k + j * 10000000]
            end
        end
    end

    local I = {}
    I.__index = function(t, k)
        local g = rawget(get, k)
        if g then
            return g(t)
        end
        return nil
    end

    local mk
    local uk = uniqkeys[1]
    if enumidx == nil and #uniqkeys == 1 and uk[4] == nil then
        --- 优化
        local allname, _, k1 = unpack(uk)
        local all = self[allname]
        mk = function(...)
            local v = { ... }
            setmetatable(v, I)
            all[v[k1]] = v
            return v
        end
    else
        mk = function(...)
            local v = { ... }
            setmetatable(v, I)
            for _, uk in ipairs(uniqkeys) do
                local allname, _, k1, k2 = unpack(uk)
                local all = self[allname]
                if k2 == nil then
                    all[v[k1]] = v
                else
                    all[v[k1] + v[k2] * 10000000] = v
                end
            end

            if enumidx then
                local e = v[enumidx]
                if #e > 0 then
                    self[e] = v
                end
            end
            return v
        end
    end
    return mk
end

return mkcfg