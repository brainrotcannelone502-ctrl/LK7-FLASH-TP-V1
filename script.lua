
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("LK7 FLASH TP", "DarkTheme")


local targetHeight = 91
local toolName = "Teletransporte Instantâneo"
local itemName = "Brainrot"

local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Flash Steal V2")


Section:NewButton("FLASH GRAB", "Mira no item, teleporta e usa Trigger", function()
    local player = game.Players.LocalPlayer
    local mouse = player:GetMouse()
    local character = player.Character
    local root = character and character:FindFirstChild("HumanoidRootPart")
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    
    if root and humanoid then
        
        local targetPos = mouse.Hit.p
        
        
        local tool = character:FindFirstChild(toolName) or player.Backpack:FindFirstChild(toolName)
        local brainrot = character:FindFirstChild(itemName) or player.Backpack:FindFirstChild(itemName)

      
        if tool then humanoid:EquipTool(tool) end
        if brainrot then humanoid:EquipTool(brainrot) end

       
        local finalPos = Vector3.new(targetPos.X, targetHeight, targetPos.Z)
        root.CFrame = CFrame.new(finalPos)

        task.spawn(function()
            task.wait(0.1)
            
            if tool then tool:Activate() end
            
            
            for _, v in pairs(game:GetDescendants()) do
                if v:IsA("RemoteEvent") and (v.Name == "FlashRemote" or v.Name == toolName) then
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


local screenGui = game.CoreGui:FindFirstChild("LK7 HUB - IMPÉRIO GG") or game.Players.LocalPlayer.PlayerGui:FindFirstChild("LK7 HUB - IMPÉRIO GG")
local mainFrame = screenGui.Main

local OpenButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

OpenButton.Name = "OpenButton"
OpenButton.Parent = screenGui
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenButton.Position = UDim2.new(0.1, 0, 0.1, 0)
OpenButton.Size = UDim2.new(0, 50, 0, 50)
OpenButton.Visible = false
OpenButton.Text = "LK7"
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenButton.Font = Enum.Font.SourceSansBold
OpenButton.TextSize = 18

UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = OpenButton

local function ToggleUI()
    if mainFrame.Visible then
        mainFrame.Visible = false
        OpenButton.Visible = true
    else
        mainFrame.Visible = true
        OpenButton.Visible = false
    end
end

OpenButton.MouseButton1Click:Connect(ToggleUI)


local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

OpenButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = OpenButton.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        OpenButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

OpenButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

mainFrame.Active = true
mainFrame.Draggable = true

Library:Notify("LK7 HUB", "Aperte o X para minimizar para a bolinha!", 5)
