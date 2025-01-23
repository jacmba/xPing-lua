-- Hoppie API interface

module(..., package.seeall);

local request = require "xPingModules/luajit-request"

API_URL = "http://www.hoppie.nl/acars/system/connect.html"

local pilotLogon = "" -- logonCode

-- Sets pilot logon code for Hoppie messaging
function set_logon_code(code)
	pilotLogon = code
end

-- Send a message to Hoppie ACARS server
-- msgType: Message type [inforeq, progress, cpdlc, telex, ping, posreq, position, datareq, poll, peek]
-- from: Message sender (my callsign)
-- to: Destination station
function send_message(msgType, from, to, payload)	
	local resp = request.send(API_URL, {
		method = "POST",
		data = {
			logon = pilotLogon,
			from = from,
			to = to,
			type = msgType,
			packet = payload
		}
	})
	
	logMsg("Server response: [" .. resp.code .. "]: " .. resp.body)
	
	return resp.body, resp.code
end