-- User Interface main script

local loginScreen = require "xPingModules/ui/screens/login"
local preflightScreen = require "xPingModules/ui/screens/preflightScreen"
local loginErrorScreen = require "xPingModules/ui/screens/loginErrorScreen"
local connectingScreen = require "xPingModules/ui/screens/connectingScreen"
local loggedScreen = require "xPingModules/ui/screens/loggedScreen"
local menuScreen = require "xPingModules/ui/screens/menuScreen"
local requestsScreen = require "xPingModules/ui/screens/requestsScreen"
local metarScreen = require "xPingModules/ui/screens/metarScreen"
local messageScreen = require "xPingModules/ui/screens/messageScreen"

local ui = {
	showWindow = false,
	canShow = true,
	canClose = false,
	main_window
}

local screenMap = {
	[STATUS.OFFLINE] = loginScreen,
	[STATUS.PREFLIGHT] = preflightScreen,
	[STATUS.LOG_ERROR] = loginErrorScreen,
	[STATUS.LOGGED] = loggedScreen,
	[STATUS.LOGGING] = connectingScreen,
	[STATUS.MENU] = menuScreen,
	[STATUS.REQUESTS] = requestsScreen,
	[STATUS.METAR] = metarScreen,
	[STATUS.MESSAGE_LIST] = messageScreen
}

local errorMsg = ""

-- Create user interface
-- Params:
--  wnd: Parent window handler
function create_ui(wnd)
	local currentScreen = screenMap[App.status]
	currentScreen.show()
end

-- Handle window closing
local function close_window(wnd)
	showWindow = false
	canShow = true
	canClose = false
	logMsg("Main window closed")
end

-- Create main UI window
function ui.create_window()
	ui.main_window = float_wnd_create(400, 300, 1, true)
	float_wnd_set_title(ui.main_window, "xPing" .. XPING_VERSION)
	float_wnd_set_imgui_builder(ui.main_window, "create_ui")
	float_wnd_set_onclose(ui.main_window, "close_window")
end

return ui