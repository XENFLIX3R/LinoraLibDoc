# Linoria Library Dokümantasyonu

Temalar, yapılandırmalar ve geniş bir UI öğeleri yelpazesi desteğine sahip, Roblox için kapsamlı bir kullanıcı arayüzü (UI) kütüphanesi.

> **Önemli**: LinoriaLib, [violin-suzutsuki](https://github.com/violin-suzutsuki) tarafından oluşturulmuştur. Bu dokümantasyon resmi kütüphaneye dayanmaktadır.

---

## Diller
- [English](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/readme.md)
- [Spanish](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/spanish.md)
- [Russian](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/russian.md)
- [Portuguese](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/portuguese.md)
- [Vietnamese](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/vietnamese.md)
- [Chinese](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/chinese.md)
- [French](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/french.md)
- [Turkish](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/turkish.md) - Güncel
- [Indonesian](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/indonesian.md)

---

## İçindekiler
- [Kütüphaneyi İçe Aktarma](#kütüphaneyi-içe-aktarma)
- [Pencere Oluşturma](#pencere-oluşturma)
- [Sekme Oluşturma](#sekme-oluşturma)
- [Groupboxlar ve Tabboxlar](#groupboxlar-ve-tabboxlar)
- [UI Öğeleri](#ui-öğeleri)
  - [Togglelar (Aç/Kapat)](#togglelar)
  - [Butonlar](#butonlar)
  - [Etiketler (Labels)](#etiketler)
  - [Ayırıcılar (Dividers)](#ayırıcılar)
  - [Sürgüler (Sliders)](#sürgüler)
  - [Metin Girişi (Text Input)](#metin-girişi)
  - [Açılır Menüler (Dropdowns)](#açılır-menüler)
  - [Renk Seçiciler (Color Pickers)](#renk-seçiciler)
  - [Tuş Atamaları (Keybinds)](#tuş-atamaları)
- [Bağımlılık Kutuları (Dependency Boxes)](#bağımlılık-kutuları)
- [Kütüphane Fonksiyonları](#kütüphane-fonksiyonları)
- [Tema Yöneticisi (Theme Manager)](#tema-yöneticisi)
- [Kayıt Yöneticisi (Save Manager)](#kayıt-yöneticisi)

---

## Kütüphaneyi İçe Aktarma

```lua
local repo = '[https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/](https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/)'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
```

---

## Pencere Oluşturma

```lua
local Window = Library:CreateWindow({
    Title = 'Örnek Menü',
    Center = true,        -- Menüyü ekranda ortalamak için true yapın
    AutoShow = true,      -- Menüyü hemen göstermek için true yapın
    TabPadding = 8,       -- Sekmeler arası boşluk
    MenuFadeTime = 0.2    -- Kararma/aydınlanma animasyon süresi
    -- Position = UDim2 (isteğe bağlı)
    -- Size = UDim2 (isteğe bağlı)
})
```

---

## Sekme Oluşturma

Sekmeler, arayüzünüzü farklı bölümlere ayırır.

```lua
local Tabs = {
    Main = Window:AddTab('Ana Menü'),
    Settings = Window:AddTab('Ayarlar')
}
```

Sekmelere doğrudan şu şekilde de erişebilirsiniz:

```lua
local MainTab = Window.Tabs.Main
```

---

## Groupboxlar ve Tabboxlar

### Groupbox Oluşturma

Groupboxlar, bir sekmenin sol veya sağ tarafındaki UI öğeleri için kapsayıcılardır.

```lua
local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Grup Başlığı')
local RightGroupBox = Tabs.Main:AddRightGroupbox('Grup Başlığı')
```

### Tabbox Oluşturma

Tabboxlar, bir groupbox alanı içinde alt sekmeler oluşturmanıza olanak tanır.

```lua
local TabBox = Tabs.Main:AddLeftTabbox()

local Tab1 = TabBox:AddTab('Sekme 1')
local Tab2 = TabBox:AddTab('Sekme 2')

-- Artık bu sekmelere öğe ekleyebilirsiniz
Tab1:AddToggle('Tab1Toggle', { Text = 'Sekme 1 Toggle' })
```

---

## UI Öğeleri

### Togglelar (Aç/Kapat)

İkili açık/kapalı anahtarları.

```lua
LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Bu bir toggle',
    Default = true,           -- Varsayılan değer (true / false)
    Tooltip = 'Bu bir ipucudur',
    
    Callback = function(Value)
        print('[cb] MyToggle şuna değişti:', Value)
    end
})
```

---

### Butonlar

Tıklandığında fonksiyonları çalıştırır.

```lua
local MyButton = LeftGroupBox:AddButton({
    Text = 'Buton',
    Func = function()
        print('Butona tıkladınız!')
    end,
    DoubleClick = false,      -- Tetiklemek için çift tıklama gerektirsin mi?
    Tooltip = 'Bu ana butondur'
})
```

---

### Sürgüler (Sliders)

Bir aralıkta sayısal değer seçin.

```lua
LeftGroupBox:AddSlider('MySlider', {
    Text = 'Bu benim sürgüm!',
    Default = 0,
    Min = 0,
    Max = 5,
    Rounding = 1,             -- Hassasiyet için ondalık basamak
    Compact = false,          -- true ise başlık etiketini gizle
    Suffix = '',              -- İsteğe bağlı son ek (örn: 'px', '%')
    HideMax = false,          -- Sadece değeri göster, değer/maksimum gösterme
    
    Callback = function(Value)
        print('[cb] MySlider değişti! Yeni değer:', Value)
    end
})
```

---

### Renk Seçiciler (Color Pickers)

İsteğe bağlı şeffaflık ile renkleri seçin.

```lua
LeftGroupBox:AddLabel('Renk'):AddColorPicker('ColorPicker', {
    Default = Color3.new(0, 1, 0),     -- Parlak yeşil
    Title = 'Bir renk seç',            -- İsteğe bağlı özel başlık
    Transparency = 0,                  -- İsteğe bağlı (devre dışı bırakmak için nil)
    
    Callback = function(Value)
        print('[cb] Renk değişti!', Value)
    end
})
```

---

## Bağımlılık Kutuları (Dependency Boxes)

UI öğelerinin görünürlüğünü diğer öğelerin durumlarına göre kontrol edin.

```lua
local RightGroupbox = Tabs.Main:AddRightGroupbox('Bağımlılık Grubu')
RightGroupbox:AddToggle('ControlToggle', { Text = 'Kontrol Toggle' })

-- Bağımlılık kutusu oluştur
local Depbox = RightGroupbox:AddDependencyBox()
Depbox:AddToggle('DepboxToggle', { Text = 'Bağımlı Toggle' })

-- Bağımlılıkları kur
Depbox:SetupDependencies({
    { Toggles.ControlToggle, true } -- Kontrol toggle true olduğunda göster
})
```

---

## Kütüphane Fonksiyonları

### Watermark (Filigran)

```lua
-- Görünürlük
Library:SetWatermarkVisibility(true)

-- Metni güncelle
Library:SetWatermark('LinoriaLib demo | 60 fps | 50 ms')
```

### Unload (Kapatma)

```lua
-- Kütüphaneyi temizle ve kapat
Library:Unload()

-- Unload olayını dinle
Library:OnUnload(function()
    print('Kütüphane kapatıldı!')
    Library.Unloaded = true
end)
```

---

## Tema Yöneticisi (Theme Manager)

ThemeManager eklentisi, UI temaları oluşturmanıza ve yönetmenize olanak tanır.

```lua
ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder('ScriptHubKlasorum')
ThemeManager:ApplyToTab(Tabs['Settings'])
```

---

## Kayıt Yöneticisi (Save Manager)

SaveManager eklentisi, ayarları kaydetmek/yüklemek için bir yapılandırma sistemi sağlar.

```lua
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
SaveManager:SetFolder('ScriptHubKlasorum/oyun-adi')
SaveManager:BuildConfigSection(Tabs['Settings'])
SaveManager:LoadAutoloadConfig()
```

---

## Krediler
- **Inori**: Ana geliştirici
- **Wally**: Kod temizleme ve işlevsellik ekleme
- **Stefanuk**: İşlevsellik ekleme
- **matas3535**: Splix'in yaratıcısı

Daha fazla bilgi için [resmi LinoriaLib deposunu](https://github.com/violin-suzutsuki/LinoriaLib) ziyaret edin.
