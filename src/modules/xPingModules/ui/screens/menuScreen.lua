-- Main menu screen

local menu = {}

function menu.show()
	imgui.TextUnformatted(App.callsign .. " - ACARS MENU")
	Utils.newLine()
	
	if imgui.Button("Requests") then
		App.goToRequests()
	end
	
	Utils.newLine()
	local msgsTitle = "Received messages"
	if App.hasPendingMsgs() then
		msgsTitle = "(*) " .. msgsTitle
	end
	if imgui.Button(msgsTitle) then
		App.goToMessages()
	end
end

return menu