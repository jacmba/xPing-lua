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

-- Parse server response
function Utils.parseResponse(resp)
	local msgList = {}
	local buffer = ""
	local result = ""
	local header = ""
	
	for i = 1, #resp do
		local currentChar = string.sub(resp, i, i)
		if currentChar == "{" then
			if result == ""  and buffer ~= " " then
				result = string.sub(buffer, 0, #buffer - 1)
			elseif header == "" and buffer ~= " " then
				header = string.sub(buffer, 0, #buffer - 1)
			end
			buffer = ""
		elseif currentChar == "}" then
			if buffer ~= "" and header ~= "" then
				table.insert(msgList, {
					title = header,
					content = buffer
				})
				logMsg("Received msg: [" .. header .. "] " .. buffer)
				
				header = ""
			end
			
			buffer = ""
		else
			buffer = buffer .. currentChar
		end
	end
	
	if result == "" then
		result = buffer
	end
	
	return result, msgList
end