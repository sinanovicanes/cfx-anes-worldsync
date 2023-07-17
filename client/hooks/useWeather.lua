local function map(targets)
    local map = {}
    for k, v in pairs(targets) do map[v] = true end
    return map
end

function useWeather(data)
    if not data?.targets then return end

    local handlers = {}
    local targets = map(data.targets)
    local resource = GetInvokingResource()
    local onStateChange = data.onStateChange

    if type(onStateChange) == "string" then
        local event = onStateChange

        onStateChange = function(state)
            TriggerEvent(event, state)
        end
    end

    local hook = {
        state = nil,
        destroy = function()
            for i = 1, #handlers do
                RemoveEventHandler(handlers[i])
            end
        end
    }

    data = nil

    local function control(weather)
        local newState = targets[weather] == true

        if hook.state == newState then return end
        hook.state = newState
    
        if not onStateChange then return end
        onStateChange(hook.state)
    end

    control(currentWeather)

    handlers[#handlers + 1] = AddEventHandler("worldSync:weather:set", control)
    handlers[#handlers + 1] = AddEventHandler("onResourceStop", function(resName)
        if resName ~= resource then return end
        hook.destroy()
    end)

    return hook
end

exports("useWeather", useWeather)