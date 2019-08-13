--Animator的调用方式
--通过play 和 stop控制
--不通过show hide,但是要确保component enable，否则timer不执行

local Animator = Component:extends()

function Animator:onEnable()
    if self.animcfg==nil then
        self:play(self.entity.ACT_IDLE)
    end
end

function Animator:onPopEvent(type,data)
    if type == "cameraDraw" then
        if self.animcfg==nil then
            return
        end
        local entity = self.entity
        local x, y = entity.x, entity.y
        local w, h = self.animcfg.width, self.animcfg.height
        local scale = self.animcfg.scale or 1
        local dir = entity.dir or 1
        local index = self.index or 1
        if dir == 1 then
            love.graphics.draw(self.img, self.quads[index], x, y, 0, scale, scale)
        else
            love.graphics.draw(self.img, self.quads[index], x + entity.w, y, 0, -1 * scale, scale)
        end
    elseif type=="Aniamtor_Play" then
        self:play(data)
    end
end

function Animator:play(animcfg)
    if animcfg == nil then
        return
    end
    if self.animcfg == animcfg then
        return
    end
    self.animcfg = animcfg
    local imgPath = animcfg.imgPath
    local width = animcfg.width
    local height = animcfg.height
    local space = animcfg.space
    local quadCnt = animcfg.cnt
    self.index = 1
    self.img = love.graphics.newImage(imgPath)
    self.quads = {}
    for i = 1, quadCnt do
        local x = (i - 1) * (space + width)
        local y = 0
        local quad = love.graphics.newQuad(x, y, width, height, self.img:getDimensions())
        table.insert(self.quads, quad)
    end
    self:scheduleTimerAtFixedRate("animatorFixedRate", 0, self.animcfg.loopTime / self.animcfg.cnt, function()
        if self.quads then
            self.index = self.index or 1
            self.index = self.index + 1
            if self.index > #self.quads then
                self.index = 1
            end
        end
    end)
end

function Animator:stop()
    self.animcfg = nil
    self.quads = nil
    self.img = nil
    self.index = nil
    self:unscheduleTimer("animatorFixedRate")
end

return Animator
