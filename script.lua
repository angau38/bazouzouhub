-- Variables principales
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local mouse = player:GetMouse()
local fishingRod = character:WaitForChild("FishingRod") -- Remplacer par le nom de ton outil
local fishingSpot = workspace:WaitForChild("FishingSpot") -- Remplacer par le point de pêche

-- Interface graphique
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local StartButton = Instance.new("TextButton")
local StopButton = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")
local isFarming = false

-- Configuration de l'interface
ScreenGui.Name = "AutoFarmMenu"
ScreenGui.Parent = game.CoreGui

Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Position = UDim2.new(0.5, -100, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.Parent = ScreenGui

StartButton.Size = UDim2.new(0, 180, 0, 40)
StartButton.Position = UDim2.new(0, 10, 0, 20)
StartButton.Text = "Start Autofarm"
StartButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
StartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StartButton.Parent = Frame

StopButton.Size = UDim2.new(0, 180, 0, 40)
StopButton.Position = UDim2.new(0, 10, 0, 70)
StopButton.Text = "Stop Autofarm"
StopButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
StopButton.TextColor3 = Color3.fromRGB(255, 255, 255)
StopButton.Parent = Frame

StatusLabel.Size = UDim2.new(0, 180, 0, 30)
StatusLabel.Position = UDim2.new(0, 10, 0, 120)
StatusLabel.Text = "Status: Idle"
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.TextScaled = true
StatusLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
StatusLabel.Parent = Frame

-- Fonctions
local function castLine()
    -- Simuler un clic pour lancer la ligne
    mouse.Target = fishingSpot
    mouse:Click()
end

local function waitForBite()
    -- Attendre un temps aléatoire pour que le poisson morde (simulé ici)
    wait(math.random(5, 10)) -- Attente aléatoire entre 5 et 10 secondes
end

local function reelIn()
    -- Simuler l'action de récupérer le poisson (par exemple en cliquant)
    mouse:Click()
end

local function autoCatch()
    -- Simuler l'autocatch dès qu'un poisson mord
    while isFarming do
        waitForBite()  -- Attendre que le poisson morde
        reelIn()      -- Récupérer le poisson immédiatement
        StatusLabel.Text = "Status: Catching fish"
        wait(1)        -- Attente avant de recommencer
    end
end

local function autoFarm()
    -- Démarrer l'autofarm
    while isFarming do
        -- Lancer la ligne
        castLine()
        -- Attendre que le poisson morde
        waitForBite()
        -- Autocatch dès que le poisson mord
        reelIn()
        StatusLabel.Text = "Status: Catching fish"
        wait(2) -- Pause de 2 secondes avant de recommencer
    end
end

-- Fonction pour démarrer l'autofarm
StartButton.MouseButton1Click:Connect(function()
    if not isFarming then
        isFarming = true
        StatusLabel.Text = "Status: Farming..."
        -- Lancer l'autofarm et l'autocatch
        spawn(autoFarm)
        spawn(autoCatch)
    end
end)

-- Fonction pour arrêter l'autofarm
StopButton.MouseButton1Click:Connect(function()
    isFarming = false
    StatusLabel.Text = "Status: Idle"
end)