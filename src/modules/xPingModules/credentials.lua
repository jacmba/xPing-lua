-- Credentials management module

local credentials = {}

local callsign = ""
local pilotLogon = ""

-- Load credentials from preferences file
function credentials.read_credentials()
	local creds = {
		NETWORK = "",
		VID = "",
		CALLSIGN = "",
		LOGON = ""
	}
	
	local config = io.open(SYSTEM_DIRECTORY .. "Output/preferences/xPing.prf", "r")
	if config == nil then
		return creds
	end
	
	io.input(config)
	local line = io.read()
	while line ~= nil do
		for k, v in string.gmatch(line, "(%w+)=(%w+)") do
		   creds[k] = v
		 end
		line = io.read()
	end
	
	config.close()
	
	credentials.set_credentials(creds)
end

-- Store credentials in preferences file
function credentials.save_credentials()
	local config = io.open(SYSTEM_DIRECTORY .. "Output/preferences/xPing.prf", "w")
	-- config:write("NETWORK=" .. network)
	-- config:write("\nVID=" .. pilotVid)
	config:write("CALLSIGN=" .. callsign)
	config:write("\nLOGON=" .. pilotLogon)
	config:close()
end

-- Credentials getter
function credentials.get_credentials()
	return {
		CALLSIGN = callsign,
		LOGON = pilotLogon
	}
end

-- Credentials setter
function credentials.set_credentials(creds)
	callsign = creds.CALLSIGN
	pilotLogon = creds.LOGON
end

return credentials