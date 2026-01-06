# Linoria Library 文档

一个功能全面的 Roblox UI 库，支持主题定制、配置保存以及丰富的 UI 组件。

> **重要提示**: LinoriaLib 由 [violin-suzutsuki](https://github.com/violin-suzutsuki) 开发。本文件基于官方库编写。

---

## 语言
- [English](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/readme.md)
- [Spanish](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/spanish.md)
- [Russian](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/russian.md)
- [Portuguese](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/portuguese.md)
- [Vietnamese](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/vietnamese.md)
- [Chinese](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/chinese.md) - 当前
- [French](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/french.md)
- [Turkish](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/turkish.md)
- [Indonesian](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/indonesian.md)

---

## 目录
- [加载库](#加载库)
- [创建窗口](#创建窗口)
- [创建标签页](#创建标签页)
- [组合框与标签盒](#组合框与标签盒)
- [UI 组件](#ui-组件)
  - [开关 (Toggles)](#开关)
  - [按钮 (Buttons)](#按钮)
  - [文本标签 (Labels)](#文本标签)
  - [分割线 (Dividers)](#分割线)
  - [滑块 (Sliders)](#滑块)
  - [文本输入 (Text Input)](#文本输入)
  - [下拉菜单 (Dropdowns)](#下拉菜单)
  - [颜色选择器 (Color Pickers)](#颜色选择器)
  - [按键绑定 (Keybinds)](#按键绑定)
- [依赖盒 (Dependency Boxes)](#依赖盒)
- [库函数](#库函数)
- [主题管理器 (Theme Manager)](#主题管理器)
- [配置管理器 (Save Manager)](#配置管理器)

---

## 加载库

```lua
local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
```

---

## 创建窗口

```lua
local Window = Library:CreateWindow({
    Title = '示例菜单',
    Center = true,        -- 设置为 true 则菜单在屏幕中央显示
    AutoShow = true,      -- 设置为 true 则立即显示菜单
    TabPadding = 8,       -- 标签页之间的间距
    MenuFadeTime = 0.2    -- 菜单淡入淡出动画时长
    -- Position = UDim2 (可选)
    -- Size = UDim2 (可选)
})
```

---

## 创建标签页

标签页用于将 UI 划分为不同的板块。

```lua
local Tabs = {
    Main = Window:AddTab('主功能'),
    Settings = Window:AddTab('设置')
}
```

你也可以直接通过窗口对象访问标签页：

```lua
local MainTab = Window.Tabs.Main
```

---

## 组合框与标签盒

### 创建组合框 (Groupboxes)

组合框是位于标签页左侧或右侧的 UI 组件容器。

```lua
local LeftGroupBox = Tabs.Main:AddLeftGroupbox('组合框标题')
local RightGroupBox = Tabs.Main:AddRightGroupbox('组合框标题')
```

### 创建标签盒 (Tabboxes)

标签盒允许你在组合框区域内创建子标签页。

```lua
local TabBox = Tabs.Main:AddLeftTabbox()

local Tab1 = TabBox:AddTab('子标签 1')
local Tab2 = TabBox:AddTab('子标签 2')

-- 现在可以向这些子标签添加组件
Tab1:AddToggle('Tab1Toggle', { Text = '子标签开关' })
```

---

## UI 组件

### 开关 (Toggles)

二元开启/关闭切换器。

```lua
LeftGroupBox:AddToggle('MyToggle', {
    Text = '这是一个开关',
    Default = true,           -- 默认值 (true / false)
    Tooltip = '这是一个悬浮提示',
    
    Callback = function(Value)
        print('[cb] 开关状态改变为:', Value)
    end
})
```

**获取开关状态：**

```lua
-- 获取当前值
local isEnabled = Toggles.MyToggle.Value

-- 监听值改变
Toggles.MyToggle:OnChanged(function()
    print('开关改变为:', Toggles.MyToggle.Value)
end)

-- 通过代码设置值
Toggles.MyToggle:SetValue(false)
```

---

### 按钮 (Buttons)

点击时执行函数。

```lua
local MyButton = LeftGroupBox:AddButton({
    Text = '按钮',
    Func = function()
        print('你点击了按钮！')
    end,
    DoubleClick = false,      -- 是否需要双击触发
    Tooltip = '这是一个主按钮'
})
```

**子按钮 (Sub-Buttons):**

你可以通过链式调用在按钮旁创建子按钮。

```lua
local MyButton2 = MyButton:AddButton({
    Text = '子按钮',
    Func = function()
        print('你点击了子按钮！')
    end,
    DoubleClick = true,
    Tooltip = '这是一个子按钮 (双击我！)'
})
```

---

### 文本标签 (Labels)

用于显示文本信息。

```lua
LeftGroupBox:AddLabel('这是一个标签')

-- 支持自动换行的标签
LeftGroupBox:AddLabel('这是一个标签\n\n它可以自动换行显示！', true)
```

---

### 分割线 (Dividers)

在 UI 组件之间添加视觉分割。

```lua
LeftGroupBox:AddDivider()
```

---

### 滑块 (Sliders)

在指定范围内选择数值。

```lua
LeftGroupBox:AddSlider('MySlider', {
    Text = '这是一个滑块！',
    Default = 0,
    Min = 0,
    Max = 5,
    Rounding = 1,             -- 小数点位数精度
    Compact = false,          -- 设置为 true 则隐藏标题标签
    Suffix = '',              -- 可选后缀 (例如 'px', '%')
    HideMax = false,          -- 仅显示当前值，不显示 最大值
    
    Callback = function(Value)
        print('[cb] 滑块数值已改变！新值为:', Value)
    end
})
```

---

### 文本输入 (Text Input)

供用户输入的文本框。

```lua
LeftGroupBox:AddInput('MyTextbox', {
    Default = '默认文本',
    Numeric = false,          -- true = 仅允许输入数字
    Finished = false,         -- true = 仅在按下回车键时调用回调
    Text = '这是一个文本框',
    Tooltip = '提示文本',
    Placeholder = '请输入内容...',
    
    Callback = function(Value)
        print('[cb] 文本已更新:', Value)
    end
})
```

---

### 下拉菜单 (Dropdowns)

从列表中选择一个或多个值。

```lua
LeftGroupBox:AddDropdown('MyDropdown', {
    Values = { '选项 A', '选项 B', '选项 C', '选项 D' },
    Default = 1,              -- 索引值或字符串名称
    Multi = false,            -- 是否支持多选
    Text = '下拉菜单',
    Tooltip = '提示信息',
    
    Callback = function(Value)
        print('[cb] 下拉菜单改变为:', Value)
    end
})
```

---

### 颜色选择器 (Color Pickers)

选择颜色，支持透明度。

```lua
LeftGroupBox:AddLabel('颜色'):AddColorPicker('ColorPicker', {
    Default = Color3.new(0, 1, 0),     -- 亮绿色
    Title = '自定义颜色',              -- 弹窗标题
    Transparency = 0,                  -- 透明度 (nil 则禁用)
    
    Callback = function(Value)
        print('[cb] 颜色已改变！', Value)
    end
})
```

---

### 按键绑定 (Keybinds)

将操作绑定到键盘或鼠标。

```lua
LeftGroupBox:AddLabel('按键绑定'):AddKeyPicker('KeyPicker', {
    Default = 'MB2',          -- MB1, MB2 代表鼠标按键
    SyncToggleState = false,  -- 与父开关同步状态
    Mode = 'Toggle',          -- 模式: Always, Toggle, Hold
    Text = '自动解锁',
    NoUI = false,             -- 设置为 true 则在绑定菜单中隐藏
    
    Callback = function(Value)
        print('[cb] 按键已被触发！', Value)
    end,
    
    ChangedCallback = function(New)
        print('[cb] 绑定按键已更改为:', New)
    end
})
```

---

## 依赖盒 (Dependency Boxes)

基于其他组件的状态控制 UI 组件的可见性。

```lua
local RightGroupbox = Tabs.Main:AddRightGroupbox('依赖组')
RightGroupbox:AddToggle('ControlToggle', { Text = '主控制开关' })

-- 创建依赖盒
local Depbox = RightGroupbox:AddDependencyBox()
Depbox:AddToggle('DepboxToggle', { Text = '依赖开关' })

-- 设置依赖关系
Depbox:SetupDependencies({
    { Toggles.ControlToggle, true } -- 当主开关为 true 时显示
})
```

---

## 库函数

### 水印 (Watermark)

```lua
-- 设置水印显示状态
Library:SetWatermarkVisibility(true)

-- 更新水印文本
Library:SetWatermark('LinoriaLib 演示 | 60 fps | 50 ms')
```

### 卸载库 (Unload)

```lua
-- 卸载库并清理资源
Library:Unload()

-- 监听卸载事件
Library:OnUnload(function()
    print('库已卸载！')
    Library.Unloaded = true
end)
```

---

## 主题管理器 (Theme Manager)

ThemeManager 插件允许你创建和管理 UI 主题。

```lua
ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder('MyScriptHub')
ThemeManager:ApplyToTab(Tabs['Settings'])
```

---

## 配置管理器 (Save Manager)

SaveManager 插件提供了一套用于保存和加载设置的配置系统。

```lua
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings() -- 不保存主题设置
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' }) -- 忽略特定索引
SaveManager:SetFolder('MyScriptHub/specific-game')
SaveManager:BuildConfigSection(Tabs['Settings']) -- 在指定标签页构建配置界面
SaveManager:LoadAutoloadConfig() -- 加载自动运行配置
```

---

## 最佳实践

### UI 代码分离

建议将 UI 代码与逻辑代码解耦：

```lua
-- 推荐做法：UI 与逻辑分离
LeftGroupBox:AddToggle('MyToggle', {
    Text = '功能开关',
    Default = true
})

-- 随后设置逻辑
Toggles.MyToggle:OnChanged(function()
    print('当前值:', Toggles.MyToggle.Value)
end)
```

### 访问 UI 组件

该库在 ```getgenv()``` 中添加了两个全局表：
- **```Toggles```**: 访问开关对象。
- **```Options```**: 访问所有其他 UI 组件（滑块、下拉菜单、输入框等）。

---

## 致谢
- **Inori**: 核心开发者
- **Wally**: 优化冗长代码，扩展库功能
- **Stefanuk**: 扩展库功能
- **matas3535**: Splix 的创建者

更多信息请访问 [官方 LinoriaLib 仓库](https://github.com/violin-suzutsuki/LinoriaLib)。
