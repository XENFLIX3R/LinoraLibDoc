local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/VaxKs/gfe/main/CustomLinoria"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/DetainedMonkey2891/ThemeManager/refs/heads/main/Maina"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/refs/heads/main/addons/SaveManager.lua"))()

local Window = Library:CreateWindow({
    Title = 'Example Menu',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    Main = Window:AddTab('Main'),
    ['UI Settings'] = Window:AddTab('UI Settings')
}

local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Main Settings')

LeftGroupBox:AddButton({
    Text = 'Click Me!',
    Func = function()
        print('Button clicked!')
    end,
    DoubleClick = false,
    Tooltip = 'This is a clickable button!'
})

LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Enable Feature',
    Default = false,
    Tooltip = 'Toggle this feature on or off',
    Callback = function(Value)
        print('[cb] MyToggle changed to:', Value)
    end
})

LeftGroupBox:AddDropdown('MyDropdown', {
    Values = { 'Option 1', 'Option 2', 'Option 3' },
    Default = 1,
    Multi = false,
    Text = 'Select an Option',
    Tooltip = 'Choose an option from the dropdown',
    Callback = function(Value)
        print('[cb] Dropdown selected:', Value)
    end
})

LeftGroupBox:AddSlider('MySlider', {
    Text = 'Adjust the Slider',
    Default = 0,
    Min = 0,
    Max = 10,
    Rounding = 1,
    Callback = function(Value)
        print('[cb] Slider changed! New value:', Value)
    end
})

LeftGroupBox:AddLabel('Choose a Color'):AddColorPicker('ColorPicker', {
    Default = Color3.fromRGB(255, 0, 0),
    Title = 'Color Picker',
    Transparency = 0,
    Callback = function(Value)
        print('[cb] Color changed to:', Value)
    end
})

LeftGroupBox:AddLabel('Keybind'):AddKeyPicker('KeyPicker', {
    Default = 'MB1',
    SyncToggleState = false,
    Text = 'Example Keybind',
    NoUI = false,
    ChangedCallback = function(New)
        print('[cb] Keybind changed to:', New)
    end
})

local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu Settings')
MenuGroup:AddButton('Unload', function() Library:Unload() end)

ThemeManager:SetLibrary(Library)
ThemeManager:ApplyToTab(Tabs['UI Settings'])

SaveManager:SetLibrary(Library)
SaveManager:BuildConfigSection(Tabs['UI Settings'])

Library:OnUnload(function()
    print('Unloaded the library!')
end)
