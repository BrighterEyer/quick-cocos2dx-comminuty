local CameraScene = class("CameraScene", function()
	return display.newScene("CameraScene")
end)


function CameraScene:ctor()
	-- 新建层
	local layer = display.newLayer()
	layer:addTo(self)

	-- 添加背景图片到层
	display.newSprite("background.png")
		:pos(display.cx, display.cy)
		:addTo(layer)

	-- 添加主角到层
	local startY = 100
	local player = display.newSprite("player.png")
		:pos(display.cx, startY)
		:addTo(layer)
	player:runAction(cc.MoveTo:create(4, cc.p(display.cx, 800)))

	local camera = cc.Camera:createOrthographic(display.width, display.height, 0, 1)
	camera:setCameraFlag(cc.CameraFlag.USER1)
	layer:addChild(camera)

	-- 默认会递归设置所有子结点，如果子结点在这行代码之后加入，子结点需要自行设置照相机掩码
	layer:setCameraMask(2)

	-- 启用帧事件
	self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT, function(dt)
		camera:setPositionY(player:getPositionY() - startY)
	end)
	self:scheduleUpdate()
end

function CameraScene:onEnter()
end

function CameraScene:onExit()
end

return CameraScene
