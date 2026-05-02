-- LK7 HUB - VERSÃO FINAL COM TRIGGER AUTOMÁTICO
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("LK7 HUB - IMPÉRIO GG", "DarkTheme")

-- Configurações de Busca e Alvo
local targetHeight = 91 
local itemName = "FLASH TELEPORTE"
local remoteName = "Teletransporte Instantâneo"

-- ABA PRINCIPAL
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Flash Steal V2")

-- BOTÃO FLASH TP COM TRIGGER NO FINAL
Section:NewButton("Flash TP (Coord 91)", "Teleporta e usa Trigger no final", function()
    local player = game.Players.LocalPlayer
    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    
    if root and humanoid then
        local targetPos = Vector3.new(root.Position.X, targetHeight, root.Position.Z)
        
        -- 1. TENTA EQUIPAR O ITEM FLASH TELEPORTE
        local tool = player.Backpack:FindFirstChild(itemName) or character:FindFirstChild(itemName)
        if tool then
            humanoid:EquipTool(tool)
            task.wait(0.05)
        end

        -- 2. EXECUTA O TELEPORTE (CFrame)
        root.CFrame = CFrame.new(targetPos)

        -- 3. O "TRIGGER" (DISPARA QUANDO ESTÁ QUASE ACABANDO/CHEGANDO)
        -- Espera um milissegundo para garantir que a posição foi atingida
        task.spawn(function()
            repeat task.wait() until (root.Position.Y >= targetHeight - 1)
            
            -- Dispara o Trigger via Item
            if tool then tool:Activate() end
            
            -- Dispara o Trigger via Remote (Busca por Teletransporte Instantâneo)
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("RemoteEvent") and (v.Name == remoteName or v.Name == "FlashRemote") then
                    v:FireServer(targetPos)
                    break
                end
            end
            
            Library:Notify("TRIGGER", "Teletransporte Validado!", 2)
        end)
    end
end)

-- BOTÃO BASE RAY X (CONFORME image_7c0618.jpg)
Section:NewToggle("Brainrot / X-Ray", "Visão externa otimizada", function(state)
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj.Parent:FindFirstChild("Humanoid") then
            obj.LocalTransparencyModifier = state and 0.5 or 0
        end
    end
end)

-- SCRIPT DE ARRASTE (DESTRANCAR MENU)
spawn(function()
    local gui = game.CoreGui:WaitForChild("LK7 HUB - IMPÉRIO GG", 10) or game.Players.LocalPlayer.PlayerGui:WaitForChild("LK7 HUB - IMPÉRIO GG", 10)
    if gui then
        gui.Main.Active = true
        gui.Main.Draggable = true
    end
end)

Library:Notify("LK7 HUB", "Sistema com Trigger Ativado!", 5)
