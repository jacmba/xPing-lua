-- Display login window

local acars = require "xPingModules/acars"
local credentials = require "xPingModules/credentials"

local loginScreen = {}

local saveCredentialsFlag = true
local myCredentials = credentials.get_credentials()

function loginScreen.show()
	imgui.TextUnformatted("Enter your CPDLC credentials")
	
	-- Network selection
	-- imgui.TextUnformatted("")
	-- imgui.TextUnformatted("Network")
	
	-- if imgui.RadioButton(NETWORK.IVAO, network == NETWORK.IVAO) then
		-- network = NETWORK.IVAO
		-- logMsg("Selected network: IVAO")
	-- end
	
	-- imgui.SameLine()
	
	-- if imgui.RadioButton(NETWORK.VATSIM, network == NETWORK.VATSIM) then
		-- network = NETWORK.VATSIM
		-- logMsg("Selected network: VATSIM")
	-- end
	
	-- Pilot id input
	-- imgui.TextUnformatted("")	
	-- local changed, newVid = imgui.InputTextWithHint("Network VID", "My " .. network .. " Virtual ID", pilotVid, 100)
	
	-- if changed then
		-- pilotVid = newVid
	-- end
	
	-- Pilot callsign
	-- imgui.TextUnformatted("")	
	local changed, newCallsign = imgui.InputTextWithHint("Call sign", "My ATC radio callsign", myCredentials.CALLSIGN, 20)
	
	if changed then
		myCredentials.CALLSIGN = newCallsign
	end
	
	-- Pilot Hoppie logon secret
	imgui.TextUnformatted("")
	local changed, newLogon = imgui.InputTextWithHint("Hoppie logon", "My Hoppie ACARS logon secret", myCredentials.LOGON, 100)
	
	if changed then
		myCredentials.LOGON = newLogon
	end
	
	-- Save credentials check
	imgui.TextUnformatted("")
	local changed, newSaveCredentials = imgui.Checkbox("Save credentials", saveCredentialsFlag)
	
	if changed then
		saveCredentialsFlag = newSaveCredentials
	end
	
	-- Confirm login!
	imgui.TextUnformatted("")
	if imgui.Button("Connect") then
		App.status = STATUS.LOGGING
		local co = coroutine.create(acars.do_login)
		coroutine.resume(co, credentials, saveCredentialsFlag)
	end
end

credentials.read_credentials()
myCredentials = credentials.get_credentials()

return loginScreen