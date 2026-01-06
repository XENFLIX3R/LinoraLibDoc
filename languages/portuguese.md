# Documentação Linoria Library

Uma biblioteca de UI abrangente para Roblox com suporte a temas, configurações e uma vasta gama de elementos de interface.

> **Importante**: LinoriaLib foi criada por [violin-suzutsuki](https://github.com/violin-suzutsuki). Esta é uma documentação baseada na biblioteca oficial.

---

## Idiomas
- [English](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/readme.md)
- [Spanish](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/spanish.md)
- [Russian](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/russian.md)
- [Portuguese](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/portuguese.md) - Atual
- [Vietnamese](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/vietnamese.md)
- [Chinese](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/chinese.md)
- [French](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/french.md)
- [Turkish](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/turkish.md)
- [Indonesian](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/indonesian.md)

---

## Sumário
- [Importando a Biblioteca](#importando-a-biblioteca)
- [Criando uma Janela](#criando-uma-janela)
- [Criando Abas](#criando-abas)
- [Groupboxes e Tabboxes](#groupboxes-e-tabboxes)
- [Elementos de UI](#elementos-de-ui)
  - [Toggles](#toggles)
  - [Botões](#buttons)
  - [Labels](#labels)
  - [Divisores](#dividers)
  - [Sliders](#sliders)
  - [Entrada de Texto](#text-input)
  - [Dropdowns](#dropdowns)
  - [Seletores de Cor](#color-pickers)
  - [Keybinds](#keybinds)
- [Caixas de Dependência](#dependency-boxes)
- [Funções da Biblioteca](#funções-da-biblioteca)
- [Gerenciador de Temas](#theme-manager)
- [Gerenciador de Salvamento](#save-manager)

---

## Importando a Biblioteca

```lua
local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
```

---

## Criando uma Janela

```lua
local Window = Library:CreateWindow({
    Title = 'Menu de Exemplo',
    Center = true,        -- Define como true para centralizar o menu na tela
    AutoShow = true,      -- Define como true para mostrar o menu imediatamente
    TabPadding = 8,       -- Espaçamento entre abas
    MenuFadeTime = 0.2    -- Duração da animação de fade
    -- Position = UDim2 (opcional)
    -- Size = UDim2 (opcional)
})
```

---

## Criando Abas

As abas organizam sua UI em diferentes seções.

```lua
local Tabs = {
    Main = Window:AddTab('Principal'),
    Settings = Window:AddTab('Configurações')
}
```

Você também pode acessar as abas diretamente:

```lua
local MainTab = Window.Tabs.Main
```

---

## Groupboxes e Tabboxes

### Criando Groupboxes

Groupboxes são containers para elementos de UI no lado esquerdo ou direito de uma aba.

```lua
local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Título do Grupo')
local RightGroupBox = Tabs.Main:AddRightGroupbox('Título do Grupo')
```

### Criando Tabboxes

Tabboxes permitem criar sub-abas dentro de uma área de groupbox.

```lua
local TabBox = Tabs.Main:AddLeftTabbox()

local Tab1 = TabBox:AddTab('Aba 1')
local Tab2 = TabBox:AddTab('Aba 2')

-- Agora você pode adicionar elementos a estas abas
Tab1:AddToggle('Tab1Toggle', { Text = 'Toggle da Aba 1' })
```

---

## Elementos de UI

### Toggles

Interruptores binários de ligar/desligar.

```lua
LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Isto é um toggle',
    Default = true,           -- Valor padrão (true / false)
    Tooltip = 'Isto é uma dica (tooltip)',
    
    Callback = function(Value)
        print('[cb] MyToggle alterado para:', Value)
    end
})
```

**Acessando o Estado do Toggle:**

```lua
-- Obter valor atual
local isEnabled = Toggles.MyToggle.Value

-- Ouvir alterações
Toggles.MyToggle:OnChanged(function()
    print('MyToggle alterado para:', Toggles.MyToggle.Value)
end)

-- Definir valor via script
Toggles.MyToggle:SetValue(false)
```

---

### Botões

Executam funções quando clicados.

```lua
local MyButton = LeftGroupBox:AddButton({
    Text = 'Botão',
    Func = function()
        print('Você clicou no botão!')
    end,
    DoubleClick = false,      -- Requer clique duplo para ativar
    Tooltip = 'Este é o botão principal'
})
```

**Sub-Botões:**

Você pode encadear botões para criar botões secundários.

```lua
local MyButton2 = MyButton:AddButton({
    Text = 'Sub botão',
    Func = function()
        print('Você clicou no sub botão!')
    end,
    DoubleClick = true,
    Tooltip = 'Este é o sub botão (clique duplo!)'
})
```

**Exemplo de Encadeamento:**

```lua
LeftGroupBox:AddButton({ 
    Text = 'Matar todos', 
    Func = Functions.KillAll, 
    Tooltip = 'Isso matará todos no jogo!' 
})
:AddButton({ 
    Text = 'Kickar todos', 
    Func = Functions.KickAll, 
    Tooltip = 'Isso kickará todos do jogo!' 
})
```

---

### Labels

Exibem informações em texto.

```lua
LeftGroupBox:AddLabel('Isto é um label')

-- Label com quebra de linha automática
LeftGroupBox:AddLabel('Isto é um label\n\nque quebra o texto!', true)
```

**Parâmetros:**
- ```Text``` (string): O texto a ser exibido.
- ```DoesWrap``` (boolean, opcional): Ativa a quebra de linha.

---

### Divisores

Adicionam separação visual entre elementos.

```lua
LeftGroupBox:AddDivider()
```

---

### Sliders

Selecionam valores numéricos dentro de um intervalo.

```lua
LeftGroupBox:AddSlider('MySlider', {
    Text = 'Este é meu slider!',
    Default = 0,
    Min = 0,
    Max = 5,
    Rounding = 1,             -- Casas decimais para precisão
    Compact = false,          -- Oculta o título se true
    Suffix = '',              -- Sufixo opcional (ex: 'px', '%')
    HideMax = false,          -- Mostra apenas o valor, não valor/máximo
    
    Callback = function(Value)
        print('[cb] MySlider foi alterado! Novo valor:', Value)
    end
})
```

**Parâmetros Obrigatórios:**
- ```Text```, ```Default```, ```Min```, ```Max```, ```Rounding``` devem ser especificados.

**Acessando o Valor do Slider:**

```lua
-- Obter valor atual
local Number = Options.MySlider.Value

-- Ouvir alterações
Options.MySlider:OnChanged(function()
    print('MySlider foi alterado! Novo valor:', Options.MySlider.Value)
end)

-- Definir valor via script
Options.MySlider:SetValue(3)
```

---

### Entrada de Texto

Caixas de texto para entrada do usuário.

```lua
LeftGroupBox:AddInput('MyTextbox', {
    Default = 'Meu texto!',
    Numeric = false,          -- true = permite apenas números
    Finished = false,         -- true = chama o callback apenas ao apertar Enter
    Text = 'Isto é uma caixa de texto',
    Tooltip = 'Dica de ferramenta',
    Placeholder = 'Texto de exemplo',
    -- MaxLength = number (opcional)
    
    Callback = function(Value)
        print('[cb] Texto atualizado. Novo texto:', Value)
    end
})
```

**Acessando o Valor da Entrada:**

```lua
Options.MyTextbox:OnChanged(function()
    print('Texto atualizado. Novo texto:', Options.MyTextbox.Value)
end)
```

---

## Dropdowns

Selecione a partir de uma lista de valores.

#### Dropdown de Seleção Única

```lua
LeftGroupBox:AddDropdown('MyDropdown', {
    Values = { 'Isto', 'é', 'um', 'dropdown' },
    Default = 1,              -- Índice ou valor em string
    Multi = false,            -- Seleção única
    Text = 'Um dropdown',
    Tooltip = 'Dica de ferramenta',
    
    Callback = function(Value)
        print('[cb] Dropdown alterado. Novo valor:', Value)
    end
})
```

**Acessando o Valor do Dropdown:**

```lua
Options.MyDropdown:OnChanged(function()
    print('Dropdown alterado. Novo valor:', Options.MyDropdown.Value)
end)

-- Definir valor via script
Options.MyDropdown:SetValue('Isto')
```

#### Dropdown de Seleção Múltipla

```lua
LeftGroupBox:AddDropdown('MyMultiDropdown', {
    Values = { 'Isto', 'é', 'um', 'dropdown' },
    Default = 1,
    Multi = true,             -- Permite múltiplas seleções
    Text = 'Um dropdown múltiplo',
    Tooltip = 'Dica de ferramenta',
    
    Callback = function(Value)
        print('[cb] Multi dropdown alterado:', Value)
    end
})
```

**Acessando Valores do Multi-Dropdown:**

```lua
Options.MyMultiDropdown:OnChanged(function()
    print('Multi dropdown alterado:')
    for key, value in next, Options.MyMultiDropdown.Value do
        print(key, value) -- ex: "Isto", true
    end
end)

-- Definir múltiplos valores
Options.MyMultiDropdown:SetValue({
    Isto = true,
    um = true,
})
```

**Nota:** Atualmente não é possível definir múltiplos valores padrão diretamente no dropdown.

#### Dropdown de Jogadores

Dropdown especial para selecionar jogadores.

```lua
LeftGroupBox:AddDropdown('MyPlayerDropdown', {
    SpecialType = 'Player',
    Text = 'Dropdown de jogadores',
    Tooltip = 'Selecione um jogador',
    
    Callback = function(Value)
        print('[cb] Player dropdown alterado:', Value)
    end
})
```

---

### Seletores de Cor (Color Pickers)

Selecione cores com transparência opcional.

```lua
LeftGroupBox:AddLabel('Cor'):AddColorPicker('ColorPicker', {
    Default = Color3.new(0, 1, 0),     -- Verde brilhante
    Title = 'Uma cor',                 -- Título customizado opcional
    Transparency = 0,                  -- Opcional (nil para desativar)
    
    Callback = function(Value)
        print('[cb] Cor alterada!', Value)
    end
})
```

**Acessando o Color Picker:**

```lua
Options.ColorPicker:OnChanged(function()
    print('Cor alterada!', Options.ColorPicker.Value)
    print('Transparência alterada!', Options.ColorPicker.Transparency)
end)

-- Definir cor via script
Options.ColorPicker:SetValueRGB(Color3.fromRGB(0, 255, 140))
```

**Nota:** Você também pode adicionar ColorPickers a Toggles.

---

### Keybinds

Associe ações a teclas do teclado ou botões do mouse.

```lua
LeftGroupBox:AddLabel('Tecla'):AddKeyPicker('KeyPicker', {
    Default = 'MB2',          -- MB1, MB2 para botões do mouse
    SyncToggleState = false,  -- Sincroniza estado com o toggle pai
    Mode = 'Toggle',          -- Modos: Always, Toggle, Hold
    Text = 'Auto lockpick',
    NoUI = false,             -- Oculta do menu de keybinds se true
    
    -- Acionado quando a tecla é pressionada
    Callback = function(Value)
        print('[cb] Keybind clicado!', Value)
    end,
    
    -- Acionado quando a tecla é alterada
    ChangedCallback = function(New)
        print('[cb] Keybind alterado!', New)
    end
})
```

**Nota sobre SyncToggleState:** - Funciona apenas com toggles.
- Permite que o estado do keybind sincronize com o toggle pai.
- Exemplo: Keybind para ligar/desligar flyhack - desligar o toggle desativa o estado do keybind.

**Acessando Keybind:**

```lua
-- OnClick só é disparado no modo Toggle
Options.KeyPicker:OnClick(function()
    print('Keybind clicado!', Options.KeyPicker:GetState())
end)

Options.KeyPicker:OnChanged(function()
    print('Keybind alterado!', Options.KeyPicker.Value)
end)

-- Verificar se a tecla está sendo pressionada
local state = Options.KeyPicker:GetState()
if state then
    print('KeyPicker está sendo segurado')
end

-- Definir keybind via script
Options.KeyPicker:SetValue({ 'MB2', 'Toggle' })
```

---

## Caixas de Dependência

Controlam a visibilidade de elementos da UI baseando-se no estado de outros elementos.

```lua
local RightGroupbox = Tabs.Main:AddRightGroupbox('Groupbox #3')
RightGroupbox:AddToggle('ControlToggle', { Text = 'Toggle de controle' })

-- Criar caixa de dependência
local Depbox = RightGroupbox:AddDependencyBox()
Depbox:AddToggle('DepboxToggle', { Text = 'Toggle sub-dependente' })

-- Caixa de dependência aninhada
local SubDepbox = Depbox:AddDependencyBox()
SubDepbox:AddSlider('DepboxSlider', { 
    Text = 'Slider', 
    Default = 50, 
    Min = 0, 
    Max = 100, 
    Rounding = 0 
})

-- Configurar dependências
Depbox:SetupDependencies({
    { Toggles.ControlToggle, true } -- Mostra quando o toggle for true
})

SubDepbox:SetupDependencies({
    { Toggles.DepboxToggle, true }
})
```

---

## Funções da Biblioteca

### Marca d'água (Watermark)

```lua
-- Definir visibilidade
Library:SetWatermarkVisibility(true)

-- Atualizar texto
Library:SetWatermark('LinoriaLib demo | 60 fps | 50 ms')
```

### Unload (Descarregar)

```lua
-- Descarrega a biblioteca e limpa tudo
Library:Unload()

-- Ouvir evento de unload
Library:OnUnload(function()
    print('Biblioteca descarregada!')
    Library.Unloaded = true
end)
```

---

## Gerenciador de Temas (Theme Manager)

O addon ThemeManager permite criar e gerenciar temas de UI.

```lua
-- Passa a biblioteca para o ThemeManager
ThemeManager:SetLibrary(Library)

-- Define a pasta para os temas
ThemeManager:SetFolder('MeuScriptHub')

-- Aplica o gerenciador a uma aba
ThemeManager:ApplyToTab(Tabs['Configurações'])
```

---

## Gerenciador de Salvamento (Save Manager)

O addon SaveManager fornece um sistema de configuração para salvar/carregar definições.

```lua
-- Passa a biblioteca para o SaveManager
SaveManager:SetLibrary(Library)

-- Ignora configurações de tema (não queremos que configs salvem temas)
SaveManager:IgnoreThemeSettings()

-- Define índices para ignorar (ex: tecla do menu)
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })

-- Define a pasta para as configs
SaveManager:SetFolder('MeuScriptHub/jogo-especifico')

-- Constrói a seção de config em uma aba
SaveManager:BuildConfigSection(Tabs['Configurações'])

-- Carrega config automática
SaveManager:LoadAutoloadConfig()
```

---

## Melhores Práticas

### Separação de Código de UI e Lógica

É recomendado separar a criação da UI da lógica do script:

1. **Crie os elementos de UI primeiro**
2. **Configure as funções :OnChanged depois**

```lua
-- RECOMENDADO: Desacoplar UI de lógica
LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Isto é um toggle',
    Default = true
})

Toggles.MyToggle:OnChanged(function()
    print('Valor:', Toggles.MyToggle.Value)
end)
```

### Acessando Elementos

A biblioteca adiciona duas tabelas globais ao ```getgenv()```:
- **```Toggles```**: Acesso aos objetos de toggle.
- **```Options```**: Acesso a todos os outros elementos (sliders, dropdowns, inputs, etc).

```lua
local toggleVal = Toggles.MyToggle.Value
local sliderVal = Options.MySlider.Value
```

---

## Créditos
- **Inori**: Desenvolvedor principal
- **Wally**: Limpeza de código e extensão de funcionalidades
- **Stefanuk**: Extensão de funcionalidades
- **matas3535**: Criador do Splix

Para mais informações, visite o [repositório oficial da LinoriaLib](https://github.com/violin-suzutsuki/LinoriaLib).
