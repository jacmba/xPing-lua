-- Screen displaying the list of received messages

local messageScreen = {}

function messageScreen.show()
	imgui.TextUnformatted("RECEIVED MESSAGES")
	Utils.newLine()
	
	for i, msg in ipairs(App.messages) do
		local message = msg.message
		local title = message.title
		
		if not msg.read then
			title = "(*) " .. title
			Utils.setTextColor(UI_COLOR.BLUE)
		end
		
		if imgui.TreeNode(title) then
			-- Utils.unsetTextColor()
			imgui.TextUnformatted(message.content)
			
			if imgui.Button("Delete") then
				table.remove(App.messages, i)
			end
			
			imgui.TreePop()
			msg.read = true
		end
		Utils.unsetTextColor()
	end
	
	Utils.newLine(2)
	
	if imgui.Button("Back to menu") then
		App.goToMenu()
	end
end

return messageScreen