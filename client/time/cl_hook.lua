local function isInRange(range, hours)
    if range[1] < range[2] then return hours >= range[1] and hours < range[2] end
    return hours >= range[1] or hours < range[2]
end

function useTimeHook(data)
    if not data.cb and not data.event or not data.range then return end
    
    local hook = {
        range = data.range,
        cb = data.cb,
        event = data.event,
        resource = GetInvokingResource(),
        state = nil
    }

    data = nil

    local function control(hours)
        local newState = isInRange(hook.range, hours)
    
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

    control(time.h)

    hook.handler = AddEventHandler("worldSync:time:hours:set", control)
    hook.rHandler = AddEventHandler("onResourceStop", function(resName)
        if resName ~= hook.resource then return end
        remove()
    end)

    return remove
end
