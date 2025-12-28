local Workspace = game:GetService("Workspace")

local HIDE_BILLBOARD_NAMES = {"PlayerName", "NameTagTemplate", "NameTag"}

local function setBillboardsState(state)
    for _, desc in ipairs(Workspace:GetDescendants()) do
        if desc:IsA("BillboardGui") and table.find(HIDE_BILLBOARD_NAMES, desc.Name) then
            desc.Enabled = state
        end
    end
end

return {
    enable = function()
        setBillboardsState(false)
    end,
    
    disable = function()
        setBillboardsState(true)
    end
}
