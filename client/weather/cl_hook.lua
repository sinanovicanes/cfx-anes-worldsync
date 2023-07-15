local function mapWeathers(weathers)
    local map = {}
    for k, v in pairs(weathers) do map[v] = true end
    return map
end

function useWeatherHook(data)
    if not data.cb and not data.event or not data.weathers then return end

    local hook = {
        cb = data.cb,
        event = data.event,
        resource = GetInvokingResource(),
        weathers = mapWeathers(data.weathers),
        state = nil
    }

    data = nil

    local function control(weather)
        local newState = hook.weathers[weather] == true
    
        if hook.state == newState then return end
        hook.state = newState
    
        if hook.cb then hook.cb(hook.state) end
        if hook.event then TriggerEvent(hook.event, hook.state) end
    end

    local function remove()
        RemoveEventHandler(hook.handler)
        RemoveEventHandler(hook.rHandler)
        if hook.cb then hook.cb(false) end
        if hook.event then TriggerEvent(hook.event, false) end
    end

    control(currentWeather)

    hook.handler = AddEventHandler("worldSync:weather:set", control)
    hook.rHandler = AddEventHandler("onResourceStop", function(resName)
        if resName ~= hook.resource then return end
        remove()
    end)

    return remove
end
