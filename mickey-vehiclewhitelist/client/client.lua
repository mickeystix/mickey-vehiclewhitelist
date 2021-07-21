--Made by Mickey with Love

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

QBCore = nil
local isLoggedIn = false
local PlayerJob = {}
local isAllowed = false

Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(1)
        if QBCore == nil then
            TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)    
            Citizen.Wait(200)
        end
    end
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
	isLoggedIn = true
    PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

-- Code

whitelistedVehicles = {
    "lib11vic",
    "lib12caprice",
    "lib14charger",
    "lib14ram",
    "lib16explorer",
    "lib18charger",
    "lib18taurus",
    "lib19camaro",
    "lib19silverado",
    "lib19tahoe",
    "bear01",
    "brush",
    "f450ambo",
    "bat3",
    "pengine",
    "20ramambo"
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if QBCore == nil then
            TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
            TriggerEvent('QBCore:Client:IsPlayerLoggedIn', function (state)
                isLoggedIn = state
                if isLoggedIn then
                    TriggerEvent('QBCore:Client:OnPlayerLoaded')
                end
            end)
            Citizen.Wait(200)
        end
    end
end)
-------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(400)
        if PlayerJob.name == "police" or PlayerJob.name == "LSPD" or PlayerJob.name == "doctor" or PlayerJob.name == "ambulance" or PlayerJob.name == "EMS" or PlayerJob.name == "PBMedical" or PlayerJob.name == "mechanic" then
            isAllowed = true
        else
            isAllowed = false
        end

        local ped = PlayerPedId()
        local veh = nil

        if IsPedInAnyVehicle(ped, false) then
            veh = GetVehiclePedIsUsing(ped)
        else
            veh = GetVehiclePedIsTryingToEnter(ped)
        end
        
        if veh and DoesEntityExist(veh) then
            local model = GetEntityModel(veh)
            local driver = GetPedInVehicleSeat(veh, -1)
            if driver == ped and not isAllowed then
                for i = 1, #whitelistedVehicles do
        
                    if type(whitelistedVehicles[i]) == "number" then
                        if GetVehicleClass(veh) == whitelistedVehicles[i] then
                            TaskLeaveVehicle(ped, GetVehiclePedIsIn(ped, false), 1)
                            ClearPedTasksImmediately(ped)
                        end
                    elseif type(whitelistedVehicles[i]) == "string" then
                        local restrictedVehicleModel = GetHashKey(whitelistedVehicles[i])
                        if (model == restrictedVehicleModel) then
                            TaskLeaveVehicle(ped, GetVehiclePedIsIn(ped, false), 1)
                            ClearPedTasksImmediately(ped)
                        end
                    end
                end
            end
        end
    end
end)

