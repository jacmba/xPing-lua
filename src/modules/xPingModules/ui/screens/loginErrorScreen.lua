-- Login error screen

local screen = {}

function screen.show()
	imgui.TextUnformatted("Login error")
	imgui.TextUnformatted(errorMsg)
	if imgui.Button("Retry") then
		App.status = STATUS.OFFLINE
	end
end

return screen