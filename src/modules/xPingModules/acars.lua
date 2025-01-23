-- ACARS business logic functions

local api = require("xPingModules/hoppie-api")

local acars = {}

-- Connect to ACARS server
function acars.do_login(credentials, saveCredentialsFlag)
	api.set_logon_code(credentials.get_credentials().LOGON)
	local resp, code = api.send_message(
		MESSAGE_TYPE.PING,
		credentials.get_credentials().CALLSIGN,
		"SERVER",
		""
	)
	
	if code == "200" then
		if resp == "ok" then
			if saveCredentialsFlag then
				credentials.save_credentials()
			end
			
			App.callsign = credentials.get_credentials().CALLSIGN
			
			-- if network == NETWORK.VATSIM then
				-- check_vatsim()
			-- end
			App.status = STATUS.LOGGED
		else
			local i = string.find(resp, "{") + 1
			local j = string.find(resp, "}") - 1
			errorMsg = string.sub(resp, i, j)
			errorMsg = string.upper(errorMsg)
			status = STATUS.LOG_ERROR
		end
	else
		errorMsg = "Server error. Check your connection and try again"
		App.status = STATUS.LOG_ERROR
	end
	
	coroutine.yield()
end

return acars