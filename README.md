# addz_redemrp_roulette
Roulette script for REDM (Redemrp framework)

This Script is converted from VORP lp_roulette. Courtesy to LetsPatrick#5417

How to use?

Since this resource is using NUI, is it advisable not to change the resource name since it will break unless you know what to do.

1. Please remove '-main' in the resource name. leave it as addz_redemrp_roulette
2. add ensure addz_redemrp_roulette in server.cfg
3. Enjoy

Right now the location is hardcoded, you can change the location here 

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

Change '3290.734, -1309.692, 43.696' to any x,y,z
