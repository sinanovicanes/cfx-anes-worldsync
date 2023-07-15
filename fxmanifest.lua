fx_version "cerulean"
author "sinanovicanes"
version "1.0.0"
lua54 "yes"
games { "gta5" }

client_scripts {
    "client/cl_main.lua",
    "client/time/cl_time.lua",
    "client/time/cl_hook*.lua",
    "client/weather/cl_weather.lua",
    "client/weather/cl_hook*.lua",
    "client/density/cl_*.lua"
}

server_scripts {
    "server/time/sv_*.lua",
    "server/weather/sv_*.lua",
    "server/density/sv_*.lua"
}

exports {
    "useTimeHook",
    "useWeatherHook"
}