local Bird = class("Bird",function ()
	return display.newSprite(bird_hero1)
end)

function Bird:ctor()
	self.scale=display.height/2/display.newSprite(bird_obstacle_up):getContentSize().height

	self.scale=display.width*0.1/self:getContentSize().width
	self:setScale(self.scale)
--	local body = cc.PhysicsBody:createBox(cc.sMul(self:getContentSize(),self.scale),cc.PHYSICSBODY_MATERIAL_NULL,cc.p(0,0))
	local body = cc.PhysicsBody:createBox(self:scaled(self:getContentSize()), cc.PHYSICSBODY_MATERIAL_DEFAULT, cc.p(0, 0))
	:setGravityEnable(false)
	:setRotationEnable(false)
	:setCategoryBitmask(CategoryBitmask_player)
	:setContactTestBitmask(ContactTestBitmask_player)
	:setCollisionBitmask(CollisionBitmask_player)
	self:setPhysicsBody(body)

	local frames = display.newFrames("bird_hero%01d.png", 1, 3)
    local animation = display.newAnimation(frames, 0.4 / 3)
--	transition.playAnimationForever(self,animation)
	local animate = cc.Animate:create(animation)
	local seq = cc.Sequence:create(animate)
	local rep = cc.RepeatForever:create(seq)
	self:runAction(rep)
end

function  Bird:scaled(origin)
	return cc.size(origin.width*self.scale, origin.height*self.scale)
end

return Bird