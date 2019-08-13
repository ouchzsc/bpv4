local ArrowCmd = Component:extends()

function ArrowCmd:onEnable()
    self:reg(event.onCmdUpdate, function(dt)
        self.entity.cmdX, self.entity.cmdY = utils.getAxisArrow()
    end)
end

return ArrowCmd