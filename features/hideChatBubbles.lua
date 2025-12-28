local TextChatService = game:GetService("TextChatService")

local function setChatBubblesState(state)
    for _, bubble in ipairs(TextChatService:GetChildren()) do
        if bubble:IsA("TextChatWindow") then
            bubble.Enabled = state
        end
    end
end

return {
    enable = function()
        setChatBubblesState(false)
    end,
    
    disable = function()
        setChatBubblesState(true)
    end
}