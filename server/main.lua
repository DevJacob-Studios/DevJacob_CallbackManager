local registeredCallbacks = {}
local pendingRequests = {}
local nextRequestId = 0

local function RegisterCallback(eventName, callback)
    registeredCallbacks[eventName] = callback 
    DevJacobLib.Logger.Info(("Server Callback %s registered by resource %s"):format(eventName, GetCurrentResourceName() or "unknown"))
end

local function TriggerCallback(player, eventName, callback, ...)
    pendingRequests[nextRequestId] = callback
    TriggerClientEvent("DevJacob:CallbackManager:Client:TriggerCallback", player, eventName, nextRequestId, GetInvokingResource() or "unknown", ...)
    nextRequestId = nextRequestId + 1
end

local function OnEventTriggerCallback(eventName, requestId, invoker, ...)
    local source = source
  
    if not registeredCallbacks[eventName] then
        DevJacobLib.Logger.Error(("Server Callback not registered, name: %s, invoker resource: %s"):format(eventName, invoker))
        return
    end
  
    registeredCallbacks[eventName](source, function(...)
        TriggerClientEvent("DevJacob:CallbackManager:Client:ReturnCallback", source, requestId, invoker, ...)
    end, ...)
end

local function OnEventReturnCallback(requestId, invoker, ...)
    if not pendingRequests[requestId] then
        DevJacobLib.Logger.Error(("Client Callback with requestId %s was called by %s but doesn't exist"):format(requestId, invoker))
        return
    end
  
    pendingRequests[requestId](...)
    pendingRequests[requestId] = nil
end

RegisterNetEvent("DevJacob:CallbackManager:Server:TriggerCallback", OnEventTriggerCallback)
RegisterNetEvent("DevJacob:CallbackManager:Server:ReturnCallback", OnEventReturnCallback)

exports("getCallbackManagerObject", function()
    CallbackManager = {}
    CallbackManager._RegisterCallback = RegisterCallback
    CallbackManager._TriggerCallback = TriggerCallback

    CallbackManager.RegisterServerCallback = RegisterCallback
    CallbackManager.TriggerClientCallback = TriggerCallback

	return CallbackManager
end)
