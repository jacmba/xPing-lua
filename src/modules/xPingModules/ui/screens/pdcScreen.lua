-- Pre-departure Clearance Request screen

local acars = require "xPingModules/acars"

local pdcScreen = {}

local station = nil
local stand = ""
local atisVersion = ""
local freeText = ""

function pdcScreen.show()
	if station == nil then
		station = App.flightplan.orig
	end
	
	imgui.TextUnformatted("PRE-DEPARTURE CLEARANCE REQUEST - " .. App.callsign)
	Utils.newLine()
	
	local changed, newStation = imgui.InputTextWithHint("Station", "ZZZZ", station, 5)
	if changed then
		station = newStation:upper()
	end
	
	imgui.TextUnformatted("A/C")
	imgui.SameLine()
	imgui.TextUnformatted(PLANE_ICAO)
	
	imgui.TextUnformatted("To")
	imgui.SameLine()
	imgui.TextUnformatted(App.flightplan.dest)
	
	imgui.TextUnformatted("At")
	imgui.SameLine()
	imgui.TextUnformatted(App.flightplan.orig)
	
	local changed, newStand = imgui.InputTextWithHint("Stand", "XXX", stand, 5)
	if changed then
		stand = newStand:upper()
	end
	
	local changed, newAtis = imgui.InputTextWithHint("ATIS", "X", atisVersion, 2)
	if changed then
		atisVersion = newAtis:upper()
	end
	
	local changed, newText = imgui.InputTextMultiline("Free text (opt)", freeText, 50)
	if changed then
		freeText = newText
	end
	
	Utils.newLine()
	
	if imgui.Button("Send request") then
		local co = coroutine.create(acars.request_pdc)
		coroutine.resume(co, station, stand, atisVersion, freeText)
	end
	
	Utils.newLine(2)
	
	if imgui.Button("Return to requests") then
		App.goToRequests()
	end
end

return pdcScreen