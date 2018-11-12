local NetworkScene = class("NetworkScene", function()
    return display.newScene("NetworkScene")
end)

function NetworkScene:ctor()
    display.newTTFLabel({
        text = "this's NetworkScene",
        size = 64,
        align = cc.TEXT_ALIGNMENT_CENTER,
        x = display.cx,
        y = display.cy + 100
    }):addTo(self)

    print("WiFi status:" .. tostring(network.isLocalWiFiAvailable()))
    print("3G status:" .. tostring(network.isInternetConnectionAvailable()))
    print("HomeName:" .. tostring(network.isHostNameReachable("cn.cocos2d-x.org")))

    local netStatus = network.getInternetConnectionStatus()
    if netStatus == cc.kCCNetworkStatusNotReachable then
        print("kCCNetworkStatusNotReachable")
    elseif netStatus == cc.kCCNetworkStatusReachableViaWiFi then
        print("kCCNetworkStatusReachableViaWiFi")
    elseif netStatus == cc.kCCNetworkStatusReachableViaWAN then
        print("kCCNetworkStatusReachableViaWAN")
    else
        print("Error")
    end

    -- http request
    local function onRequestCallback(event)
        local request = event.request
        dump(event)
        if event.name == "completed" then
            print(request:getResponseHeadersString())
            local code = request:getResponseStatusCode()
            if code ~= 200 then
                -- 请求结束，但没有返回 200 响应代码
                print(code)
                return
            end
            -- 请求成功，显示服务端返回的内容
            print("response length" .. request:getResponseDataLength())
            local response = request:getResponseString()
            print(response)
        elseif event.name == "progress" then
            print("progress" .. event.dltotal)
        else
            -- 请求失败，显示错误代码和错误消息
            print(event.name)
            print(request:getErrorCode(), request:getErrorMessage())
            return
        end
    end

    -- get test
    --local request = network.createHTTPRequest(onRequestCallback, "http://127.0.0.1:1234/hello", "GET")
    --request:start()
    -- post test
    local request = network.createHTTPRequest(onRequestCallback, "http://127.0.0.1:1234/hello", "POST")
    --request:addPOSTValue("name", "laoliu")
    request:setPOSTData("this is poststring to server!")
    request:start()
end

function NetworkScene:onEnter()
end

function NetworkScene:onExit()
end

return NetworkScene
