require("reactor")

local reactor = get_reactor()

local max_coolant_threshold = 50
local max_waste_threshold = 50
local max_damage_threshold = 1

while true do
	reactor_dat = poll_reactor(reactor)
	
	if reactor_dat.coolant_filled_perc >= max_coolant_threshold then
		reactor.scram()
	end
	
	if reactor_dat.waste_filled_perc >= max_waste_threshold then
		reactor.scram()
	end
	
	if reactor_dat.damage_percent >= max_damage_threshold then
		reactor.scram()
	end
	
	sleep(1)
end