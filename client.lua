local game_during = false
local elements = {}
local ingame = false
local chip = 0

RegisterNetEvent('lp_roulette:start')
AddEventHandler('lp_roulette:start', function(money)
	local chip = money
	Citizen.Trace('RULET CHIP ' .. chip)
	if chip >= 10 then
		Citizen.Trace('START GAME')
		SendNUIMessage({
			type = "show_table",
			zetony = chip
		})
		ingame = true
		SetNuiFocus(true, true)
	else
		--exports.NotyFive:SendNotification({text = "This is a test", type = "success", timeout = 7500})
		TriggerEvent('redem_roleplay:Tip', 'You need at least 10 chips to play!', 5000)

		SendNUIMessage({

			type = "reset_bet"
		})
	end
end)

RegisterNUICallback('exit', function(data, cb)
	
	SetNuiFocus(false, false)
        ingame = false
	cb('ok')
end)

RegisterNUICallback('betup', function(data, cb)
	
	TriggerServerEvent('InteractSound_SV:PlayOnSource', 'betup', 1.0)
    TriggerServerEvent('InteractSound_SV:PlayOnAll', 'demo', 1.0)
	cb('ok')
end)

RegisterNUICallback('roll', function(data, cb)
	TriggerEvent('lp_roulette:start_game', data.kolor, data.kwota)
	cb('ok')
end)

RegisterNetEvent('lp_roulette:start_game')
AddEventHandler('lp_roulette:start_game', function(action, amount)
        TriggerServerEvent('InteractSound_SV:PlayOnAll', 'demo', 1.0)
	local amount = amount
	if game_during == false then
		TriggerServerEvent('lp_roulette:removemoney', amount)
		local kolorBetu = action
		--TriggerEvent("vorp:TipBottom", "You have bet "..amount.." chips on "..kolorBetu..". The wheel is spinning...", 2500) -- from client side
		TriggerEvent('redem_roleplay:Tip', "You have bet "..amount.." chips on "..kolorBetu..". The wheel is spinning...", 5000)
		game_during = true
		local randomNumber = math.floor(math.random() * 36)
		--local randomNumber = 0
		SendNUIMessage({
			type = "show_roulette",
			hwButton = randomNumber
		})
		TriggerServerEvent('InteractSound_SV:PlayOnSource', 'ruletka', 1.0)
		Citizen.Wait(10000)
		local red = {32,19,21,25,34,27,36,30,23,5,16,1,14,9,18,7,12,3};
		local black = {15,4,2,17,6,13,11,8,10,24,33,20,31,22,29,28,35,26};
		local function has_value (tab, val)
			for index, value in ipairs(tab) do
				if value == val then
					return true
				end
			end
			return false
		end
		if action == 'black' then
			local win = amount * 2
			if has_value(black, randomNumber) then
				SendNUIMessage({type = 'hide_roulette'})
				SetNuiFocus(false, false)
			        ingame = false
				TriggerEvent('redem_roleplay:Tip', "Black wins! "..win.." Dollar!", 5000)
				TriggerServerEvent('lp_roulette:givemoney', action, win )
			else				
				SendNUIMessage({type = 'hide_roulette'})
				SetNuiFocus(false, false)
			    ingame = false
				TriggerEvent('redem_roleplay:Tip', "Unfortunately next to it. Try it again!", 5000)
				--TriggerEvent("vorp:TipBottom", "Leider daneben. Versuchen sie es erneut!", 2500) -- from client side
			end
		elseif action == 'red' then
			local win = amount * 2
			if has_value(red, randomNumber) then
				SendNUIMessage({type = 'hide_roulette'})
				SetNuiFocus(false, false)
			        ingame = false
				TriggerEvent('redem_roleplay:Tip', "Red wins! "..win.." Dollar!", 5000)
				--TriggerEvent("vorp:TipBottom", "Rot gewinnt! "..won.." Dollar!", 2500) -- from client side
				TriggerServerEvent('lp_roulette:givemoney', action, win )
			else
				SendNUIMessage({type = 'hide_roulette'})
				SetNuiFocus(false, false)
			        ingame = false
				TriggerEvent('redem_roleplay:Tip', "Unfortunately next to it. Try it again!", 5000)
				--TriggerEvent("vorp:TipBottom", "Leider daneben. Versuchen sie es erneut!", 2500) -- from client side
			end
		elseif action == 'green' then
			local win = amount * 14
			if randomNumber == 0 then
				SendNUIMessage({type = 'hide_roulette'})
				SetNuiFocus(false, false)
			        ingame = false
				TriggerEvent('redem_roleplay:Tip', "green! "..win.." Dollar!", 5000)
				TriggerServerEvent('lp_roulette:givemoney', action, win )
			else
				SendNUIMessage({type = 'hide_roulette'})
				SetNuiFocus(false, false)
			        ingame = false
				TriggerEvent('redem_roleplay:Tip', "Unfortunately next to it. Try it again!", 5000)

			end
		end

		SendNUIMessage({type = 'hide_roulette'})
		SetNuiFocus(false, false)
		ingame = false
		game_during = false
		--TriggerEvent('lp_roulette:start')
	else
		TriggerEvent('redem_roleplay:Tip', "The wheel is turning ...", 5000)

	end
end)

Citizen.CreateThread(function()

	while true do
      	local ped = GetPlayerPed(-1)
      	local coords = GetEntityCoords(PlayerPedId())

       	if not ingame and (Vdist(coords.x, coords.y, coords.z, 3290.734, -1309.692, 43.696) < 1.8) then
            TriggerEvent("lp_roulette:anzeige")
            if IsControlJustReleased(0,0xD9D0E1C0) then
				--Citizen.Trace('CHECK YOUR MONEY!')
				TriggerServerEvent('lp_roulette:checkmoney')
            end
		end
	Citizen.Wait(0)
	end
end)


RegisterNetEvent('lp_roulette:anzeige')
  AddEventHandler('lp_roulette:anzeige', function()
	local str = "Press [SPACEBAR] to play"
    --DrawTxt(str, 0.50, 0.95, 0.7, 0.5, true, 255, 255, 255, 255, true)

    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
  end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    SetTextFontForCurrentCommand(15) 
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    DisplayText(str, x, y)
end
