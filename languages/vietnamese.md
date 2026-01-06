# Tài liệu Thư viện Linoria

Một thư viện giao diện (UI) toàn diện cho Roblox hỗ trợ chủ đề (themes), cấu hình (configurations) và đa dạng các thành phần UI.

> **Quan trọng**: LinoriaLib được tạo bởi [violin-suzutsuki](https://github.com/violin-suzutsuki). Đây là tài liệu dựa trên thư viện chính thức.

---

## Ngôn ngữ
- [English](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/readme.md)
- [Spanish](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/spanish.md)
- [Russian](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/russian.md)
- [Portuguese](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/portuguese.md)
- [Vietnamese](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/vietnamese.md) - Hiện tại
- [Chinese](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/chinese.md)
- [French](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/french.md)
- [Turkish](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/turkish.md)
- [Indonesian](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/indonesian.md)

---

## Mục lục
- [Nhập thư viện](#nhập-thư-viện)
- [Tạo cửa sổ](#tạo-cửa-sổ)
- [Tạo Tab](#tạo-tab)
- [Groupboxes và Tabboxes](#groupboxes-và-tabboxes)
- [Thành phần UI](#thành-phần-ui)
  - [Toggles (Công tắc)](#toggles)
  - [Buttons (Nút bấm)](#buttons)
  - [Labels (Nhãn văn bản)](#labels)
  - [Dividers (Thanh ngăn)](#dividers)
  - [Sliders (Thanh trượt)](#sliders)
  - [Text Input (Nhập văn bản)](#text-input)
  - [Dropdowns (Danh sách chọn)](#dropdowns)
  - [Color Pickers (Chọn màu)](#color-pickers)
  - [Keybinds (Phím tắt)](#keybinds)
- [Dependency Boxes (Hộp phụ thuộc)](#dependency-boxes)
- [Các hàm thư viện](#các-hàm-thư-viện)
- [Theme Manager (Quản lý chủ đề)](#theme-manager)
- [Save Manager (Quản lý lưu trữ)](#save-manager)

---

## Nhập thư viện

`lua
local repo = '[https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/](https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/)'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
``

---

## Tạo cửa sổ

`lua
local Window = Library:CreateWindow({
    Title = 'Menu ví dụ',
    Center = true,        -- Đặt thành true để căn giữa menu trên màn hình
    AutoShow = true,      -- Đặt thành true để hiển thị menu ngay lập tức
    TabPadding = 8,       -- Khoảng cách giữa các tab
    MenuFadeTime = 0.2    -- Thời gian hiệu ứng mờ dần
    -- Position = UDim2 (tùy chọn)
    -- Size = UDim2 (tùy chọn)
})
``

---

## Tạo Tab

Tab giúp tổ chức giao diện của bạn thành các phần khác nhau.

`lua
local Tabs = {
    Main = Window:AddTab('Chính'),
    Settings = Window:AddTab('Cài đặt')
}
``

Bạn cũng có thể truy cập tab trực tiếp:

`lua
local MainTab = Window.Tabs.Main
``

---

## Groupboxes và Tabboxes

### Tạo Groupboxes

Groupbox là các khung chứa thành phần UI ở phía bên trái hoặc bên phải của tab.

`lua
local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Tiêu đề nhóm')
local RightGroupBox = Tabs.Main:AddRightGroupbox('Tiêu đề nhóm')
``

### Tạo Tabboxes

Tabbox cho phép bạn tạo các tab phụ bên trong một khu vực groupbox.

`lua
local TabBox = Tabs.Main:AddLeftTabbox()

local Tab1 = TabBox:AddTab('Tab 1')
local Tab2 = TabBox:AddTab('Tab 2')

-- Bây giờ bạn có thể thêm các thành phần vào các tab này
Tab1:AddToggle('Tab1Toggle', { Text = 'Công tắc Tab 1' })
``

---

## Thành phần UI

### Toggles (Công tắc)

Công tắc bật/tắt nhị phân.

`lua
LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Đây là một công tắc',
    Default = true,           -- Giá trị mặc định (true / false)
    Tooltip = 'Đây là một chú thích',
    
    Callback = function(Value)
        print('[cb] MyToggle đã đổi thành:', Value)
    end
})
``

**Truy cập trạng thái Toggle:**

`lua
-- Lấy giá trị hiện tại
local isEnabled = Toggles.MyToggle.Value

-- Lắng nghe thay đổi
Toggles.MyToggle:OnChanged(function()
    print('MyToggle đã đổi thành:', Toggles.MyToggle.Value)
end)

-- Đặt giá trị bằng code
Toggles.MyToggle:SetValue(false)
``

---

### Buttons (Nút bấm)

Thực thi các hàm khi được nhấp vào.

`lua
local MyButton = LeftGroupBox:AddButton({
    Text = 'Nút bấm',
    Func = function()
        print('Bạn đã nhấn nút!')
    end,
    DoubleClick = false,      -- Yêu cầu nhấp đúp để kích hoạt
    Tooltip = 'Đây là nút chính'
})
``

**Nút phụ (Sub-Buttons):**

Bạn có thể nối chuỗi các nút để tạo nút phụ.

`lua
local MyButton2 = MyButton:AddButton({
    Text = 'Nút phụ',
    Func = function()
        print('Bạn đã nhấn nút phụ!')
    end,
    DoubleClick = true,
    Tooltip = 'Đây là nút phụ (nhấp đúp vào tôi!)'
})
``

---

### Labels (Nhãn)

Hiển thị thông tin văn bản.

`lua
LeftGroupBox:AddLabel('Đây là một nhãn')

-- Nhãn có tự động xuống dòng
LeftGroupBox:AddLabel('Đây là một nhãn\n\ncó thể tự động xuống dòng!', true)
``

---

### Sliders (Thanh trượt)

Chọn các giá trị số trong một phạm vi.

`lua
LeftGroupBox:AddSlider('MySlider', {
    Text = 'Đây là thanh trượt của tôi!',
    Default = 0,
    Min = 0,
    Max = 5,
    Rounding = 1,             -- Số chữ số thập phân
    Compact = false,          -- Ẩn tiêu đề nếu là true
    Suffix = '',              -- Hậu tố tùy chọn (vd: 'px', '%')
    HideMax = false,          -- Chỉ hiện giá trị, không hiện giá trị/tối đa
    
    Callback = function(Value)
        print('[cb] MySlider đã thay đổi! Giá trị mới:', Value)
    end
})
``

---

### Text Input (Nhập văn bản)

Ô văn bản để người dùng nhập liệu.

`lua
LeftGroupBox:AddInput('MyTextbox', {
    Default = 'Văn bản của tôi!',
    Numeric = false,          -- true = chỉ cho phép nhập số
    Finished = false,         -- true = chỉ gọi callback khi nhấn Enter
    Text = 'Đây là một ô nhập liệu',
    Tooltip = 'Đây là chú thích',
    Placeholder = 'Văn bản giữ chỗ',
    
    Callback = function(Value)
        print('[cb] Văn bản đã cập nhật:', Value)
    end
})
``

---

### Dropdowns (Danh sách chọn)

Chọn từ một danh sách các giá trị.

`lua
LeftGroupBox:AddDropdown('MyDropdown', {
    Values = { 'Cái này', 'là', 'một', 'danh sách' },
    Default = 1,              -- Chỉ số (index) hoặc giá trị chuỗi
    Multi = false,            -- Chọn một giá trị
    Text = 'Một danh sách chọn',
    Tooltip = 'Đây là chú thích',
    
    Callback = function(Value)
        print('[cb] Dropdown đã thay đổi thành:', Value)
    end
})
``

---

### Color Pickers (Chọn màu)

Chọn màu sắc với tùy chọn độ trong suốt.

`lua
LeftGroupBox:AddLabel('Màu sắc'):AddColorPicker('ColorPicker', {
    Default = Color3.new(0, 1, 0),     -- Màu xanh lá tươi
    Title = 'Chọn màu',                -- Tiêu đề tùy chỉnh
    Transparency = 0,                  -- Tùy chọn (nil để tắt)
    
    Callback = function(Value)
        print('[cb] Màu đã đổi!', Value)
    end
})
``

---

### Keybinds (Phím tắt)

Gán hành động cho các phím bàn phím hoặc nút chuột.

`lua
LeftGroupBox:AddLabel('Phím tắt'):AddKeyPicker('KeyPicker', {
    Default = 'MB2',          -- MB1, MB2 cho các nút chuột
    SyncToggleState = false,  -- Đồng bộ trạng thái với Toggle cha
    Mode = 'Toggle',          -- Chế độ: Always, Toggle, Hold
    Text = 'Tự động mở khóa',
    NoUI = false,             -- Ẩn khỏi menu phím tắt nếu là true
    
    Callback = function(Value)
        print('[cb] Đã nhấn phím tắt!', Value)
    end,
    
    ChangedCallback = function(New)
        print('[cb] Phím tắt đã đổi thành:', New)
    end
})
``

---

## Dependency Boxes (Hộp phụ thuộc)

Điều khiển sự hiển thị của thành phần UI dựa trên trạng thái của thành phần khác.

`lua
local RightGroupbox = Tabs.Main:AddRightGroupbox('Nhóm phụ thuộc')
RightGroupbox:AddToggle('ControlToggle', { Text = 'Công tắc điều khiển' })

local Depbox = RightGroupbox:AddDependencyBox()
Depbox:AddToggle('DepboxToggle', { Text = 'Công tắc phụ thuộc' })

-- Thiết lập phụ thuộc
Depbox:SetupDependencies({
    { Toggles.ControlToggle, true } -- Hiển thị khi công tắc điều khiển là true
})
``

---

## Các hàm thư viện

### Watermark (Dấu mờ)

`lua
Library:SetWatermarkVisibility(true)
Library:SetWatermark('LinoriaLib demo | 60 fps | 50 ms')
``

### Unload (Gỡ cài đặt)

`lua
Library:Unload()

Library:OnUnload(function()
    print('Thư viện đã được gỡ!')
    Library.Unloaded = true
end)
``

---

## Theme Manager

Addon ThemeManager cho phép bạn tạo và quản lý các chủ đề UI.

`lua
ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder('MyScriptHub')
ThemeManager:ApplyToTab(Tabs['Settings'])
``

---

## Save Manager

Addon SaveManager cung cấp hệ thống cấu hình để lưu/tải các cài đặt.

`lua
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
SaveManager:SetFolder('MyScriptHub/specific-game')
SaveManager:BuildConfigSection(Tabs['Settings'])
SaveManager:LoadAutoloadConfig()
``

---

## Thực hành tốt nhất

### Tách biệt Code UI và Logic

Khuyến khích tách code UI khỏi code xử lý:

`lua
-- NÊN DÙNG: Tách biệt UI và logic
LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Công tắc',
    Default = true
})

Toggles.MyToggle:OnChanged(function()
    print('Giá trị:', Toggles.MyToggle.Value)
end)
``

### Truy cập các thành phần

Thư viện thêm hai bảng toàn cục vào `getgenv()`:
- **`Toggles`**: Truy cập các đối tượng công tắc.
- **`Options`**: Truy cập tất cả các thành phần khác (thanh trượt, danh sách, ô nhập, v.v.).

---

## Tín dụng
- **Inori**: Nhà phát triển chính
- **Wally**: Tối ưu code, mở rộng chức năng
- **Stefanuk**: Mở rộng chức năng
- **matas3535**: Người tạo ra Splix

Để biết thêm thông tin, hãy truy cập [kho lưu trữ LinoriaLib chính thức](https://github.com/violin-suzutsuki/LinoriaLib).
