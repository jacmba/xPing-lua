-- Main menu screen

local menu = {}

function menu.show()
	imgui.TextUnformatted(App.callsign .. " - ACARS MENU")
	imgui.TextUnformatted("")
	
	if imgui.Button("Requests") then
		App.goToRequests()
	end
	
	imgui.TextUnformatted("")
	imgui.TextUnformatted("")
	if imgui.Button("Received messages") then
		App.goToMessages()
	end
end

return menu