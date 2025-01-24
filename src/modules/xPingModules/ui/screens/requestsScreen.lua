-- Requests menu screen

local requests = {}

function requests.show()
	imgui.TextUnformatted("Requests menu")
	Utils.newLine()
	
	if imgui.Button("PDC") then
		App.goToPdc()
	end
	
	if imgui.Button("METAR") then
		App.goToMetar()
	end
	
	if imgui.Button("ATIS") then
		App.goToAtis()
	end
	
	Utils.newLine(2)
	
	if imgui.Button("Return to main menu") then
		App.goToMenu()
	end
end

return requests