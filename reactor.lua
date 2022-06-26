function poll_reactor(reactor)
    return {
        coolant_capacity = reactor.getCoolantCapacity(),
        coolant_needed = reactor.getCoolantNeeded(),
        coolant_filled_perc = reactor.getCoolantFilledPercentage(),
        fuel = reactor.getFuel(),
        fuel_capaciy = reactor.getFuelCapacity(),
        fuel_needed = reactor.getFuelNeeded(),
        fuel_filled_perc = reactor.getFuelFilledPercentage(),
        waste = reactor.getWaste(),
        waste_capacity = reactor.getWasteCapacity(),
        waste_filled_perc = reactor.getWasteFilledPercentage(),
        active = reactor.getStatus(),
        burn_rate = reactor.getBurnRate(),
        actual_burn_rate = reactor.getActualBurnRate(),
        max_burn_rate = reactor.getMaxBurnRate(),
        damage_percent = reactor.getDamagePercent(),
        heating_rate = reactor.getHeatingRate(),
        environmental_loss = reactor.getEnvironmentalLoss(),
        temp = reactor.getTemperature(),
        max_temp = reactor.getHeatCapacity()
    }
end