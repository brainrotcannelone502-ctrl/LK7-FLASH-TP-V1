-- LK7 HUB - VERSÃO RECUPERADA (FIX VS CODE)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("LK7 HUB - IMPÉRIO GG", "DarkTheme")

-- Variáveis Técnicas
local targetHeight = 91 -- A altura recomendada para ficar no topo da base

-- ABA PRINCIPAL
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Movimentação & Visual")

-- BOTÃO FLASH TP (Coordenada 91)
Section:NewButton("Flash TP (Coord 91)", "Teleporte para o topo", function()
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local targetPos = Vector3.new(character.HumanoidRootPart.Position.X, targetHeight, character.HumanoidRootPart.Position.Z)
        character.HumanoidRootPart.CFrame = CFrame.new(targetPos)
    end
end)

-- BOTÃO BASE RAY X (Otimizado para não travar)
Section:NewToggle("Base Ray X", "Ver através das paredes", function(state)
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj.Parent:FindFirstChild("Humanoid") then
            obj.LocalTransparencyModifier = state and 0.5 or 0
        end
    end
end)

-- SOLUÇÃO PARA O PAINEL APARECER E MOVER
spawn(function()
    local gui = game.CoreGui:WaitForChild("LK7 HUB - IMPÉRIO GG", 10) or game.Players.LocalPlayer.PlayerGui:WaitForChild("LK7 HUB - IMPÉRIO GG", 10)
    if gui then
        gui.Main.Active = true
        gui.Main.Draggable = true -- Ativa o movimento do painel
    end
end)

Library:Notify("LK7 HUB", "Sistema restaurado com sucesso!", 5)
