local density = 0.8

RegisterNetEvent("worldSync:request", function()
    TriggerClientEvent("worldSync:density:set", source, density)
end)

RegisterCommand("density", function(source, args)
    local newDensity = tonumber(args[1])
    if not newDensity or density == newDensity then return end

    density = newDensity
    print("Setting density: " .. density)
    TriggerClientEvent("worldSync:density:set", -1, density)
end, false)

AddEventHandler("onResourceStart", function(resName)
    if resName ~= GetCurrentResourceName() then return end
    Wait(100)
    TriggerClientEvent("worldSync:density:set", -1, density)
end)