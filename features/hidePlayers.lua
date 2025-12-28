local Players = game:GetService("Players")

local localPlayer = Players.LocalPlayer
local playerConnections = {}

local function setCharacterVisibility(character, visible)
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("Decal") then
            part.LocalTransparencyModifier = visible and 0 or 1
        elseif part:IsA("BillboardGui") or part:IsA("SurfaceGui") then
            -- hide nametags and healthbars
            part.Enabled = visible
        end
    end
end

local function hideAllPlayers()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            setCharacterVisibility(player.Character, false)
        end
    end
end

local function showAllPlayers()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character then
            setCharacterVisibility(player.Character, true)
        end
    end
end

return {
    enable = function()
        hideAllPlayers()
        
        -- handle new players and respawns
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer then
                playerConnections[player] = player.CharacterAdded:Connect(function(char)
                    task.wait(0.1)
                    setCharacterVisibility(char, false)
                end)
            end
        end
        
        playerConnections.playerAdded = Players.PlayerAdded:Connect(function(player)
            playerConnections[player] = player.CharacterAdded:Connect(function(char)
                task.wait(0.1)
                setCharacterVisibility(char, false)
            end)
        end)
    end,
    
    disable = function()
        showAllPlayers()
        
        -- disconnect all connections
        for _, connection in pairs(playerConnections) do
            if connection then
                connection:Disconnect()
            end
        end
        playerConnections = {}
    end
}
