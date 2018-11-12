local CollisionDetectScene = class("CollisionDetectScene", function()
    return display.newScene("CollisionDetectScene")
end)

function CollisionDetectScene:ctor()
    local enemy = display.newSprite("enemy.png")
        :pos(display.cx, display.cy)
        :addTo(self)

    local player = display.newSprite("player.png")
        -- :pos(display.cx, display.bottom)
        :pos(0, display.cy)
        :addTo(self)
    -- player:runAction(cc.MoveTo:create(6, cc.p(display.cx, display.top)))
    player:runAction(cc.MoveTo:create(6, cc.p(display.width, display.cy)))

    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, function()
        -- AABB
        local rectA = player:getBoundingBox()
        local rectB = enemy:getBoundingBox()
        if (math.abs(player:getPositionX() - enemy:getPositionX()) * 2 <= (rectA.width + rectB.width))
            and (math.abs(player:getPositionY() - enemy:getPositionY()) * 2 <= (rectA.height + rectB.height)) then
            -- 碰撞、闪烁
            if nil == player:getActionByTag(10) then
                local blink = cc.Blink:create(0.05, 1)
                blink:setTag(10)
                player:runAction(blink)
            end
        else
            if player:getActionByTag(10) then
                player:stopActionByTag(10)
                player:setVisible(true)
            end
        end
    end)
    self:scheduleUpdate()
end

function CollisionDetectScene:onEnter()
end

function CollisionDetectScene:onExit()
end

return CollisionDetectScene
