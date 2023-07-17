currentWeather = ""
local blocked = false
local RAIN_LEVELS = {
    ["RAIN"] = 0.1,
    ["THUNDER"] = 0.3
}

local function setWeather(pWeather)
    SetWeatherTypeOvertimePersist(pWeather, 15.0)
	SetRainLevel(RAIN_LEVELS[pWeather] or 0.0)
end

RegisterNetEvent("worldSync:weather:set", function(pWeather)
    if currentWather == pWeather then return end
    currentWeather = pWeather
    if disableSync or blocked then return end
    setWeather(currentWeather)
end)

AddEventHandler("worldSync:weather:block", function(state)
    blocked = state
    if blocked then return end
    setWeather(currentWeather)
end)

AddEventHandler("worldSync:disable", function(state)
    if state or blocked then return end
    setWeather(currentWeather)
end)

exports("getWeather", function()
    return currentWeather
end)

exports("setWeather", function(weather, block)
    if block ~= nil then blocked = block end
    setWeather(weather or currentWeather)
end)
