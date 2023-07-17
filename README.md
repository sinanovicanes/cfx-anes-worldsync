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

| Command      | Description                        | Parameter 1      | Parameter 2          |
| ------------ | ---------------------------------- | ---------------- | -------------------- |
| `getDensity` | Returns current density multiplier |
| `getTime`    | Returns current time object        |
| `getWeather` | Returns current weather            |
| `setWeather` | Changes current weather            | weather?: string | disableSync: boolean |
| `useTime`    | [Usage](#usetime)                  | Hook Options     |
| `useWeather` | [Usage](#useweather)               | Hook Options     |

# Hooks

## useTime

### Hook Options

| Option         | Type              |
| -------------- | ----------------- |
| range          | number[]          |
| onStateChange? | string / Function |

### Usage

```lua
local dayTime = useTime({
    range = {7, 19},
    onStateChange = function(state)
        -- Do something
    end
})

print(dayTime.state) -- true / false
dayTime.destroy() -- Saves last state (no longer updating)

AddEventHandler("nightTime", function(state)
    -- Do something
end)

local nightTime = exports["cfx-anes-worldsync"]:useTime({
    range = {19, 7},
    onStateChange = "nightTime"
})
```

## useWeather

### Hook Options

| Option         | Type              |
| -------------- | ----------------- |
| targets        | string[]          |
| onStateChange? | string / Function |

### Usage

```lua
useWeather({
    targets = {"XMAS"},
    onStateChange = function(state)
        SetForceVehicleTrails(state)
        SetForcePedFootstepsTracks(state)
    end
})

AddEventHandler("rainy", function(state)
    -- Do something
end)

local rainy = exports["cfx-anes-worldsync"]:useWeather({
    targets = {"RAIN", "THUNDER"},
    onStateChange = "rainy"
})

print(rainy.state) -- true / false
rainy.destroy() -- Saves last state (no longer updating)
```
