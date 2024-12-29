-- Variables principales
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local mouse = player:GetMouse()

-- Le "tool" que le joueur utilise pour pêcher (exemple : canne à pêche)
local fishingRod = character:WaitForChild("FishingRod") -- Remplacer par le nom de ton outil
local fishingSpot = workspace:WaitForChild("FishingSpot") -- Le point de pêche

-- Fonction pour lancer la ligne
local function castLine()
    -- Simuler un clic pour lancer la ligne
    mouse.Target = fishingSpot
    mouse:Click()
end

-- Fonction pour attendre qu'un poisson morde
local function waitForBite()
    -- Attendre un temps aléatoire pour que le poisson morde (simulé ici)
    wait(math.random(5, 10)) -- Attente aléatoire entre 5 et 10 secondes
end

-- Fonction pour récupérer le poisson
local function reelIn()
    -- Simuler l'action de récupérer le poisson (par exemple en cliquant)
    mouse:Click()
end

-- Fonction principale d'autofarming
local function autoFarm()
    while true do
        -- Lancer la ligne
        castLine()
        
        -- Attendre qu'un poisson morde
        waitForBite()

        -- Récupérer le poisson
        reelIn()

        -- Attendre un peu avant de relancer la ligne
        wait(2) -- Pause de 2 secondes avant de recommencer
    end
end

-- Lancer l'autofarming
autoFarm()
