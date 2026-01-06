# Dokumentasi Linoria Library

Sebuah perpustakaan UI komprehensif untuk Roblox dengan dukungan tema, konfigurasi, dan berbagai elemen antarmuka.

> **Penting**: LinoriaLib dibuat oleh [violin-suzutsuki](https://github.com/violin-suzutsuki). Dokumentasi ini didasarkan pada perpustakaan resmi.

---

## Bahasa
- [English](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/readme.md)
- [Spanish](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/spanish.md)
- [Russian](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/russian.md)
- [Portuguese](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/portuguese.md)
- [Vietnamese](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/vietnamese.md)
- [Chinese](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/chinese.md)
- [French](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/french.md)
- [Turkish](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/turkish.md)
- [Indonesian](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/indonesian.md) - Saat Ini

---

## Daftar Isi
- [Mengimpor Library](#mengimpor-library)
- [Membuat Jendela](#membuat-jendela)
- [Membuat Tab](#membuat-tab)
- [Groupbox dan Tabbox](#groupbox-dan-tabbox)
- [Elemen UI](#elemen-ui)
  - [Toggle (Saklar)](#toggle)
  - [Button (Tombol)](#button)
  - [Label (Teks)](#label)
  - [Divider (Pemisah)](#divider)
  - [Slider (Penggeser)](#slider)
  - [Input Teks](#input-teks)
  - [Dropdown (Daftar Pilihan)](#dropdown)
  - [Color Picker (Pemilih Warna)](#color-picker)
  - [Keybind (Tombol Cepat)](#keybind)
- [Dependency Box (Kotak Ketergantungan)](#dependency-box)
- [Fungsi Library](#fungsi-library)
- [Theme Manager (Pengelola Tema)](#theme-manager)
- [Save Manager (Pengelola Simpanan)](#save-manager)

---

## Mengimpor Library

```lua
local repo = '[https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/](https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/)'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
```

---

## Membuat Jendela

```lua
local Window = Library:CreateWindow({
    Title = 'Menu Contoh',
    Center = true,        -- Atur true untuk memusatkan menu di layar
    AutoShow = true,      -- Atur true untuk langsung menampilkan menu
    TabPadding = 8,       -- Jarak antar tab
    MenuFadeTime = 0.2    -- Durasi animasi fade menu
    -- Position = UDim2 (opsional)
    -- Size = UDim2 (opsional)
})
```

---

## Membuat Tab

Tab mengatur UI Anda menjadi bagian-bagian yang berbeda.

```lua
local Tabs = {
    Main = Window:AddTab('Utama'),
    Settings = Window:AddTab('Pengaturan')
}
```

Anda juga dapat mengakses tab secara langsung:

```lua
local MainTab = Window.Tabs.Main
```

---

## Groupbox dan Tabbox

### Membuat Groupbox

Groupbox adalah wadah untuk elemen UI di sisi kiri atau kanan tab.

```lua
local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Judul Grup')
local RightGroupBox = Tabs.Main:AddRightGroupbox('Judul Grup')
```

### Membuat Tabbox

Tabbox memungkinkan Anda membuat sub-tab di dalam area groupbox.

```lua
local TabBox = Tabs.Main:AddLeftTabbox()

local Tab1 = TabBox:AddTab('Tab 1')
local Tab2 = TabBox:AddTab('Tab 2')

-- Sekarang Anda bisa menambahkan elemen ke tab ini
Tab1:AddToggle('Tab1Toggle', { Text = 'Saklar Tab 1' })
```

---

## Elemen UI

### Toggle

Saklar on/off biner.

```lua
LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Ini adalah saklar',
    Default = true,           -- Nilai default (true / false)
    Tooltip = 'Ini adalah tooltip',
    
    Callback = function(Value)
        print('[cb] MyToggle berubah menjadi:', Value)
    end
})
```

**Mengakses Status Toggle:**

```lua
-- Mendapatkan nilai saat ini
local isEnabled = Toggles.MyToggle.Value

-- Mendengarkan perubahan
Toggles.MyToggle:OnChanged(function()
    print('MyToggle berubah menjadi:', Toggles.MyToggle.Value)
end)

-- Mengatur nilai melalui skrip
Toggles.MyToggle:SetValue(false)
```

---

### Tombol (Button)

Menjalankan fungsi saat diklik.

```lua
local MyButton = LeftGroupBox:AddButton({
    Text = 'Tombol',
    Func = function()
        print('Anda mengklik tombol!')
    end,
    DoubleClick = false,      -- Memerlukan klik ganda untuk memicu
    Tooltip = 'Ini tombol utama'
})
```

---

### Penggeser (Slider)

Memilih nilai numerik dalam rentang tertentu.

```lua
LeftGroupBox:AddSlider('MySlider', {
    Text = 'Ini penggeser saya!',
    Default = 0,
    Min = 0,
    Max = 5,
    Rounding = 1,             -- Tempat desimal untuk presisi
    Compact = false,          -- Sembunyikan label judul jika true
    Suffix = '',              -- Akhiran opsional (misal, 'px', '%')
    HideMax = false,          -- Hanya tampilkan nilai, bukan nilai/maks
    
    Callback = function(Value)
        print('[cb] MySlider diubah! Nilai baru:', Value)
    end
})
```

---

### Daftar Pilihan (Dropdown)

Memilih dari daftar nilai.

```lua
LeftGroupBox:AddDropdown('MyDropdown', {
    Values = { 'Satu', 'Dua', 'Tiga', 'Empat' },
    Default = 1,              -- Indeks atau nilai string
    Multi = false,            -- Pilihan tunggal
    Text = 'Menu Pilihan',
    Tooltip = 'Ini adalah tooltip',
    
    Callback = function(Value)
        print('[cb] Dropdown berubah menjadi:', Value)
    end
})
```

---

### Pemilih Warna (Color Picker)

Memilih warna dengan transparansi opsional.

```lua
LeftGroupBox:AddLabel('Warna'):AddColorPicker('ColorPicker', {
    Default = Color3.new(0, 1, 0),     -- Hijau terang
    Title = 'Pilih warna',             -- Judul khusus opsional
    Transparency = 0,                  -- Opsional (nil untuk menonaktifkan)
    
    Callback = function(Value)
        print('[cb] Warna berubah!', Value)
    end
})
```

---

## Dependency Box

Mengontrol visibilitas elemen UI berdasarkan status elemen lainnya.

```lua
local RightGroupbox = Tabs.Main:AddRightGroupbox('Grup Dependensi')
RightGroupbox:AddToggle('ControlToggle', { Text = 'Saklar Kontrol' })

-- Membuat kotak dependensi
local Depbox = RightGroupbox:AddDependencyBox()
Depbox:AddToggle('DepboxToggle', { Text = 'Saklar Tergantung' })

-- Menyiapkan dependensi
Depbox:SetupDependencies({
    { Toggles.ControlToggle, true } -- Tampilkan saat saklar kontrol bernilai true
})
```

---

## Fungsi Library

### Watermark (Tanda Air)

```lua
-- Mengatur visibilitas
Library:SetWatermarkVisibility(true)

-- Memperbarui teks
Library:SetWatermark('Demo LinoriaLib | 60 fps | 50 ms')
```

### Bongkar Library (Unload)

```lua
-- Membongkar library dan membersihkan aset
Library:Unload()

-- Mendengarkan acara pembongkaran
Library:OnUnload(function()
    print('Library dibongkar!')
    Library.Unloaded = true
end)
```

---

## Theme Manager

Addon ThemeManager memungkinkan Anda membuat dan mengelola tema UI.

```lua
ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder('FolderScriptSaya')
ThemeManager:ApplyToTab(Tabs['Settings'])
```

---

## Save Manager

Addon SaveManager menyediakan sistem konfigurasi untuk menyimpan/memuat pengaturan.

```lua
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
SaveManager:SetFolder('FolderScriptSaya/game-spesifik')
SaveManager:BuildConfigSection(Tabs['Settings'])
SaveManager:LoadAutoloadConfig()
```

---

## Kredit
- **Inori**: Pengembang utama
- **Wally**: Pembersihan kode, perluasan fungsionalitas
- **Stefanuk**: Perluasan fungsionalitas
- **matas3535**: Pembuat Splix

Untuk informasi lebih lanjut, kunjungi [repositori resmi LinoriaLib](https://github.com/violin-suzutsuki/LinoriaLib).
