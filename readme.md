# LinoriaLib Documentation

A comprehensive UI library for Roblox with support for themes, configurations, and a wide range of UI elements.

> **Important**: LinoriaLib was created by [violin-suzutsuki](https://github.com/violin-suzutsuki). This is documentation based on the official library.

---

## Languages
- [English](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/readme.md)
- [Spanish](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/spanish.md)
- [Arabic](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/arabic.md)
- [Russian](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/russian.md)
- [Portuguese](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/portuguese.md)
- [Vietnamese](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/vietnamese.md)
- [Chinese](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/chinese.md)
- [French](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/french.md)
- [Turkish](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/turkish.md)
- [Indonesian](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/indonesian.md)

---

## Table of Contents
- [Importing the Library](#importing-the-library)
- [Creating a Window](#creating-a-window)
- [Creating Tabs](#creating-tabs)
- [Groupboxes and Tabboxes](#groupboxes-and-tabboxes)
- [UI Elements](#ui-elements)
  - [Toggles](#toggles)
  - [Buttons](#buttons)
  - [Labels](#labels)
  - [Dividers](#dividers)
  - [Sliders](#sliders)
  - [Text Input](#text-input)
  - [Dropdowns](#dropdowns)
  - [Color Pickers](#color-pickers)
  - [Keybinds](#keybinds)
- [Dependency Boxes](#dependency-boxes)
- [Library Functions](#library-functions)
- [Theme Manager](#theme-manager)
- [Save Manager](#save-manager)

---

## Importing the Library

```lua
local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
```

---

## Creating a Window

```lua
local Window = Library:CreateWindow({
    Title = 'Example menu',
    Center = true,        -- Set to true to center the menu on screen
    AutoShow = true,      -- Set to true to show menu immediately
    TabPadding = 8,       -- Padding between tabs
    MenuFadeTime = 0.2    -- Fade animation duration
    -- Position = UDim2 (optional)
    -- Size = UDim2 (optional)
})
```

---

## Creating Tabs

Tabs organize your UI into different sections.

```lua
local Tabs = {
    Main = Window:AddTab('Main'),
    Settings = Window:AddTab('Settings')
}
```

You can also access tabs directly:

```lua
local MainTab = Window.Tabs.Main
```

---

## Groupboxes and Tabboxes

### Creating Groupboxes

Groupboxes are containers for UI elements on the left or right side of a tab.

```lua
local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Groupbox Title')
local RightGroupBox = Tabs.Main:AddRightGroupbox('Groupbox Title')
```

### Creating Tabboxes

Tabboxes allow you to create sub-tabs within a groupbox area.

```lua
local TabBox = Tabs.Main:AddLeftTabbox()

local Tab1 = TabBox:AddTab('Tab 1')
local Tab2 = TabBox:AddTab('Tab 2')

-- Now you can add elements to these tabs
Tab1:AddToggle('Tab1Toggle', { Text = 'Tab1 Toggle' })
```

---

## UI Elements

### Toggles

Binary on/off switches.

```lua
LeftGroupBox:AddToggle('MyToggle', {
    Text = 'This is a toggle',
    Default = true,           -- Default value (true / false)
    Tooltip = 'This is a tooltip',
    
    Callback = function(Value)
        print('[cb] MyToggle changed to:', Value)
    end
})
```

**Accessing Toggle State:**

```lua
-- Get current value
local isEnabled = Toggles.MyToggle.Value

-- Listen for changes
Toggles.MyToggle:OnChanged(function()
    print('MyToggle changed to:', Toggles.MyToggle.Value)
end)

-- Set value programmatically
Toggles.MyToggle:SetValue(false)
```

---

### Buttons

Execute functions when clicked.

```lua
local MyButton = LeftGroupBox:AddButton({
    Text = 'Button',
    Func = function()
        print('You clicked a button!')
    end,
    DoubleClick = false,      -- Require double-click to trigger
    Tooltip = 'This is the main button'
})
```

**Sub-Buttons:**

You can chain buttons to create sub-buttons.

```lua
local MyButton2 = MyButton:AddButton({
    Text = 'Sub button',
    Func = function()
        print('You clicked a sub button!')
    end,
    DoubleClick = true,
    Tooltip = 'This is the sub button (double click me!)'
})
```

**Chaining Example:**

```lua
LeftGroupBox:AddButton({ 
    Text = 'Kill all', 
    Func = Functions.KillAll, 
    Tooltip = 'This will kill everyone in the game!' 
})
:AddButton({ 
    Text = 'Kick all', 
    Func = Functions.KickAll, 
    Tooltip = 'This will kick everyone in the game!' 
})
```

---

### Labels

Display text information.

```lua
LeftGroupBox:AddLabel('This is a label')

-- Label with text wrapping
LeftGroupBox:AddLabel('This is a label\n\nwhich wraps its text!', true)
```

**Parameters:**
- `Text` (string): The text to display
- `DoesWrap` (boolean, optional): Enable text wrapping

---

### Dividers

Add visual separation between UI elements.

```lua
LeftGroupBox:AddDivider()
```

---

### Sliders

Select numerical values within a range.

```lua
LeftGroupBox:AddSlider('MySlider', {
    Text = 'This is my slider!',
    Default = 0,
    Min = 0,
    Max = 5,
    Rounding = 1,             -- Decimal places for precision
    Compact = false,          -- Hide title label if true
    Suffix = '',              -- Optional suffix (e.g., 'px', '%')
    HideMax = false,          -- Show only value, not value/max
    
    Callback = function(Value)
        print('[cb] MySlider was changed! New value:', Value)
    end
})
```

**Required Parameters:**
- `Text`, `Default`, `Min`, `Max`, `Rounding` must be specified

**Accessing Slider Value:**

```lua
-- Get current value
local Number = Options.MySlider.Value

-- Listen for changes
Options.MySlider:OnChanged(function()
    print('MySlider was changed! New value:', Options.MySlider.Value)
end)

-- Set value programmatically
Options.MySlider:SetValue(3)
```

---

### Text Input

Text boxes for user input.

```lua
LeftGroupBox:AddInput('MyTextbox', {
    Default = 'My textbox!',
    Numeric = false,          -- true = only allows numbers
    Finished = false,         -- true = only calls callback on Enter press
    Text = 'This is a textbox',
    Tooltip = 'This is a tooltip',
    Placeholder = 'Placeholder text',
    -- MaxLength = number (optional)
    
    Callback = function(Value)
        print('[cb] Text updated. New text:', Value)
    end
})
```

**Accessing Input Value:**

```lua
Options.MyTextbox:OnChanged(function()
    print('Text updated. New text:', Options.MyTextbox.Value)
end)
```

---

### Dropdowns

Select from a list of values.

#### Single Selection Dropdown

```lua
LeftGroupBox:AddDropdown('MyDropdown', {
    Values = { 'This', 'is', 'a', 'dropdown' },
    Default = 1,              -- Index or string value
    Multi = false,            -- Single selection
    Text = 'A dropdown',
    Tooltip = 'This is a tooltip',
    
    Callback = function(Value)
        print('[cb] Dropdown got changed. New value:', Value)
    end
})
```

**Accessing Dropdown Value:**

```lua
Options.MyDropdown:OnChanged(function()
    print('Dropdown got changed. New value:', Options.MyDropdown.Value)
end)

-- Set value programmatically
Options.MyDropdown:SetValue('This')
```

#### Multi-Selection Dropdown

```lua
LeftGroupBox:AddDropdown('MyMultiDropdown', {
    Values = { 'This', 'is', 'a', 'dropdown' },
    Default = 1,
    Multi = true,             -- Allow multiple selections
    Text = 'A dropdown',
    Tooltip = 'This is a tooltip',
    
    Callback = function(Value)
        print('[cb] Multi dropdown got changed:', Value)
    end
})
```

**Accessing Multi-Dropdown Values:**

```lua
Options.MyMultiDropdown:OnChanged(function()
    print('Multi dropdown got changed:')
    for key, value in next, Options.MyMultiDropdown.Value do
        print(key, value) -- e.g., "This", true
    end
end)

-- Set multiple values
Options.MyMultiDropdown:SetValue({
    This = true,
    is = true,
})
```

**Note:** Currently you cannot set multiple default values with a dropdown.

#### Player Dropdown

Special dropdown for selecting players.

```lua
LeftGroupBox:AddDropdown('MyPlayerDropdown', {
    SpecialType = 'Player',
    Text = 'A player dropdown',
    Tooltip = 'This is a tooltip',
    
    Callback = function(Value)
        print('[cb] Player dropdown got changed:', Value)
    end
})
```

---

### Color Pickers

Select colors with optional transparency.

```lua
LeftGroupBox:AddLabel('Color'):AddColorPicker('ColorPicker', {
    Default = Color3.new(0, 1, 0),     -- Bright green
    Title = 'Some color',              -- Optional custom title
    Transparency = 0,                  -- Optional (nil to disable)
    
    Callback = function(Value)
        print('[cb] Color changed!', Value)
    end
})
```

**Accessing Color Picker:**

```lua
Options.ColorPicker:OnChanged(function()
    print('Color changed!', Options.ColorPicker.Value)
    print('Transparency changed!', Options.ColorPicker.Transparency)
end)

-- Set color programmatically
Options.ColorPicker:SetValueRGB(Color3.fromRGB(0, 255, 140))
```

**Note:** You can also add ColorPickers to Toggles.

---

### Keybinds

Bind actions to keyboard or mouse inputs.

```lua
LeftGroupBox:AddLabel('Keybind'):AddKeyPicker('KeyPicker', {
    Default = 'MB2',          -- MB1, MB2 for mouse buttons
    SyncToggleState = false,  -- Sync state with parent toggle
    Mode = 'Toggle',          -- Modes: Always, Toggle, Hold
    Text = 'Auto lockpick safes',
    NoUI = false,             -- Hide from keybind menu if true
    
    -- Triggered when keybind is pressed
    Callback = function(Value)
        print('[cb] Keybind clicked!', Value)
    end,
    
    -- Triggered when keybind is changed
    ChangedCallback = function(New)
        print('[cb] Keybind changed!', New)
    end
})
```

**SyncToggleState Note:** 
- Only works with toggles
- Allows keybind state to sync with parent toggle
- Example: Keybind for toggling flyhack - changing the toggle disables the keybind state

**Accessing Keybind:**

```lua
-- OnClick is only fired in Toggle mode
Options.KeyPicker:OnClick(function()
    print('Keybind clicked!', Options.KeyPicker:GetState())
end)

Options.KeyPicker:OnChanged(function()
    print('Keybind changed!', Options.KeyPicker.Value)
end)

-- Check if keybind is being pressed
local state = Options.KeyPicker:GetState()
if state then
    print('KeyPicker is being held down')
end

-- Set keybind programmatically
Options.KeyPicker:SetValue({ 'MB2', 'Toggle' })
```

**Example Loop for Checking Keybind State:**

```lua
task.spawn(function()
    while true do
        wait(1)
        
        local state = Options.KeyPicker:GetState()
        if state then
            print('KeyPicker is being held down')
        end
        
        if Library.Unloaded then break end
    end
end)
```

**Note:** You can also add KeyPickers to Toggles.

---

## Dependency Boxes

Control UI element visibility based on other elements' states.

```lua
local RightGroupbox = Tabs.Main:AddRightGroupbox('Groupbox #3')
RightGroupbox:AddToggle('ControlToggle', { Text = 'Dependency box toggle' })

-- Create dependency box
local Depbox = RightGroupbox:AddDependencyBox()
Depbox:AddToggle('DepboxToggle', { Text = 'Sub-dependency box toggle' })

-- Nested dependency box
local SubDepbox = Depbox:AddDependencyBox()
SubDepbox:AddSlider('DepboxSlider', { 
    Text = 'Slider', 
    Default = 50, 
    Min = 0, 
    Max = 100, 
    Rounding = 0 
})
SubDepbox:AddDropdown('DepboxDropdown', { 
    Text = 'Dropdown', 
    Default = 1, 
    Values = {'a', 'b', 'c'} 
})

-- Setup dependencies
Depbox:SetupDependencies({
    { Toggles.ControlToggle, true } -- Show when toggle is true
})

SubDepbox:SetupDependencies({
    { Toggles.DepboxToggle, true }
})
```

**Dependency Parameters:**
- Pass `true` to show when element is enabled
- Pass `false` to show when element is disabled
- Nested dependency boxes automatically inherit parent visibility

---

## Library Functions

### Watermark

```lua
-- Set watermark visibility
Library:SetWatermarkVisibility(true)

-- Update watermark text
Library:SetWatermark('LinoriaLib demo | 60 fps | 50 ms')
```

**Example: Dynamic Watermark with FPS and Ping**

```lua
local FrameTimer = tick()
local FrameCounter = 0
local FPS = 60

local WatermarkConnection = game:GetService('RunService').RenderStepped:Connect(function()
    FrameCounter += 1
    
    if (tick() - FrameTimer) >= 1 then
        FPS = FrameCounter
        FrameTimer = tick()
        FrameCounter = 0
    end
    
    Library:SetWatermark(('LinoriaLib demo | %s fps | %s ms'):format(
        math.floor(FPS),
        math.floor(game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
    ))
end)
```

### Keybind Frame

```lua
-- Show/hide keybind frame
Library.KeybindFrame.Visible = true
```

### Unload Library

```lua
-- Unload the library and clean up
Library:Unload()

-- Listen for unload event
Library:OnUnload(function()
    print('Library unloaded!')
    Library.Unloaded = true
end)
```

---

## Theme Manager

The ThemeManager addon allows you to create and manage UI themes.

### Setup Theme Manager

```lua
-- Hand the library over to ThemeManager
ThemeManager:SetLibrary(Library)

-- Set folder for themes
ThemeManager:SetFolder('MyScriptHub')

-- Apply theme manager to a tab
ThemeManager:ApplyToTab(Tabs['UI Settings'])

-- Or apply to a specific groupbox
ThemeManager:ApplyToGroupbox(SomeGroupbox)
```

ThemeManager comes with plenty of built-in themes that users can select from.

---

## Save Manager

The SaveManager addon provides a configuration system for saving/loading settings.

### Setup Save Manager

```lua
-- Hand the library over to SaveManager
SaveManager:SetLibrary(Library)

-- Ignore theme settings (we don't want configs to save themes)
SaveManager:IgnoreThemeSettings()

-- Set indices to ignore (e.g., menu keybind)
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

-- Set folder for configs
SaveManager:SetFolder('MyScriptHub/specific-game')

-- Build config section on a tab
SaveManager:BuildConfigSection(Tabs['UI Settings'])

-- Load autoload config
SaveManager:LoadAutoloadConfig()
```

### Use Case

A script hub could have:
- Themes in a global folder: `ThemeManager:SetFolder('MyScriptHub')`
- Game configs in separate folders per game: `SaveManager:SetFolder('MyScriptHub/specific-game')`

---

## Complete Menu Example

```lua
-- Menu keybind setup
local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { 
    Default = 'End', 
    NoUI = true, 
    Text = 'Menu keybind' 
})

Library.ToggleKeybind = Options.MenuKeybind

-- Setup managers
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

ThemeManager:SetFolder('MyScriptHub')
SaveManager:SetFolder('MyScriptHub/specific-game')

SaveManager:BuildConfigSection(Tabs['UI Settings'])
ThemeManager:ApplyToTab(Tabs['UI Settings'])

SaveManager:LoadAutoloadConfig()
```

---

## Best Practices

### UI Code Separation

It's recommended to decouple UI code from logic code:

1. **Create UI elements first**
2. **Setup :OnChanged functions later**

```lua
-- RECOMMENDED: Decouple UI from logic
LeftGroupBox:AddToggle('MyToggle', {
    Text = 'This is a toggle',
    Default = true,
    Tooltip = 'This is a tooltip'
})

-- Setup logic separately
Toggles.MyToggle:OnChanged(function()
    -- Your logic here
    print('MyToggle changed to:', Toggles.MyToggle.Value)
end)
```

```lua
-- NOT RECOMMENDED: Coupling UI and logic
LeftGroupBox:AddToggle('MyToggle', {
    Text = 'This is a toggle',
    Default = true,
    Tooltip = 'This is a tooltip',
    Callback = function(Value)
        -- Logic mixed with UI creation
        print('MyToggle changed to:', Value)
    end
})
```

### Accessing UI Elements

The library adds two global tables to `getgenv()`:

- **`Toggles`**: Access toggle objects
- **`Options`**: Access all other UI elements (sliders, dropdowns, inputs, etc.)

```lua
-- Accessing toggles
local toggleValue = Toggles.MyToggle.Value

-- Accessing other elements
local sliderValue = Options.MySlider.Value
local dropdownValue = Options.MyDropdown.Value
local textboxValue = Options.MyTextbox.Value
local colorValue = Options.ColorPicker.Value
local keybindValue = Options.KeyPicker.Value
```

---

## Credits

- **Inori**: Main developer
- **Wally**: Cleaning up verbose code, extending library functionality
- **Stefanuk**: Extending library functionality
- **matas3535**: Creator of Splix

For more information, visit the [official LinoriaLib repository](https://github.com/violin-suzutsuki/LinoriaLib).
```
