local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("pedRestrictions:request", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local cid = Player.PlayerData.citizenid
    local restrictions = {}

    for model in pairs(Config.RestrictedPeds) do
        restrictions[model] = false
    end

    if Config.PEDRestrictions[cid] then
        for _, allowedModel in ipairs(Config.PEDRestrictions[cid]) do
            restrictions[allowedModel] = true
        end
    end

    TriggerClientEvent("pedRestrictions:apply", src, restrictions)
end)
