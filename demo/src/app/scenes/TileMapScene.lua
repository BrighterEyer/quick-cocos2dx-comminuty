local TileMapScene = class("TileMapScene", function()
    return display.newScene("TileMapScene")
end)

function TileMapScene:ctor()
    self:addPageView()
end

function TileMapScene:createPageLayoutWithTile(tilemap)
    --- 创建layout，内容添加到layout
    local layout = ccui.Layout:create():setContentSize(700, 700):setPosition(0, 0)
    local map = cc.TMXTiledMap:create(tilemap):addTo(layout)
    local bgLayer = map:getLayer("background")
    local tile = bgLayer:getTileAt(cc.p(1, 2)) --获取指定位置瓦片
    bgLayer:removeChild(tile, true) --移除瓦片
    local coinArray = map:getObjectGroup("coin"):getObjects()
    for _, value in pairs(coinArray) do
        local coinSprite = display.newSprite("tilemap/coin.png")
        coinSprite:pos(value.x, value.y)
        coinSprite:addTo(layout)
    end
    return layout
end

function TileMapScene:addPageView()
    local layer = display.newColorLayer(cc.c4b(255, 255, 255, 255))
    self.layer = layer
    self:addChild(self.layer)

    local function touchListener(event) -- touch event listener
    dump(event, "Test PageViewScene - event:")
    end

    self.pv = ccui.PageView:create()
    local page = self.pv
    for i = 1, 8 do
        --- 创建layout，内容添加到layout
        local layout = self:createPageLayoutWithTile("tilemap/map0"..(i % 2)..".tmx")
        page:addPage(layout) --- 一个layout 为一个 page内容
    end
    layer:addChild(page)
    page:setContentSize(700, 700)
    page:setTouchEnabled(true)
    page:setAnchorPoint(cc.p(0.5, 0.5))
    page:setPosition( display.width / 2, display.height / 2)
    --注册事件
    page:addEventListener(function(sender, event)
        if event == ccui.PageViewEventType.turning then
            self:setName(page:getCurPageIndex())
        end
    end)
end

function TileMapScene:onEnter()
end

function TileMapScene:onExit()
end

return TileMapScene
