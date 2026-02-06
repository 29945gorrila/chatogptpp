--[[
    Enhanced Cohoes UI Loader
    Made by: You
    GitHub: https://github.com/29945gorrila/chatogptpp
]]

-- Load the main library
local CohoesLib = game:HttpGet("https://raw.githubusercontent.com/29945gorrila/chatogptpp/main/lib")
loadstring(CohoesLib)()

-- Load the elements (dropdown, colorpicker)
local CohoesElements = game:HttpGet("https://raw.githubusercontent.com/29945gorrila/chatogptpp/main/elements.lua")
loadstring(CohoesElements)()

-- Access the library
local Cohoes = _G.Cohoes or Cohoes

-- Create window
local Window = Cohoes:CreateWindow({
    Title = "skibi",
    Subtitle = ".cc",
    Size = {700, 565},
    ToggleKey = Enum.KeyCode.RightShift,
    GameInfo = "skibi.cc for " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
})

-- ============================================
-- COMBAT TAB
-- ============================================
local CombatTab = Window:CreateTab("Combat", "rbxassetid://6034509993")

local WeaponsSection, WeaponsLayout = CombatTab:CreateSection("Weapons")

CombatTab:CreateToggle({
    Name = "Silent Aim",
    Default = false,
    Section = WeaponsSection,
    Callback = function(value)
        print("Silent Aim:", value)
    end
})

CombatTab:CreateSlider({
    Name = "FOV Size",
    Min = 0,
    Max = 500,
    Default = 100,
    Decimals = 0,
    Section = WeaponsSection,
    Callback = function(value)
        print("FOV:", value)
    end
})

CombatTab:CreateDropdown({
    Name = "Target Part",
    Options = {"Head", "Torso", "HumanoidRootPart", "Random"},
    Default = "Head",
    Section = WeaponsSection,
    Callback = function(value)
        print("Target Part:", value)
    end
})

CombatTab:CreateColorPicker({
    Name = "FOV Color",
    Default = Color3.fromRGB(155, 150, 219),
    Alpha = 0.5,
    Section = WeaponsSection,
    Callback = function(color, alpha)
        print("FOV Color:", color, "Alpha:", alpha)
    end
})

-- ============================================
-- VISUALS TAB
-- ============================================
local VisualsTab = Window:CreateTab("Visuals", "rbxassetid://6034767608")

local ESPSection, ESPLayout = VisualsTab:CreateSection("ESP")

VisualsTab:CreateToggle({
    Name = "Enable ESP",
    Default = false,
    Section = ESPSection,
    Callback = function(value)
        print("ESP:", value)
    end
})

VisualsTab:CreateToggle({
    Name = "Show Names",
    Default = true,
    Section = ESPSection,
    Callback = function(value)
        print("Names ESP:", value)
    end
})

VisualsTab:CreateToggle({
    Name = "Show Distance",
    Default = true,
    Section = ESPSection,
    Callback = function(value)
        print("Distance ESP:", value)
    end
})

VisualsTab:CreateColorPicker({
    Name = "Enemy Color",
    Default = Color3.fromRGB(255, 100, 100),
    Alpha = 0,
    Section = ESPSection,
    Callback = function(color, alpha)
        print("Enemy Color:", color)
    end
})

VisualsTab:CreateColorPicker({
    Name = "Team Color",
    Default = Color3.fromRGB(100, 255, 100),
    Alpha = 0,
    Section = ESPSection,
    Callback = function(color, alpha)
        print("Team Color:", color)
    end
})

-- ============================================
-- MOVEMENT TAB
-- ============================================
local MovementTab = Window:CreateTab("Movement", "rbxassetid://6034754420")

local SpeedSection, SpeedLayout = MovementTab:CreateSection("Speed")

MovementTab:CreateToggle({
    Name = "Speed Hack",
    Default = false,
    Section = SpeedSection,
    Callback = function(value)
        print("Speed Hack:", value)
        if value then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
        else
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end
})

MovementTab:CreateSlider({
    Name = "Walk Speed",
    Min = 16,
    Max = 200,
    Default = 50,
    Decimals = 0,
    Section = SpeedSection,
    Callback = function(value)
        print("Speed:", value)
        if game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
        end
    end
})

local JumpSection, JumpLayout = MovementTab:CreateSection("Jump")

MovementTab:CreateSlider({
    Name = "Jump Power",
    Min = 50,
    Max = 300,
    Default = 50,
    Decimals = 0,
    Section = JumpSection,
    Callback = function(value)
        print("Jump Power:", value)
        if game.Players.LocalPlayer.Character then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
        end
    end
})

-- ============================================
-- MISC TAB
-- ============================================
local MiscTab = Window:CreateTab("Misc", "rbxassetid://6031075938")

local PlayerSection, PlayerLayout = MiscTab:CreateSection("Player")

MiscTab:CreateButton({
    Name = "Reset Character",
    Section = PlayerSection,
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
        Cohoes:Notify({
            Title = "Reset",
            Message = "Character has been reset!",
            Duration = 3
        })
    end
})

MiscTab:CreateInput({
    Name = "Player Name",
    Default = "",
    Placeholder = "Enter player name...",
    Section = PlayerSection,
    Callback = function(value)
        print("Player Name:", value)
    end
})

local GameSection, GameLayout = MiscTab:CreateSection("Game")

MiscTab:CreateToggle({
    Name = "Auto Farm",
    Default = false,
    Section = GameSection,
    Callback = function(value)
        print("Auto Farm:", value)
    end
})

MiscTab:CreateToggle({
    Name = "Anti AFK",
    Default = true,
    Section = GameSection,
    Callback = function(value)
        print("Anti AFK:", value)
    end
})

MiscTab:CreateDropdown({
    Name = "Farm Mode",
    Options = {"Nearest", "Highest Value", "Lowest Health"},
    Default = "Nearest",
    Section = GameSection,
    Callback = function(value)
        print("Farm Mode:", value)
    end
})

-- ============================================
-- SETTINGS TAB
-- ============================================
local SettingsTab = Window:CreateTab("Settings", "rbxassetid://6031280882")

local UISection, UILayout = SettingsTab:CreateSection("UI Settings")

SettingsTab:CreateColorPicker({
    Name = "Theme Color",
    Default = Color3.fromRGB(155, 150, 219),
    Alpha = 0,
    Section = UISection,
    Callback = function(color, alpha)
        Cohoes:UpdateTheme(color)
        Cohoes:Notify({
            Title = "Theme",
            Message = "Theme color updated!",
            Duration = 2
        })
    end
})

SettingsTab:CreateKeybind({
    Name = "Toggle UI",
    Default = Enum.KeyCode.RightShift,
    Section = UISection,
    Callback = function(key)
        print("New UI Keybind:", key)
    end
})

local ConfigSection, ConfigLayout = SettingsTab:CreateSection("Config")

SettingsTab:CreateInput({
    Name = "Config Name",
    Default = "",
    Placeholder = "Enter config name...",
    Section = ConfigSection,
    Callback = function(value)
        print("Config Name:", value)
    end
})

SettingsTab:CreateButton({
    Name = "Save Config",
    Section = ConfigSection,
    Callback = function()
        Cohoes:Notify({
            Title = "Config",
            Message = "Configuration saved!",
            Duration = 3
        })
    end
})

SettingsTab:CreateButton({
    Name = "Load Config",
    Section = ConfigSection,
    Callback = function()
        Cohoes:Notify({
            Title = "Config",
            Message = "Configuration loaded!",
            Duration = 3
        })
    end
})

-- Welcome notification
Cohoes:Notify({
    Title = "Welcome!",
    Message = "skibi.cc loaded successfully!",
    Duration = 5
})

print("========================================")
print("skibi.cc UI Loaded!")
print("Press RightShift to toggle UI")
print("GitHub: github.com/29945gorrila/chatogptpp")
print("========================================")
