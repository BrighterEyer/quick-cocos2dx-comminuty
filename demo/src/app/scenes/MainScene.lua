local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

local scheduler = require(cc.PACKAGE_NAME .. ".scheduler")

function MainScene:ctor()

    --[[
    local background = display.newSprite("image/main.jpg"):scale(2.0, 1.9)
    background:pos(display.cx, display.cy):addTo(self)
    local title = display.newSprite("image/title.png"):pos(display.cx / 2 * 3, display.cy):scale(1.5, 1.5):addTo(self)
    --]]

    --[[
        self.printAll(display.widthInPixels, display.heightInPixels,
            display.width, display.height,
            display.cx, display.cy,
            display.left, display.top, display.right, display.bottom,
            display.c_left, display.c_top, display.c_right, display.c_bottom,
            display.contentScaleFactor)
    ]]

    -- local move1 = cc.MoveBy:create(0.5, cc.p(0, 10))
    -- local move2 = cc.MoveBy:create(0.5, cc.p(0, -10))
    -- local SequenceAction = cc.Sequence:create( move1, move2 )
    -- self:runAction(title, cc.RepeatForever:create( SequenceAction ))



    --[[
    --锚点
    local red = cc.LayerColor:create(cc.c4b(255, 100, 100, 128))
    red:setContentSize(display.width / 2, display.height / 2)
    --red:ignoreAnchorPointForPosition(false)
    red:setAnchorPoint(0.5, 0.5)
    red:setPosition(display.width / 2, display.height / 2)

    local green = cc.LayerColor:create(cc.c4b(100, 255, 100, 128))
    green:setContentSize(display.width / 4, display.height / 4)
    --green:ignoreAnchorPointForPosition(false)
    green:setAnchorPoint(1, 1)

    red:addChild(green)
    self:addChild(red)
    ]]

    --[[
       -- audio
       audio.loadFile("audio/mainMainMusic.ogg", function()
           -- body
           -- audio.playBGM("audio/mainMainMusic.ogg", true)
           audio.playEffect("audio/mainMainMusic.ogg", true)
           audio.setBGMVolume(0.5)
       end)
    --]]

    --[[
    --字体
    local ttflabel = display.newTTFLabel({
        text = "TTF LABEL, TTF 文本标签",
        font = "",
        size = 50,
        align = cc.TEXT_ALIGNMENT_CENTER,
        x = display.cx,
        y = display.cy + 100
    })
    self:addChild(ttflabel)
    -- BMFontLabel
    local bmflabel = display.newBMFontLabel({
        text = "BMFont LABEL",
        font = "helvetica-32.fnt",
    })
    bmflabel:setPosition(display.cx, display.cy + 100)
    self:addChild(bmflabel)
    -- display 创建TTF
    display.newTTFLabel({ text = "TTFLabel 文本标签", size = 50 }):align(display.CENTER, display.cx, display.cy):addTo(self)
    -- display 创建bmfont
    display.newBMFontLabel({ text = "TTFLabel BMFont",font="helvetica-32.fnt", size = 50 }):align(display.CENTER, display.cx, display.cy - 100):addTo(self)
    --]]

    -------------------- checkbox --------------------
    --[[
    local images = {
        off = "button/CheckBoxButtonOff.png",
        off_pressed = "button/CheckBoxButtonOffPressed.png",
        off_disabled = "button/CheckBoxButtonOffDisabled.png",
        on = "button/CheckBoxButtonOn.png",
        on_pressed = "button/CheckBoxButtonOnPressed.png",
        on_disabled = "button/CheckBoxButtonOnDisabled.png",
    }
    local checkbox = ccui.CheckBox:create()
    checkbox:setAnchorPoint(cc.p(0, 0))
    checkbox:setPosition(cc.p(display.width / 2, display.height / 2))
    checkbox:setSelected(false)
    checkbox:loadTextures("button/CheckBoxButtonOn.png",
        "button/CheckBoxButtonOnPressed.png",
        "button/CheckBoxButtonOff.png",
        "button/CheckBoxButtonOnDisabled.png", ccui.TextureResType.localType)
    checkbox:setEnabled(true)
    self:addChild(checkbox)
    local function tick(Ref, type)
        local state = ""
        if Ref == checkbox and type == ccui.CheckBoxEventType.selected then
            state = "on"
        elseif type == ccui.CheckBoxEventType.unselected then
            state = "off"
        end
        if not checkbox.enabled then
            state = state .. " (disabled)"
        end
    end
    checkbox:addEventListener(tick)
    --]]

    -------------------- 场景跳转按钮 --------------------
    --[[
    local startBtnImages = {
        normal = "#startBtn_N.png",
        pressed = "#startBtn_S.png",
    }
--    local switchBtn = ccui.Button:create(startBtnImages.normal, startBtnImages.pressed, startBtnImages.normal, 2)
    local switchBtn = ccui.Button:create()
    switchBtn:setTitleText("Switch to Second");
    switchBtn:setTitleColor(cc.c4b(255, 255, 255, 255));
    switchBtn:setTitleFontSize(48)
    switchBtn:setPosition(display.width / 2, display.height / 2)
    switchBtn:setPressedActionEnabled(true)

    switchBtn:addTouchEventListener(function(Ref, event)
        local secondScene = require("app.scenes.SecondScene").new()
        print("event\n")
        print(event)
        display.replaceScene(secondScene, "fade", 0.5, cc.c3b(255, 0, 0))
    end)
    self:addChild(switchBtn)
    --]]

    --[[
    -- 序列动画
    self.backgroundLayer = display.newColorLayer(cc.c4f(128, 128, 128, 255))
    self.backgroundLayer:addTo(self)
    -- preload frames to cache
    display.addSpriteFrames("stars.plist", "stars.ccz")
    local sprite = display.newSprite("#star01.png"):center():addTo(self.backgroundLayer)
    local frames = display.newFrames("star%02d.png", 1, 9)
    local animation = display.newAnimation(frames, 0.1)
    -- 添加到cache
    display.setAnimationCache("stars", animation)
    -- 从cache中取出
    animation = display.getAnimationCache("stars")
    -- 清除动画缓存
    display.removeAnimationCache("stars")

    local callback = cc.CallFunc:create(function() print("complete...") end)
    local animate = cc.Animate:create(animation)
    --    local action = cc.Sequence:create(cc.DelayTime:create(2), animate, callback)
    local action = cc.Sequence:create(animate, callback)
    -- 反复
    local rep = cc.RepeatForever:create(action)
    sprite:runAction(rep)
    --]]

    --------------- 全局帧调度器 ---------------
    --[[
    local function onInterval(dt)
        print("update")
    end
    scheduler.scheduleUpdateGlobal(onInterval)
    -- 全局自定义调度器
    local function onInterval(dt)
        print("Custom")
    end
    scheduler.scheduleGlobal(onInterval, 0.5)
    -- 全局延时调度器
    local function onInterval(dt)
        print("once")
    end
    scheduler.performWithDelayGlobal(onInterval, 0.5)
    --]]

    --[[
    --事件分发机制-节点事件
    local function createTestScene(name)
        local scene = display.newScene(name)
        scene:addNodeEventListener(cc.NODE_EVENT, function(event) printf("node in scene [%s] NODE_EVENT:%s",name,event.name)end)
        return scene
    end
    self:performWithDelay(function ()
        local scene1 = createTestScene("scene1")
        display.replaceScene(scene1)
        scene1:performWithDelay(function ()
            print("-----------")
            local scene2 = createTestScene("scene2")
            display.replaceScene(scene2)
        end, 1.0)
    end, 1.0)
    --]]

    --[[
    --触摸事件:多点触摸
    local node = display.newSprite("HelloWorld.png")
    self:addChild(node)
    node:setAnchorPoint(0.5, 0.5)
    node:setPosition(display.cx / 2, display.cy / 2)
    node:setTouchMode(cc.TOUCH_MODE_ALL_AT_ONCE)
    node:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        for id, point in pairs(event.points) do
            printf("event [%s] | id = %s | x = %0.2f | y = %0.2f", event.name, id, point.x, point.y)
        end
        if event.name == "began" then
            return true
        end
    end)
    -- 以下setTouchEnabled 要在 addNodeEventListener 执行后调用,要在否则会导致异常
    node:setTouchEnabled(true)
    --]]

    --[[
    -- 1.加载精灵帧
    display.addSpriteFrames("fruit.plist", "fruit.png")
    -- 2.背景图片
    display.newSprite("mainBG.png"):pos(display.cx, display.cy):addTo(self)
    local startBtnImages = {
        normal = "#startBtn_N.png",
        pressed = "#startBtn_S.png",
    }
    -- 3.开始按钮
    ccui.Button:create()
    :setTitleText("Start")
    :setTitleColor(cc.c4b(255, 255, 255, 255))
    :setTitleFontSize(48)
    :setPressedActionEnabled(true)
    :setScale9Enabled(false)
    :align(display.CENTER, display.cx, display.cy - 80)
    :addTo(self)
    :addTouchEventListener(function(Ref, event)
        audio.loadFile("music/btnStart.ogg", function()
            audio.playEffect("music/btnStart.ogg")
            audio.setBGMVolume(0.5)
        end)
        local playScene = import("app.scenes.PlayScene"):new()
        display.replaceScene(playScene, "turnOffTiles", 0.5)
    end)
    --]]

    --[[
    --启动http.exe开启接口127.0.0.1:1234/hello
    -- 网络通信
    local networkBtn = ccui.Button:create()
    networkBtn:setTitleText("网络通信");
    networkBtn:setTitleColor(cc.c4b(255, 255, 255, 255));
    networkBtn:setTitleFontSize(48)
    networkBtn:setPosition(display.width / 2, display.height / 2)
    networkBtn:setPressedActionEnabled(true)
    networkBtn:addTouchEventListener(function(Ref, event)
        local secondScene = require("app.scenes.NetworkScene").new()
        display.replaceScene(secondScene, "fade", 0.5, cc.c3b(255, 0, 0))
    end)
    self:addChild(networkBtn)
    --]]

    --[[
    -- simple tcp [socket]
    local btn = ccui.Button:create()
    btn:setTitleText("simple tcp通信");
    btn:setTitleColor(cc.c4b(255, 255, 255, 255));
    btn:setTitleFontSize(48)
    btn:setPosition(display.width / 2, display.height / 2)
    btn:setPressedActionEnabled(true)
    btn:addTouchEventListener(function(Ref, event)
        local simpleTCPScene = require("app.scenes.SimpleTCPScene").new()
        display.replaceScene(simpleTCPScene, "fade", 0.5, cc.c3b(255, 0, 0))
    end)
    self:addChild(btn)
    --]]

    --[[
    -- websocket
    local btn = ccui.Button:create()
    btn:setTitleText("websocket通信");
    btn:setTitleColor(cc.c4b(255, 255, 255, 255));
    btn:setTitleFontSize(48)
    btn:setPosition(display.width / 2, display.height / 2)
    btn:setPressedActionEnabled(true)
    btn:addTouchEventListener(function(Ref, event)
        local websocketScene = require("app.scenes.WebSocketScene").new()
        display.replaceScene(websocketScene, "fade", 0.5, cc.c3b(255, 0, 0))
    end)
    self:addChild(btn)
    --]]

    --[[
    -- websocket
    local btn = ccui.Button:create()
    btn:setTitleText("物理引擎");
    btn:setTitleColor(cc.c4b(255, 255, 255, 255));
    btn:setTitleFontSize(48)
    btn:center()
    btn:setPosition(display.width / 2, display.height / 2)
    btn:setPressedActionEnabled(true)
    btn:addTouchEventListener(function(Ref, event)
        local nextScene = require("app.scenes.PhysicsScene").new()
        display.replaceScene(nextScene, "fade", 0.5, cc.c3b(255, 0, 0))
    end)
    self:addChild(btn)
    --]]

    --[[
    --摄像机
    local btn = ccui.Button:create()
    btn:setTitleText("摄像机");
    btn:setTitleColor(cc.c4b(255, 255, 255, 255));
    btn:setTitleFontSize(48)
    btn:center()
    btn:setPosition(display.width / 2, display.height / 2)
    btn:setPressedActionEnabled(true)
    btn:addTouchEventListener(function(Ref, event)
        local nextScene = require("app.scenes.CameraScene").new()
        display.replaceScene(nextScene, "fade", 0.5, cc.c3b(255, 0, 0))
    end)
    self:addChild(btn)
    --]]

    --[[
    --富文本
        local RichTextEx = require("app.utils.RichTextEx")
        local clickDeal = function(id, content) print(id, content) end

        RichTextEx.new([==[
    <t c="#f00" s="50" id="click">Hello World!</t><br><i s="res/animal_panda.png" id="imageid"></i>
    ]==], clickDeal):addTo(self):center()
    --]]

    --[[
    --裁剪
    local rect = cc.rect(20, 20, 400, 400)
    local shape3 = display.newRect(rect, {
        borderColor = cc.c4f(0,1,0,1),
        borderWidth = 2
    })
    :addTo(self)
    local clipA = display.newClippingRectangleNode(rect)
    :addTo(self)
    local spB = display.newSprite("background.png")
    :addTo(clipA)
    :pos(150, 150)

    local spD = display.newSprite("2.png")
    :addTo(clipA)
    :pos(300, 380)
    local clipC = display.newClippingRectangleNode(cc.rect(200, 200, 300, 300))
    :addTo(spB)

    local btn = ccui.Button:create()
    :pos(display.right - 50, 50)
    :addTo(self)

    btn:setTitleText("snap")
    btn:setTitleFontSize(30)
    btn:setTitleColor(cc.c3b(255, 255, 0))
    btn:addTouchEventListener(function(sender, eventType)
        if 2 == eventType then
            local render_texture = cc.RenderTexture:create(display.width, display.height)
            render_texture:begin()
            self:visit()
            render_texture:endToLua()

            local photo_texture = render_texture:getSprite():getTexture()
            local sprite_photo = cc.Sprite:createWithTexture(photo_texture)
            sprite_photo:flipY(true)
            sprite_photo:scale(0.5)

            sprite_photo:addTo(self):center()
        end
    end)
    --]]

    -------------------- 控件 --------------------
    --[[
    --listview
    local lv = ccui.ListView:create()
    lv:setContentSize(cc.size(300, 200))
    lv:center():addTo(self)
    lv:setBackGroundColorType(1)
    lv:setBackGroundColor(cc.c3b(0, 100, 0))
    lv:setAnchorPoint(cc.p(0.5, 0.5))
    lv:setItemsMargin(4)
    -- convert to tablevlew
    local TableView = require("app.utils.TableView")
    local sizeSource = function(self, index)
        return cc.size(300, 15)
    end
    local loadSource = function(self, index)
        return ccui.Text:create(index, "Airal", 18)
    end
    local unloadSource = function(self, index)
        print("do texture unload here:", index)
    end
    TableView.attachTo(lv, sizeSource, loadSource, unloadSource)
    lv:initDefaultItems(300)
    lv:jumpTo(300)
    lv:addScrollViewEventListener(function(ref, type)
        print("event:", type)
    end)
    --]]

    --[[
    --瓦片地图+翻页
    local btn = ccui.Button:create()
    btn:setTitleText("瓦片地图");
    btn:setTitleColor(cc.c4b(255, 255, 255, 255));
    btn:setTitleFontSize(48)
    btn:center()
    btn:setPosition(display.width / 2, display.height / 2)
    btn:setPressedActionEnabled(true)
    btn:addTouchEventListener(function(sender, eventType)
        local nextScene = require("app.scenes.TileMapScene").new()
        display.replaceScene(nextScene, "fade", 0.5, cc.c3b(255, 0, 0))
    end)
    self:addChild(btn)
    --]]

    --[[
    -- 精灵批处理
    math.randomseed(1)
    display.addSpriteFrames("sprites.plist", "sprites.ccz")
    local batch = display.newBatchNode("sprites.ccz")
    batch:addTo(self)
    for i = 1, 100 do
        local sprite = display.newSprite("#star01.png")
        batch:addChild(sprite)
        sprite:setPosition(math.random(display.width), math.random(display.height))
    end
    --]]

    --[[
    --碰撞检测
    local btn = ccui.Button:create()
    btn:setTitleText("碰撞检测");
    btn:setTitleColor(cc.c4b(255, 255, 255, 255));
    btn:setTitleFontSize(48)
    btn:center()
    btn:setPosition(display.width / 2, display.height / 2)
    btn:setPressedActionEnabled(true)
    btn:addTouchEventListener(function(sender, eventType)
        local nextScene = require("app.scenes.CollisionDetectScene").new()
        display.replaceScene(nextScene, "fade", 0.5, cc.c3b(255, 0, 0))
    end)
    self:addChild(btn)
    --]]

    --[[
    --Lua内存管理
    local btn = ccui.Button:create()
    btn:setTitleText("Lua内存管理");
    btn:setTitleColor(cc.c4b(255, 255, 255, 255));
    btn:setTitleFontSize(48)
    btn:center()
    btn:setPosition(display.width / 2, display.height / 2)
    btn:setPressedActionEnabled(true)
    btn:addTouchEventListener(function(sender, eventType)
        local nextScene = require("app.scenes.CollectGarbageScene").new()
        display.replaceScene(nextScene, "fade", 0.5, cc.c3b(255, 0, 0))
    end)
    self:addChild(btn)
    --]]

    --[[
    --粒子系统
    local btn = ccui.Button:create()
    btn:setTitleText("粒子系统");
    btn:setTitleColor(cc.c4b(255, 255, 255, 255));
    btn:setTitleFontSize(48)
    btn:center()
    btn:setPosition(display.width / 2, display.height / 2)
    btn:setPressedActionEnabled(true)
    btn:addTouchEventListener(function(sender, eventType)
        if eventType == 0 then
            local nextScene = require("app.scenes.ParticlesScene").new()
            display.replaceScene(nextScene, "turnOffTiles", 0.5, cc.c3b(255, 0, 0))
        end
    end)
    self:addChild(btn)
    --]]

    ----[[
    --纹理渲染
    local btn = ccui.Button:create()
    btn:setTitleText("纹理渲染");
    btn:setTitleColor(cc.c4b(255, 255, 255, 255));
    btn:setTitleFontSize(48)
    btn:center()
    btn:setPosition(display.width / 2, display.height / 2)
    btn:setPressedActionEnabled(true)
    btn:addTouchEventListener(function(sender, eventType)
        if eventType == 0 then
            local nextScene = require("app.scenes.RenderTextureScene").new()
            display.replaceScene(nextScene, "turnOffTiles", 0.5, cc.c3b(255, 0, 0))
        end
    end)
    self:addChild(btn)
    --]]

    --[[
    --骨骼动画
    local btn = ccui.Button:create()
    btn:setTitleText("骨骼动画");
    btn:setTitleColor(cc.c4b(255, 255, 255, 255));
    btn:setTitleFontSize(48)
    btn:center()
    btn:setPosition(display.width / 2, display.height / 2)
    btn:setPressedActionEnabled(true)
    btn:addTouchEventListener(function(sender, eventType)
        if eventType == 0 then
            local nextScene = require("app.scenes.SpineScene").new()
            display.replaceScene(nextScene, "turnOffTiles", 0.5, cc.c3b(255, 0, 0))
        end
    end)
    self:addChild(btn)
    --]]

end

function MainScene:printAll(...)
    for k, v in ipairs({ ... }) do
        print(v .. '\n')
    end
end

function MainScene:onEnter()
    --在构造函数里面写没有转换场景的效果
    --[[
    --动作场景
    local actionScene = require("app.scenes.ActionScene").new()
    display.replaceScene(actionScene, "fade", 0.5, cc.c3b(255, 0, 0))
    --]]
    --[[
    cc.Device:setAccelerometerEnabled(true)
    local function accelerometerListener(event, x, y, z, timestamp)
        print(event)
        print("TestAccelerateEvent" .. x .. y .. z .. timestamp)
    end
    local listener = cc.EventListenerAcceleration:create(accelerometerListener)
    self:getEventDispatcher():addEventListenerWithSceneGraphPriority(listener, self)
    --]]
end

function MainScene:onExit()
end

return MainScene

