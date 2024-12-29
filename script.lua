-- Interface et options
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Créer un menu simple
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local GodModeButton = Instance.new("TextButton")
local AutoJumpButton = Instance.new("TextButton")

-- Configuration du ScreenGui
ScreenGui.Name = "CustomMenu"
ScreenGui.Parent = game.CoreGui

Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Position = UDim2.new(0.5, -100, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Frame.Parent = ScreenGui

GodModeButton.Size = UDim2.new(0, 180, 0, 40)
GodModeButton.Position = UDim2.new(0, 10, 0, 10)
GodModeButton.Text = "God Mode : OFF"
GodModeButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
GodModeButton.Parent = Frame

AutoJumpButton.Size = UDim2.new(0, 180, 0, 40)
AutoJumpButton.Position = UDim2.new(0, 10, 0, 60)
AutoJumpButton.Text = "Auto Jump : OFF"
AutoJumpButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
AutoJumpButton.Parent = Frame

-- Fonctionnalités
local godModeActive = false
local autoJumpActive = false

GodModeButton.MouseButton1Click:Connect(function()
    godModeActive = not godModeActive
    if godModeActive then
        GodModeButton.Text = "God Mode : ON"
        humanoid.HealthChanged:Connect(function(health)
            if godModeActive and health < humanoid.MaxHealth then
                humanoid.Health = humanoid.MaxHealth
            end
        end)
    else
        GodModeButton.Text = "God Mode : OFF"
    end
end)

AutoJumpButton.MouseButton1Click:Connect(function()
    autoJumpActive = not autoJumpActive
    if autoJumpActive then
        AutoJumpButton.Text = "Auto Jump : ON"
        while autoJumpActive do
            humanoid.Jump = true
            wait(0.5)
        end
    else
        AutoJumpButton.Text = "Auto Jump : OFF"
    end
end)