-- Application global variables

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
	}
}

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

function App.goToMessages()
	App.status = STATUS.MESSAGE_LIST
end