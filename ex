--[[
    COHOES UI LIBRARY - EXAMPLE USAGE
    
    Load the library first, then use it to create your UI
]]

-- Load the library (replace URL with your raw GitHub/Pastebin URL)
local Cohoes = loadstring(game:HttpGet("YOUR_RAW_URL_HERE"))()

-- Or if testing locally:
-- local Cohoes = loadstring(readfile("CohoesLib.lua"))()

-- Create a window
local Window = Cohoes:CreateWindow({
    Title = "My Cool Script",
    Size = {380, 500},           -- Width, Height
    ToggleKey = Enum.KeyCode.RightShift  -- Key to show/hide
})

-- Show a welcome notification
Cohoes:Notify({
    Title = "Welcome!",
    Message = "Script loaded successfully",
    Duration = 3
})

-- ============================================
-- MAIN TAB
-- ============================================

local MainTab = Window:CreateTab("Main")

-- Create a section (returns the section frame)
local AimbotSection = MainTab:CreateSection("Aimbot")

-- Toggle
local aimbotEnabled = MainTab:CreateToggle({
    Name = "Enable Aimbot",
    Default = false,
    Section = AimbotSection,
    Callback = function(value)
        print("Aimbot:", value)
        Cohoes:Notify({
            Title = "Aimbot",
            Message = value and "Enabled" or "Disabled",
            Duration = 2
        })
    end
})

-- Slider
local fovSlider = MainTab:CreateSlider({
    Name = "FOV Size",
    Min = 50,
    Max = 500,
    Default = 150,
    Section = AimbotSection,
    Callback = function(value)
        print("FOV:", value)
    end
})

-- Number input
local smoothInput = MainTab:CreateInput({
    Name = "Smoothness",
    Default = "0.5",
    Numeric = true,
    Section = AimbotSection,
    Callback = function(value)
        print("Smoothness:", value)
    end
})

-- Another section
local TargetSection = MainTab:CreateSection("Target Settings")

-- Dropdown
local hitpartDropdown = MainTab:CreateDropdown({
    Name = "Hit Part",
    Options = {"Head", "Torso", "Random"},
    Default = "Head",
    Section = TargetSection,
    Callback = function(value)
        print("Hit Part:", value)
    end
})

-- Keybind
local aimKey = MainTab:CreateKeybind({
    Name = "Aim Key",
    Default = Enum.KeyCode.E,
    Section = TargetSection,
    Callback = function(key)
        print("Aim key pressed!")
    end
})

-- ============================================
-- VISUALS TAB
-- ============================================

local VisualsTab = Window:CreateTab("Visuals")

local ESPSection = VisualsTab:CreateSection("ESP")

VisualsTab:CreateToggle({
    Name = "Box ESP",
    Default = false,
    Section = ESPSection,
    Callback = function(value)
        print("Box ESP:", value)
    end
})

VisualsTab:CreateToggle({
    Name = "Name ESP",
    Default = true,
    Section = ESPSection,
    Callback = function(value)
        print("Name ESP:", value)
    end
})

VisualsTab:CreateToggle({
    Name = "Health Bar",
    Default = false,
    Section = ESPSection,
    Callback = function(value)
        print("Health Bar:", value)
    end
})

local ColorSection = VisualsTab:CreateSection("Colors")

VisualsTab:CreateDropdown({
    Name = "ESP Color",
    Options = {"White", "Red", "Green", "Blue", "Yellow"},
    Default = "White",
    Section = ColorSection,
    Callback = function(value)
        print("ESP Color:", value)
    end
})

-- ============================================
-- MISC TAB
-- ============================================

local MiscTab = Window:CreateTab("Misc")

local PlayerSection = MiscTab:CreateSection("Player")

MiscTab:CreateSlider({
    Name = "Walk Speed",
    Min = 16,
    Max = 100,
    Default = 16,
    Section = PlayerSection,
    Callback = function(value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = value
        end
    end
})

MiscTab:CreateSlider({
    Name = "Jump Power",
    Min = 50,
    Max = 200,
    Default = 50,
    Section = PlayerSection,
    Callback = function(value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = value
        end
    end
})

MiscTab:CreateButton({
    Name = "Reset Character",
    Section = PlayerSection,
    Callback = function()
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = 0
        end
    end
})

local UtilSection = MiscTab:CreateSection("Utilities")

MiscTab:CreateButton({
    Name = "Copy Game ID",
    Section = UtilSection,
    Callback = function()
        setclipboard(tostring(game.PlaceId))
        Cohoes:Notify({
            Title = "Copied!",
            Message = "Game ID copied to clipboard",
            Duration = 2
        })
    end
})

MiscTab:CreateLabel({
    Text = "Press RightShift to toggle UI",
    Section = UtilSection
})

-- ============================================
-- SETTINGS TAB
-- ============================================

local SettingsTab = Window:CreateTab("Settings")

local UISection = SettingsTab:CreateSection("UI Settings")

SettingsTab:CreateKeybind({
    Name = "Menu Toggle",
    Default = Enum.KeyCode.RightShift,
    Section = UISection,
    Callback = function()
        -- This fires when the key is pressed
    end
})

SettingsTab:CreateButton({
    Name = "Destroy UI",
    Section = UISection,
    Callback = function()
        Window:Destroy()
    end
})

-- ============================================
-- PROGRAMMATIC CONTROL EXAMPLES
-- ============================================

-- You can control elements programmatically:
-- aimbotEnabled:Set(true)     -- Turn on aimbot
-- aimbotEnabled:Get()         -- Returns current value
-- fovSlider:Set(200)          -- Set FOV to 200
-- hitpartDropdown:Set("Torso") -- Change dropdown selection

print("Example script loaded! Press RightShift to toggle the menu.")
