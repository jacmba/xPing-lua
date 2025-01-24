-- Application global variables

local acars = require "xPingModules/acars"

App = {
	status = STATUS.OFFLINE,
	netWork = NETWORK.VATSIM,
	callsign = "",
	errorMsg = "",
	
	-- List of received messages
	messages = {},
	
	-- Flightplan info
	flightplan = {
		orig = "",
		dest = "",
		etd = "",
		eta = ""
	},
	
	-- Polling timer
	lastPoll = 0
}

local POLLING_TIME = 4

-- Navigation functions

function App.goToMenu()
	App.status = STATUS.MENU
end

function App.goToRequests()
	App.status = STATUS.REQUESTS
end

function App.goToMetar()
	App.status = STATUS.METAR
end

function App.goToAtis()
	App.status = STATUS.ATIS
end

function App.goToPdc()
	App.status = STATUS.PDC
end

function App.goToMessages()
	App.status = STATUS.MESSAGE_LIST
end

-- Another util App functions

function App.hasPendingMsgs()
	for _, msg in ipairs(App.messages) do
		if not msg.read then
			return true
		end
	end
	return false
end

function App.runPolling()
	if App.status <= STATUS.PREFLIGHT or os.clock() - App.lastPoll < POLLING_TIME then
		return
	end
	App.lastPoll = os.clock()
	logMsg("Polling every " .. POLLING_TIME .. " seconds... " .. tostring(App.lastPoll))
	
	local co = coroutine.create(acars.get_messages)
	coroutine.resume(co)
end