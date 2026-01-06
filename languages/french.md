# Documentation de la bibliothèque Linoria

Une bibliothèque d'interface utilisateur (UI) complète pour Roblox, prenant en charge les thèmes, les configurations et une large gamme d'éléments d'interface.

> **Important** : LinoriaLib a été créée par [violin-suzutsuki](https://github.com/violin-suzutsuki). Cette documentation est basée sur la bibliothèque officielle.

---

## Langues
- [English](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/readme.md)
- [Spanish](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/spanish.md)
- [Russian](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/russian.md)
- [Portuguese](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/portuguese.md)
- [Vietnamese](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/vietnamese.md)
- [Chinese](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/chinese.md)
- [French](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/french.md) - Actuel
- [Turkish](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/turkish.md)
- [Indonesian](https://github.com/XENFLIX3R/LinoraLibDoc/blob/main/languages/indonesian.md)

---

## Table des matières
- [Importation de la bibliothèque](#importation-de-la-bibliothèque)
- [Création d'une fenêtre](#création-d-une-fenêtre)
- [Création d'onglets](#création-d-onglets)
- [Groupboxes et Tabboxes](#groupboxes-et-tabboxes)
- [Éléments d'interface](#éléments-d-interface)
  - [Interrupteurs (Toggles)](#interrupteurs-toggles)
  - [Boutons (Buttons)](#boutons-buttons)
  - [Étiquettes (Labels)](#étiquettes-labels)
  - [Diviseurs (Dividers)](#diviseurs-dividers)
  - [Curseurs (Sliders)](#curseurs-sliders)
  - [Saisie de texte (Text Input)](#saisie-de-texte-text-input)
  - [Listes déroulantes (Dropdowns)](#listes-déroulantes-dropdowns)
  - [Sélecteurs de couleur (Color Pickers)](#sélecteurs-de-couleur-color-pickers)
  - [Raccourcis clavier (Keybinds)](#raccourcis-clavier-keybinds)
- [Boîtes de dépendance (Dependency Boxes)](#boîtes-de-dépendance-dependency-boxes)
- [Fonctions de la bibliothèque](#fonctions-de-la-bibliothèque)
- [Gestionnaire de thèmes (Theme Manager)](#gestionnaire-de-thèmes-theme-manager)
- [Gestionnaire de sauvegardes (Save Manager)](#gestionnaire-de-sauvegardes-save-manager)

---

## Importation de la bibliothèque

```lua
local repo = '[https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/](https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/)'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()
```

---

## Création d'une fenêtre

```lua
local Window = Library:CreateWindow({
    Title = 'Menu d\'exemple',
    Center = true,        -- Centrer le menu sur l'écran
    AutoShow = true,      -- Afficher le menu immédiatement
    TabPadding = 8,       -- Espacement entre les onglets
    MenuFadeTime = 0.2    -- Durée de l'animation d'apparition
    -- Position = UDim2 (optionnel)
    -- Size = UDim2 (optionnel)
})
```

---

## Création d'onglets

Les onglets organisent votre interface en différentes sections.

```lua
local Tabs = {
    Main = Window:AddTab('Principal'),
    Settings = Window:AddTab('Paramètres')
}
```

Vous pouvez également accéder aux onglets directement :

```lua
local MainTab = Window.Tabs.Main
```

---

## Groupboxes et Tabboxes

### Création de Groupboxes

Les Groupboxes sont des conteneurs pour les éléments d'interface sur le côté gauche ou droit d'un onglet.

```lua
local LeftGroupBox = Tabs.Main:AddLeftGroupbox('Titre du groupe')
local RightGroupBox = Tabs.Main:AddRightGroupbox('Titre du groupe')
```

### Création de Tabboxes

Les Tabboxes permettent de créer des sous-onglets à l'intérieur d'une zone de groupbox.

```lua
local TabBox = Tabs.Main:AddLeftTabbox()

local Tab1 = TabBox:AddTab('Onglet 1')
local Tab2 = TabBox:AddTab('Onglet 2')

-- Vous pouvez maintenant ajouter des éléments à ces onglets
Tab1:AddToggle('Tab1Toggle', { Text = 'Interrupteur Onglet 1' })
```

---

## Éléments d'interface

### Interrupteurs (Toggles)

Commutateurs binaires marche/arrêt.

```lua
LeftGroupBox:AddToggle('MyToggle', {
    Text = 'Ceci est un interrupteur',
    Default = true,           -- Valeur par défaut (true / false)
    Tooltip = 'Ceci est une infobulle',
    
    Callback = function(Value)
        print('[cb] MyToggle a changé pour :', Value)
    end
})
```

**Accès à l'état de l'interrupteur :**

```lua
-- Obtenir la valeur actuelle
local isEnabled = Toggles.MyToggle.Value

-- Écouter les changements
Toggles.MyToggle:OnChanged(function()
    print('MyToggle a changé pour :', Toggles.MyToggle.Value)
end)

-- Définir la valeur par script
Toggles.MyToggle:SetValue(false)
```

---

### Boutons (Buttons)

Exécutent des fonctions lors d'un clic.

```lua
local MyButton = LeftGroupBox:AddButton({
    Text = 'Bouton',
    Func = function()
        print('Vous avez cliqué sur le bouton !')
    end,
    DoubleClick = false,      -- Nécessite un double-clic pour s'activer
    Tooltip = 'Ceci est le bouton principal'
})
```

---

### Curseurs (Sliders)

Sélection de valeurs numériques dans une plage donnée.

```lua
LeftGroupBox:AddSlider('MySlider', {
    Text = 'Ceci est mon curseur !',
    Default = 0,
    Min = 0,
    Max = 5,
    Rounding = 1,             -- Nombre de décimales
    Compact = false,          -- Masquer le titre si true
    Suffix = '',              -- Suffixe optionnel (ex: 'px', '%')
    HideMax = false,          -- Afficher uniquement la valeur, pas la valeur/max
    
    Callback = function(Value)
        print('[cb] MySlider a été modifié ! Nouvelle valeur :', Value)
    end
})
```

---

### Listes déroulantes (Dropdowns)

Sélection dans une liste de valeurs.

```lua
LeftGroupBox:AddDropdown('MyDropdown', {
    Values = { 'Option 1', 'Option 2', 'Option 3' },
    Default = 1,              -- Index ou valeur sous forme de texte
    Multi = false,            -- Sélection unique
    Text = 'Liste déroulante',
    Tooltip = 'Infobulle',
    
    Callback = function(Value)
        print('[cb] La liste déroulante a changé pour :', Value)
    end
})
```

---

### Sélecteurs de couleur (Color Pickers)

Sélection de couleurs avec transparence optionnelle.

```lua
LeftGroupBox:AddLabel('Couleur'):AddColorPicker('ColorPicker', {
    Default = Color3.new(0, 1, 0),     -- Vert vif
    Title = 'Choisir une couleur',     -- Titre personnalisé
    Transparency = 0,                  -- Optionnel (nil pour désactiver)
    
    Callback = function(Value)
        print('[cb] La couleur a changé !', Value)
    end
})
```

---

## Boîtes de dépendance (Dependency Boxes)

Contrôlent la visibilité des éléments d'interface en fonction de l'état d'autres éléments.

```lua
local RightGroupbox = Tabs.Main:AddRightGroupbox('Groupe Dépendances')
RightGroupbox:AddToggle('ControlToggle', { Text = 'Interrupteur de contrôle' })

-- Créer la boîte de dépendance
local Depbox = RightGroupbox:AddDependencyBox()
Depbox:AddToggle('DepboxToggle', { Text = 'Interrupteur dépendant' })

-- Configurer les dépendances
Depbox:SetupDependencies({
    { Toggles.ControlToggle, true } -- Afficher quand l'interrupteur est true
})
```

---

## Fonctions de la bibliothèque

### Filigrane (Watermark)

```lua
-- Visibilité
Library:SetWatermarkVisibility(true)

-- Texte
Library:SetWatermark('Démo LinoriaLib | 60 fps | 50 ms')
```

### Déchargement (Unload)

```lua
-- Décharger la bibliothèque
Library:Unload()

-- Événement lors du déchargement
Library:OnUnload(function()
    print('Bibliothèque déchargée !')
    Library.Unloaded = true
end)
```

---

## Gestionnaire de thèmes (Theme Manager)

L'extension ThemeManager permet de créer et de gérer des thèmes d'interface.

```lua
ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder('MyScriptHub')
ThemeManager:ApplyToTab(Tabs['Settings'])
```

---

## Gestionnaire de sauvegardes (Save Manager)

L'extension SaveManager fournit un système de configuration pour sauvegarder/charger les paramètres.

```lua
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
SaveManager:SetFolder('MyScriptHub/jeu-specifique')
SaveManager:BuildConfigSection(Tabs['Settings'])
SaveManager:LoadAutoloadConfig()
```

---

## Crédits
- **Inori** : Développeur principal
- **Wally** : Nettoyage du code, extension des fonctionnalités
- **Stefanuk** : Extension des fonctionnalités
- **matas3535** : Créateur de Splix

Pour plus d'informations, visitez le [dépôt officiel de LinoriaLib](https://github.com/violin-suzutsuki/LinoriaLib).
