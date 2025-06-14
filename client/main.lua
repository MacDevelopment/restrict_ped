local restrictedPeds = {}
local fallbackModel = `a_m_y_skater_01`
local fallbackLoaded = false

local function isModelRestricted(model)
    return restrictedPeds[model] == false
end

local function loadModelIfNeeded(model)
    if HasModelLoaded(model) then return true end
    RequestModel(model)
    local timeout = 1000
    while not HasModelLoaded(model) and timeout > 0 do
        Wait(10)
        timeout -= 10
    end
    return HasModelLoaded(model)
end

local function applyFallback()
    if not fallbackLoaded then
        loadModelIfNeeded(fallbackModel)
        fallbackLoaded = true
    end
    SetPlayerModel(PlayerId(), fallbackModel)
end

CreateThread(function()
    while true do
        Wait(2000)
        local ped = PlayerPedId()
        local model = GetEntityModel(ped)

        if next(restrictedPeds) then
            if isModelRestricted(model) then
                applyFallback()
            end
        end
    end
end)

RegisterNetEvent("pedRestrictions:apply")
AddEventHandler("pedRestrictions:apply", function(restrictions)
    restrictedPeds = {}
    for model, allowed in pairs(restrictions) do
        restrictedPeds[GetHashKey(model)] = allowed
    end
end)

CreateThread(function()
    Wait(1000)
    TriggerServerEvent("pedRestrictions:request")
end)
