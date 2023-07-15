local DEFAULT_DURATION = 30
local current = {
    weather = "EXTRASUNNY",
    duration = math.random(30, 60)
}
local WEATHERS = {
    EXTRASUNNY = {duration = {30, 60}, next = {EXTRASUNNY = {1, 20}, CLOUDS = {21, 50}, CLEAR = {51, 100}}},
    CLEAR = {duration = {30, 45}, next = {EXTRASUNNY = {1, 70}, CLOUDS = {71, 100}}},
    NEUTRAL = {duration = {10, 20}, next = {NEUTRAL = {1, 10}, EXTRASUNNY = {11, 50}, CLOUDS = {51, 100}}},
    SMOG = {},
    FOGGY = {},
    OVERCAST = {duration = 5, next = {CLOUDS = {1, 50}, CLEARING = {51, 100}}},
    CLOUDS = {duration = {15, 20}, next = {RAIN = {1, 20}, CLEARING = {21, 100}}},
    CLEARING = {duration = 10, next = "CLEAR"},
    THUNDER = {duration = 10, next = "RAIN"},
    SNOW = {},
    BLIZZARD = {},
    SNOWLIGHT = {},
    HALLOWEEN = {},
    XMAS = {},
    RAIN = {duration = 15, next = {RAIN = {1, 20}, THUNDER = {21, 35}, CLOUDS = {36, 45}, CLEARING = {46, 100}}}
}

local function GetNextWeather(pWeather)
    local weatherData = WEATHERS[pWeather]
    if not weatherData then return {weather = pWeather, duration = DEFAULT_DURATION} end
    
    local nextWeather = weatherData.next or pWeather

    if type(nextWeather) == "table" then
        local rand = math.random(100)
        
        for weather, range in pairs(nextWeather) do
            if rand >= range[1] and rand <= range[2] then
                nextWeather = weather
                break
            end
        end
    end

    local nextWeatherData = WEATHERS[nextWeather]
    local duration = nextWeatherData.duration and type(nextWeatherData.duration) == "table" and math.random(nextWeatherData.duration[1], nextWeatherData.duration[2]) or nextWeatherData.duration or DEFAULT_DURATION

    return {weather = nextWeather, duration = duration}
end

CreateThread(function()
    while true do
        Wait(60 * 1000)
        current.duration = current.duration - 1

        if current.duration <= 0 then
            current = GetNextWeather(current.weather)
            print("UPDATING WEATHER: " .. current.weather .. " DURATION: " .. current.duration)
            TriggerClientEvent("worldSync:weather:set", -1, current.weather)
        end
    end
end)

RegisterNetEvent("worldSync:request", function()
    TriggerClientEvent("worldSync:weather:set", source, current.weather)
end)

RegisterCommand("weather", function(source, args)
    local weather = args[1] and args[1]:upper() or nil
    if not weather or not WEATHERS[weather] then return end

    local weatherData = WEATHERS[weather]
    current = {
        weather = weather,
        duration = tonumber(args[2]) or type(weatherData.duration) == "table" and math.random(weatherData.duration[1], weatherData.duration[2]) or weatherData.duration or DEFAULT_DURATION
    }
    print("Setting weather: " .. current.weather .. " | Duration: " .. current.duration)
    TriggerClientEvent("worldSync:weather:set", -1, current.weather)
end, false)

AddEventHandler("onResourceStart", function(resName)
    if resName ~= GetCurrentResourceName() then return end
    Wait(100)
    TriggerClientEvent("worldSync:weather:set", -1, current.weather)
end)