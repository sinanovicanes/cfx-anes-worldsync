fx_version "cerulean"
author "sinanovicanes"
version "1.0.0"
lua54 "yes"
games { "gta5" }

client_scripts {
    "client/cl_main.lua",
    "client/hooks/*.lua",
    "client/time/cl_*.lua",
    "client/weather/cl_*.lua",
    "client/density/cl_*.lua"
}

server_scripts {
    "server/time/sv_*.lua",
    "server/weather/sv_*.lua",
    "server/density/sv_*.lua"
}
