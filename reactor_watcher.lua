require("reactor")

function scram(reactor)
	if reactor.getStatus() then
		reactor.scram()
	end
end

local min_coolant_threshold = 0.9
local max_heated_coolant_threshold = 0.5
local max_waste_threshold = 0.5
local max_damage_threshold = 0.1

while true do
	local reactor = get_reactor()
	local reactor_dat = poll_reactor(reactor)
	
	local danger = false
	
	print("====")
	print(os.date())
	print("====")
	if reactor_dat.coolant_filled_perc <= min_coolant_threshold then
		print(string.format("Reactor coolant too high (%.2f%%), SCRAM!", reactor_dat.coolant_filled_perc * 100))
		scram(reactor)
		danger = true
	else
		print(string.format("Coolant nominal. %.2f%%", reactor_dat.coolant_filled_perc * 100))
	end
	
	if reactor_dat.heated_coolant_filled_perc >= max_heated_coolant_threshold then
		print(string.format("Heated reactor coolant too high (%.2f%%), SCRAM!", reactor_dat.heated_coolant_filled_perc * 100))
		scram(reactor)
		danger = true
	else
		print(string.format("Heated coolant nominal. %.2f%%", reactor_dat.heated_coolant_filled_perc * 100))
	end
	
	if reactor_dat.waste_filled_perc >= max_waste_threshold then
		print(string.format("Waste too high (%.2f%%), SCRAM!", reactor_dat.waste_filled_perc * 100))
		scram(reactor)
		danger = true
	else
		print(string.format("Waste nominal. %.2f%%", reactor_dat.waste_filled_perc * 100))
	end
	
	if reactor_dat.damage_percent >= max_damage_threshold then
		print(string.format("Damage too high (%.2f%%), SCRAM!", reactor_dat.damage_percent * 100))
		scram(reactor)
		danger = true
	else
		print(string.format("Damage nominal. %.2f%%", reactor_dat.damage_percent * 100))
	end
	print("====")
	
	sleep(1)
end