# Documentación de LinoriaLib

Una biblioteca de UI completa para Roblox con soporte para temas, configuraciones y una amplia variedad de elementos de interfaz.

> **Importante**: LinoriaLib fue creada por [violin-suzutsuki](https://github.com/violin-suzutsuki). Esta es documentación basada en la biblioteca oficial.

---

## Idiomas
- [Inglés](
- [Español](
- [Árabe](
- [Ruso](
- [Portugués](
- [Vietnamita](
- [Chino](
- [Francés](
- [Turco](
- [Indonesio](
  
---

## Tabla de Contenidos
- [Importando la Biblioteca](#importando-la-biblioteca)
- [Creando una Ventana](#creando-una-ventana)
- [Creando Pestañas](#creando-pestañas)
- [Groupboxes y Tabboxes](#groupboxes-y-tabboxes)
- [Elementos de UI](#elementos-de-ui)
  - [Toggles](#toggles)
  - [Botones](#botones)
  - [Etiquetas](#etiquetas)
  - [Divisores](#divisores)
  - [Sliders](#sliders)
  - [Entrada de Texto](#entrada-de-texto)
  - [Dropdowns](#dropdowns)
  - [Selectores de Color](#selectores-de-color)
  - [Keybinds](#keybinds)
- [Cajas de Dependencia](#cajas-de-dependencia)
- [Funciones de la Biblioteca](#funciones-de-la-biblioteca)
- [Gestor de Temas](#gestor-de-temas)
- [Gestor de Configuraciones](#gestor-de-configuraciones)

---

## Importando la Biblioteca

```lua
local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
```

---

## Creando una Ventana

```lua
local Window = Library:CreateWindow({
    Title = 'Menú de ejemplo',
    Center = true,        -- Poner en true para centrar el menú en pantalla
    AutoShow = true,      -- Poner en true para mostrar el menú inmediatamente
    TabPadding = 8,       -- Espaciado entre pestañas
    MenuFadeTime = 0.2    -- Duración de la animación de desvanecimiento
    -- Position = UDim2 (opcional)
    -- Size = UDim2 (opcional)
})
```

---

## Creando Pestañas

Las pestañas organizan tu UI en diferentes secciones.

```lua
local Tabs = {
    Main = Window:AddTab('Principal'),
    Settings = Window:AddTab('Configuración')
}
```

También puedes acceder a ellas directamente:

```lua
local MainTab = Window.Tabs.Main
```

---

## Groupboxes y Tabboxes

### Creando Groupboxes

Los groupboxes son contenedores para elementos de UI en el lado izquierdo o derecho de una pestaña.

```lua
local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Título del Groupbox')
local RightGroupBox = Tabs.Main:AddRightGroupbox('Título del Groupbox')
```

### Creando Tabboxes

Los tabboxes permiten crear sub-pestañas dentro de un groupbox.

```lua
local TabBox = Tabs.Main:AddLeftTabbox()

local Tab1 = TabBox:AddTab('Pestaña 1')
local Tab2 = TabBox:AddTab('Pestaña 2')

-- Ahora puedes añadir elementos a estas pestañas
Tab1:AddToggle('Tab1Toggle', { Text = 'Toggle Pestaña 1' })
```

---

## Elementos de UI

### Toggles

Interruptores binarios (on/off).

```lua
LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Este es un toggle',
    Default = true,           -- Valor por defecto (true / false)
    Tooltip = 'Este es un tooltip',
    
    Callback = function(Value)
        print('[cb] MyToggle cambió a:', Value)
    end
})
```

**Accediendo al estado del Toggle:**

```lua
-- Obtener valor actual
local isEnabled = Toggles.MyToggle.Value

-- Escuchar cambios
Toggles.MyToggle:OnChanged(function()
    print('MyToggle cambió a:', Toggles.MyToggle.Value)
end)

-- Cambiar valor programáticamente
Toggles.MyToggle:SetValue(false)
```

---

### Botones

Ejecutan funciones al hacer clic.

```lua
local MyButton = LeftGroupBox:AddButton({
    Text = 'Botón',
    Func = function()
        print('¡Hiciste clic en un botón!')
    end,
    DoubleClick = false,      -- Requiere doble clic para activar
    Tooltip = 'Este es el botón principal'
})
```

**Sub-Botones:**

Se pueden encadenar botones para crear sub-botones.

```lua
local MyButton2 = MyButton:AddButton({
    Text = 'Sub-botón',
    Func = function()
        print('¡Hiciste clic en un sub-botón!')
    end,
    DoubleClick = true,
    Tooltip = 'Este es el sub-botón (¡haz doble clic!)'
})
```

**Ejemplo de Encadenamiento:**

```lua
LeftGroupBox:AddButton({ 
    Text = 'Eliminar a todos', 
    Func = Functions.KillAll, 
    Tooltip = 'Esto eliminará a todos en el juego!' 
})
:AddButton({ 
    Text = 'Expulsar a todos', 
    Func = Functions.KickAll, 
    Tooltip = 'Esto expulsará a todos del juego!' 
})
```

---

### Etiquetas

Mostrar información en texto.

```lua
LeftGroupBox:AddLabel('Esta es una etiqueta')

-- Etiqueta con ajuste de texto
LeftGroupBox:AddLabel('Esta es una etiqueta\n\nque ajusta su texto!', true)
```

**Parámetros:**
- `Text` (string): Texto a mostrar
- `DoesWrap` (boolean, opcional): Habilitar ajuste de texto

---

### Divisores

Agregar separación visual entre elementos.

```lua
LeftGroupBox:AddDivider()
```

---

### Sliders

Seleccionar valores numéricos dentro de un rango.

```lua
LeftGroupBox:AddSlider('MySlider', {
    Text = 'Este es mi slider!',
    Default = 0,
    Min = 0,
    Max = 5,
    Rounding = 1,             -- Decimales para precisión
    Compact = false,          -- Ocultar título si es true
    Suffix = '',              -- Sufijo opcional (ej: 'px', '%')
    HideMax = false,          -- Mostrar solo valor, no valor/máx
    
    Callback = function(Value)
        print('[cb] Slider cambió! Nuevo valor:', Value)
    end
})
```

**Parámetros obligatorios:**
- `Text`, `Default`, `Min`, `Max`, `Rounding`

**Accediendo al valor del Slider:**

```lua
-- Obtener valor actual
local Number = Options.MySlider.Value

-- Escuchar cambios
Options.MySlider:OnChanged(function()
    print('Slider cambió! Nuevo valor:', Options.MySlider.Value)
end)

-- Cambiar valor programáticamente
Options.MySlider:SetValue(3)
```

---

### Entrada de Texto

Cajas de texto para entrada de usuario.

```lua
LeftGroupBox:AddInput('MyTextbox', {
    Default = 'Mi caja de texto!',
    Numeric = false,          -- true = solo números
    Finished = false,         -- true = solo llama al callback al presionar Enter
    Text = 'Esta es una caja de texto',
    Tooltip = 'Este es un tooltip',
    Placeholder = 'Texto de ejemplo',
    -- MaxLength = número (opcional)
    
    Callback = function(Value)
        print('[cb] Texto actualizado. Nuevo texto:', Value)
    end
})
```

**Accediendo al valor de la Entrada:**

```lua
Options.MyTextbox:OnChanged(function()
    print('Texto actualizado. Nuevo texto:', Options.MyTextbox.Value)
end)
```

---

### Dropdowns

Seleccionar de una lista de valores.

#### Dropdown de Selección Única

```lua
LeftGroupBox:AddDropdown('MyDropdown', {
    Values = { 'Esto', 'es', 'un', 'dropdown' },
    Default = 1,              -- Índice o valor
    Multi = false,            -- Selección única
    Text = 'Un dropdown',
    Tooltip = 'Este es un tooltip',
    
    Callback = function(Value)
        print('[cb] Dropdown cambió. Nuevo valor:', Value)
    end
})
```

**Accediendo al valor del Dropdown:**

```lua
Options.MyDropdown:OnChanged(function()
    print('Dropdown cambió. Nuevo valor:', Options.MyDropdown.Value)
end)

-- Cambiar valor programáticamente
Options.MyDropdown:SetValue('Esto')
```

#### Dropdown de Selección Múltiple

```lua
LeftGroupBox:AddDropdown('MyMultiDropdown', {
    Values = { 'Esto', 'es', 'un', 'dropdown' },
    Default = 1,
    Multi = true,             -- Permitir múltiples selecciones
    Text = 'Un dropdown',
    Tooltip = 'Este es un tooltip',
    
    Callback = function(Value)
        print('[cb] Dropdown múltiple cambió:', Value)
    end
})
```

**Accediendo a valores múltiples:**

```lua
Options.MyMultiDropdown:OnChanged(function()
    print('Dropdown múltiple cambió:')
    for key, value in next, Options.MyMultiDropdown.Value do
        print(key, value) -- ej: "Esto", true
    end
end)

-- Cambiar múltiples valores
Options.MyMultiDropdown:SetValue({
    Esto = true,
    es = true,
})
```

**Nota:** No se puede establecer múltiples valores por defecto actualmente.

#### Dropdown de Jugadores

Dropdown especial para seleccionar jugadores.

```lua
LeftGroupBox:AddDropdown('MyPlayerDropdown', {
    SpecialType = 'Player',
    Text = 'Dropdown de jugadores',
    Tooltip = 'Este es un tooltip',
    
    Callback = function(Value)
        print('[cb] Dropdown de jugadores cambió:', Value)
    end
})
```

---

### Selectores de Color

Seleccionar colores con transparencia opcional.

```lua
LeftGroupBox:AddLabel('Color'):AddColorPicker('ColorPicker', {
    Default = Color3.new(0, 1, 0),     -- Verde brillante
    Title = 'Algún color',             -- Título opcional
    Transparency = 0,                  -- Opcional (nil para desactivar)
    
    Callback = function(Value)
        print('[cb] Color cambió!', Value)
    end
})
```

**Accediendo al Selector de Color:**

```lua
Options.ColorPicker:OnChanged(function()
    print('Color cambió!', Options.ColorPicker.Value)
    print('Transparencia cambió!', Options.ColorPicker.Transparency)
end)

-- Cambiar color programáticamente
Options.ColorPicker:SetValueRGB(Color3.fromRGB(0, 255, 140))
```

**Nota:** También se pueden añadir ColorPickers a Toggles.

---

### Keybinds

Asignar acciones a teclas o botones del mouse.

```lua
LeftGroupBox:AddLabel('Keybind'):AddKeyPicker('KeyPicker', {
    Default = 'MB2',          -- MB1, MB2 para mouse
    SyncToggleState = false,  -- Sincronizar estado con toggle padre
    Mode = 'Toggle',          -- Modos: Always, Toggle, Hold
    Text = 'Auto lockpick safes',
    NoUI = false,             -- Ocultar del menú de keybind si es true
    
    Callback = function(Value)
        print('[cb] Keybind presionado!', Value)
    end,
    
    ChangedCallback = function(New)
        print('[cb] Keybind cambió!', New)
    end
})
```

**SyncToggleState Nota:**  
- Solo funciona con toggles  
- Permite sincronizar estado con toggle padre  

**Accediendo al Keybind:**

```lua
-- OnClick solo se dispara en modo Toggle
Options.KeyPicker:OnClick(function()
    print('Keybind presionado!', Options.KeyPicker:GetState())
end)

Options.KeyPicker:OnChanged(function()
    print('Keybind cambió!', Options.KeyPicker.Value)
end)

-- Revisar si se está presionando
local state = Options.KeyPicker:GetState()
if state then
    print('KeyPicker está siendo presionado')
end

-- Cambiar keybind programáticamente
Options.KeyPicker:SetValue({ 'MB2', 'Toggle' })
```

**Ejemplo de Loop para revisar Keybind:**

```lua
task.spawn(function()
    while true do
        wait(1)
        
        local state = Options.KeyPicker:GetState()
        if state then
            print('KeyPicker está siendo presionado')
        end
        
        if Library.Unloaded then break end
    end
end)
```

**Nota:** También se pueden añadir KeyPickers a Toggles.

---

## Cajas de Dependencia

Controlar la visibilidad de elementos según otros elementos.

```lua
local RightGroupbox = Tabs.Main:AddRightGroupbox('Groupbox #3')
RightGroupbox:AddToggle('ControlToggle', { Text = 'Toggle de caja de dependencia' })

-- Crear caja de dependencia
local Depbox = RightGroupbox:AddDependencyBox()
Depbox:AddToggle('DepboxToggle', { Text = 'Sub-toggle de dependencia' })

-- Caja de dependencia anidada
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

-- Configurar dependencias
Depbox:SetupDependencies({
    { Toggles.ControlToggle, true } -- Mostrar cuando toggle es true
})

SubDepbox:SetupDependencies({
    { Toggles.DepboxToggle, true }
})
```

**Parámetros de Dependencia:**
- `true` = mostrar cuando elemento está activo
- `false` = mostrar cuando elemento está desactivado
- Las cajas de dependencia anidadas heredan visibilidad de padre automáticamente

---

## Funciones de la Biblioteca

### Watermark

```lua
-- Mostrar/ocultar watermark
Library:SetWatermarkVisibility(true)

-- Actualizar texto del watermark
Library:SetWatermark('LinoriaLib demo | 60 fps | 50 ms')
```

**Ejemplo: Watermark dinámico con FPS y ping**

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
-- Mostrar/ocultar frame de keybind
Library.KeybindFrame.Visible = true
```

### Descargar Biblioteca

```lua
-- Descargar la biblioteca y limpiar
Library:Unload()

-- Escuchar evento de descarga
Library:OnUnload(function()
    print('¡Biblioteca descargada!')
    Library.Unloaded = true
end)
```

---

## Gestor de Temas

El addon ThemeManager permite crear y gestionar temas de UI.

### Configuración

```lua
-- Asignar biblioteca al ThemeManager
ThemeManager:SetLibrary(Library)

-- Carpeta para guardar temas
ThemeManager:SetFolder('MiScriptHub')

-- Aplicar ThemeManager a una pestaña
ThemeManager:ApplyToTab(Tabs['Configuración UI'])

-- O aplicar a un groupbox específico
ThemeManager:ApplyToGroupbox(SomeGroupbox)
```

Viene con muchos temas incorporados que los usuarios pueden seleccionar.

---

## Gestor de Configuraciones

El addon SaveManager permite guardar/cargar configuraciones.

### Configuración

```lua
-- Asignar biblioteca al SaveManager
SaveManager:SetLibrary(Library)

-- Ignorar configuración de temas
SaveManager:IgnoreThemeSettings()

-- Ignorar índices específicos (ej: keybind del menú)
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

-- Carpeta para configuraciones
SaveManager:SetFolder('MiScriptHub/juego-específico')

-- Crear sección de configuración en una pestaña
SaveManager:BuildConfigSection(Tabs['Configuración UI'])

-- Cargar configuración autoload
SaveManager:LoadAutoloadConfig()
```

### Caso de uso

Un hub de scripts puede tener:
- Temas en carpeta global: `ThemeManager:SetFolder('MiScriptHub')`
- Configuraciones por juego: `SaveManager:SetFolder('MiScriptHub/juego-específico')`

---

## Ejemplo Completo de Menú

```lua
-- Configuración de keybind del menú
local MenuGroup = Tabs['Configuración UI']:AddLeftGroupbox('Menú')

MenuGroup:AddButton('Unload', function() Library:Unload() end)
MenuGroup:AddLabel('Keybind del menú'):AddKeyPicker('MenuKeybind', { 
    Default = 'End', 
    NoUI = true, 
    Text = 'Keybind del menú' 
})

Library.ToggleKeybind = Options.MenuKeybind

-- Configurar gestores
ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

ThemeManager:SetFolder('MiScriptHub')
SaveManager:SetFolder('MiScriptHub/juego-específico')

SaveManager:BuildConfigSection(Tabs['Configuración UI'])
ThemeManager:ApplyToTab(Tabs['Configuración UI'])

SaveManager:LoadAutoloadConfig()
```

---

## Buenas Prácticas

### Separación de Código UI

Se recomienda separar la UI de la lógica:

1. **Crear elementos UI primero**
2. **Configurar :OnChanged después**

```lua
-- RECOMENDADO: Separar UI de lógica
LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Este es un toggle',
    Default = true,
    Tooltip = 'Este es un tooltip'
})

-- Configurar lógica aparte
Toggles.MyToggle:OnChanged(function()
    print('MyToggle cambió a:', Toggles.MyToggle.Value)
end)
```

```lua
-- NO RECOMENDADO: Mezclar UI con lógica
LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Este es un toggle',
    Default = true,
    Tooltip = 'Este es un tooltip',
    Callback = function(Value)
        print('MyToggle cambió a:', Value)
    end
})
```

### Accediendo a Elementos UI

La biblioteca añade dos tablas globales a `getgenv()`:

- **`Toggles`**: Acceso a toggles
- **`Options`**: Acceso a otros elementos UI (sliders, dropdowns, inputs, etc.)

```lua
-- Accediendo a toggles
local toggleValue = Toggles.MyToggle.Value

-- Accediendo a otros elementos
local sliderValue = Options.MySlider.Value
local dropdownValue = Options.MyDropdown.Value
local textboxValue = Options.MyTextbox.Value
local colorValue = Options.ColorPicker.Value
local keybindValue = Options.KeyPicker.Value
```

---

## Créditos

- **Inori**: Desarrollador principal
- **Wally**: Limpieza de código y extensión de funcionalidades
- **Stefanuk**: Extensión de funcionalidades
- **matas3535**: Creador de Splix

Para más información, visita el [repositorio oficial de LinoriaLib](https://github.com/violin-suzutsuki/LinoriaLib).
