-- config.lua
return {
    version = "b0.1",
    
    categories = {
        {
            id = "visibility",
            name = "Visibility",
            features = {
                {
                    id = "hidePlayers",
                    name = "Hide Players",
                    description = "Hides other players and their characters",
                    path = "features/hidePlayers.lua",
                    enabled = true
                },
                {
                    id = "hideBillboards",
                    name = "Hide Billboards",
                    description = "Hides overhead name tags",
                    path = "features/hideBillboards.lua",
                    enabled = true
                },
                {
                    id = "hideChatBubbles",
                    name = "Hide Chat Bubbles",
                    description = "Hides chat bubbles above players",
                    path = "features/hideChatBubbles.lua",
                    enabled = true
                }
            }
        },
        {
            id = "ui",
            name = "UI",
            features = {
                {
                    id = "hideUI",
                    name = "Hide Screen GUIs",
                    description = "Hides all screen GUIs",
                    path = "features/hideUI.lua",
                    enabled = true
                },
                {
                    id = "ignoreGuiInset",
                    name = "Ignore GUI Inset",
                    description = "Makes all ScreenGuis fullscreen by ignoring safe area insets",
                    path = "features/ignoreGuiInset.lua",
                    enabled = true
                }
            }
        },
        {
            id = "camera",
            name = "Camera",
            features = {
                {
                    id = "freecam",
                    name = "Freecam",
                    description = "Enables free camera movement",
                    path = "features/freecam.lua",
                    enabled = true
                }
            }
        }
    },
    
    keybinds = {
        toggle = Enum.KeyCode.Z,
        menu = Enum.KeyCode.RightShift
    }
}