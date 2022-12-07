local currentCoords = nil

RegisterServerEvent('noodknop:noodknopGeactiveerd')
AddEventHandler('noodknop:noodknopGeactiveerd', function(coords)

    currentCoords = coords
    TriggerClientEvent('noodknop:GeactiveerdBericht', -1, "~o~Noodknop~s~: Een eenheid heeft hun noodknop geactiveerd. ~y~/noodaccepteer", coords)

end)

RegisterServerEvent('noodknop:noodGeaccepteerd')
AddEventHandler('noodknop:noodGeaccepteerd', function(source)

    if currentCoords ~= nil then
        TriggerClientEvent('noodknop:GeaccepteerdBericht', source, "~o~Noodknop~s~: Navigatie gestart naar laatste noodbericht.", c)
        TriggerClientEvent('noodknop:GeaccepteerdNavigatie', source, currentCoords)
    else
        TriggerClientEvent('noodknop:GeaccepteerdBericht', source, "~o~Noodknop~s~: Er is geen actieve noodbericht gaande.")
    end

end)