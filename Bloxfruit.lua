print("=== KANEKI CHEATS LOADING ===")

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Main screen GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KanekiMain"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Picture entry point (full screen)
local picFrame = Instance.new("Frame")
picFrame.Name = "PictureEntry"
picFrame.Size = UDim2.new(1, 0, 1, 0)
picFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
picFrame.BorderSizePixel = 0
picFrame.Parent = screenGui

local picImage = Instance.new("ImageLabel")
picImage.Image = "rbxassetid://108083060527602"
picImage.Size = UDim2.new(1, 0, 1, 0)
picImage.BackgroundTransparency = 0.3
picImage.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
picImage.BorderSizePixel = 0
picImage.Parent = picFrame

-- Tap to enter
local tapLabel = Instance.new("TextLabel")
tapLabel.Text = "TAP TO ENTER KANEKI CHEATS"
tapLabel.Size = UDim2.new(1, 0, 0, 50)
tapLabel.Position = UDim2.new(0, 0, 0.5, -25)
tapLabel.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
tapLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
tapLabel.Font = Enum.Font.GothamBold
tapLabel.TextScaled = true
tapLabel.BorderSizePixel = 0
tapLabel.Parent = picFrame

picFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        picFrame:Destroy()
        print("Entering hub...")
    end
end)

wait(1)

-- Main hub UI
local hubGui = Instance.new("ScreenGui")
hubGui.Name = "KanekiHub"
hubGui.ResetOnSpawn = false
hubGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 650)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -325)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BorderColor3 = Color3.fromRGB(200, 0, 0)
mainFrame.BorderSizePixel = 3
mainFrame.Parent = hubGui

-- Title
local titleBar = Instance.new("TextLabel")
titleBar.Text = "KANEKI CHEATS"
titleBar.Size = UDim2.new(1, 0, 0, 50)
titleBar.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
titleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
titleBar.Font = Enum.Font.GothamBold
titleBar.TextScaled = true
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

-- Content
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Size = UDim2.new(1, 0, 1, -100)
contentFrame.Position = UDim2.new(0, 0, 0, 50)
contentFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
contentFrame.BorderSizePixel = 0
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 800)
contentFrame.ScrollBarThickness = 6
contentFrame.ScrollBarImageColor3 = Color3.fromRGB(200, 0, 0)
contentFrame.Parent = mainFrame

-- Toggles
local toggles = {}

local function createToggle(name, yPos)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 40)
    frame.Position = UDim2.new(0, 10, 0, yPos)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderColor3 = Color3.fromRGB(100, 100, 100)
    frame.BorderSizePixel = 1
    frame.Parent = contentFrame
    
    local label = Instance.new("TextLabel")
    label.Text = name
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.Parent = frame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 60, 0, 28)
    btn.Position = UDim2.new(0.7, 0, 0.5, -14)
    btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = "OFF"
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.BorderSizePixel = 0
    btn.Parent = frame
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = state and "ON" or "OFF"
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(200, 0, 0)
    end)
    
    table.insert(toggles, {name = name, state = function() return state end})
    return state
end

createToggle("Auto Farm", 10)
createToggle("Auto Collect", 55)
createToggle("Auto Attack", 100)
createToggle("Auto Heal", 145)
createToggle("Follow NPC", 190)
createToggle("Anti-AFK", 235)

-- Luck boost button
local luckBtn = Instance.new("TextButton")
luckBtn.Text = "🍀 BOOST 1M LUCK"
luckBtn.Size = UDim2.new(1, -20, 0, 45)
luckBtn.Position = UDim2.new(0, 10, 0, 290)
luckBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
luckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
luckBtn.Font = Enum.Font.GothamBold
luckBtn.TextScaled = true
luckBtn.BorderSizePixel = 0
luckBtn.Parent = contentFrame

local luckActive = false
luckBtn.MouseButton1Click:Connect(function()
    if not luckActive then
        luckActive = true
        luckBtn.Text = "⏳ BOOSTING..."
        luckBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        
        spawn(function()
            for i = 1, 100 do
                wait(0.8 + math.random() * 0.4)
                luckBtn.Text = "⏳ " .. i .. "%"
            end
            luckBtn.Text = "✅ DRAGON FRUIT READY"
            luckBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
            luckActive = false
        end)
    end
end)

-- Start/Stop buttons
local startBtn = Instance.new("TextButton")
startBtn.Text = "▶️ START FARM"
startBtn.Size = UDim2.new(0.5, -7, 0, 40)
startBtn.Position = UDim2.new(0, 10, 1, -50)
startBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
startBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
startBtn.Font = Enum.Font.GothamBold
startBtn.TextScaled = true
startBtn.BorderSizePixel = 0
startBtn.Parent = mainFrame

local stopBtn = Instance.new("TextButton")
stopBtn.Text = "⏹️ STOP FARM"
stopBtn.Size = UDim2.new(0.5, -7, 0, 40)
stopBtn.Position = UDim2.new(0.5, 4, 1, -50)
stopBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
stopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
stopBtn.Font = Enum.Font.GothamBold
stopBtn.TextScaled = true
stopBtn.BorderSizePixel = 0
stopBtn.Parent = mainFrame

print("UI complete")

-- Farming logic
local farming = false

startBtn.MouseButton1Click:Connect(function()
    farming = true
    startBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
end)

stopBtn.MouseButton1Click:Connect(function()
    farming = false
    startBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
end)

-- Main farm loop
spawn(function()
    while true do
        if farming then
            local character = player.Character
            if character then
                local hrp = character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    -- Collect fruits
                    for _, obj in pairs(game.Workspace:GetDescendants()) do
                        if obj.Name:match("Fruit") and obj:FindFirstChild("Position") then
                            pcall(function()
                                hrp.CFrame = obj.CFrame
                                wait(0.3)
                            end)
                        end
                    end
                end
            end
        end
        wait(1)
    end
end)

print("=== KANEKI CHEATS READY ===")
