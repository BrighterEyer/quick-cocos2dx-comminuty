local Obstacle = class("Obstacle",function ()
	return display.newNode()
end)

function Obstacle:ctor()
    self.scale=display.height/2/display.newSprite(bird_obstacle_up):getContentSize().height
end

function Obstacle:addScore(func)
	local delay2 = cc.DelayTime:create(1.25)
    local callback2 = cc.CallFunc:create(func)
    local sequence2 = cc.Sequence:create(delay2,callback2)
	self:runAction(cc.RepeatForever:create(sequence2))
end

function Obstacle:addObstacle()
	local delay = cc.DelayTime:create(1)
    local callback = cc.CallFunc:create(function() self:addOne(0) end)
    local sequence = cc.Sequence:create(callback,delay)
	self:runAction(cc.RepeatForever:create(sequence))
end

function Obstacle:addOne(offsetX)
	local sprite = display.newSprite(bird_obstacle_up)
	:scale(self.scale)
	:addTo(self,1,TAG_OBSTACLE)
	local spriteSize = sprite:getContentSize()
	local body = cc.PhysicsBody:createBox(self:scaled(spriteSize),cc.PHYSICSBODY_MATERIAL_DEFAULT,{0,0})
	:setGravityEnable(false)
	:setDynamic(false)
	:setCategoryBitmask(CategoryBitmask_obstacle)
	:setContactTestBitmask(ContactTestBitmask_obstacle)
	:setCollisionBitmask(CollisionBitmask_obstacle)
	sprite:setPhysicsBody(body)

	local sprite2 = display.newSprite(bird_obstacle_down)
	:scale(self.scale)
	:addTo(self,1,TAG_OBSTACLE)
	local spriteSize2 = sprite2:getContentSize()
	local body2 = cc.PhysicsBody:createBox(self:scaled(spriteSize2),cc.PHYSICSBODY_MATERIAL_DEFAULT,{0,0})
	:setGravityEnable(false)
	:setDynamic(false)
	:setCategoryBitmask(CategoryBitmask_obstacle)
	:setContactTestBitmask(ContactTestBitmask_obstacle)
	:setCollisionBitmask(CollisionBitmask_obstacle)
	sprite2:setPhysicsBody(body2)

	local offset_max1 = self:scaled(spriteSize).height/2
	local offset_max2 = self:scaled(spriteSize2).height/2
	local y1 = math.random(0,1)*offset_max1+display.height-self:scaled(spriteSize).height/2
	local y2 = math.random(0,1)*offset_max2

	if y1-y2-display.height/2<self:scaled(spriteSize).width*2 then
		y2=y1-self:scaled(spriteSize).width*2-display.height/2
	end
	sprite:pos(display.width+self:scaled(spriteSize).width/2+offsetX, y1)
	sprite2:pos(display.width+self:scaled(spriteSize2).width/2+offsetX, y2)

	local move =cc.MoveBy:create(2.5,cc.p(-display.width-self:scaled(spriteSize).width, 0))
	local callback = cc.CallFunc:create(function() self:removeChild(sprite) end)
	local sequence = cc.Sequence:create(move,callback)
	sprite:runAction(cc.RepeatForever:create(sequence))

	local move2 =cc.MoveBy:create(2.5,cc.p(-display.width-self:scaled(spriteSize2).width, 0))
	local callback2 = cc.CallFunc:create(function() self:removeChild(sprite2) end)
	local sequence2 = cc.Sequence:create(move2,callback2)
	sprite2:runAction(cc.RepeatForever:create(sequence2))
end

function  Obstacle:scaled(origin)
	return cc.size(origin.width*self.scale, origin.height*self.scale)
end

function Obstacle:gameOver()
	self:stopAllActions()
	self:removeAllChildren()
end

return Obstacle