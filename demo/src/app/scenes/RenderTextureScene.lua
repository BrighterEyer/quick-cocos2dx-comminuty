local RenderTextureScene = class("RenderTextureScene", function()
    return display.newScene("RenderTextureScene")
end)

function RenderTextureScene:ctor()
    -- background
    display.newSprite("HelloWorld.png"):addTo(self):center()
    -- render buffer
    self.fbo = cc.RenderTexture:create(display.width, display.height):center():addTo(self)
    self.fbo:clear(0, 0, 0, 0.5) -- init with blackColor

    -- eraser NOT add to self
    self.eraser = display.newSolidCircle(20,{color = cc.c4f(1, 1, 1, 0)})
    self.eraser:retain()
    self.eraser:setBlendFunc(gl.ONE, gl.ZERO)
    self:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            return true
        end
        if event.name == "moved" then
            self.eraser:pos(event.x, event.y)
            self.fbo:begin()
            self.eraser:visit()
            self.fbo:endToLua()
        end
    end)
    self:setTouchEnabled(true)
end

function RenderTextureScene:onEnter()
end

function RenderTextureScene:onExit()
end

return RenderTextureScene
