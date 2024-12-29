-- Déclarations de base
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local mouse = player:GetMouse()

-- Variables pour les états des options
local godModeActive = false
local aimbotActive = false
local silentAimActive = false
local noclipActive = false

-- 1. **God Mode (Invincibilité)**
local function activateGodMode()
    godModeActive = true
    humanoid.HealthChanged:Connect(function(health)
        if health < humanoid.MaxHealth then
            humanoid.Health = humanoid.MaxHealth
        end
    end)
end

local function deactivateGodMode()
    godModeActive = false
end

-- 2. **Aimbot (Vise automatiquement l'ennemi)**
local function getClosestEnemy()
    local closestEnemy = nil
    local shortestDistance = math.huge

    -- Cherche les ennemis proches
    for _, otherPlayer in pairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player then
            local otherCharacter = otherPlayer.Character
            if otherCharacter and otherCharacter:FindFirstChild("HumanoidRootPart") then
                local distance = (otherCharacter.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    closestEnemy = otherCharacter
                end
            end
        end
    end
    return closestEnemy
end

local function aimbot()
    while aimbotActive do
        wait(0.1)

        local target = getClosestEnemy()
        if target then
            -- Viser automatiquement l'ennemi
            local gun = character:FindFirstChild("Gun") -- Remplace par ton arme
            if gun then
                local aimPart = gun:FindFirstChild("AimingPart") -- Remplace par la partie de visée de l'arme
                if aimPart then
                    aimPart.CFrame = CFrame.new(aimPart.Position, target.HumanoidRootPart.Position)
                end
            end
        end
    end
end

local function stopAimbot()
    aimbotActive = false
end

-- 3. **Silent Aim (Tirer sans visée visible)**
local function silentAim()
    while silentAimActive do
        wait(0.1)

        local target = getClosestEnemy()
        if target then
            -- Tirer sans viser visuellement
            local gun = character:FindFirstChild("Gun") -- Remplace par le nom de ton arme
            if gun then
                local aimPart = gun:FindFirstChild("AimingPart") -- Remplace par la partie de visée de ton arme
                if aimPart then
                    gun.Fire() -- Remplace par le code pour tirer
                end
            end
        end
    end
end

local function stopSilentAim()
    silentAimActive = false
end

-- 4. **NoClip (Traverser les murs)**
local function enableNoClip()
    noclipActive = true
    humanoid.PlatformStand = true
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end

local function disableNoClip()
    noclipActive = false
    humanoid.PlatformStand = false
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = true
        end
    end
end

-- GUI : Interface graphique
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player.PlayerGui
ScreenGui.ResetOnSpawn = false

-- Créer une fenêtre pour les options
local window = Instance.new("Frame")
window.Parent = ScreenGui
window.Size = UDim2.new(0, 250, 0, 300)
window.Position = UDim2.new(0, 10, 0, 10)
window.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
window.BorderSizePixel = 2
window.BorderColor3 = Color3.fromRGB(255, 255, 255)

-- Ajouter un titre
local title = Instance.new("TextLabel")
title.Parent = window
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
title.Text = "Options du Script"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 14
title.TextAlign = Enum.TextAnchor.MiddleCenter

-- Bouton pour minimiser
local closeButton = Instance.new("TextButton")
closeButton.Parent = window
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 18

closeButton.MouseButton1Click:Connect(function()
    window.Visible = false
end)

-- Reouvrir la fenêtre
local openButton = Instance.new("TextButton")
openButton.Parent = player.PlayerGui
openButton.Size = UDim2.new(0, 30, 0, 30)
openButton.Position = UDim2.new(0, 10, 0, 10)
openButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
openButton.Text = "+"
openButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openButton.TextSize = 18

openButton.MouseButton1Click:Connect(function()
    window.Visible = true
end)

-- Section pour les options

-- Bouton God Mode
local godModeButton = Instance.new("TextButton")
godModeButton.Parent = window
godModeButton.Size = UDim2.new(1, 0, 0, 40)
godModeButton.Position = UDim2.new(0, 0, 0, 40)
godModeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
godModeButton.Text = "Activer God Mode"
godModeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
godModeButton.TextSize = 14

godModeButton.MouseButton1Click:Connect(function()
    if godModeActive then
        deactivateGodMode()
        godModeButton.Text = "Activer God Mode"
    else
        activateGodMode()
        godModeButton.Text = "Désactiver God Mode"
    end
end)

-- Bouton Aimbot
local aimbotButton = Instance.new("TextButton")
aimbotButton.Parent = window
aimbotButton.Size = UDim2.new(1, 0, 0, 40)
aimbotButton.Position = UDim2.new(0, 0, 0, 80)
aimbotButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
aimbotButton.Text = "Activer Aimbot"
aimbotButton.TextColor3 = Color3.fromRGB(255, 255, 255)
aimbotButton.TextSize = 14

aimbotButton.MouseButton1Click:Connect(function()
    if aimbotActive then
        stopAimbot()
        aimbotButton.Text = "Activer Aimbot"
    else
        aimbotActive = true
        aimbotButton.Text = "Désactiver Aimbot"
        aimbot()
    end
end)

-- Bouton Silent Aim
local silentAimButton = Instance.new("TextButton")
silentAimButton.Parent = window
silentAimButton.Size = UDim2.new(1, 0, 0, 40)
silentAimButton.Position = UDim2.new(0, 0, 0, 120)
silentAimButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
silentAimButton.Text = "Activer Silent Aim"
silentAimButton.TextColor3 = Color3.fromRGB(255, 255, 255)
silentAimButton.TextSize = 14

silentAimButton.MouseButton1Click:Connect(function()
    if silentAimActive then
        stopSilentAim()
        silentAimButton.Text = "Activer Silent Aim"
    else
        silentAimActive = true
        silentAimButton.Text = "Désactiver Silent Aim"
        silentAim()
    end
end)

-- Bouton NoClip
local noclipButton = Instance.new("TextButton")
noclipButton.Parent = window
noclipButton.Size = UDim2.new(1, 0, 0, 40)
noclipButton.Position = UDim2.new(0, 0, 0, 160)
noclipButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
noclipButton.Text = "Activer NoClip"
noclipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
noclip