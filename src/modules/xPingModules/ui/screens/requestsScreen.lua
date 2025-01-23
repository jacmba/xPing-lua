-- Requests menu screen

local requests = {}

function requests.show()
	imgui.TextUnformatted("Requests menu")
	imgui.TextUnformatted("")
	
	if imgui.Button("METAR") then
		App.goToMetar()
	end
	
	imgui.TextUnformatted("")
	imgui.TextUnformatted("")
	
	if imgui.Button("Return to main menu") then
		App.goToMenu()
	end
end

return requests