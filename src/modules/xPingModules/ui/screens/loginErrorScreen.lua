-- Login error screen

local screen = {}

function screen.show()
	imgui.TextUnformatted("Login error")
	imgui.TextUnformatted(App.errorMsg)
	if imgui.Button("Retry") then
		App.status = STATUS.OFFLINE
	end
end

return screen