-- LK7 HUB - VERSÃO FINAL (CORREÇÃO DE MENU E POSIÇÃO)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("LK7 HUB - IMPÉRIO GG", "DarkTheme")

-- Configurações de Busca e Alvo
local targetHeight = 91 
local itemName = "FLASH TELEPORTE"
local remoteName = "Teletransporte Instantâneo"

-- ABA PRINCIPAL
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Flash Steal V2")

-- BOTÃO FLASH TP COM TRIGGER AUTOMÁTICO
Section:NewButton("Flash TP (Coord 91)", "Teleporta e usa Trigger no final", function()
    local player = game.Players.LocalPlayer
    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    
    if root and humanoid then
        local targetPos = Vector3.new(root.Position.X, targetHeight, root.Position.Z)
        
        local tool = player.Backpack:FindFirstChild(itemName) or character:FindFirstChild(itemName)
        if tool then
            humanoid:EquipTool(tool)
            task.wait(0.05)
        end

        root.CFrame = CFrame.new(targetPos)

        task.spawn(function()
            repeat task.wait() until (root.Position.Y >= targetHeight - 1)
            if tool then tool:Activate() end
            
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("RemoteEvent") and (v.Name == remoteName or v.Name == "FlashRemote") then
                    v:FireServer(targetPos)
                    break
                end
            end
        end)
    end
end)

-- BOTÃO X-RAY OTIMIZADO
Section:NewToggle("Brainrot / X-Ray", "Visão externa", function(state)
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj.Parent:FindFirstChild("Humanoid") then
            obj.LocalTransparencyModifier = state and 0.5 or 0
        end
    end
end)

-- FUNÇÃO PARA DESTRAVAR O MENU E PERMITIR ARRASTAR
local function MakeDraggable(gui)
    local UserInputService = game:GetService("UserInputService")
    local dragging, dragInput, dragStart, startPos

    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- APLICA O ARRASTE ASSIM QUE O MENU CARREGAR
spawn(function()
    local screenGui = game.CoreGui:WaitForChild("LK7 HUB - IMPÉRIO GG", 15) or game.Players.LocalPlayer.PlayerGui:WaitForChild("LK7 HUB - IMPÉRIO GG", 15)
    if screenGui then
        local mainFrame = screenGui:FindFirstChild("Main")
        if mainFrame then
            -- Define uma posição inicial para não ficar bem no meio da cara
            mainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
            MakeDraggable(mainFrame)
        end
    end
end)

Library:Notify("LK7 HUB", "Menu Destravado! Arraste pelo topo.", 5)
