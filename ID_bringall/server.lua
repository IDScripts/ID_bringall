RegisterCommand('bringall', function(source, args, rawCommand)
    local src = source
    local radius = tonumber(args[1])
    
    if src == 0 then
        print("Ez a command nem használható a konzolból!")
        return
    end

    if radius == nil then
        TriggerClientEvent('chat:addMessage', src, {
            args = { 'Usage: /bringall <radius>' }
        })
        return
    end

    local srcCoords = GetEntityCoords(GetPlayerPed(src))
    
    for _, playerId in ipairs(GetPlayers()) do
        local playerPed = GetPlayerPed(playerId)
        local playerCoords = GetEntityCoords(playerPed)

        if #(playerCoords - srcCoords) <= radius then
            SetEntityCoords(playerPed, srcCoords.x, srcCoords.y, srcCoords.z, false, false, false, true)
            TriggerClientEvent('chat:addMessage', playerId, {
                args = { 'Hozzá lettél teleportálva: ' .. GetPlayerName(src) }
            })
        end
    end

    TriggerClientEvent('chat:addMessage', src, {
        args = { 'Minden játékos a(z) ' .. radius .. ' méteres körzetben hozzád lett teleportálva!' }
    })
end, false)
