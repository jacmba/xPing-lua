-- Successful login screen

local screen = {}

function screen.show()
	imgui.TextUnformatted("Successfully connected as " .. App.callsign .. "!")
	if imgui.Button("Continue") then
		App.status = STATUS.PREFLIGHT
	end
end

return screen