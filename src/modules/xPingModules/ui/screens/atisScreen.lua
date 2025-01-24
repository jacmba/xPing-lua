-- ATIS request screen

local acars = require "xPingModules/acars"

local atisScreen = {}

local ATIS_OPTION = {
	ORIG = 1,
	DEST = 2,
	CUST = 3
}

local selection = ATIS_OPTION.ORIG
local customStation = ""
local station = ""

function atisScreen.show()
	imgui.TextUnformatted("Request ATIS")
	Utils.newLine()
	
	if not station or #station == 0 then
		station = App.flightplan.orig
	end
	
	-- ATIS for origin
	if imgui.RadioButton(App.flightplan.orig, selection == ATIS_OPTION.ORIG) then
		selection = ATIS_OPTION.ORIG
		station = App.flightplan.orig
	end
	
	imgui.SameLine()
	
	-- ATIS for destination
	if imgui.RadioButton(App.flightplan.dest, selection == ATIS_OPTION.DEST) then
		selection = ATIS_OPTION.DEST
		station = App.flightplan.dest
	end
	
	imgui.SameLine()
	
	-- ATIS for custom station
	if imgui.RadioButton("Other", selection == ATIS_OPTION.CUST) then
		selection = ATIS_OPTION.CUST
		station = customStation
	end
	
	-- Input for custom ATIS station
	if selection == ATIS_OPTION.CUST then
		local changed, newStation = imgui.InputTextWithHint("Enter station", "ZZZZ", customStation, 7)
		if changed then
			customStation = newStation:upper()
			station = customStation
		end
	end
	
	Utils.newLine()
	if imgui.Button("Send request") then
		imgui.TextUnformatted("Sending request...")
		local co = coroutine.create(acars.request_atis)
		coroutine.resume(co, station)
	end
	
	Utils.newLine(2)
	if imgui.Button("Return to requests menu") then
		App.goToRequests()
	end
end

return atisScreen