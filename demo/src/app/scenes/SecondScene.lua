local SecondScene = class("SecondScene", function()
    return display.newScene("SecondScene")
end)

function SecondScene:ctor()

    local label = display.newTTFLabel({
        text = "this's Second Scene",
        font = "",
        size = 50,
        align = cc.TEXT_ALIGNMENT_CENTER,
        x = display.width / 2,
        y = display.height / 2
    })
    label:setAnchorPoint(0.5, 0.5)
    self:addChild(label)
end

function SecondScene:onEnter()
end

function SecondScene:onExit()
end

return SecondScene
