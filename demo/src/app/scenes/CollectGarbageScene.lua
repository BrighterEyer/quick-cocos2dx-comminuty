local CollectGarbageScene = class("CollectGarbageScene", function()
	return display.newScene("CollectGarbageScene")
end)

function CollectGarbageScene:ctor()
	print(collectgarbage("count"))
	local test = {}
	for i=1,10000 do
		test[i] = {}
	end
	print(collectgarbage("count"))
	collectgarbage("collect")
	print(collectgarbage("count"))
end

function CollectGarbageScene:onEnter()
end

function CollectGarbageScene:onExit()
end

return CollectGarbageScene
