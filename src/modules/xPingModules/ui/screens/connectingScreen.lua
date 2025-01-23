-- ACARS server connecting screen

local connectingScreen = {}

function connectingScreen.show()
	imgui.TextUnformatted("Connecting to server...")
end

return connectingScreen