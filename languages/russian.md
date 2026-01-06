# Документация Linoria Library

Комплексная библиотека пользовательского интерфейса для Roblox с поддержкой тем, конфигураций и широким набором элементов UI.

> **Важно**: LinoriaLib была создана [violin-suzutsuki](https://github.com/violin-suzutsuki). Это документация, основанная на официальной библиотеке.

---

## Языки
- [English](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/readme.md)
- [Spanish](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/spanish.md)
- [Russian](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/russian.md) - Текущий
- [Portuguese](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/portuguese.md)
- [Vietnamese](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/vietnamese.md)
- [Chinese](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/chinese.md)
- [French](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/french.md)
- [Turkish](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/turkish.md)
- [Indonesian](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/indonesian.md)

---

## Содержание
- [Импорт библиотеки](#импорт-библиотеки)
- [Создание окна](#создание-окна)
- [Создание вкладок](#создание-вкладок)
- [Groupboxes и Tabboxes](#groupboxes-и-tabboxes)
- [Элементы UI](#элементы-ui)
  - [Переключатели (Toggles)](#переключатели)
  - [Кнопки (Buttons)](#кнопки)
  - [Текстовые метки (Labels)](#текстовые-метки)
  - [Разделители (Dividers)](#разделители)
  - [Слайдеры (Sliders)](#слайдеры)
  - [Ввод текста (Text Input)](#ввод-текста)
  - [Выпадающие списки (Dropdowns)](#выпадающие-списки)
  - [Выбор цвета (Color Pickers)](#выбор-цвета)
  - [Горячие клавиши (Keybinds)](#горячие-клавиши)
- [Контейнеры зависимостей (Dependency Boxes)](#контейнеры-зависимостей)
- [Функции библиотеки](#функции-библиотеки)
- [Менеджер тем (Theme Manager)](#менеджер-тем)
- [Менеджер сохранений (Save Manager)](#менеджер-сохранений)

---

## Импорт библиотеки

```lua
local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
```

---

## Создание окна

```lua
local Window = Library:CreateWindow({
    Title = 'Пример меню',
    Center = true,        -- Установите true, чтобы центрировать меню на экране
    AutoShow = true,      -- Установите true, чтобы показать меню сразу
    TabPadding = 8,       -- Отступ между вкладками
    MenuFadeTime = 0.2    -- Длительность анимации появления
    -- Position = UDim2 (опционально)
    -- Size = UDim2 (опционально)
})
```

---

## Создание вкладок

Вкладки организуют ваш интерфейс по разделам.

```lua
local Tabs = {
    Main = Window:AddTab('Главная'),
    Settings = Window:AddTab('Настройки')
}
```

Вы также можете обращаться к вкладкам напрямую:

```lua
local MainTab = Window.Tabs.Main
```

---

## Groupboxes и Tabboxes

### Создание Groupboxes

Groupboxes — это контейнеры для элементов интерфейса на левой или правой стороне вкладки.

```lua
local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Заголовок группы')
local RightGroupBox = Tabs.Main:AddRightGroupbox('Заголовок группы')
```

### Создание Tabboxes

Tabboxes позволяют создавать под-вкладки внутри области groupbox.

```lua
local TabBox = Tabs.Main:AddLeftTabbox()

local Tab1 = TabBox:AddTab('Вкладка 1')
local Tab2 = TabBox:AddTab('Вкладка 2')

-- Теперь вы можете добавлять элементы в эти вкладки
Tab1:AddToggle('Tab1Toggle', { Text = 'Переключатель 1' })
```

---

## Элементы UI

### Переключатели (Toggles)

Бинарные переключатели "вкл/выкл".

```lua
LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Это переключатель',
    Default = true,           -- Значение по умолчанию (true / false)
    Tooltip = 'Это всплывающая подсказка',
    
    Callback = function(Value)
        print('[cb] MyToggle изменился на:', Value)
    end
})
```

**Доступ к состоянию переключателя:**

```lua
-- Получить текущее значение
local isEnabled = Toggles.MyToggle.Value

-- Прослушивание изменений
Toggles.MyToggle:OnChanged(function()
    print('MyToggle изменился на:', Toggles.MyToggle.Value)
end)

-- Установить значение программно
Toggles.MyToggle:SetValue(false)
```

---

### Кнопки (Buttons)

Выполняют функции при нажатии.

```lua
local MyButton = LeftGroupBox:AddButton({
    Text = 'Кнопка',
    Func = function()
        print('Вы нажали кнопку!')
    end,
    DoubleClick = false,      -- Требовать двойной клик для активации
    Tooltip = 'Это основная кнопка'
})
```

**Под-кнопки (Sub-Buttons):**

Вы можете создавать цепочки кнопок.

```lua
local MyButton2 = MyButton:AddButton({
    Text = 'Под-кнопка',
    Func = function()
        print('Вы нажали под-кнопку!')
    end,
    DoubleClick = true,
    Tooltip = 'Это под-кнопка (нажми дважды!)'
})
```

**Пример цепочки:**

```lua
LeftGroupBox:AddButton({ 
    Text = 'Убить всех', 
    Func = Functions.KillAll, 
    Tooltip = 'Это убьет всех в игре!' 
})
:AddButton({ 
    Text = 'Кикнуть всех', 
    Func = Functions.KickAll, 
    Tooltip = 'Это кикнет всех из игры!' 
})
```

---

### Текстовые метки (Labels)

Отображение текстовой информации.

```lua
LeftGroupBox:AddLabel('Это текстовая метка')

-- Метка с переносом текста
LeftGroupBox:AddLabel('Это метка\n\nс переносом текста!', true)
```

**Параметры:**
- ```Text``` (string): Текст для отображения
- ```DoesWrap``` (boolean, опционально): Включить перенос текста

---

### Разделители (Dividers)

Визуальное разделение между элементами.

```lua
LeftGroupBox:AddDivider()
```

---

### Слайдеры (Sliders)

Выбор числовых значений в диапазоне.

```lua
LeftGroupBox:AddSlider('MySlider', {
    Text = 'Это мой слайдер!',
    Default = 0,
    Min = 0,
    Max = 5,
    Rounding = 1,             -- Количество знаков после запятой
    Compact = false,          -- Скрыть заголовок, если true
    Suffix = '',              -- Опциональный суффикс (например, 'px', '%')
    HideMax = false,          -- Показывать только значение, а не значение/макс
    
    Callback = function(Value)
        print('[cb] MySlider изменился! Новое значение:', Value)
    end
})
```

**Обязательные параметры:**
- ```Text```, ```Default```, ```Min```, ```Max```, ```Rounding``` должны быть указаны.

**Доступ к значению слайдера:**

```lua
-- Получить текущее значение
local Number = Options.MySlider.Value

-- Прослушивание изменений
Options.MySlider:OnChanged(function()
    print('MySlider изменился! Новое значение:', Options.MySlider.Value)
end)

-- Установить значение программно
Options.MySlider:SetValue(3)
```

---

### Ввод текста (Text Input)

Поля для ввода текста пользователем.

```lua
LeftGroupBox:AddInput('MyTextbox', {
    Default = 'Текст!',
    Numeric = false,          -- true = разрешить только числа
    Finished = false,         -- true = вызывать callback только при нажатии Enter
    Text = 'Это текстовое поле',
    Tooltip = 'Подсказка',
    Placeholder = 'Введите текст...',
    -- MaxLength = number (опционально)
    
    Callback = function(Value)
        print('[cb] Текст обновлен. Новое значение:', Value)
    end
})
```

**Доступ к значению ввода:**

```lua
Options.MyTextbox:OnChanged(function()
    print('Текст обновлен. Новое значение:', Options.MyTextbox.Value)
end)
```

---

### Выпадающие списки (Dropdowns)

Выбор из списка значений.

#### Одиночный выбор

```lua
LeftGroupBox:AddDropdown('MyDropdown', {
    Values = { 'Первый', 'Второй', 'Третий', 'Четвертый' },
    Default = 1,              -- Индекс или строка
    Multi = false,            -- Одиночный выбор
    Text = 'Список',
    Tooltip = 'Подсказка',
    
    Callback = function(Value)
        print('[cb] Dropdown изменился. Новое значение:', Value)
    end
})
```

**Доступ к значению списка:**

```lua
Options.MyDropdown:OnChanged(function()
    print('Dropdown изменился. Новое значение:', Options.MyDropdown.Value)
end)

-- Установить значение программно
Options.MyDropdown:SetValue('Первый')
```

#### Множественный выбор

```lua
LeftGroupBox:AddDropdown('MyMultiDropdown', {
    Values = { 'Один', 'Два', 'Три', 'Четыре' },
    Default = 1,
    Multi = true,             -- Разрешить выбор нескольких элементов
    Text = 'Мульти-список',
    Tooltip = 'Подсказка',
    
    Callback = function(Value)
        print('[cb] Мульти-список изменился:', Value)
    end
})
```

**Доступ к значениям мульти-выбора:**

```lua
Options.MyMultiDropdown:OnChanged(function()
    print('Мульти-список изменился:')
    for key, value in next, Options.MyMultiDropdown.Value do
        print(key, value) -- например: "Один", true
    end
end)

-- Установить несколько значений
Options.MyMultiDropdown:SetValue({
    Один = true,
    Два = true,
})
```

---

### Выбор цвета (Color Pickers)

Выбор цвета с поддержкой прозрачности.

```lua
LeftGroupBox:AddLabel('Цвет'):AddColorPicker('ColorPicker', {
    Default = Color3.new(0, 1, 0),     -- Ярко-зеленый
    Title = 'Выберите цвет',           -- Опциональный заголовок
    Transparency = 0,                  -- Опционально (nil для отключения)
    
    Callback = function(Value)
        print('[cb] Цвет изменился!', Value)
    end
})
```

**Доступ к Color Picker:**

```lua
Options.ColorPicker:OnChanged(function()
    print('Цвет:', Options.ColorPicker.Value)
    print('Прозрачность:', Options.ColorPicker.Transparency)
end)

-- Установить цвет программно
Options.ColorPicker:SetValueRGB(Color3.fromRGB(0, 255, 140))
```

---

### Горячие клавиши (Keybinds)

Привязка действий к клавишам или кнопкам мыши.

```lua
LeftGroupBox:AddLabel('Клавиша'):AddKeyPicker('KeyPicker', {
    Default = 'MB2',          -- MB1, MB2 для кнопок мыши
    SyncToggleState = false,  -- Синхронизировать состояние с родителем-переключателем
    Mode = 'Toggle',          -- Режимы: Always, Toggle, Hold
    Text = 'Авто-взлом сейфов',
    NoUI = false,             -- Скрыть из меню биндов, если true
    
    -- Срабатывает при нажатии
    Callback = function(Value)
        print('[cb] Клавиша нажата!', Value)
    end,
    
    -- Срабатывает при смене клавиши
    ChangedCallback = function(New)
        print('[cb] Клавиша изменена!', New)
    end
})
```

**Accessing Keybind:**

```lua
-- OnClick работает только в режиме Toggle
Options.KeyPicker:OnClick(function()
    print('Клик по бинду!', Options.KeyPicker:GetState())
end)

Options.KeyPicker:OnChanged(function()
    print('Бинд изменен!', Options.KeyPicker.Value)
end)

-- Проверка нажатия
local state = Options.KeyPicker:GetState()
if state then
    print('Клавиша удерживается')
end
```

---

## Контейнеры зависимостей (Dependency Boxes)

Управление видимостью элементов на основе состояния других элементов.

```lua
local RightGroupbox = Tabs.Main:AddRightGroupbox('Группа зависимостей')
RightGroupbox:AddToggle('ControlToggle', { Text = 'Управляющий переключатель' })

-- Создание контейнера
local Depbox = RightGroupbox:AddDependencyBox()
Depbox:AddToggle('DepboxToggle', { Text = 'Вложенный переключатель' })

-- Настройка зависимостей
Depbox:SetupDependencies({
    { Toggles.ControlToggle, true } -- Показать, когда переключатель активен
})
```

---

## Функции библиотеки

### Ватермарк (Watermark)

```lua
-- Видимость
Library:SetWatermarkVisibility(true)

-- Текст
Library:SetWatermark('LinoriaLib демо | 60 fps | 50 ms')
```

### Выгрузка (Unload)

```lua
-- Полная выгрузка
Library:Unload()

-- Событие при выгрузке
Library:OnUnload(function()
    print('Библиотека выгружена!')
    Library.Unloaded = true
end)
```

---

## Theme Manager

Аддон для управления темами.

```lua
ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder('MyScriptHub')
ThemeManager:ApplyToTab(Tabs['Настройки'])
```

---

## Save Manager

Система конфигураций для сохранения настроек.

```lua
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
SaveManager:SetFolder('MyScriptHub/game-name')
SaveManager:BuildConfigSection(Tabs['Настройки'])
SaveManager:LoadAutoloadConfig()
```

---

## Авторы

- **Inori**: Основной разработчик
- **Wally**: Чистка кода, расширение функционала
- **Stefanuk**: Расширение функционала
- **matas3535**: Создатель Splix

Для получения дополнительной информации посетите [официальный репозиторий LinoriaLib](https://github.com/violin-suzutsuki/LinoriaLib).
