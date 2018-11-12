local FruitItem = class("FruitItem", function(x, y, fruitIndex)
	fruitIndex = fruitIndex or math.round(math.random() * 1000) % 8 + 1
	local sprite = display.newSprite("#fruit"  .. fruitIndex .. '_1.png')
	sprite.fruitIndex = fruitIndex
	sprite.x = x
	sprite.y = y
	sprite.isActive = false
	return sprite
end)

function FruitItem:ctor()
end

function FruitItem:setActive(active)
    self.isActive = active

    local frame
    if (active) then
        frame = display.newSpriteFrame("fruit"  .. self.fruitIndex .. '_2.png')
    else
        frame = display.newSpriteFrame("fruit"  .. self.fruitIndex .. '_1.png')
    end

    self:setSpriteFrame(frame)

    if (active) then
        self:stopAllActions()
        local scaleTo1 = cc.ScaleTo:create(0.1, 1.1)
        local scaleTo2 = cc.ScaleTo:create(0.05, 1.0)
        self:runAction(cc.Sequence:create(scaleTo1, scaleTo2))
    end
end

function FruitItem.getWidth()
    g_fruitWidth = 0
    if (0 == g_fruitWidth) then
        local sprite = display.newSprite("#fruit1_1.png")
        g_fruitWidth = sprite:getContentSize().width
    end
    return g_fruitWidth
end

return FruitItem
