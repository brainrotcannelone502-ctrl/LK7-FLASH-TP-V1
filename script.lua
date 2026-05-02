-- LK7 HUB - VERSÃO FLASH ITEM + BRAINROT EFFECT
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("LK7 HUB - IMPÉRIO GG", "DarkTheme")

-- Configurações
local targetHeight = 91 

-- ABA PRINCIPAL
local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Flash Steal V2")

-- BOTÃO FLASH TP COM ITEM (IGUAL AO VÍDEO)
Section:NewButton("Flash TP (Item Flash)", "Teleporta usando o item da mochila", function()
    local player = game.Players.LocalPlayer
    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    
    -- 1. Procura o item Flash TP na mochila ou na mão
    local flashItem = player.Backpack:FindFirstChild("Flash TP") or character:FindFirstChild("Flash TP")
    
    if flashItem and root then
        -- 2. Equipa o item se não estiver na mão
        humanoid = character:FindFirstChildOfClass("Humanoid")
        humanoid:EquipTool(flashItem)
        
        -- 3. Define a posição de saída (Altura 91)
        local targetPos = Vector3.new(root.Position.X, targetHeight, root.Position.Z)
        
        -- 4. ATIVA O ITEM (Isso faz o efeito 'Flash' e 'Brainrot' igual ao vídeo)
        -- Aqui usamos o gatilho do próprio item para o servidor aceitar
        root.CFrame = CFrame.new(targetPos)
        flashItem:Activate() 
        
    else
        -- Caso não tenha o item, ele avisa
        Library:Notify("ERRO", "Você precisa ter o item 'Flash TP' no inventário!", 3)
    end
end)

-- BOTÃO BASE RAY X (Para ver o loot fora da base)
Section:NewToggle("Brainrot / X-Ray", "Melhora a visão externa", function(state)
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj.Parent:FindFirstChild("Humanoid") then
            obj.LocalTransparencyModifier = state and 0.5 or 0
        end
    end
end)

-- SCRIPT PARA MOVER O PAINEL
spawn(function()
    local gui = game.CoreGui:WaitForChild("LK7 HUB - IMPÉRIO GG", 10)
    if gui then
        gui.Main.Active = true
        gui.Main.Draggable = true
    end
end)

Library:Notify("LK7 HUB", "Modo Flash Steal V2 Carregado!", 5)
