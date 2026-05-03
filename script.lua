local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("LK7 FLASH TP", "DarkTheme")


local targetHeight = 91 
local toolName = "Teletransporte Instantâneo" 

local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Flash Steal V2")

Section:NewButton("FLASH TP", "Teleporta para a mira e ativa o item", function()
    local player = game.Players.LocalPlayer
    local mouse = player:GetMouse()
    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    
    if root and humanoid then

        local targetPos = mouse.Hit.p
        
       
        local tool = character:FindFirstChild(toolName) or player.Backpack:FindFirstChild(toolName)
        local brainrot = character:FindFirstChild("Brainrot") or player.Backpack:FindFirstChild("Brainrot")

       
        if tool then 
            humanoid:EquipTool(tool) 
        end
        if brainrot then
            humanoid:EquipTool(brainrot)
        end

       
   
        local finalPos = Vector3.new(targetPos.X, targetHeight, targetPos.Z)
        root.CFrame = CFrame.new(finalPos)

        task.spawn(function()
            
            task.wait(0.1)
            if tool then 
                tool:Activate()
            end
            
            
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("RemoteEvent") and (v.Name == "FlashRemote" or v.Name == "Teletransporte Instantâneo") then
                    v:FireServer(finalPos)
                    break
                end
            end
        end)
    end
end)


Section:NewToggle("x ray", "Visão externa", function(state)
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj.Parent:FindFirstChild("Humanoid") then
            obj.LocalTransparencyModifier = state and 0.5 or 0
        end
    end
end)

-- Lógica da Bolinha LK7 e Arrastar (Mantida do seu original)
-- [O restante do seu código de GUI e movimentação de botões entra aqui]
