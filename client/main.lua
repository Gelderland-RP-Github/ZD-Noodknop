ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData() == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

------------------------------------------------------------------

RegisterCommand('noodknop', function()
    if PlayerData.job ~= nil and (PlayerData.job.name == 'police' or PlayerData.job.name == 'kmar') then
        
        local coords = GetEntityCoords(PlayerPedId())
        TriggerServerEvent('noodknop:noodknopGeactiveerd', coords)

    else
        ESX.ShowNotification("~o~Noodknop~s~: Je hebt niet de correcte baan!")
    end
end)

RegisterNetEvent('noodknop:GeactiveerdBericht')
AddEventHandler('noodknop:GeactiveerdBericht', function(bericht, coords)

    if PlayerData.job ~= nil and (PlayerData.job.name == 'police' or PlayerData.job.name == 'kmar') then
        ESX.ShowNotification(bericht)

        local x, y, z = table.unpack(coords)
        local alpha = 250
        
        blip = AddBlipForCoord(x, y, z)
        SetBlipScale(blip, 1.0)
        SetBlipSprite(blip, 161)
        SetBlipAlpha(blip, alpha)
        SetBlipColour(blip, 79)

        while alpha ~= 0 do
            Citizen.Wait(160)
            alpha = alpha - 1
            SetBlipAlpha(blip, alpha)
        
            if alpha == 0 then
                RemoveBlip(blip)
                return
            end
        end

    end

end)

------------------------------------------------------------------

RegisterCommand('noodaccepteer', function(source)
    if PlayerData.job ~= nil and (PlayerData.job.name == 'police' or PlayerData.job.name == 'kmar') then
        
        local src = GetPlayerServerId(PlayerId(source))
        TriggerServerEvent('noodknop:noodGeaccepteerd', src)

    end
end)

RegisterNetEvent('noodknop:GeaccepteerdBericht')
AddEventHandler('noodknop:GeaccepteerdBericht', function(bericht)

    if PlayerData.job ~= nil and (PlayerData.job.name == 'police' or PlayerData.job.name == 'kmar') then
        ESX.ShowNotification(bericht)
    end

end)

RegisterNetEvent('noodknop:GeaccepteerdNavigatie')
AddEventHandler('noodknop:GeaccepteerdNavigatie', function(coords)

    if PlayerData.job ~= nil and (PlayerData.job.name == 'police' or PlayerData.job.name == 'kmar') then
        
        local x, y, z = table.unpack(coords)

        ClearGpsMultiRoute()
        StartGpsMultiRoute(6, true, true)
        AddPointToGpsMultiRoute(x, y, z)
        SetGpsMultiRouteRender(true)

        while true do
            local ped = GetEntityCoords(PlayerPedId(1))
            Citizen.Wait(500)
            if Vdist(coords, ped) < 40 then
                ClearGpsMultiRoute()
                break
            end
        end
        

    else
        ESX.ShowNotification("~o~Noodknop~s~: Je hebt niet de correcte baan!")
    end

end)