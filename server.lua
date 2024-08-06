local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('restrictped:CheckPerms', function(source, cb)
    local src = source
    local userPEDs = {}

    local Player = QBCore.Functions.GetPlayer(src)
    local citizenID = Player.PlayerData.citizenid

    if citizenID then
        for id, PEDs in pairs(Config.PEDRestrictions) do
            if id == citizenID then
                userPEDs = PEDs
                print("[restrictped] " .. GetPlayerName(src) .. " has received permission for PEDs: " .. table.concat(PEDs, ", "))
                break
            end
        end
    else
        print("[restrictped] " .. GetPlayerName(src) .. " did not receive permissions because citizenID is nil")
    end

    cb(userPEDs)
end)
