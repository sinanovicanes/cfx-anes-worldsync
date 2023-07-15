local INCREASE_TIME_PER_SEC = 6
local time = 31800

local function Timer()
    time = (time + INCREASE_TIME_PER_SEC) % 86400
    TriggerClientEvent("worldSync:time:set", -1, time)
    SetTimeout(1000, Timer)
end

CreateThread(function()
	local currentDate = os.date("*t")
	time = currentDate.hour * 3600 + currentDate.min * 60 + currentDate.sec
    SetTimeout(1000, Timer)
end)

RegisterCommand("time", function(source, args)
    local hour = tonumber(args[1])

    if not hour then return end

    local min = tonumber(args[2]) or 0
    local sec = tonumber(args[3]) or 0

    time = hour * 3600 + min * 60 + sec
    TriggerClientEvent("worldSync:time:set", -1, time)
end, false)
