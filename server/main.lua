local Airplanes = {}

RegisterCommand("redstuntsmoke", function(source, args, rawCommand)
    src = source

    local entity = GetVehiclePedIsIn(GetPlayerPed(src), false)
    if GetEntityModel(entity) ~= -2122757008 then return end
    local networkID = NetworkGetNetworkIdFromEntity(entity)

    local found = false

    for k,v in pairs(Airplanes) do
        if v.netID == networkID then
            v.color = {r = 200.0, g = 0.0, b = 0.0}
            found = true
        end
    end

    if found == false then
        table.insert(Airplanes, {
            netID = networkID,
            color = {r = 200.0, g = 0.0, b = 0.0}
        })
    end

    TriggerClientEvent("notbad-stunt-plane-smoke:syncData", -1, Airplanes)
end, false)

RegisterCommand("bluestuntsmoke", function(source, args, rawCommand)
    src = source

    local entity = GetVehiclePedIsIn(GetPlayerPed(src), false)
    if GetEntityModel(entity) ~= -2122757008 then return end
    local networkID = NetworkGetNetworkIdFromEntity(entity)

    local found = false

    for k,v in pairs(Airplanes) do
        if v.netID == networkID then
            v.color = {r = 0.0, g = 21.0, b = 213.0}
            found = true
        end
    end

    if found == false then
        table.insert(Airplanes, {
            netID = networkID,
            color = {r = 0.0, g = 21.0, b = 213.0}
        })
    end

    TriggerClientEvent("notbad-stunt-plane-smoke:syncData", -1, Airplanes)
end, false)

RegisterCommand("stopsmoke", function(source, args, rawCommand)
    src = source

    local entity = GetVehiclePedIsIn(GetPlayerPed(src), false)
    local networkID = NetworkGetNetworkIdFromEntity(entity)

    for k,v in pairs(Airplanes) do
        if v.netID == networkID then
            table.remove(Airplanes, k)
        end
    end

    TriggerClientEvent("notbad-stunt-plane-smoke:syncData", -1, Airplanes)
end, false)

Citizen.CreateThread(function()
    while true do
        for k,v in pairs(Airplanes) do
            if NetworkGetEntityFromNetworkId(v.netID) == 0 then
                table.remove(Airplanes, k)
            end
        end
        Citizen.Wait(5000)
    end
end)

RegisterServerEvent("notbad-stunt-plane-smoke:syncData")
AddEventHandler("notbad-stunt-plane-smoke:syncData", function()
    src = source

    TriggerClientEvent("notbad-stunt-plane-smoke:syncData", src, Airplanes)
end)