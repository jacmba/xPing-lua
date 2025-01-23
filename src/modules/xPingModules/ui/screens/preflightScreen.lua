-- Preflight screen display

local preflight = {}

function preflight.show()
	imgui.TextUnformatted("PREFLIGHT")
	imgui.TextUnformatted("")
	
	-- Origin airport
	local changed, newOrig = imgui.InputTextWithHint("From", "ZZZZ", App.flightplan.orig, 5)
	if changed then
		App.flightplan.orig = newOrig:upper()
	end
	
	-- Destination airport
	local changed, newDest = imgui.InputTextWithHint("To", "ZZZZ", App.flightplan.dest, 5)
	if changed then
		App.flightplan.dest = newDest:upper()
	end
	
	-- Departure time
	local changed, newEtd = imgui.InputTextWithHint("ETD", "hhmm", App.flightplan.etd, 5)
	if changed then
		App.flightplan.etd = newEtd
	end
	
	-- Arrival time
	local changed, newEta = imgui.InputTextWithHint("ETA", "hhmm", App.flightplan.eta, 5)
	if changed then
		App.flightplan.eta = newEta
	end
	
	if imgui.Button("OK") then
		App.goToMenu()
	end
end

return preflight