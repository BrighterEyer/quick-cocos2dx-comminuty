local FiniteStateMachineScene = class("FiniteStateMachineScene", function()
	return display.newScene("FiniteStateMachineScene")
end)

function FiniteStateMachineScene:ctor()
	cc(self):addComponent("components.behavior.StateMachine"):exportMethods()

	self:setupState({
		initial = "Stranger",
		events = {
            {name = "Fallinlove", from = "Stranger", to = "Lover" },
            {name = "Part", from = {"Lover", "Spouse"}, to = "Stranger"},
            {name = "Marry", from = {"Lover", "Stranger"}, to = "Spouse"}
        },

		callbacks = {
			-- event
			onbeforeFallinlove = function(event) print("Before Fallinlove: " .. event.from .. " to " .. event.to) end,
			onafterFallinlove = function(event) print("After Fallinlove: " .. event.from .. " to " .. event.to) end,
			onbeforePart = function(event) print("Before Part: " .. event.from .. " to " .. event.to) end,
			onafterPart = function(event) print("After Part: " .. event.from .. " to " .. event.to) end,
			onbeforeMarry = function(event) print("Before Marry: " .. event.from .. " to " .. event.to) end,
			onafterMarry = function(event) print("After Marry: " .. event.from .. " to " .. event.to) end,
			-- status
			onenterStranger = function(event) print("Enter Stranger: " .. event.from .. " to " .. event.to) end,
			onleaveStranger = function(event) print("Leave Stranger: " .. event.from .. " to " .. event.to) end,
			onenterLover = function(event) print("Enter Lover: " .. event.from .. " to " .. event.to) end,
			onleaveLover = function(event) print("Leave Lover: " .. event.from .. " to " .. event.to) end,
			onenterSpouse = function(event) print("Enter Spouse: " .. event.from .. " to " .. event.to) end,
			onleaveSpouse = function(event)
				print("Leave Spouse: " .. event.from .. " to " .. event.to)
				-- A state change takes time
				self:performWithDelay(function()
					print("==Just Finish")
					event.transition()
				end, 3)
				return "async"
			end,
			-- status change
			onchangestate = function(event) print("CHANGED STATE: " .. event.from .. " to " .. event.to) end
		},
	})

	ccui.Button:create()
	:setTitleText("Fallinlove")
	:setTitleFontSize(32)
	:setTitleColor(display.COLOR_WHITE)
	:center()
	:setPosition(display.cx, display.cy + 100)
	:setPressedActionEnabled(true)
	:addTo(self)
	:addTouchEventListener(function(Ref, event)
		if self:canDoEvent("Fallinlove") then
			self:doEvent("Fallinlove")
		else
			print("Can't do Fallinlove, in Status:%s", self:getState())
		end
	end)

	ccui.Button:create()
	:setTitleText("Part")
	:setTitleFontSize(32)
	:setTitleColor(display.COLOR_WHITE)
	:center()
	:setPosition(display.cx, display.cy)
	:setPressedActionEnabled(true)
	:addTo(self)
	:addTouchEventListener(function(Ref, event)
		if self:canDoEvent("Part") then
			self:doEvent("Part")
		else
			print("Can't do Part, in Status:%s", self:getState())
		end
	end)

	ccui.Button:create()
	:setTitleText("Marry")
	:setTitleFontSize(32)
	:setTitleColor(display.COLOR_WHITE)
	:center()
	:setPosition(display.cx, display.cy - 100)
	:setPressedActionEnabled(true)
	:addTo(self)
	:addTouchEventListener(function(Ref, event)
		if self:canDoEvent("Marry") then
			self:doEvent("Marry")
		else
			print("Can't do Marry, in Status:%s", self:getState())
		end
	end)

end

function FiniteStateMachineScene:onEnter()
end

function FiniteStateMachineScene:onExit()
end

return FiniteStateMachineScene
