require("reactor")

local reactor = get_reactor()

local max_coolant_threshold = 50
local max_waste_threshold = 50
local max_damage_threshold = 1

while true do
	reactor_dat = poll_reactor(reactor)
	
	print("====")
	if reactor_dat.coolant_filled_perc >= max_coolant_threshold then
		print(string.format("Reactor coolant too high (%d%%), SCRAM!", reactor_dat.coolant_filled_perc))
		reactor.scram()
	else
		print("Coolant nominal.")
	end
	
	if reactor_dat.waste_filled_perc >= max_waste_threshold then
		print(string.format("Waste too high (%d%%), SCRAM!", reactor_dat.waste_filled_perc))
		reactor.scram()
	else
		print("Waste nominal.")
	end
	
	if reactor_dat.damage_percent >= max_damage_threshold then
		print(string.format("Damage too high (%d%%), SCRAM!", reactor_dat.damage_percent))
		reactor.scram()
	else
		print("Damage nominal.")
	end
	print("====")
	
	sleep(1)
end