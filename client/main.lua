local registeredCallbacks = {}
local pendingRequests = {}
local nextRequestId = 0

local function RegisterCallback(eventName, callback)
    registeredCallbacks[eventName] = callback 
    DevJacobLib.Logger.Info(("Server Callback %s registered by resource %s"):format(eventName, GetCurrentResourceName() or "unknown"))
end

local function TriggerCallback(eventName, callback, ...)
    pendingRequests[nextRequestId] = callback
    TriggerServerEvent("DevJacob:CallbackManager:Server:TriggerCallback", eventName, nextRequestId, GetInvokingResource() or "unknown", ...)
    nextRequestId = nextRequestId + 1
end

local function OnEventTriggerCallback(eventName, requestId, invoker, ...)
    if not registeredCallbacks[eventName] then
        DevJacobLib.Logger.Error(("Client Callback not registered, name: %s, invoker resource: %s"):format(eventName, invoker))
        return
    end
  
    registeredCallbacks[eventName](function(...)
        TriggerServerEvent("DevJacob:CallbackManager:Server:ReturnCallback", requestId, invoker, ...)
    end, ...)
end

local function OnEventReturnCallback(requestId, invoker, ...)
    if not pendingRequests[requestId] then
        DevJacobLib.Logger.Error(("Server Callback with requestId %s was called by %s but doesn't exist"):format(requestId, invoker))
        return
    end
  
    pendingRequests[requestId](...)
    pendingRequests[requestId] = nil
end

RegisterNetEvent("DevJacob:CallbackManager:Client:TriggerCallback", OnEventTriggerCallback)
RegisterNetEvent("DevJacob:CallbackManager:Client:ReturnCallback", OnEventReturnCallback)

exports("getCallbackManagerObject", function()
    CallbackManager = {}
    CallbackManager._RegisterCallback = RegisterCallback
    CallbackManager._TriggerCallback = TriggerCallback

    CallbackManager.RegisterClientCallback = RegisterCallback
    CallbackManager.TriggerServerCallback = TriggerCallback

	return CallbackManager
end)
