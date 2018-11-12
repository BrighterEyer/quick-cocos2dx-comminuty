local SpineScene = class("SpineScene", function()
    return display.newScene("SpineScene")
end)

function SpineScene:ctor()

	-- Spine 基本用法
	-- http://www.cocos2d-lua.org/doc/spine/basic/index.md

	cachedData = sp.SkeletonData:create("HERO1.json", "HERO1.atlas")
	local spineAnimation = sp.SkeletonAnimation:createWithData(cachedData)
	    :pos(display.width / 2, display.height / 2)
		:addTo(self)
		:setAnimation(0, "attack_1", true)

    -- 可用于游戏角色消灭
	self:performWithDelay(function()
		spineAnimation:removeFromParent()
		cachedData = nil
		collectgarbage("collect")
	end, 5)
end

function SpineScene:onEnter()
end

function SpineScene:onExit()
end

return SpineScene
