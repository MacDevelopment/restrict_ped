local QBCore = exports['qb-core']:GetCoreObject()

myPEDs = {}

CreateThread(function()
    QBCore.Functions.TriggerCallback('restrictped:CheckPerms', function(PEDs)
        myPEDs = PEDs
    end)

    while true do
        Wait(2000)
        local PlayerPED = PlayerPedId()
        local modelhashed = GetHashKey("a_m_y_skater_01")

        RequestModel(modelhashed)
        while not HasModelLoaded(modelhashed) do 
            RequestModel(modelhashed)
            Wait(0)
        end

        local hasPerm = false;

        for i = 1, #myPEDs do
            if IsPedModel(PlayerPED, GetHashKey(tostring(myPEDs[i]))) then
                hasPerm = true;
                break;
            end
        end

        if not hasPerm then
            for _, PEDList in pairs(restrictedPeds) do
                for i = 1, #PEDList do
                    if IsPedModel(PlayerPED, GetHashKey(tostring(PEDList[i]))) then
                        SetPlayerModel(PlayerId(), modelhashed)
                        SetModelAsNoLongerNeeded(modelhashed)
                        QBCore.Functions.Notify("This PED model is restricted.", "primary", 2500)
                        break;
                    end
                end
            end
        end
    end
end)
