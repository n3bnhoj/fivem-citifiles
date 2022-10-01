
Citizen.CreateThread(function()
	while true do
	    Citizen.Wait(0)
	    SetVehicleDensityMultiplierThisFrame(Config.VehicleMultiplier)
	    SetPedDensityMultiplierThisFrame(Config.PedDensityMultiplier)
	    SetRandomVehicleDensityMultiplierThisFrame(Config.RandomVehicleMultiplier)
	    SetParkedVehicleDensityMultiplierThisFrame(Config.ParkVehicleMultiplier)
	    SetScenarioPedDensityMultiplierThisFrame(Config.ScenarioMultiplier, Config.ScenarioMultiplier)
	end
end)