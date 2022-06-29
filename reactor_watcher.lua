require("reactor")

local reactor = get_reactor()

local min_coolant_threshold = 0.5
local max_heated_coolant_threshold = 0.5
local max_waste_threshold = 0.5
local max_damage_threshold = 0.1

while true do
	local reactor_dat = poll_reactor(reactor)
	
	print("====")
	print(os.date())
	print("====")
	if reactor_dat.coolant_filled_perc <= min_coolant_threshold then
		print(string.format("Reactor coolant too high (%f%%), SCRAM!", reactor_dat.coolant_filled_perc))
		reactor.scram()
	else
		print(string.format("Coolant nominal. %f%%", reactor_dat.coolant_filled_perc))
	end
	
	if reactor_dat.heated_coolant_filled_perc >= max_heated_coolant_threshold then
		print(string.format("Heated reactor coolant too high (%f%%), SCRAM!", reactor_dat.heated_coolant_filled_perc))
		reactor.scram()
	else
		print(string.format("Heated coolant nominal. %f%%", reactor_dat.heated_coolant_filled_perc))
	end
	
	if reactor_dat.waste_filled_perc >= max_waste_threshold then
		print(string.format("Waste too high (%f%%), SCRAM!", reactor_dat.waste_filled_perc))
		reactor.scram()
	else
		print(string.format("Waste nominal. %f%%", reactor_dat.waste_filled_perc))
	end
	
	if reactor_dat.damage_percent >= max_damage_threshold then
		print(string.format("Damage too high (%f%%), SCRAM!", reactor_dat.damage_percent))
		reactor.scram()
	else
		print(string.format("Damage nominal. %f%%", reactor_dat.damage_percent))
	end
	print("====")
	
	sleep(1)
end