local Airplanes = nil

Citizen.CreateThread(function()
    while true do
        while Airplanes == nil do
            Wait(500)
        end

        for k,v in pairs(Airplanes) do
            local entity = NetworkGetEntityFromNetworkId(v.netID)

            if entity ~= 0 then
                RequestNamedPtfxAsset("scr_carsteal4")

                while not HasNamedPtfxAssetLoaded("scr_carsteal4") do
                    Citizen.Wait(100)
                end
            
                UseParticleFxAssetNextCall("scr_carsteal4")

                SetParticleFxNonLoopedColour(v.color.r, v.color.g, v.color.b)

                StartParticleFxNonLoopedOnEntity("scr_carsteal4_wheel_burnout", entity, -0.15, -1.4, 0.2, 0, 0, 0, 0.9, 0, 1, 0)
            end
        end
        
        Citizen.Wait(40)
    end
end)

if Airplanes == nil then
    TriggerServerEvent("notbad-stunt-plane-smoke:syncData")
end

RegisterNetEvent("notbad-stunt-plane-smoke:syncData")
AddEventHandler("notbad-stunt-plane-smoke:syncData", function(data)
    Airplanes = data
end)