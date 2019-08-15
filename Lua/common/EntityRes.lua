local Entity = require("common.Entity")
local module = require("module.module")
local logger = module.logger

local EntityRes = Entity:extends()

function EntityRes:onNew()
    self.resObj = nil
    self.isLoading = false
    self.isEnable = false
    self.wishEnable = false
    self.awaken = false
end

function EntityRes:show()
    self.wishEnable = true
    if self.resObj == nil then
        if self.isLoading then
            -- do nothing
            return
        else
            self.isLoading = true
            self:startLoad()
            return
        end
    else
        if self.isLoading then
            logger.info("error, can't be loading")
        else
            if self.isEnable == false then
                self:getCache():get(self)
                if not self.awaken then
                    self.awaken = true
                    self:onAwake()
                end

                self.isEnable = true
                self:onResEnable()
                self:onEnable()
            end
            self:onShow()
        end
    end
end

function EntityRes:onLoaded(obj)
    self.resObj = obj
    self.isLoading = false
    if self.wishEnable then
        self.awaken = true
        self:onAwake()
        self.isEnable = true
        self:onResEnable()
        self:onEnable()
        self:onShow()
    else
        self:onResDisable()
        self:getCache():put(self)
    end
end

function EntityRes:onCacheOut()
    self:removeChildren()
    if self.awaken then
        self:onDestroy()
    end
    self:onResDestroy()
    self.resObj = nil
end

function EntityRes:hide()
    self.wishEnable = false
    if self.resObj then
        if self.isEnable then
            self.isEnable = false
            self:hideChildren()
            self:onDisable()
            self:unRegAllEvent()
            self:unScheduleAllTimer()
            self:onResDisable()
            self:getCache():put(self)
        else
            --do nothing
            return
        end
    else
        -- do nothing
        return
    end
end

function EntityRes:getCache()
    return module.cacheMgr.defaultCache
end

function EntityRes:onResEnable()
end

function EntityRes:onResDisable()
end

function EntityRes:onResDestroy()
end


return EntityRes
