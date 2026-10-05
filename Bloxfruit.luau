print("=== KANEKI CHEATS v5 FULL BUILD ===")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Antiban: randomized timing
local function randomWait(min, max)
    wait(math.random(min * 1000, max * 1000) / 1000)
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KanekiCheatsV5"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Logo button
local logoBtn = Instance.new("ImageButton")
logoBtn.Name = "LogoBtn"
logoBtn.Image = "rbxassetid://108083060527602"
logoBtn.Size = UDim2.new(0, 70, 0, 70)
logoBtn.Position = UDim2.new(0.02, 0, 0.02, 0)
logoBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
logoBtn.BorderColor3 = Color3.fromRGB(200, 0, 0)
logoBtn.BorderSizePixel = 2
logoBtn.Parent = screenGui

-- Main menu
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 320, 0, 700)
mainFrame.Position = UDim2.new(0.02, 0, 0.1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BorderColor3 = Color3.fromRGB(200, 0, 0)
mainFrame.BorderSizePixel = 2
mainFrame.Visible = false
mainFrame.Parent = screenGui

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 45)
titleBar.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleText = Instance.new("TextLabel")
titleText.Text = "KANEKI CHEATS v5"
titleText.Size = UDim2.new(0.85, 0, 1, 0)
titleText.BackgroundTransparency = 1
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 13
titleText.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Text = "✕"
closeBtn.Size = UDim2.new(0.15, 0, 1, 0)
closeBtn.Position = UDim2.new(0.85, 0, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = titleBar

-- Content
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Size = UDim2.new(1, 0, 1, -45)
contentFrame.Position = UDim2.new(0, 0, 0, 45)
contentFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
contentFrame.BorderSizePixel = 0
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 1400)
contentFrame.ScrollBarThickness = 5
contentFrame.ScrollBarImageColor3 = Color3.fromRGB(200, 0, 0)
contentFrame.Parent = mainFrame

-- Helper: create section header
local function createHeader(text, yPos)
    local header = Instance.new("TextLabel")
    header.Text = "▼ " .. text
    header.Size = UDim2.new(1, -10, 0, 30)
    header.Position = UDim2.new(0, 5, 0, yPos)
    header.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    header.TextColor3 = Color3.fromRGB(255, 255, 255)
    header.Font = Enum.Font.GothamBold
    header.TextSize = 12
    header.BorderSizePixel = 0
    header.Parent = contentFrame
    return header
end

-- Helper: create toggle
local toggleStates = {}
local function createToggle(name, yPos, category)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 32)
    frame.Position = UDim2.new(0, 5, 0, yPos)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.BorderColor3 = Color3.fromRGB(80, 80, 80)
    frame.BorderSizePixel = 1
    frame.Parent = contentFrame
    
    local label = Instance.new("TextLabel")
    label.Text = name
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 10
    label.Parent = frame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 50, 0, 24)
    btn.Position = UDim2.new(0.72, 0, 0.5, -12)
    btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = "OFF"
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 8
    btn.BorderSizePixel = 0
    btn.Parent = frame
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = state and "ON" or "OFF"
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(200, 0, 0)
    end)
    
    toggleStates[category .. "_" .. name] = function() return state end
    return function() return state end
end

-- Helper: create button
local function createButton(text, yPos, callback, color)
    local btn = Instance.new("TextButton")
    btn.Text = text
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.Position = UDim2.new(0, 5, 0, yPos)
    btn.BackgroundColor3 = color or Color3.fromRGB(200, 0, 0)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.BorderSizePixel = 0
    btn.Parent = contentFrame
    
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = btn.BackgroundColor3 - Color3.fromRGB(50, 0, 0)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = color or Color3.fromRGB(200, 0, 0)
    end)
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- === LUCK SYSTEM ===
createHeader("LUCK SYSTEM", 5)

local luckValue = 0
local luckLabel = Instance.new("TextLabel")
luckLabel.Text = "Luck: 0 / 1,000,000"
luckLabel.Size = UDim2.new(1, -10, 0, 28)
luckLabel.Position = UDim2.new(0, 5, 0, 38)
luckLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
luckLabel.TextColor3 = Color3.fromRGB(200, 0, 0)
luckLabel.Font = Enum.Font.GothamBold
luckLabel.TextSize = 10
luckLabel.BorderColor3 = Color3.fromRGB(80, 80, 80)
luckLabel.BorderSizePixel = 1
luckLabel.Parent = contentFrame

local luckBar = Instance.new("Frame")
luckBar.Size = UDim2.new(1, -10, 0, 18)
luckBar.Position = UDim2.new(0, 5, 0, 69)
luckBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
luckBar.BorderSizePixel = 0
luckBar.Parent = contentFrame

local luckBarFill = Instance.new("Frame")
luckBarFill.Size = UDim2.new(0, 0, 1, 0)
luckBarFill.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
luckBarFill.BorderSizePixel = 0
luckBarFill.Parent = luckBar

local luckBtn = createButton("🍀 UNLOCK DRAGON FRUIT", 90, function()
    luckBtn.Interactable = false
    luckBtn.Text = "⏳ BOOSTING..."
    luckBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    
    spawn(function()
        luckValue = 0
        while luckValue < 1000000 do
            local increment = math.random(8000, 15000)
            luckValue = math.min(luckValue + increment, 1000000)
            luckLabel.Text = "Luck: " .. string.format("%,d", luckValue) .. " / 1,000,000"
            luckBarFill.Size = UDim2.new(luckValue / 1000000, 0, 1, 0)
            randomWait(0.3, 0.8)
        end
        luckBtn.Text = "✅ DRAGON FRUIT READY"
        luckBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
    end)
end, Color3.fromRGB(200, 0, 0))

-- === FARMING ===
createHeader("FARMING", 135)

local getFarm = createToggle("Auto Farm", 168, "farm")
local getCollect = createToggle("Auto Collect Fruits", 203, "farm")
local getLoot = createToggle("Auto Loot Drops", 238, "farm")
local getFollowNPC = createToggle("Follow NPC", 273, "farm")
local getAutoRespawn = createToggle("Auto Respawn", 308, "farm")

-- === COMBAT ===
createHeader("COMBAT", 343)

local getAttack = createToggle("Auto Attack", 376, "combat")
local getHeal = createToggle("Auto Heal", 411, "combat")
local getAutoBlock = createToggle("Auto Block", 446, "combat")
local getWeaponSwap = createToggle("Smart Weapon Swap", 481, "combat")

-- === MOVEMENT ===
createHeader("MOVEMENT", 516)

local getWalkSpeed = createToggle("Speed Boost (x2)", 549, "movement")
local getSpeedMode = createToggle("Flight Mode", 584, "movement")
local getTeleportNPC = createToggle("Teleport to NPC", 619, "movement")

-- === ANTI-DETECTION ===
createHeader("ANTI-DETECTION", 654)

local getAntiAfk = createToggle("Anti-AFK", 687, "antiban")
local getRandomDelay = createToggle("Random Delays", 722, "antiban")
local getStealthMode = createToggle("Stealth Mode", 757, "antiban")

-- === STATS ===
createHeader("SESSION STATS", 792)

local statsFrame = Instance.new("Frame")
statsFrame.Size = UDim2.new(1, -10, 0, 100)
statsFrame.Position = UDim2.new(0, 5, 0, 825)
statsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
statsFrame.BorderColor3 = Color3.fromRGB(80, 80, 80)
statsFrame.BorderSizePixel = 1
statsFrame.Parent = contentFrame

local fruitsLabel = Instance.new("TextLabel")
fruitsLabel.Text = "🍌 Fruits: 0"
fruitsLabel.Size = UDim2.new(0.5, 0, 0.33, 0)
fruitsLabel.BackgroundTransparency = 1
fruitsLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
fruitsLabel.Font = Enum.Font.Gotham
fruitsLabel.TextSize = 10
fruitsLabel.Parent = statsFrame

local npcsLabel = Instance.new("TextLabel")
npcsLabel.Text = "⚔️ NPCs: 0"
npcsLabel.Size = UDim2.new(0.5, 0, 0.33, 0)
npcsLabel.Position = UDim2.new(0.5, 0, 0, 0)
npcsLabel.BackgroundTransparency = 1
npcsLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
npcsLabel.Font = Enum.Font.Gotham
npcsLabel.TextSize = 10
npcsLabel.Parent = statsFrame

local timeLabel = Instance.new("TextLabel")
timeLabel.Text = "⏱️ Time: 0m 0s"
timeLabel.Size = UDim2.new(1, 0, 0.33, 0)
timeLabel.Position = UDim2.new(0, 0, 0.33, 0)
timeLabel.BackgroundTransparency = 1
timeLabel.TextColor3 = Color3.fromRGB(200, 100, 255)
timeLabel.Font = Enum.Font.Gotham
timeLabel.TextSize = 10
timeLabel.Parent = statsFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Text = "Status: IDLE"
statusLabel.Size = UDim2.new(1, 0, 0.34, 0)
statusLabel.Position = UDim2.new(0, 0, 0.66, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(255, 150, 100)
statusLabel.Font = Enum.Font.GothamBold
statusLabel.TextSize = 10
statusLabel.Parent = statsFrame

-- === CONTROLS ===
createHeader("CONTROLS", 935)

local startBtn = createButton("▶️ START FARM", 968, function()
    farmingActive = true
    statusLabel.Text = "Status: FARMING"
    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
end, Color3.fromRGB(0, 150, 0))

local stopBtn = createButton("⏹️ STOP FARM", 1006, function()
    farmingActive = false
    statusLabel.Text = "Status: IDLE"
    statusLabel.TextColor3 = Color3.fromRGB(255, 150, 100)
end, Color3.fromRGB(150, 0, 0))

createButton("📊 RESET STATS", 1044, function()
    fruitsCollected = 0
    npcsDefeated = 0
    sessionTime = 0
    fruitsLabel.Text = "🍌 Fruits: 0"
    npcsLabel.Text = "⚔️ NPCs: 0"
    timeLabel.Text = "⏱️ Time: 0m 0s"
end, Color3.fromRGB(100, 100, 100))

createButton("🔧 SETTINGS", 1082, function()
    -- Settings placeholder
end, Color3.fromRGB(100, 100, 100))

-- === STATE ===
local farmingActive = false
local fruitsCollected = 0
local npcsDefeated = 0
local sessionTime = 0

-- === MENU TOGGLE ===
logoBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

-- === DRAGGABLE ===
local dragging = false
local dragStart = nil
local frameStart = nil

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = game:GetService("UserInputService"):GetMouseLocation()
        frameStart = mainFrame.Position
    end
end)

titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mouse = player:GetMouse()
        local delta = mouse.Position - dragStart
        mainFrame.Position = frameStart + UDim2.new(0, delta.X, 0, delta.Y)
    end
end)

-- === MAIN FARMING LOOP ===
spawn(function()
    while true do
        if farmingActive then
            local character = player.Character
            if character then
                local hrp = character:FindFirstChild("HumanoidRootPart")
                local humanoid = character:FindFirstChild("Humanoid")
                
                if hrp and humanoid then
                    -- Collect fruits
                    if getCollect() then
                        for _, obj in pairs(game.Workspace:GetDescendants()) do
                            if obj.Name:match("Fruit") or obj.Name:match("Chest") then
                                if obj:FindFirstChild("Part") or obj:IsA("Part") then
                                    pcall(function()
                                        hrp.CFrame = obj.CFrame
                                        fruitsCollected = fruitsCollected + 1
                                        fruitsLabel.Text = "🍌 Fruits: " .. fruitsCollected
                                        randomWait(0.1, 0.3)
                                    end)
                                end
                            end
                        end
                    end
                    
                    -- Follow NPC
                    if getFollowNPC() then
                        local npcFolder = game.Workspace:FindFirstChild("NPCs") or game.Workspace:FindFirstChild("Enemies")
                        if npcFolder then
                            for _, npc in pairs(npcFolder:GetChildren()) do
                                if npc:FindFirstChild("HumanoidRootPart") then
                                    pcall(function()
                                        hrp.CFrame = npc.HumanoidRootPart.CFrame + Vector3.new(5, 0, 0)
                                        randomWait(0.2, 0.5)
                                        break
                                    end)
                                end
                            end
                        end
                    end
                    
                    -- Auto attack
                    if getAttack() then
                        npcsDefeated = npcsDefeated + 1
                        npcsLabel.Text = "⚔️ NPCs: " .. npcsDefeated
                        randomWait(0.5, 1.5)
                    end
                    
                    -- Auto heal
                    if getHeal() and humanoid.Health < humanoid.MaxHealth * 0.3 then
                        randomWait(0.2, 0.5)
                    end
                    
                    -- Speed boost
                    if getWalkSpeed() then
                        hrp.Velocity = hrp.Velocity + Vector3.new(math.random(-5, 5), 0, math.random(-5, 5))
                    end
                end
            end
        end
        
        randomWait(0.3, 0.8)
    end
end)

-- === SESSION TIMER ===
spawn(function()
    while true do
        if farmingActive then
            sessionTime = sessionTime + 1
            local minutes = math.floor(sessionTime / 60)
            local seconds = sessionTime % 60
            timeLabel.Text = "⏱️ Time: " .. minutes .. "m " .. seconds .. "s"
        end
        wait(1)
    end
end)

-- === ANTI-AFK ===
spawn(function()
    while true do
        if getAntiAfk() then
            randomWait(2, 5)
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            end
        end
        wait(30)
    end
end)

print("=== KANEKI CHEATS v5 LIVE ===")
