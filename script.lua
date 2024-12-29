-- Déclaration des variables principales
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local mouse = player:GetMouse()

-- 1. **God Mode (Invincibilité)**
local function activateGodMode()
    -- Empêcher les dégâts en réinitialisant la santé à chaque changement
    humanoid.HealthChanged:Connect(function(health)
        if health < humanoid.MaxHealth then
            humanoid.Health = humanoid.MaxHealth
        end
    end)
end

-- 2. **Aimbot (Vise automatiquement l'ennemi)**
local function getClosestEnemy()
    local closestEnemy = nil
    local shortestDistance = math.huge

    -- Chercher les ennemis dans le jeu
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
    while true do
        wait(0.1)

        local target = getClosestEnemy()
        if target then
            -- Ajuster la visée de l'arme vers l'ennemi
            local gun = character:FindFirstChild("Gun") -- Remplace par le nom de ton arme
            if gun then
                local aimPart = gun:FindFirstChild("AimingPart") -- Remplace par la partie d'aiming de l'arme
                if aimPart then
                    aimPart.CFrame = CFrame.new(aimPart.Position, target.HumanoidRootPart.Position)
                end
            end
        end
    end
end

-- 3. **Silent Aim (Tirer automatiquement sans visée visible)**
local function silentAim()
    while true do
        wait(0.1)

        local target = getClosestEnemy()
        if target then
            -- Tirer automatiquement vers l'ennemi sans viser visuellement
            local gun = character:FindFirstChild("Gun") -- Remplace par le nom de ton arme
            if gun then
                local aimPart = gun:FindFirstChild("AimingPart") -- Remplace par la partie de visée
                if aimPart then
                    -- Si tu utilises un script de tir automatique
                    gun.Fire() -- Remplace par la méthode pour tirer dans ton jeu
                end
            end
        end
    end
end

-- 4. **NoClip (Traverser les murs)**
local function enableNoClip()
    humanoid.PlatformStand = true
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
end

local function disableNoClip()
    humanoid.PlatformStand = false
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = true
        end
    end
end

local noclip = false
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.N then -- Appuyer sur "N" pour activer/désactiver NoClip
        noclip = not noclip
        if noclip then
            enableNoClip()
        else
            disableNoClip()
        end
    end
end)

-- Activation des fonctionnalités
activateGodMode()  -- Activer le God Mode
aimbot()           -- Activer l'Aimbot
silentAim()        -- Activer le Silent Aim