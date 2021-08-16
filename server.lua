RegisterServerEvent('lp_roulette:removemoney')
AddEventHandler('lp_roulette:removemoney', function(amount)
	local _amount = amount
	local _source = source

	TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		local userMoney = user.getMoney()
		user.removeMoney(_amount)
	end)
end)

RegisterServerEvent('lp_roulette:givemoney')
AddEventHandler('lp_roulette:givemoney', function(action, amount)
	local action = action
	local _amount = amount
	local _source = source

	TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		local userMoney = user.getMoney()
		--user.removeMoney(_amount)
		user.addMoney(_amount)
		--[[ if action == 'black' or action == 'red' then
			user.addMoney(_amount)
			--TriggerEvent("vorp:addMoney", source, 0, win)
		elseif action == 'green' then
			--TriggerEvent("vorp:addMoney", source, 0, win)
		end ]]
	end)

end)

RegisterServerEvent('lp_roulette:checkmoney')
AddEventHandler('lp_roulette:checkmoney', function()
	local _source = source

	TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
		local userMoney = user.getMoney()
		--print('ROULETTE MONEY CHECK ' .. userMoney)
		TriggerClientEvent('lp_roulette:start', _source, userMoney)
	end)
end)
