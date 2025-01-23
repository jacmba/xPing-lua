-- Screen displaying the list of received messages

local messageScreen = {}

function messageScreen.show()
	imgui.TextUnformatted("RECEIVED MESSAGES")
	if imgui.BeginChild("Received messages", 350, 200, true) then
		for _, msg in ipairs(App.messages) do
			local message = msg.message
			if imgui.TreeNode(message.title) then
				imgui.TextUnformatted(message.content)
			end
		end
		
		imgui.TextUnformatted("")
		imgui.TextUnformatted("")
	end
	
	imgui.EndChild()
	
	if imgui.Button("Back to menu") then
		App.goToMenu()
	end
end

return messageScreen