local Background = require("app.layers.BgLayer")
local UILayer = require("app.layers.UILayer")

local MainScene = class("MainScene", function()
    return display.newPhysicsScene("MainScene")
end)

function MainScene:ctor()

    audio.loadFile(music_bg,function() print("music_bg loaded!") end)
    audio.loadFile(music_jump,function() print("music_jump loaded!") end)
    audio.loadFile(music_over,function() print("music_over loaded!") end)

    self.GAME_STATUS = ""

    self.world = self:getPhysicsWorld()
    self.world:setGravity(cc.p(0, -98.0))
    --self.world:setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)

    self.BgLayer = Background:new():addTo(self, -1)

    self.uiLayer = UILayer:new():addTo(self, 10)

    self.uiLayer.btn_start:addTouchEventListener(function(sender,eventType)
        self:gameStart()
    end)
    self:addCollision()
    self.GAME_STATUS = GAME_STATUS_START
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

function MainScene:gameStart()
    self.GAME_STATUS = GAME_STATUS_PLAYING
    self.uiLayer:gameStart()
    self.BgLayer:gameStart(function() self.uiLayer:addScore() end)
    audio.playEffect(music_bg, true)
end

function MainScene:onEnterFrame(dt)
end

function MainScene:addCollision()
    local function contactLogic(node)
        if node:getTag() == TAG_OBSTACLE and self.GAME_STATUS == GAME_STATUS_PLAYING then
            self.GAME_STATUS = GAME_STATUS_GAME_OVER
--            audio.stopMusic(false)
            audio.playEffect(music_over, false)
            self.uiLayer:gameOver()
            self.BgLayer:gameOver()
            self:performWithDelay(function() self:restart() end, 3)
        end
    end

    local function onContactBegin(contact)
        local a = contact:getShapeA():getBody():getNode()
        local b = contact:getShapeB():getBody():getNode()
        contactLogic(a)
        contactLogic(b)
        return true
    end

    local contactListener = cc.EventListenerPhysicsContact:create()
    contactListener:registerScriptHandler(onContactBegin, cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)
    local eventDipatcher = cc.Director:getInstance():getEventDispatcher()
    eventDipatcher:addEventListenerWithFixedPriority(contactListener, 1)
end

function MainScene:restart()
    self.GAME_STATUS = GAME_STATUS_START
    self.BgLayer:restart()
    self.uiLayer:restart()
end

return MainScene
