local WaitTime = 2500 -- Actuallissation du status sur Discord

local DiscordAppId = tonumber(GetConvar("RichAppId", "382624125287399424"))
local DiscordAppAsset = GetConvar("RichAssetId", "fivem_large")
local UseKMH = GetConvar("RichUseKMH", false)
	
Citizen.CreateThread(function()
	SetDiscordAppId(DiscordAppId)
	SetDiscordRichPresenceAsset(DiscordAppAsset)
	while true do
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
		local StreetHash = GetStreetNameAtCoord(x, y, z)
		Citizen.Wait(WaitTime)
		if StreetHash ~= nil then
			StreetName = GetStreetNameFromHashKey(StreetHash)
			if IsPedOnFoot(PlayerPedId()) and not IsEntityInWater(PlayerPedId()) then
				if IsPedSprinting(PlayerPedId()) then
					SetRichPresence("Sprinting down "..StreetName)
				elseif IsPedRunning(PlayerPedId()) then
					SetRichPresence("Running down "..StreetName)
				elseif IsPedWalking(PlayerPedId()) then
					SetRichPresence("Walking down "..StreetName)
				elseif IsPedStill(PlayerPedId()) then
					SetRichPresence("Standing on "..StreetName)
				end
			elseif GetVehiclePedIsUsing(PlayerPedId()) ~= nil and not IsPedInAnyHeli(PlayerPedId()) and not IsPedInAnyPlane(PlayerPedId()) and not IsPedOnFoot(PlayerPedId()) and not IsPedInAnySub(PlayerPedId()) and not IsPedInAnyBoat(PlayerPedId()) then
				local VehSpeed = GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId()))
				local CurSpeed = UseKMH and math.ceil(VehSpeed * 3.6) or math.ceil(VehSpeed * 2.236936)
				local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
				if CurSpeed > 50 then
					SetRichPresence(" Accélérer  sur "..StreetName.." Dans un  "..VehName)
				elseif CurSpeed <= 50 and CurSpeed > 0 then
					SetRichPresence(" Descend sur "..StreetName.." Dans un  "..VehName)
				elseif CurSpeed == 0 then
					SetRichPresence(" Garé sur "..StreetName.." Dans un  "..VehName)
				end
			elseif IsPedInAnyHeli(PlayerPedId()) or IsPedInAnyPlane(PlayerPedId()) then
				local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
				if IsEntityInAir(GetVehiclePedIsUsing(PlayerPedId())) or GetEntityHeightAboveGround(GetVehiclePedIsUsing(PlayerPedId())) > 5.0 then
					SetRichPresence("Survolant "..StreetName.." Dans un  "..VehName)
				else
					SetRichPresence(" Atterri à "..StreetName.." Dans un  "..VehName)
				end
			elseif IsEntityInWater(PlayerPedId()) then
				SetRichPresence(" Nage Autour ")
					elseif IsPedInAnySub(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
				SetRichPresence(" Dans un sours-marin ")
			elseif IsPedInAnyBoat(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
				local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
				SetRichPresence(" Navige autour Dans un  "..VehName)
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        local player = GetPlayerPed(-1)
        
        Citizen.Wait(5*1000) 
        
        SetDiscordAppId(588877885281140753)

        SetRichPresence( GetPlayerName(source) .. " is on " .. GetStreetNameFromHashKey(GetStreetNameAtCoord(table.unpack(GetEntityCoords(player))) )) -- text 

        SetDiscordRichPresenceAsset("big") -- gros logo 
        SetDiscordRichPresenceAssetText(GetPlayerName(source)) 

        SetDiscordRichPresenceAssetSmall("zua") -- petti logo
        SetDiscordRichPresenceAssetSmallText("Health: "..(GetEntityHealth(player)-100))

    end
end)
