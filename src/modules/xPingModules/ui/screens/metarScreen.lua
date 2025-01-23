-- METAR request screen

local acars = require "xPingModules/acars"

local metarScreen = {}

local METAR_OPTION = {
	ORIG = 1,
	DEST = 2,
	CUST = 3
}

local selection = METAR_OPTION.ORIG
local customStation = ""
local station = ""

function metarScreen.show()
	imgui.TextUnformatted("Request metar")
	imgui.TextUnformatted("")
	
	if not station or #station == 0 then
		station = App.flightplan.orig
	end
	
	-- Metar for origin
	if imgui.RadioButton(App.flightplan.orig, selection == METAR_OPTION.ORIG) then
		selection = METAR_OPTION.ORIG
		station = App.flightplan.orig
	end
	
	imgui.SameLine()
	
	-- Metar for destination
	if imgui.RadioButton(App.flightplan.dest, selection == METAR_OPTION.DEST) then
		selection = METAR_OPTION.DEST
		station = App.flightplan.dest
	end
	
	imgui.SameLine()
	
	-- Metar for custom station
	if imgui.RadioButton("Other", selection == METAR_OPTION.CUST) then
		selection = METAR_OPTION.CUST
		station = customStation
	end
	
	-- Input for custom METAR station
	if selection == METAR_OPTION.CUST then
		local changed, newStation = imgui.InputTextWithHint("Enter station", "ZZZZ", customStation, 5)
		if changed then
			customStation = newStation
			station = customStation
		end
	end
	
	imgui.TextUnformatted("")
	imgui.TextUnformatted("")
	if imgui.Button("Request METAR") then
		imgui.TextUnformatted("Sending request...")
		local co = coroutine.create(acars.request_metar)
		coroutine.resume(co, station)
	end
	
	imgui.TextUnformatted("")
	imgui.TextUnformatted("")
	if imgui.Button("Return to requests menu") then
		App.goToRequests()
	end
end

return metarScreen