currentWeather = ""
local blocked = false
local RAIN_LEVELS = {
    ["RAIN"] = 0.1,
    ["THUNDER"] = 0.3
}

function SetWeather(pWeather)
    SetWeatherTypeOvertimePersist(pWeather, 15.0)
	SetRainLevel(RAIN_LEVELS[pWeather] or 0.0)
end

RegisterNetEvent("worldSync:weather:set", function(pWeather)
    if currentWather == pWeather then return end
    currentWeather = pWeather
    if disableSync or blocked then return end
    SetWeather(currentWeather)
end)

AddEventHandler("worldSync:weather:block", function(state)
    blocked = state
    if blocked then return end
    SetWeather(currentWeather)
end)

AddEventHandler("worldSync:disable", function(state)
    if state or blocked then return end
    SetWeather(currentWeather)
end)

exports("getWeather", function()
    return currentWeather
end)

exports("SetWeather", function(weather, block)
    if block ~= nil then blocked = block end
    SetWeather(weather or currentWeather)
end)
