# CFX-FiveM World Sync

A FiveM resource that controls worlds time, density and weather.

# Installation

> Add line below to your server.cfg

```cfg
ensure cfx-anes-worldsync
```

## Commands

| Command   | Description                      | Parameter 1                    | Parameter 2      | Parameter 3      |
| --------- | -------------------------------- | ------------------------------ | ---------------- | ---------------- |
| `density` | Sets density for all the clients | multiplier: number (0.0 - 1.0) |
| `time`    | Sets time for all the clients    | hours: number                  | minutes?: number | seconds?: number |
| `weather` | Sets weather for all the clients | weather: string                |

## Event Handlers

| Event                         | Description                    | Net Event | Parameter 1                    |
| ----------------------------- | ------------------------------ | --------- | ------------------------------ |
| `worldSync:disable`           | Disables all syncs             | false     | state: boolean                 |
| `worldSync:density:setCustom` | Sets custom density for client | false     | multiplier: number (0.0 - 1.0) |
| `worldSync:time:block`        | Blocks time sync               | false     | state: boolean                 |
| `worldSync:weather:block`     | Blocks weather sync            | false     | state: boolean                 |

## Events

| Event                        | Description                 | Parameter 1            | Parameter 2   | Parameter 3     |
| ---------------------------- | --------------------------- | ---------------------- | ------------- | --------------- |
| `worldSync:time:hours:set`   | Informs current hours       | hours: number          |
| `worldSync:time:minutes:set` | Informs current minutes     | minutes: number        |
| `worldSync:time:header:set`  | Informs current time header | header: string (00:00) | hours: number | minutes: number |

## Client Exports

| Command          | Description                        |
| ---------------- | ---------------------------------- |
| `getDensity`     | Returns current density multiplier |
| `getTime`        | Returns current time object        |
| `getWeather`     | Returns current weather            |
| `useTimeHook`    | [Usage](#usetimehook)              |
| `useWeatherHook` | [Usage](#useweatherhook)           |

# Hooks

## useTimeHook

> Add line below to your fxmanifest.lua or use exports

```lua
client_script "@cfx-anes-worldsync/client/time/cl_hook.lua"
```

### Usage

```lua
local dayTime = false
local nightTime = false

useTimeHook({
    cb = function(state) dayTime = state end,
    range = {7, 19}
})

-- Hook returns cb function to destroy the hook
local destroy = useTimeHook({
    event = "nightTime",
    range = {19, 7}
})

RegisterCommand("destroy", destroy)
AddEventHandler("nightTime", function(state) nightTime = state end)
```

## useWeatherHook

> Add line below to your fxmanifest.lua or use exports

```lua
client_script "@cfx-anes-worldsync/client/weather/cl_hook.lua"
```

### Usage

```lua
local rainy = false

useWeatherHook({
    weathers = {"XMAS"},
    cb = function(state)
        SetForceVehicleTrails(state)
        SetForcePedFootstepsTracks(state)
    end
})

-- Hook returns cb function to destroy the hook
local destroy = useWeatherHook({
    weathers = {"RAIN", "THUNDER"}
    event = "rainy"
})

RegisterCommand("destroy", destroy)
AddEventHandler("rainy", function(state) rainy = state end)
```
