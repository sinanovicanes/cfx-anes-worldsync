disableSync = false

AddEventHandler("worldSync:disable", function(state)
    disableSync = state
end)

TriggerServerEvent("worldSync:request")