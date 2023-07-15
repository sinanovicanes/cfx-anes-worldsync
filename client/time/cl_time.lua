time = {
    base = 31800,
    h = 0,
    m = 0,
    s = 0,
    header = "00:00"
}
local blocked = false

RegisterNetEvent("worldSync:time:set", function(pTime)
    time.base = pTime

    local hours = math.floor(time.base / 3600)
    local minutes = math.floor((time.base - (hours * 3600)) / 60)
    local seconds = time.base - (hours * 3600) - (minutes * 60)

    if hours ~= time.h then
        time.h = hours
        TriggerEvent("worldSync:time:hours:set", time.h)
    end

    if minutes ~= time.m then
        time.m = minutes
        TriggerEvent("worldSync:time:minutes:set", time.m)
    end

    time.s = seconds

    local header = (time.h < 10 and "0" .. time.h or time.h) .. ":" .. (time.m < 10 and "0" .. time.m or time.m)

    if header ~= time.header then
        time.header = header
        TriggerEvent("worldSync:time:header:set", time.header, time.h, time.m)
    end

    if disableSync or blocked then return end

    NetworkOverrideClockTime(time.h, time.m, time.s)
end)

AddEventHandler("worldSync:time:block", function(state)
    blocked = state
end)

exports("getTime", function()
    return time
end)