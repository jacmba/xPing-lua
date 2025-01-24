-- ACARS business logic functions

local api = require("xPingModules/hoppie-api")

local acars = {}

-- Connect to ACARS server
function acars.do_login(credentials, saveCredentialsFlag)	
	api.set_logon_code(credentials.get_credentials().LOGON)
	local resp, code = api.send_message(
		MESSAGE_TYPE.PING,
		credentials.get_credentials().CALLSIGN,
		SERVER,
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
			local errorMsg = string.sub(resp, i, j)
			App.errorMsg = string.upper(errorMsg)
			App.status = STATUS.LOG_ERROR
		end
	else
		App.errorMsg = "Server error. Check your connection and try again"
		App.status = STATUS.LOG_ERROR
	end
	
	coroutine.yield()
end

-- Request METAR
function acars.request_metar(station)	
	local resp, code = api.send_message(
		MESSAGE_TYPE.INFOREQ,
		App.callsign,
		SERVER,
		"Metar " .. station
	)
	
	if code == "200" then
		local prefix = "{acars info {"
		local i = string.find(resp, prefix) + #prefix
		local j = string.find(resp, "}}") - 1
		local parsedResponse = string.sub(resp, i, j)
		acars.receive_message({
			title = "Metar from " .. station,
			content = parsedResponse
		})
	end
	
	coroutine.yield()
end

-- Request ATIS
function acars.request_atis(station)	
	local resp, code = api.send_message(
		MESSAGE_TYPE.INFOREQ,
		App.callsign,
		SERVER,
		"VATATIS " .. station
	)
	
	if code == "200" then
		local prefix = "{acars info {"
		local i = string.find(resp, prefix) + #prefix
		local j = string.find(resp, "}}") - 1
		local parsedResponse = string.sub(resp, i, j)
		acars.receive_message({
			title = "ATIS from " .. station,
			content = parsedResponse
		})
	end
	
	coroutine.yield()
end

-- Request PDC
function acars.request_pdc(station, stand, atisVersion, freeText)
	local requestMsg = 
		"REQUEST PREDEP CLEARANCE " ..
		App.callsign ..
		" " ..
		PLANE_ICAO ..
		" TO " ..
		App.flightplan.dest ..
		" AT " ..
		App.flightplan.orig ..
		" STAND " ..
		stand ..
		" ATIS " ..
		atisVersion
		
	if #freeText > 0 then
		requestMsg = requestMsg .. " " .. freeText
	end
	
	local resp, code = api.send_message(
		MESSAGE_TYPE.TELEX,
		App.callsign,
		station,
		requestMsg
	)
	
	coroutine.yield()
end

-- Get pending messages
function acars.get_messages()
	local resp, code = api.send_message(
		MESSAGE_TYPE.POLL,
		App.callsign,
		SERVER,
		""
	)
	
	if code == "200" then
		result, messages = Utils.parseResponse(resp)
		
		if result == "ok" then
			for _, msg in ipairs(messages) do
				acars.receive_message(msg)
			end
		end
	end
	
	coroutine.yield()
end

-- Add received message to the list
function acars.receive_message(msg)
	table.insert(App.messages, 1, {
		read = false,
		message = msg
	})
	
	logMsg("[Inserted received message] " .. msg.title .. ": " .. msg.content)
end

return acars