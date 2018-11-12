local ActionScene = class("ActionScene", function()
    return display.newScene("ActionScene")
end)

function ActionScene:ctor()

    --[[
    --编辑框
    display.newTTFLabel({ text = "Hello, World", size = 64 }):align(display.CENTER, display.cx, display.cy):addTo(self)

    local editbox = ccui.EditBox:create(cc.size(200, 40), "demo.png", ccui.TextureResType.localType)
    --设置输入框的位置
    editbox:setPosition(display.cx, display.cy * 3 / 2)
    editbox:setName("inputTxt")
    editbox:setAnchorPoint(0.5, 0.5)
    --设置输入设置字体的大小
    editbox:setFontSize(40)
    --设置输入最大长度为6
    editbox:setMaxLength(6)
    --设置输入的字体颜色
    editbox:setFontColor(cc.c4b(124, 92, 63, 255))
    --设置输入的字体为simhei.ttf
    -- editbox:setFontName("simhei")
    --设置数字符号键盘
    editbox:setInputMode(cc.EDITBOX_INPUT_MODE_NUMERIC)
    --设置预制提示文本
    editbox:setPlaceHolder("请输入账号")
    --输入键盘返回类型，done，send，go等KEYBOARD_RETURNTYPE_DONE
    editbox:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
    --输入模型，如整数类型，URL，电话号码等，会检测是否符合
    editbox:setInputMode(cc.EDITBOX_INPUT_MODE_NUMERIC)
    self:addChild(editbox, 5)

    --输入框的事件，主要有光标移进去，光标移出来，以及输入内容改变等
    local function editboxEventHandler(eventType, sender)
        print(eventType)
        if eventType == "began" then
            -- triggered when an edit box gains focus after keyboard is shown
        elseif eventType == "ended" then
            -- triggered when an edit box loses focus after keyboard is hidden.
        elseif eventType == "changed" then
            -- triggered when the edit box text was changed.
            -- self:editboxHandle(eventType,sender)
        elseif eventType == "return" then
            -- triggered when the return button was pressed or the outside area of keyboard was touched.
        end
        self:editboxHandle(eventType, sender)
    end
    editbox:registerScriptEditBoxHandler(editboxEventHandler)
    --]]

    self.backgroundLayer = display.newColorLayer(cc.c4f(128, 128, 128, 255))
    self.backgroundLayer:addTo(self)
    -- preload frames to cache
    display.addSpriteFrames("demo.plist", "demo.png")
    -- run actions: 1 to 9
    self:runMyAction(7)
end

--委托方法
function ActionScene:editboxHandle(eventType, sender)
    -- body
    print("sender:")
    print(sender:getText())
end

function ActionScene:runMyAction(actionNum)
    self["action" .. actionNum](self)
end

--[[
action ! ~ 12
]]
function ActionScene:action1()
    -- 用在层跟随精灵中，固定摄像机到精灵身上
    local sprite1 = display.newSprite("res/button/btnDog_N.png")
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
    local sprite2 = display.newSprite("button/btnDog_D.png"):center():addTo(self.backgroundLayer)
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

    local sprite1 = display.newSprite("res/button/btnDog_N.png"):center():addTo(self.backgroundLayer):runAction(action)
end

--[[
CallFunc
]]
function ActionScene:action4()
    -- 判断顺序动画执行结束
    local callback = cc.CallFunc:create(function() print("In callback function") end)
    local moveTo = cc.MoveTo:create(2, cc.p(0, 0))
    local action = cc.Sequence:create(moveTo, callback)

    local sprite1 = display.newSprite("res/button/btnDog_N.png"):center():addTo(self.backgroundLayer):runAction(action)
end

--[[
贝塞尔曲线
]]
function ActionScene:action5()
    local action = cc.BezierTo:create(2, { cc.p(display.right, display.top), cc.p(200, 200), cc.p(50, 100) })

    local sprite1 = display.newSprite("res/button/btnDog_N.png"):pos(0, 0):addTo(self.backgroundLayer):runAction(action)
end

--[[
FadeTo
]]
function ActionScene:action6()
    local action = cc.FadeTo:create(2, 0)

    local sprite1 = display.newSprite("res/button/btnDog_N.png"):center():addTo(self.backgroundLayer):runAction(action)
end

--[[
帧动画
]]
function ActionScene:action7()
    local frames = display.newFrames("btn%02d.png", 1, 3)
    local animation = display.newAnimation(frames, 1)
    local animate = cc.Animate:create(animation)

    local sprite1 = display.newSprite("#btn03.png"):center():addTo(self.backgroundLayer):runAction(animate)
end

--[[
延迟动作
]]
function ActionScene:action8()
    local move = cc.MoveBy:create(1, cc.vertex2F(150, 0))
    local action = cc.Sequence:create(move, cc.DelayTime:create(2), move:reverse())

    local sprite1 = display.newSprite("res/button/btnDog_N.png"):center():addTo(self.backgroundLayer):runAction(action)
end

--[[
变速动作
]]
function ActionScene:action9()
    local action = cc.EaseSineOut:create(cc.MoveBy:create(2, cc.p(300, 0)))
    local sprite1 = display.newSprite("res/button/btnDog_N.png"):center():addTo(self.backgroundLayer):runAction(action)
end

function ActionScene:onEnter()
end

function ActionScene:onExit()
end

return ActionScene

