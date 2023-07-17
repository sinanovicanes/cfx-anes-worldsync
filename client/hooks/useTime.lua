local function isInRange(range, hours)
    if range[1] < range[2] then return hours >= range[1] and hours < range[2] end
    return hours >= range[1] or hours < range[2]
end

function useTime(data)
    if not data?.range then return end

    local handlers = {}
    local range = data.range
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

    local function control(hours)
        local newState = isInRange(range, hours)
    
        if hook.state == newState then return end
        hook.state = newState
    
        if not onStateChange then return end
        onStateChange(hook.state)
    end

    control(time.h)

    handlers[#handlers + 1] = AddEventHandler("worldSync:time:hours:set", control)
    handlers[#handlers + 1] = AddEventHandler("onResourceStop", function(resName)
        if resName ~= resource then return end
        hook.destroy()
    end)

    return hook
end

exports("useTime", useTime)