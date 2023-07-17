useWeather({
    targets = {"XMAS"},
    onStateChange = function(state)
        SetForceVehicleTrails(state)
        SetForcePedFootstepsTracks(state)
    end
})