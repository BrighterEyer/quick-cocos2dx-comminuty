local WebSocketScene = class("WebSocketScene", function()
    return display.newScene("WebSocketScene")
end)

function WebSocketScene:ctor()
    --  self.socket = cc.WebSocket:create("wss://127.0.0.1:1234")
    --	self.socket = cc.WebSocket:create("127.0.0.1:1234")

    if self.socket then
        self.socket:registerScriptHandler(handler(self, self.onOpen_), cc.WEBSOCKET_OPEN)
        self.socket:registerScriptHandler(handler(self, self.onMessage_), cc.WEBSOCKET_MESSAGE)
        self.socket:registerScriptHandler(handler(self, self.onClose_), cc.WEBSOCKET_CLOSE)
        self.socket:registerScriptHandler(handler(self, self.onError_), cc.WEBSOCKET_ERROR)
    end
end

function WebSocketScene:onOpen_()
    print("onOpen")
    self.socket:sendString("Hello server, i'm Quick websocket")
    -- delay to close
    self:performWithDelay(function() self.socket:close() end, 1.0)
end

function WebSocketScene:onMessage_(message)
    print("onMessage:" .. message)
end

function WebSocketScene:onClose_()
    print("onClose")
    self.socket = nil
end

function WebSocketScene:onError_(error)
    print("onError:" .. error)
end

function WebSocketScene:onEnter()
end

function WebSocketScene:onExit()
end

return WebSocketScene
