-- main toggle function
function toggleUI()
    uiHidden = not uiHidden
    toggleOtherPlayers(not uiHidden)
    toggleActiveGUIs(not uiHidden)
    toggleBillboards(not uiHidden)
    toggleChatBubbles(not uiHidden)
end

-- bind z key to toggle ui
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Z then
        toggleUI()
    end
end)