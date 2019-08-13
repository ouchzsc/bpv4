local HeroHp = Component:extends()
local hpimgpath = "img/heart.png"
local startX, startY = 10, 10
local imgWidth = 13
local scale = 1
function HeroHp:onEnable()
    self.img = self.img or love.graphics.newImage(hpimgpath)
    self:reg(event.onDrawUi, function()
        local hero = heroModule.getHero()
        if hero==nil then
            return
        end
        local hp = hero.hp or 0
        for i = 1, hp do
            love.graphics.draw(self.img, startX + (i - 1) * imgWidth * scale, startY, 0, scale, scale)
        end
    end)
end

return HeroHp