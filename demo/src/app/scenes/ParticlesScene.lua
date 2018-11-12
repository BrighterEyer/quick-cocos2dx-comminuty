local ParticlesScene = class("ParticlesScene", function()
	return display.newScene("ParticlesScene")
end)

function ParticlesScene:ctor()
	self:method3()
end

function ParticlesScene:method1()
	-- 创建粒子系统对象，并初始化粒子个数
	local _emitter = cc.ParticleSystemQuad:createWithTotalParticles(50)
	--设置粒子贴图
	local texture = cc.Director:getInstance():getTextureCache():addImage("stars.png")
	_emitter:setTexture(texture)

	-- 添加到场景
	self:addChild(_emitter, 10)

	-- 粒子生命周期
	_emitter:setDuration(cc.PARTICLE_DURATION_INFINITY)

	-- 半径模式
	_emitter:setEmitterMode(cc.PARTICLE_MODE_RADIUS)

	-- 半径模式: 半径大小
	_emitter:setStartRadius(40)
	_emitter:setStartRadiusVar(1)
	_emitter:setEndRadius(cc.PARTICLE_START_RADIUS_EQUAL_TO_END_RADIUS)
	_emitter:setEndRadiusVar(0)

	-- 半径模式: 旋转速率
	_emitter:setRotatePerSecond(100)
	_emitter:setRotatePerSecondVar(0)

	-- 角度
	_emitter:setAngle(90)
	_emitter:setAngleVar(360)

	-- 发射器位置
	local size = display.size
	_emitter:setPosVar(cc.p(0,0))

	-- 生命
	_emitter:setLife(0.5)
	_emitter:setLifeVar(0)

	-- 粒子旋转
	_emitter:setStartSpin(0)
	_emitter:setStartSpinVar(0)
	_emitter:setEndSpin(0)
	_emitter:setEndSpinVar(0)

	-- 粒子颜色
	_emitter:setStartColor(cc.c4f(0.0, 0.8, 0.9, 1.0))
	_emitter:setStartColorVar(cc.c4f(0.0, 0, 0, 1.0))
	_emitter:setEndColor(cc.c4f(1.0, 1.0, 1.0, 0.1))
	_emitter:setEndColorVar(cc.c4f(0, 0, 0, 0.1))

	-- 大小
	_emitter:setStartSize(20)
	_emitter:setStartSizeVar(1)
	_emitter:setEndSize(0)

	-- 粒子出现速率
	_emitter:setEmissionRate(_emitter:getTotalParticles() / _emitter:getLife())

	print(_emitter:getTotalParticles() / _emitter:getLife())
	print(_emitter:getLife())

	-- 颜色混合
	_emitter:setBlendAdditive(false)

	-- 设置位置
	_emitter:setPosition(display.cx,display.cy)
end

function ParticlesScene:method2()
	-- 创建粒子系统对象
	_emitter = cc.ParticleSun:create();
	self:addChild(_emitter, 10);

	-- 设置粒子贴图
	local sprite = display.newSprite("stars.png")
	_emitter:setTexture(sprite:getTexture());

	-- 设置位置
	_emitter:setPosition(display.cx,display.cy)
end

function ParticlesScene:method3()
	-- 读入plist文件
	local _emitter = cc.ParticleSystemQuad:create("stars.plist")
	_emitter:setPosition(display.cx,display.cy)
	-- 获得粒子节点列表
	local batch = cc.ParticleBatchNode:createWithTexture(_emitter:getTexture())
	batch:addChild(_emitter)
	self:addChild(batch, 10)
end

function ParticlesScene:onEnter()
end

function ParticlesScene:onExit()
end

return ParticlesScene
