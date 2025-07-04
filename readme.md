# Linoria-Lib Documentation

## Introduction

> [!IMPORTANT]  
> Linoria Lib was not my creation and full credits to the [Owner](https://github.com/violin-suzutsuki) of Linoria!
 
> [!TIP]  
> Thank you to [Stratxgy](https://github.com/Stratxgy/Linora-Lib) for his Doc, cause of it i got more info about linoria!
>

---

## Importing the Library
To start using LinoriaLib in your Roblox script, you need to load the library and its components from the provided URLs:

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/VaxKs/gfe/main/CustomLinoria"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/DetainedMonkey2891/ThemeManager/refs/heads/main/Maina"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/refs/heads/main/addons/SaveManager.lua"))()
```
## Creating a New Window
You can create a new window using the following code:
```lua
local Window = Library:CreateWindow({
    Title = 'Example menu',
    Center = true,  -- Set Center to true for a centered menu
    AutoShow = true, -- Set AutoShow to true for the window to appear upon creation
    TabPadding = 8,
    MenuFadeTime = 0.2
    -- Position = float (optional)
    -- Size = float (optional)
})
```
## Changing theme
To change the colors of your script
```lua
ThemeManager:SetTheme({
    BackgroundColor = Color3.fromRGB(50, 50, 50), -- Main background color
    OutlineColor = Color3.fromRGB(255, 0, 0), -- Outline color
    TextColor = Color3.fromRGB(255, 255, 255), -- Text color
    ButtonColor = Color3.fromRGB(30, 30, 30) -- Button color
})
```
## Creating Tabs
To create a new tab in your window:

```lua
local mainTab = Window:AddTab('Main')
```
## Clickable UI Elements
### Creating Buttons
Create buttons with customizable actions and tooltips:

```lua
local MyButton = LeftGroupBox:AddButton({
    Text = 'Button',
    Func = function()
        print('You clicked a button!')
    end,
    DoubleClick = false, -- Set to true for double-click functionality
    Tooltip = 'This is the main button' -- Tooltip that appears on hover
})
```
## Creating a Color Picker
Add a color picker to change colors dynamically:
```lua
LeftGroupBox:AddLabel('Color'):AddColorPicker('ColorPicker', {
    Default = Color3.new(255, 255, 255), -- Default color
    Title = 'Some color', -- Optional: Custom title for the color picker
    Transparency = 0, -- Optional: Control transparency (set nil to disable)
    Callback = function(Value)
        print('[cb] Color changed!', Value)
    end
})
```
## Creating a Dropdown
Dropdowns allow selection from a list of values:

```lua
LeftGroupBox:AddDropdown('MyDropdown', {
    Values = { 'This', 'is', 'a', 'dropdown' },
    Default = 1, -- Default index or string
    Multi = false, -- Allows selection of multiple items if set to true
    Text = 'A dropdown',
    Tooltip = 'This is a tooltip',

    Callback = function(Value)
        print('[cb] Dropdown got changed. New value:', Value)
    end
})
```
## Creating Toggles
Use toggles for binary options (on/off):

```lua
LeftGroupBox:AddToggle('MyToggle', {
    Text = 'This is a toggle',
    Default = false, -- Default state (true/false)
    Tooltip = 'This is a tooltip', -- Information shown on hover
    Callback = function(Value)
        print('[cb] MyToggle changed to:', Value)
    end
})
```
## Creating Keybinds
Implement keybinds to trigger specific actions:
```lua
LeftGroupBox:AddLabel('Keybind'):AddKeyPicker('KeyPicker', {
    Default = 'MB2', -- String for the keybind (e.g., MB1, MB2 for mouse buttons)
    SyncToggleState = false, -- Sync with a toggle if needed

    Text = 'Example Keybind',
    NoUI = false, -- Hide from the keybind menu if set to true

    ChangedCallback = function(New)
        print('[cb] Keybind changed!', New) -- Triggered when the keybind is changed
    end
})
```
## Creating Sliders
Sliders enable selection of a numerical value within a range:
```lua
LeftGroupBox:AddSlider('MySlider', {
    Text = 'This is my slider!',
    Default = 0,
    Min = 0,
    Max = 5,
    Rounding = 1,
    Compact = false,

    Callback = function(Value)
        print('[cb] MySlider was changed! New value:', Value)
    end
})

local Number = Options.MySlider.Value -- Fetch the current value
Options.MySlider:OnChanged(function()
    print('MySlider was changed! New value:', Options.MySlider.Value)
end)

Options.MySlider:SetValue(3) -- Set the slider to a specific value
```
## Tabboxes and Labels
### Creating TabBoxes
You can create tabboxes to organize UI elements horizontally or vertically:
```lua
local RightTabBox = Main:AddRightTabbox() -- Right tabbox
local LeftTabBox = Main:AddLeftTabbox()   -- Left tabbox
```
## Creating Labels
Add labels for informational text or titles:

```lua
local Label = LeftGroupBox:AddLabel('This is a label')
--[[
Text = string
doesWrap = boolean (optional)
]]
```
## For any more help i recommend looking at the [example](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/example.lua)!
## More credits found at the linoria page!
### - Inori: Main developer.
### - Wally: Cleaning up verbose code, extending library functionality.
### - Stefanuk: Extending library functionality.
### - matas3535: Creator of Splix.
