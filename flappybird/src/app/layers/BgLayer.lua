local Player = require("app.objects.Bird")
local Obstacle = require("app.objects.Obstacle")

local BgLayer = class("BgLayer", function() 
	return display.newLayer() 
end)

function BgLayer:ctor()

 	local bg = display.newSprite(bird_bg)
    bg:align(display.CENTER, display.cx, display.cy)
    :setScale(display.width/bg:getContentSize().width,display.height/bg:getContentSize().height)
    :addTo(self,-1)

 	self.player = Player.new()
    self.player:align(display.CENTER, display.cx, display.cy)
    :hide()
    :addTo(self,1,TAG_HERO)
	
    local bodyTop = cc.PhysicsBody:createEdgeSegment(cc.p(0,display.top),cc.p(display.right,display.top))
    local sky = display.newNode()
    :setPhysicsBody(bodyTop)
    :addTo(self)

    local bodyBottom = cc.PhysicsBody:createEdgeSegment(cc.p(display.left,display.bottom),cc.p(display.right,display.bottom))
    local ground = display.newNode()
    :setPhysicsBody(bodyBottom)
    :addTo(self)
	
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT,function (event)
        return self:onTouch(event.name,event.x,event.y)
    end)
    self.obstacle = Obstacle:new()
    :addTo(self)

    -- self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT,function(dt) self:onEnterFrame(dt) end)
    -- self:scheduleUpdate()

end

function BgLayer:gameStart(func)
    self.player:pos(display.cx, display.cy)
	:show()
	:getPhysicsBody():setGravityEnable(true)
	self:setTouchEnabled(true)
    self.obstacle:addObstacle()
    self.obstacle:addScore(func)
end

function BgLayer:onEnterFrame(dt)
	
end

function BgLayer:onTouch(event,x,y)
	if event == "began" then
        self.player:getPhysicsBody():setVelocity(cc.p(0, 98))
        audio.playEffect(music_jump,false)
        return true
    end
end

function BgLayer:gameOver()
    self.player:hide()
    :getPhysicsBody():setGravityEnable(false)
    self.obstacle:gameOver()
    self:setTouchEnabled(false)
end

function BgLayer:restart()
    
end

return BgLayer
