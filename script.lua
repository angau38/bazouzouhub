-- Variables principales
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local mouse = player:GetMouse()

-- Interface utilisateur
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local CloseButton = Instance.new("TextButton")
local IconButton = Instance.new("TextButton")
local SilentAimButton = Instance.new("TextButton")
local NoClipButton = Instance.new("TextButton")
local SpeedSlider = Instance.new("TextBox")

-- Configuration du ScreenGui
ScreenGui.Name = "EnhancedMenu"
ScreenGui.Parent = game.CoreGui

-- Configuration de la fenêtre principale
Frame.Size = UDim2.new(0, 200, 0, 250)
Frame.Position = UDim2.new(0.5, -100, 0.5, -125)
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.Visible = true
Frame.Parent = ScreenGui

-- Bouton Fermer
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseButton.Parent = Frame

-- Bouton Icône
IconButton.Size = UDim2.new(0, 50, 0, 50)
IconButton.Position = UDim2.new(0, 20, 0, 20)
IconButton.Text = "⚙️"
IconButton.TextColor3 = Color3.fromRGB(255, 255, 255)
IconButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
IconButton.Visible = false
IconButton.Parent = ScreenGui

-- Bouton Silent Aim
SilentAimButton.Size = UDim2.new(0, 180, 0, 40)
SilentAimButton.Position = UDim2.new(0, 10, 0, 50)
SilentAimButton.Text = "Silent Aim: OFF"
SilentAimButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
SilentAimButton.Parent = Frame

-- Bouton NoClip
NoClipButton.Size = UDim2.new(0, 180, 0, 40)
NoClipButton.Position = UDim2.new(0, 10, 0, 100)
NoClipButton.Text = "NoClip: OFF"
NoClipButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
NoClipButton.Parent = Frame

-- Changeur de vitesse
SpeedSlider.Size = UDim2.new(0, 180, 0, 40)
SpeedSlider.Position = UDim2.new(0, 10, 0, 150)
SpeedSlider.PlaceholderText = "Vitesse: 16"
SpeedSlider.Text = ""
SpeedSlider.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
SpeedSlider.Parent = Frame

-- Fonctionnalités
local silentAimActive = false
local noClipActive = false
local defaultWalkSpeed = humanoid.WalkSpeed

-- Fonction pour fermer et réduire le menu
CloseButton.MouseButton1Click:Connect(function()
    Frame.Visible = false
    IconButton.Visible = true
end)

-- Fonction pour rouvrir le menu
IconButton.MouseButton1Click:Connect(function()
    Frame.Visible = true
    IconButton.Visible = false
end)

-- Silent Aim
SilentAimButton.MouseButton1Click:Connect(function()
    silentAimActive = not silentAimActive
    SilentAimButton.Text = silentAimActive and "Silent Aim: ON" or "Silent Aim: OFF"
    if silentAimActive then
        print("Silent Aim activé")
        game:GetService("RunService").RenderStepped:Connect(function()
            if silentAimActive then
                local closestPlayer = nil
                local shortestDistance = math.huge
                for _, otherPlayer in pairs(game.Players:GetPlayers()) do
                    if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("Head") then
                        local head = otherPlayer.Character.Head
                        local distance = (head.Position - character.Head.Position).Magnitude
                        if distance < shortestDistance then
                            shortestDistance = distance
                            closestPlayer = head
                        end
                    end
                end
                if closestPlayer then
                    mouse.Target = closestPlayer
                end
            end
        end)
    else
        print("Silent Aim désactivé")
    end
end)

-- NoClip
NoClipButton.MouseButton1Click:Connect(function()
    noClipActive = not noClipActive
    NoClipButton.Text = noClipActive and "NoClip: ON" or "NoClip: OFF"
    if noClipActive then
        print("NoClip activé")
        game:GetService("RunService").Stepped:Connect(function()
            if noClipActive then
                character.Humanoid:ChangeState(11)
            end
        end)
    else
        print("NoClip désactivé")
    end
end)

-- Changeur de vitesse
SpeedSlider.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        local newSpeed = tonumber(SpeedSlider.Text)
        if newSpeed and newSpeed > 0 then
            humanoid.WalkSpeed = newSpeed
            print("Vitesse réglée à :", newSpeed)
        else
            humanoid.WalkSpeed = defaultWalkSpeed
            print("Vitesse réinitialisée à :", defaultWalkSpeed)
        end
    end
end)
