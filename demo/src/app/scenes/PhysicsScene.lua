--
-- Created by IntelliJ IDEA.
-- User: Administrator
-- Date: 2018/11/12
-- Time: 9:01
-- To change this template use File | Settings | File Templates.
--
local PhysicsScene = class("PhysicsScene", function()
    return display.newPhysicsScene("PhysicsScene")
end)

function PhysicsScene:ctor()
    self:getPhysicsWorld():setGravity(cc.p(0, -100))

    local size = display.size
    local body = cc.PhysicsBody:createEdgeBox(size, cc.PHYSICSBODY_MATERIAL_DEFAULT, 3)

    local edgeNode = display.newNode()
    edgeNode:setPosition(size.width / 2, size.height / 2)
    edgeNode:setPhysicsBody(body)
    self:addChild(edgeNode)

    -- 监听碰撞检测
    local function onContactBegin(contact)
        local tag = contact:getShapeA():getBody():getNode():getTag()
        print(tag)
        return true
    end

    local contactListener = cc.EventListenerPhysicsContact:create()
    contactListener:registerScriptHandler(onContactBegin, cc.Handler.EVENT_PHYSICS_CONTACT_BEGIN)
    local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
    eventDispatcher:addEventListenerWithFixedPriority(contactListener, 1)

    -- Open Physics Debug
    self:getPhysicsWorld():setDebugDrawMask(cc.PhysicsWorld.DEBUGDRAW_ALL)

    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            self:addSprite(event.x, event.y)
            return true
        end
    end)
    self:setTouchEnabled(true)
end

function PhysicsScene:addSprite(x, y)
    -- add physics sprite to scene
    local oneSprite = display.newSprite("1.png")
    -- 物理身体封装sprite
    local oneBody = cc.PhysicsBody:createBox(oneSprite:getContentSize(), cc.PHYSICSBODY_MATERIAL_DEFAULT, cc.p(0, 0))
    oneBody:setContactTestBitmask(0xFFFFFFFF)
    oneBody:applyImpulse(cc.p(0, 100000))
    oneSprite:setPhysicsBody(oneBody)
    oneSprite:setPosition(x, y)
    oneSprite:setTag(101)
    self:addChild(oneSprite)
end

function PhysicsScene:onEnter()
end

function PhysicsScene:onExit()
end

return PhysicsScene
