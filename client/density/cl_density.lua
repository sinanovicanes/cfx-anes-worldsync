local densityMultiplier = 0.0
local customMultiplier

CreateThread(function()
	while true do
		local multiplier = customMultiplier ~= nil and customMultiplier or densityMultiplier
		SetParkedVehicleDensityMultiplierThisFrame(multiplier)
		SetVehicleDensityMultiplierThisFrame(multiplier)
		SetRandomVehicleDensityMultiplierThisFrame(multiplier)
		SetPedDensityMultiplierThisFrame(multiplier)
		SetScenarioPedDensityMultiplierThisFrame(multiplier, multiplier)
		Wait(0)
	end
end)

AddEventHandler("worldSync:density:setCustom", function(multiplier)
	customMultiplier = multiplier
end)

RegisterNetEvent("worldSync:density:set", function(multiplier)
	densityMultiplier = multiplier
end)

exports("getDensity", function()
    return densityMultiplier
end)