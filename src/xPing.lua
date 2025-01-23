------------------------------------------------------
-- xPing
-- Script to provide Hoppie CPDLC/ACARS functionality
-- Author: Jacinto Mba Cantero
------------------------------------------------------

require "xPingModules/const"
require "xPingModules/app"

local ui = require "xPingModules/ui"

logMsg("Started xPing version " .. XPING_VERSION)

-- Show or hide the main UI window
function toggle_window()
	ui.showWindow = not ui.showWindow
	
	if ui.showWindow and ui.canShow then
		ui.create_window()
		ui.canShow = false
		ui.canClose = true
	elseif ui.main_window and ui.canClose then
		float_wnd_destroy(ui.main_window)
		ui.canClose = false
		ui.canShow = true
	end
end

create_command("Jazbelt/xPing/ToggleWindow", "Show or hide xPing ACARS window", "toggle_window()", "", "")