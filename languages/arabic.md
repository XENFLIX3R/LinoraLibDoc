# توثيق LinoriaLib

مكتبة واجهة مستخدم شاملة لـ Roblox مع دعم السمات (Themes)، الإعدادات (Configurations)، ومجموعة واسعة من عناصر واجهة المستخدم.

> **مهم**: تم إنشاء LinoriaLib بواسطة  
> [violin-suzutsuki](https://github.com/violin-suzutsuki)  
> هذا التوثيق مبني على المكتبة الرسمية.

---

## اللغات
- [الإنجليزية](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/readme.md)
- [الإسبانية](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/spanish.md)
- [العربية](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/arabic.md) - الحالي
- [الروسية](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/russian.md)
- [البرتغالية](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/portuguese.md)
- [الفيتنامية](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/vietnamese.md)
- [الصينية](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/chinese.md)
- [الفرنسية](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/french.md)
- [التركية](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/turkish.md)
- [الإندونيسية](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/indonesian.md)

---

## جدول المحتويات
- [استيراد المكتبة](#استيراد-المكتبة)
- [إنشاء نافذة](#إنشاء-نافذة)
- [إنشاء التبويبات](#إنشاء-التبويبات)
- [Groupboxes و Tabboxes](#groupboxes-و-tabboxes)
- [عناصر الواجهة](#عناصر-الواجهة)
  - [مفاتيح التفعيل](#مفاتيح-التفعيل)
  - [الأزرار](#الأزرار)
  - [التسميات](#التسميات)
  - [الفواصل](#الفواصل)
  - [أشرطة التمرير](#أشرطة-التمرير)
  - [إدخال النص](#إدخال-النص)
  - [القوائم المنسدلة](#القوائم-المنسدلة)
  - [منتقي الألوان](#منتقي-الألوان)
  - [اختصارات المفاتيح](#اختصارات-المفاتيح)
- [صناديق الاعتماد](#صناديق-الاعتماد)
- [وظائف المكتبة](#وظائف-المكتبة)
- [مدير السمات](#مدير-السمات)
- [مدير الحفظ](#مدير-الحفظ)

---

## استيراد المكتبة

```lua
local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
```

---

## إنشاء نافذة

```lua
local Window = Library:CreateWindow({
    Title = 'قائمة مثال',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})
```

---

## إنشاء التبويبات

```lua
local Tabs = {
    Main = Window:AddTab('الرئيسية'),
    Settings = Window:AddTab('الإعدادات')
}
```

```lua
local MainTab = Window.Tabs.Main
```

---

## Groupboxes و Tabboxes

### إنشاء Groupbox

```lua
local LeftGroupBox = Tabs.Main:AddLeftGroupbox('عنوان المجموعة')
local RightGroupBox = Tabs.Main:AddRightGroupbox('عنوان المجموعة')
```

### إنشاء Tabbox

```lua
local TabBox = Tabs.Main:AddLeftTabbox()

local Tab1 = TabBox:AddTab('تبويب 1')
local Tab2 = TabBox:AddTab('تبويب 2')

Tab1:AddToggle('Tab1Toggle', { Text = 'زر تفعيل التبويب 1' })
```

---

## عناصر الواجهة

### مفاتيح التفعيل

```lua
LeftGroupBox:AddToggle('MyToggle', {
    Text = 'هذا مفتاح تفعيل',
    Default = true,
    Tooltip = 'هذه تلميحة',

    Callback = function(Value)
        print('[cb] تم تغيير MyToggle إلى:', Value)
    end
})
```

```lua
local isEnabled = Toggles.MyToggle.Value

Toggles.MyToggle:OnChanged(function()
    print('تم تغيير MyToggle إلى:', Toggles.MyToggle.Value)
end)

Toggles.MyToggle:SetValue(false)
```

---

### الأزرار

```lua
local MyButton = LeftGroupBox:AddButton({
    Text = 'زر',
    Func = function()
        print('تم الضغط على الزر!')
    end,
    DoubleClick = false,
    Tooltip = 'هذا هو الزر الرئيسي'
})
```

```lua
MyButton:AddButton({
    Text = 'زر فرعي',
    Func = function()
        print('تم الضغط على الزر الفرعي!')
    end,
    DoubleClick = true,
    Tooltip = 'زر فرعي (نقر مزدوج)'
})
```

---

### التسميات

```lua
LeftGroupBox:AddLabel('هذا وسم نصي')
LeftGroupBox:AddLabel('هذا وسم\nيلتف النص بداخله', true)
```

---

### الفواصل

```lua
LeftGroupBox:AddDivider()
```

---

### أشرطة التمرير

```lua
LeftGroupBox:AddSlider('MySlider', {
    Text = 'شريط تمرير',
    Default = 0,
    Min = 0,
    Max = 5,
    Rounding = 1,

    Callback = function(Value)
        print('[cb] تم تغيير القيمة إلى:', Value)
    end
})
```

```lua
Options.MySlider:SetValue(3)
```

---

### إدخال النص

```lua
LeftGroupBox:AddInput('MyTextbox', {
    Default = 'مربع نص',
    Numeric = false,
    Finished = false,
    Text = 'إدخال نص',
    Tooltip = 'تلميحة',

    Callback = function(Value)
        print('[cb] النص الجديد:', Value)
    end
})
```

---

### القوائم المنسدلة

```lua
LeftGroupBox:AddDropdown('MyDropdown', {
    Values = { 'هذا', 'قائمة', 'منسدلة' },
    Default = 1,
    Multi = false,
    Text = 'قائمة منسدلة',

    Callback = function(Value)
        print('[cb] القيمة الجديدة:', Value)
    end
})
```

```lua
LeftGroupBox:AddDropdown('MyMultiDropdown', {
    Values = { 'أ', 'ب', 'ج' },
    Default = 1,
    Multi = true,
    Text = 'قائمة متعددة'
})
```

---

### منتقي الألوان

```lua
LeftGroupBox:AddLabel('لون'):AddColorPicker('ColorPicker', {
    Default = Color3.new(0, 1, 0),
    Title = 'اختيار لون',

    Callback = function(Value)
        print('[cb] تم تغيير اللون', Value)
    end
})
```

---

### اختصارات المفاتيح

```lua
LeftGroupBox:AddLabel('اختصار'):AddKeyPicker('KeyPicker', {
    Default = 'MB2',
    Mode = 'Toggle',
    Text = 'اختصار مفتاح',

    Callback = function(Value)
        print('[cb] تم الضغط على الاختصار', Value)
    end,

    ChangedCallback = function(New)
        print('[cb] تم تغيير الاختصار', New)
    end
})
```

---

## صناديق الاعتماد

```lua
local Depbox = RightGroupBox:AddDependencyBox()
Depbox:AddToggle('DepboxToggle', { Text = 'تفعيل فرعي' })

Depbox:SetupDependencies({
    { Toggles.ControlToggle, true }
})
```

---

## وظائف المكتبة

```lua
Library:SetWatermarkVisibility(true)
Library:SetWatermark('عرض LinoriaLib | 60 fps | 50 ms')
```

```lua
Library:Unload()

Library:OnUnload(function()
    print('تم إلغاء تحميل المكتبة')
    Library.Unloaded = true
end)
```

---

## مدير السمات

```lua
ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder('MyScriptHub')
ThemeManager:ApplyToTab(Tabs['UI Settings'])
```

---

## مدير الحفظ

```lua
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
SaveManager:SetFolder('MyScriptHub/specific-game')
SaveManager:BuildConfigSection(Tabs['UI Settings'])
SaveManager:LoadAutoloadConfig()
```

---

## أفضل الممارسات

```lua
LeftGroupBox:AddToggle('MyToggle', {
    Text = 'زر تفعيل',
    Default = true
})

Toggles.MyToggle:OnChanged(function()
    print('القيمة:', Toggles.MyToggle.Value)
end)
```

---

## الوصول إلى العناصر

```lua
local toggleValue = Toggles.MyToggle.Value
local sliderValue = Options.MySlider.Value
local dropdownValue = Options.MyDropdown.Value
local textboxValue = Options.MyTextbox.Value
local colorValue = Options.ColorPicker.Value
local keybindValue = Options.KeyPicker.Value
```

---

## الشكر والتقدير

- **Inori**: المطور الرئيسي  
- **Wally**: تحسين الكود وتوسيع المكتبة  
- **Stefanuk**: توسيع وظائف المكتبة  
- **matas3535**: منشئ Splix

لمزيد من المعلومات، زر المستودع الرسمي لـ LinoriaLib.
