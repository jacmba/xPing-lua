-- Vatsim specific functions

-- ToDo check VATSIM pilot info and flightplan validation
function check()
	local url = "http://data.vatsim.net/v3/vatsim-data.json"
	local resp = request.send(url)
	
	local data = json.decode(resp.body)
	local myPilot = nil
	for i, p in ipairs(data.pilots) do
		if p.cid == pilotVid then
			myPilot = p
		end
	end
	logMsg("My pilot: " .. json.encode(firstPilot))
end