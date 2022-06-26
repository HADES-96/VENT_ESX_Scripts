local HasAlreadyEnteredMarker, IsInShopMenu = false, false
local CurrentAction, CurrentActionMsg, LastZone
local CurrentActionData = {}

-- Open Main Menu
function OpenMainMenu(zone)
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'weapon_cat', {
		title = _U('weapon_cat'),
		align = GetConvar('esx_MenuAlign', 'top-left'),
		elements = {
			{label = _U('wea_misc'), value = 'wea_misc'},
			{label = _U('wea_throw'), value = 'wea_throw'},
			{label = _U('wea_melee'), value = 'wea_melee'},
			{label = _U('wea_handgun'), value = 'wea_handgun'},
			{label = _U('wea_smg'), value = 'wea_smg'},
			{label = _U('wea_shotgun'), value = 'wea_shotgun'},
			{label = _U('wea_assault'), value = 'wea_assault'},
			{label = _U('wea_lmg'), value = 'wea_lmg'},
			{label = _U('wea_sniper'), value = 'wea_sniper'}
	}}, function(data, menu)
		local action = data.current.value

		if action == 'wea_misc' then
			if Config.Zones[zone].Legal then
				menu.close()
				OpenShopMenu(action, zone)
			else
				ESX.ShowNotification(_U('no_wea'))
			end
		elseif action == 'wea_throw' then
			if Config.Zones[zone].Legal then
				menu.close()
				OpenShopMenu(action, zone)
			else
				menu.close()
				OpenShopMenu(action, zone)
			end
		elseif action == 'wea_melee' then
			if Config.LicenseEnable and Config.RequireMeleeLicense and Config.Zones[zone].Legal then
				ESX.TriggerServerCallback('esx_license:checkLicense', function(hasLicense)
					if hasLicense then
						menu.close()
						OpenShopMenu(action, zone)
					else
						ESX.ShowNotification(_U('go_to'))
					end
				end, GetPlayerServerId(PlayerId()), 'weapon_melee')
			else
				menu.close()
				OpenShopMenu(action, zone)
			end
		elseif action == 'wea_handgun' then
			if Config.LicenseEnable and Config.Zones[zone].Legal then
				ESX.TriggerServerCallback('esx_license:checkLicense', function(hasLicense)
					if hasLicense then
						menu.close()
						OpenShopMenu(action, zone)
					else
						ESX.ShowNotification(_U('go_to'))
					end
				end, GetPlayerServerId(PlayerId()), 'weapon_handgun')
			else
				menu.close()
				OpenShopMenu(action, zone)
			end
		elseif action == 'wea_smg' then
			if Config.LicenseEnable and Config.Zones[zone].Legal then
				ESX.TriggerServerCallback('esx_license:checkLicense', function(hasLicense)
					if hasLicense then
						menu.close()
						OpenShopMenu(action, zone)
					else
						ESX.ShowNotification(_U('go_to'))
					end
				end, GetPlayerServerId(PlayerId()), 'weapon_smg')
			else
				menu.close()
				OpenShopMenu(action, zone)
			end
		elseif action == 'wea_shotgun' then
			if Config.LicenseEnable and Config.Zones[zone].Legal then
				ESX.TriggerServerCallback('esx_license:checkLicense', function(hasLicense)
					if hasLicense then
						menu.close()
						OpenShopMenu(action, zone)
					else
						ESX.ShowNotification(_U('go_to'))
					end
				end, GetPlayerServerId(PlayerId()), 'weapon_shotgun')
			else
				menu.close()
				OpenShopMenu(action, zone)
			end
		elseif action == 'wea_assault' then
			if Config.LicenseEnable and Config.Zones[zone].Legal then
				ESX.TriggerServerCallback('esx_license:checkLicense', function(hasLicense)
					if hasLicense then
						menu.close()
						OpenShopMenu(action, zone)
					else
						ESX.ShowNotification(_U('go_to'))
					end
				end, GetPlayerServerId(PlayerId()), 'weapon_assault')
			else
				menu.close()
				OpenShopMenu(action, zone)
			end
		elseif action == 'wea_lmg' then
			if Config.LicenseEnable and Config.Zones[zone].Legal then
				ESX.TriggerServerCallback('esx_license:checkLicense', function(hasLicense)
					if hasLicense then
						menu.close()
						OpenShopMenu(action, zone)
					else
						ESX.ShowNotification(_U('go_to'))
					end
				end, GetPlayerServerId(PlayerId()), 'weapon_lmg')
			else
				ESX.ShowNotification(_U('no_wea'))
			end
		elseif action == 'wea_sniper' then
			if Config.LicenseEnable and Config.Zones[zone].Legal then
				ESX.TriggerServerCallback('esx_license:checkLicense', function(hasLicense)
					if hasLicense then
						menu.close()
						OpenShopMenu(action, zone)
					else
						ESX.ShowNotification(_U('go_to'))
					end
				end, GetPlayerServerId(PlayerId()), 'weapon_sniper')
			else
				ESX.ShowNotification(_U('no_wea'))
			end
		end
	end, function(data, menu)
		menu.close()
	end)
end

-- Open Shop Menu
function OpenShopMenu(wvalue, zone)
	local elements = {}
	IsInShopMenu = true

	if wvalue == 'wea_misc' then
		for i=1, #Config.Zones[zone].Misc, 1 do
			local item = Config.Zones[zone].Misc[i]

			table.insert(elements, {
				label = ('%s - <span style="color: green;">%s</span>'):format(item.label, _U('shop_menu_item', ESX.Math.GroupDigits(item.price))),
				price = item.price,
				weaponName = item.name,
				weaponCat = item.cat
			})
		end
	elseif wvalue == 'wea_throw' then
		for i=1, #Config.Zones[zone].Throw, 1 do
			local item = Config.Zones[zone].Throw[i]

			table.insert(elements, {
				label = ('%s - <span style="color: green;">%s</span>'):format(item.label, _U('shop_menu_item', ESX.Math.GroupDigits(item.price))),
				price = item.price,
				weaponName = item.name,
				weaponCat = item.cat
			})
		end
	elseif wvalue == 'wea_melee' then
		for i=1, #Config.Zones[zone].Melee, 1 do
			local item = Config.Zones[zone].Melee[i]

			table.insert(elements, {
				label = ('%s - <span style="color: green;">%s</span>'):format(item.label, _U('shop_menu_item', ESX.Math.GroupDigits(item.price))),
				price = item.price,
				weaponName = item.name,
				weaponCat = item.cat
			})
		end
	elseif wvalue == 'wea_handgun' then
		for i=1, #Config.Zones[zone].Handgun, 1 do
			local item = Config.Zones[zone].Handgun[i]

			table.insert(elements, {
				label = ('%s - <span style="color: green;">%s</span>'):format(item.label, _U('shop_menu_item', ESX.Math.GroupDigits(item.price))),
				price = item.price,
				weaponName = item.name,
				weaponCat = item.cat
			})
		end
	elseif wvalue == 'wea_smg' then
		for i=1, #Config.Zones[zone].SMG, 1 do
			local item = Config.Zones[zone].SMG[i]

			table.insert(elements, {
				label = ('%s - <span style="color: green;">%s</span>'):format(item.label, _U('shop_menu_item', ESX.Math.GroupDigits(item.price))),
				price = item.price,
				weaponName = item.name,
				weaponCat = item.cat
			})
		end
	elseif wvalue == 'wea_shotgun' then
		for i=1, #Config.Zones[zone].Shotgun, 1 do
			local item = Config.Zones[zone].Shotgun[i]

			table.insert(elements, {
				label = ('%s - <span style="color: green;">%s</span>'):format(item.label, _U('shop_menu_item', ESX.Math.GroupDigits(item.price))),
				price = item.price,
				weaponName = item.name,
				weaponCat = item.cat
			})
		end
	elseif wvalue == 'wea_assault' then
		for i=1, #Config.Zones[zone].Assault, 1 do
			local item = Config.Zones[zone].Assault[i]

			table.insert(elements, {
				label = ('%s - <span style="color: green;">%s</span>'):format(item.label, _U('shop_menu_item', ESX.Math.GroupDigits(item.price))),
				price = item.price,
				weaponName = item.name,
				weaponCat = item.cat
			})
		end
	elseif wvalue == 'wea_lmg' then
		for i=1, #Config.Zones[zone].LMG, 1 do
			local item = Config.Zones[zone].LMG[i]

			table.insert(elements, {
				label = ('%s - <span style="color: green;">%s</span>'):format(item.label, _U('shop_menu_item', ESX.Math.GroupDigits(item.price))),
				price = item.price,
				weaponName = item.name,
				weaponCat = item.cat
			})
		end
	elseif wvalue == 'wea_sniper' then
		for i=1, #Config.Zones[zone].Sniper, 1 do
			local item = Config.Zones[zone].Sniper[i]

			table.insert(elements, {
				label = ('%s - <span style="color: green;">%s</span>'):format(item.label, _U('shop_menu_item', ESX.Math.GroupDigits(item.price))),
				price = item.price,
				weaponName = item.name,
				weaponCat = item.cat
			})
		end
	end

	--ESX.UI.Menu.CloseAll()
	--PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop', {
		title = _U('shop_menu_title'),
		align = GetConvar('esx_MenuAlign', 'top-left'),
		elements = elements
	}, function(data, menu)
		ESX.TriggerServerCallback('esx_advancedweaponshop:buyWeapon', function(bought)
			if bought then
				DisplayBoughtScaleform(data.current.weaponName, data.current.price)
			else
				PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', false)
			end
		end, data.current.weaponCat, data.current.weaponName, zone)
	end, function(data, menu)
		PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)
		IsInShopMenu = false
		menu.close()
		OpenMainMenu(zone)

		CurrentAction = 'shop_menu'
		CurrentActionData = {zone = zone}
	end, function(data, menu)
		PlaySoundFrontend(-1, 'NAV', 'HUD_AMMO_SHOP_SOUNDSET', false)
	end)
end

-- Display Bought
function DisplayBoughtScaleform(weaponName, price)
	local scaleform = ESX.Scaleform.Utils.RequestScaleformMovie('MP_BIG_MESSAGE_FREEMODE')
	local sec = 4

	BeginScaleformMovieMethod(scaleform, 'SHOW_WEAPON_PURCHASED')
	PushScaleformMovieMethodParameterString(_U('weapon_bought', ESX.Math.GroupDigits(price)))
	PushScaleformMovieMethodParameterString(ESX.GetWeaponLabel(weaponName))
	PushScaleformMovieMethodParameterInt(GetHashKey(weaponName))
	PushScaleformMovieMethodParameterString('')
	PushScaleformMovieMethodParameterInt(100)
	EndScaleformMovieMethod()
	PlaySoundFrontend(-1, 'WEAPON_PURCHASE', 'HUD_AMMO_SHOP_SOUNDSET', false)

	CreateThread(function()
		while sec > 0 do
			Wait(0)
			sec = sec - 0.01
	
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
		end
	end)
end

-- Entered Marker
AddEventHandler('esx_advancedweaponshop:hasEnteredMarker', function(zone)
	if zone == 'GunShop' or zone == 'BlackShop' then
		CurrentAction = 'shop_menu'
		CurrentActionMsg = _U('shop_menu_prompt')
		CurrentActionData = {zone = zone}
	end
end)

-- Exited Marker
AddEventHandler('esx_advancedweaponshop:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

-- Resource Stop
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if IsInShopMenu then
			ESX.UI.Menu.CloseAll()
		end
	end
end)

-- Create Blips
CreateThread(function()
	if Config.UseBlips then
		for k,v in pairs(Config.Zones) do
			if v.Legal then
				for i = 1, #v.Locations, 1 do
					local blip = AddBlipForCoord(v.Locations[i])

					SetBlipSprite (blip, 110)
					SetBlipDisplay(blip, 4)
					SetBlipScale  (blip, 1.0)
					SetBlipColour (blip, 81)
					SetBlipAsShortRange(blip, true)

					BeginTextCommandSetBlipName('STRING')
					AddTextComponentSubstringPlayerName(_U('map_blip'))
					EndTextCommandSetBlipName(blip)
				end
			end
		end
	end
end)

-- Display Markers
CreateThread(function()
	while true do
		Wait(0)
		local coords = GetEntityCoords(PlayerPedId())

		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Locations, 1 do
				if (Config.MarkerInfo.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Locations[i], true) < Config.DrawDistance) then
					DrawMarker(Config.MarkerInfo.Type, v.Locations[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerInfo.x, Config.MarkerInfo.y, Config.MarkerInfo.z, Config.MarkerInfo.r, Config.MarkerInfo.g, Config.MarkerInfo.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end
	end
end)

-- Enter / Exit marker events
CreateThread(function()
	while true do
		Wait(0)
		local coords = GetEntityCoords(PlayerPedId())
		local isInMarker, currentZone = false, nil

		for k,v in pairs(Config.Zones) do
			for i=1, #v.Locations, 1 do
				if GetDistanceBetweenCoords(coords, v.Locations[i], true) < Config.MarkerInfo.x then
					isInMarker, ShopMelee, ShopHandgun, ShopSMG, ShopShotgun, ShopAssault, ShopLMG, ShopSniper, currentZone, LastZone = true, v.Misc, v.Throw, v.Melee, v.Handgun, v.SMG, v.Shotgun, v.Assault, k, k
				end
			end
		end

		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('esx_advancedweaponshop:hasEnteredMarker', currentZone)
		end
		
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_advancedweaponshop:hasExitedMarker', LastZone)
		end
	end
end)

-- Key Controls
CreateThread(function()
	while true do
		Wait(0)

		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'shop_menu' then
					OpenMainMenu(CurrentActionData.zone)
				end

				CurrentAction = nil
			end
		end
	end
end)

function openESXAdvancedWeaponShop(type)
	OpenMainMenu(type)
end