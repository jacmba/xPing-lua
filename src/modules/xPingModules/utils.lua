-- Utility functions

Utils = {}

local popped = false

-- Insert a new line in the UI
-- n: Number of lines to insert (default = 1)
function Utils.newLine(n)
	local lines = n or 1
	for i = 1, lines do
		imgui.TextUnformatted("")
	end
end

-- Set UI text color
-- col: Color value
function Utils.setTextColor(col)
	imgui.PushStyleColor(imgui.constant.Col.Text, col)
	popped = true
end

-- Stop UI text color change
function Utils.unsetTextColor()
	if popped then
		imgui.PopStyleColor()
		popped = false
	end
end