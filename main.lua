-- main.lua
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local localPlayer = Players.LocalPlayer
repeat task.wait() until localPlayer and localPlayer:FindFirstChild("PlayerGui")
local playerGui = localPlayer:WaitForChild("PlayerGui")

-- load config
local config = loadstring(game:HttpGet("https://raw.githubusercontent.com/zqiv/LogansCameraSuite/refs/heads/main/config.lua"))()

-- load all features
local loadedFeatures = {}

local function showNotification(text)
    local screenGui = Instance.new("ScreenGui")
    screenGui.IgnoreGuiInset = true
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(0, 400, 0, 30)
    textLabel.Position = UDim2.new(0.5, -200, 0.88, 0) 
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextTransparency = 1
    textLabel.TextStrokeTransparency = 1
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.Gotham
    textLabel.Text = text
    textLabel.Parent = screenGui

    local tweenInfo = TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    
    local fadeIn = TweenService:Create(textLabel, tweenInfo, {
        Position = UDim2.new(0.5, -200, 0.85, 0),
        TextTransparency = 0,
        TextStrokeTransparency = 0
    })

    local fadeOut = TweenService:Create(textLabel, tweenInfo, {
        Position = UDim2.new(0.5, -200, 0.88, 0),
        TextTransparency = 1,
        TextStrokeTransparency = 1
    })

    fadeIn:Play()
    
    task.delay(2, function()
        fadeOut:Play()
        fadeOut.Completed:Connect(function()
            screenGui:Destroy()
        end)
    end)
end

local function loadFeature(featurePath)
    print(featurePath .. " is loading")
    showNotification(featurePath .. " is loading")
    task.wait(0.5) -- small delay so notifications don't overlap too fast
    
    local success, feature = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/zqiv/LogansCameraSuite/refs/heads/main/" .. featurePath))()
    end)
    
    if success then
        return feature
    else
        warn("Failed to load feature: " .. featurePath)
        return nil
    end
end

-- load all features from config
for _, category in ipairs(config.categories) do
    for _, featureConfig in ipairs(category.features) do
        local feature = loadFeature(featureConfig.path)
        if feature then
            loadedFeatures[featureConfig.id] = {
                module = feature,
                config = featureConfig,
                active = false
            }
        end
    end
end

-- suite state
local suiteActive = false

-- toggle suite on/off
local function toggleSuite()
    suiteActive = not suiteActive
    
    if suiteActive then
        -- enable all enabled features
        for id, feature in pairs(loadedFeatures) do
            if feature.config.enabled and feature.module.enable then
                feature.module.enable()
                feature.active = true
            end
        end
    else
        -- disable all active features
        for id, feature in pairs(loadedFeatures) do
            if feature.active and feature.module.disable then
                feature.module.disable()
                feature.active = false
            end
        end
    end
end

-- bind toggle key
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == config.keybinds.toggle then
        toggleSuite()
    end
end)

-- final notifications
print("logan's camera suite (" .. config.version .. ") has loaded!")
showNotification("logan's camera suite (" .. config.version .. ") has loaded!")

task.wait(2.5)

print('press "Z" to activate')
showNotification('press "Z" to activate')