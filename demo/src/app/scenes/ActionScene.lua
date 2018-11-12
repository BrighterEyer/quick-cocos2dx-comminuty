local ActionScene = class("ActionScene", function()
    return display.newScene("ActionScene")
end)

function ActionScene:ctor()
    self.backgroundLayer = display.newColorLayer(cc.c4f(128, 128, 128, 255))
    self.backgroundLayer:addTo(self)

    -- preload frames to cache
    display.addSpriteFrames("grossini-aliases.plist", "grossini-aliases.png")

    -- run actions: 1 to 9
    --[[
    --1:Follow
    --2:MoveBy
    --3:Hide
    --4:CallFunc
    --5:贝塞尔曲线
    --6:FadeTo
    --7:帧动画
    --8:延迟动作
    --9:变速动作
    --]]
    local number = 9
    self:run(number)
end

function ActionScene:run(actionNum)
    self["action" .. actionNum](self)
end

--[[
Follow
]]
function ActionScene:action1()
    -- 用在层跟随精灵中，固定摄像机到精灵身上
    local sprite1 = display.newSprite("1.png")
    sprite1:center()
    local move_left = cc.MoveBy:create(1.5, cc.p(display.width / 2, 0))
    local move_right = cc.MoveBy:create(3, cc.p(-display.width, 0))
    local seq = cc.Sequence:create(move_left, move_right, move_left)
    local rep = cc.RepeatForever:create(seq)
    sprite1:runAction(rep)
    sprite1:addTo(self.backgroundLayer)

    self.backgroundLayer:runAction(cc.Follow:create(sprite1))
end

--[[
MoveBy
]]
function ActionScene:action2()
    local sprite2 = display.newSprite("2.png"):center():addTo(self.backgroundLayer)
    -- true 翻转，false 重置为最初的状态
    local flipxAction = cc.FlipX:create(true)
    local moveTo = cc.MoveBy:create(1, cc.p(-300, 0))
    local action = cc.Sequence:create(moveTo, flipxAction, moveTo:reverse())
    sprite2:runAction(action)
end

--[[
Hide
]]
function ActionScene:action3()
    local hideAction = cc.Hide:create()
    local moveTo = cc.MoveTo:create(1.5, cc.p(60, 60))
    local action = cc.Sequence:create(moveTo, hideAction)

    local sprite1 = display.newSprite("1.png"):center():addTo(self.backgroundLayer):runAction(action)
end

--[[
CallFunc
]]
function ActionScene:action4()
    -- 判断顺序动画执行结束
    local callback = cc.CallFunc:create(function() print("In callback function") end)
    local moveTo = cc.MoveTo:create(2, cc.p(0, 0))
    local action = cc.Sequence:create(moveTo, callback)

    local sprite1 = display.newSprite("1.png"):center():addTo(self.backgroundLayer):runAction(action)
end

--[[
贝塞尔曲线
]]
function ActionScene:action5()
    local action = cc.BezierTo:create(2, { cc.p(display.right, display.top), cc.p(200, 200), cc.p(50, 100) })
    local sprite1 = display.newSprite("1.png"):pos(0, 0):addTo(self.backgroundLayer):runAction(action)
end

--[[
FadeTo
]]
function ActionScene:action6()
    --第二个参数最大值为255
    local action = cc.FadeTo:create(2, 50)
    local sprite1 = display.newSprite("1.png"):center():addTo(self.backgroundLayer):runAction(action)
end

--[[
帧动画
]]
function ActionScene:action7()
    local frames = display.newFrames("grossini_dance_%02d.png", 1, 14)
    local animation = display.newAnimation(frames, 0.2)
    local animate = cc.Animate:create(animation)
    local sprite1 = display.newSprite("#grossini_dance_01.png"):center():addTo(self.backgroundLayer):runAction(animate)
end

--[[
延迟动作
]]
function ActionScene:action8()
    local move = cc.MoveBy:create(1, cc.vertex2F(150, 0))
    local action = cc.Sequence:create(move, cc.DelayTime:create(2), move:reverse())
    local sprite1 = display.newSprite("1.png"):center():addTo(self.backgroundLayer):runAction(action)
end

--[[
变速动作
]]
function ActionScene:action9()
    local action = cc.EaseSineOut:create(cc.MoveBy:create(2, cc.p(300, 0)))
    local sprite1 = display.newSprite("1.png"):center():addTo(self.backgroundLayer):runAction(action)
end

function ActionScene:onEnter()
end

function ActionScene:onExit()
end

return ActionScene
