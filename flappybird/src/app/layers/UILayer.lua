local UILayer = class("UILayer", function()
	return display.newLayer()
end)

function UILayer:ctor()
    self.logo=display.newSprite(bird_logo)
    :align(display.CENTER,display.cx,display.cy*1.5)
    :addTo(self,1)

    local move1 = cc.MoveBy:create(1, cc.p(0, 10))
    local move2 = cc.MoveBy:create(1, cc.p(0, -10))
    local sequenceAcion = cc.Sequence:create(move1,move2)
--    transition.execute(self.logo,cc.RepeatForever:create(sequenceAcion))
    self.logo:runAction(cc.RepeatForever:create(sequenceAcion))

    self.logo_over = display.newSprite(bird_gameover)
    :align(display.CENTER,display.cx,display.cy+100)
    :hide()
    :addTo(self,1)

    self.btn_start = ccui.Button:create(bird_start_btn,bird_start_btn_pressed,bird_start_btn,0)
    :pos(display.cx,display.cy)
    :addTo(self,1)

    self.lbl_score = display.newBMFontLabel({text="0",size=24,font="fonts/futura-48.fnt"})
    :align(display.RIGHT_TOP, display.right-5, display.top-5)
    :setVisible(false)
    :addTo(self,1)

    self:setTouchEnabled(false)

    self:addNodeEventListener(cc.NODE_ENTER_FRAME_EVENT,function(dt) self:onEnterFrame(dt) end)
    self:scheduleUpdate()

    self.GAME_STATUS = GAME_STATUS_START

end

function UILayer:gameStart()
    self.score = 0
    self.lbl_score:setString(string.format("%d", self.score))
    :show()
	self.logo:hide()
	self.btn_start:hide()
	self.lbl_score:show()

end

function UILayer:onEnterFrame(dt)

end

function UILayer:gameOver()
    self.logo_over:show()
end

function UILayer:addScore()
    self.score=self.score+1
    self.lbl_score:setString(string.format("%d", self.score))
end

function UILayer:restart()
    self.score = 0
    self.lbl_score:hide()
    self.logo_over:hide()
    self.logo:show()
    self.btn_start:show()
end

return UILayer
