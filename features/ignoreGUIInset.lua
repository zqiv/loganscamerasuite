-- ensure ignoreguiinset
local function applyIgnoreInset(gui)
    if gui:IsA("ScreenGui") then
        gui.IgnoreGuiInset = true
    end
end

for _, gui in ipairs(playerGui:GetChildren()) do
    applyIgnoreInset(gui)
end
