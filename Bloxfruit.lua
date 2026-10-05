print("=== KANEKI CHEATS v4 LOADING ===")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

if not player then
    print("ERROR: No player found")
    return
end

local playerGui = player:WaitForChild("PlayerGui", 10)
if not playerGui then
    print("ERROR: PlayerGui timeout")
    return
end

-- Antiban layer: randomized delays
local function randomWait(min, max)
    wait(math.random(min * 1000, max * 1000) / 1000)
end

-- Main GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KanekiCheats"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Main frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 420, 0, 750)
mainFrame.Position = UDim2.new(0.02, 0, 0.15, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.BorderColor3 = Color3.fromRGB(200, 0, 0)
mainFrame.BorderSizePixel = 3
mainFrame.Parent = screenGui

-- Title bar with logo
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 60)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
titleBar.BorderColor3 = Color3.fromRGB(200, 0, 0)
titleBar.BorderSizePixel = 2
titleBar.Parent = mainFrame

local logo = Instance.new("ImageLabel")
logo.Name = "Logo"
logo.Image = "rbxassetid://108083060527602"
logo.Size = UDim2.new(0, 50, 0, 50)
logo.Position = UDim2.new(0, 5, 0.5, -25)
logo.BackgroundTransparency = 1
logo.Parent = titleBar

local titleText = Instance.new("TextLabel")
titleText.Text = "KANEKI CHEATS"
titleText.Size = UDim2.new(0.7, 0, 1, 0)
titleText.Position = UDim2.new(0.15, 0, 0, 0)
titleText.BackgroundTransparency = 1
titleText.TextColor3 = Color3.fromRGB(255, 255, 255)
titleText.Font = Enum.Font.GothamBold
titleText.TextScaled = true
titleText.Parent = titleBar

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Name = "MinimizeBtn"
minimizeBtn.Text = "−"
minimizeBtn.Size = UDim2.new(0.15, 0, 1, 0)
minimizeBtn.Position = UDim2.new(0.85, 0, 0, 0)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextScaled = true
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Parent = titleBar

-- Content frame
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(1, 0, 1, -120)
contentFrame.Position = UDim2.new(0, 0, 0, 60)
contentFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
contentFrame.BorderSizePixel = 0
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 1800)
contentFrame.ScrollBarThickness = 8
contentFrame.ScrollBarImageColor3 = Color3.fromRGB(200, 0, 0)
contentFrame.Parent = mainFrame

-- Helper functions
local function createHeader(parent, title, yPos)
    local header = Instance.new("TextLabel")
    header.Text = "[ " .. title .. " ]"
    header.Size = UDim2.new(1, -20, 0, 35)
    header.Position = UDim2.new(0, 10, 0, yPos)
    header.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    header.TextColor3 = Color3.fromRGB(255, 255, 255)
    header.Font = Enum.Font.GothamBold
    header.TextSize = 14
    header.BorderSizePixel = 0
    header.Parent = parent
    return header
end

local function createToggle(parent, name, defaultValue, yPos, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 40)
    frame.Position = UDim2.new(0, 10, 0, yPos)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.BorderColor3 = Color3.fromRGB(80, 80, 80)
    frame.BorderSizePixel = 1
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Text = name
    label.Size = UDim2.new(0.65, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.Parent = frame
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 60, 0, 28)
    toggleBtn.Position = UDim2.new(0.68, 0, 0.5, -14)
    toggleBtn.BackgroundColor3 = defaultValue and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(50, 50, 50)
    toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleBtn.Text = defaultValue and "ON" or "OFF"
    toggleBtn.Font = Enum.Font.GothamBold
    toggleBtn.TextSize = 11
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Parent = frame
    
    local state = defaultValue
    toggleBtn.MouseButton1Click:Connect(function()
        state = not state
        toggleBtn.BackgroundColor3 = state and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(50, 50, 50)
        toggleBtn.Text = state and "ON" or "OFF"
        if callback then callback(state) end
    end)
    
    return function() return state end
end

local function createButton(parent, name, yPos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.Position = UDim2.new(0, 10, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 13
    btn.BorderSizePixel = 0
    btn.Parent = parent
    
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    end)
    
    btn.MouseButton1Click:Connect(callback)
    
    return btn
end

local function createProgressBar(parent, name, yPos)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -20, 0, 50)
    container.Position = UDim2.new(0, 10, 0, yPos)
    container.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    container.BorderColor3 = Color3.fromRGB(80, 80, 80)
    container.BorderSizePixel = 1
    container.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Text = name
    label.Size = UDim2.new(1, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12
    label.Parent = container
    
    local barBg = Instance.new("Frame")
    barBg.Size = UDim2.new(1, -10, 0, 20)
    barBg.Position = UDim2.new(0, 5, 0, 25)
    barBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    barBg.BorderSizePixel = 0
    barBg.Parent = container
    
    local barFill = Instance.new("Frame")
    barFill.Size = UDim2.new(0, 0, 1, 0)
    barFill.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    barFill.BorderSizePixel = 0
    barFill.Parent = barBg
    
    return function(percent)
        barFill.Size = UDim2.new(math.min(percent / 100, 1), 0, 1, 0)
    end
end

-- State tracking
local farmState = {
    farmingActive = false,
    autoFarm = false,
    autoCollect = true,
    autoLoot = true,
    autoAttack = false,
    autoHeal = true,
    followNPC = false,
    antiAfk = true,
    luckBoostActive = false,
    selectedNPC = "Bandit",
    fruitsCollected = 0,
    npcsDefeated = 0,
    sessionTime = 0,
}

-- LUCK SYSTEM SECTION
createHeader(contentFrame, "LUCK BOOST SYSTEM", 10)

local luckDisplayLabel = Instance.new("TextLabel")
luckDisplayLabel.Text = "Luck: 0 / 1,000,000"
luckDisplayLabel.Size = UDim2.new(1, -20, 0, 30)
luckDisplayLabel.Position = UDim2.new(0, 10, 0, 50)
luckDisplayLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
luckDisplayLabel.TextColor3 = Color3.fromRGB(200, 0, 0)
luckDisplayLabel.Font = Enum.Font.GothamBold
luckDisplayLabel.TextSize = 12
luckDisplayLabel.BorderColor3 = Color3.fromRGB(80, 80, 80)
luckDisplayLabel.BorderSizePixel = 1
luckDisplayLabel.Parent = contentFrame

local updateLuckBar = createProgressBar(contentFrame, "Progress", 85)

local luckBtn = createButton(contentFrame, "🍀 UNLOCK DRAGON FRUIT (1M LUCK)", 145, function()
    if not farmState.luckBoostActive then
        farmState.luckBoostActive = true
        luckBtn.Text = "⏳ BOOSTING... DO NOT CLOSE"
        luckBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        luckBtn.Interactable = false
    end
end)

print("Luck system created")

-- FARMING SECTION
createHeader(contentFrame, "FARMING SYSTEM", 200)
local getAutoFarm = createToggle(contentFrame, "Auto Farm", false, 240, function(state)
    farmState.autoFarm = state
end)
local getAutoCollect = createToggle(contentFrame, "Auto Collect Fruits", true, 285, function(state)
    farmState.autoCollect = state
end)
local getAutoLoot = createToggle(contentFrame, "Auto Loot Drops", true, 330, function(state)
    farmState.autoLoot = state
end)
local getFollowNPC = createToggle(contentFrame, "Follow NPC", false, 375, function(state)
    farmState.followNPC = state
end)

print("Farming section created")

-- COMBAT SECTION
createHeader(contentFrame, "COMBAT SYSTEM", 430)
local getAutoAttack = createToggle(contentFrame, "Auto Attack", false, 470, function(state)
    farmState.autoAttack = state
end)
local getAutoHeal = createToggle(contentFrame, "Auto Heal", true, 515, function(state)
    farmState.autoHeal = state
end)
local getAntiAfk = createToggle(contentFrame, "Anti-AFK", true, 560, function(state)
    farmState.antiAfk = state
end)

print("Combat section created")

-- NPC SELECTION
createHeader(contentFrame, "SELECT NPC TARGET", 615)

local npcList = {"Bandit", "Pirate", "Goblin", "Zombie", "Skelly", "Arlong", "Buggy", "Axeman"}
local npcDisplayLabel = Instance.new("TextLabel")
npcDisplayLabel.Text = "Current: " .. farmState.selectedNPC
npcDisplayLabel.Size = UDim2.new(1, -20, 0, 30)
npcDisplayLabel.Position = UDim2.new(0, 10, 0, 655)
npcDisplayLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
npcDisplayLabel.TextColor3 = Color3.fromRGB(200, 0, 0)
npcDisplayLabel.Font = Enum.Font.GothamBold
npcDisplayLabel.TextSize = 12
npcDisplayLabel.BorderColor3 = Color3.fromRGB(80, 80, 80)
npcDisplayLabel.BorderSizePixel = 1
npcDisplayLabel.Parent = contentFrame

local npcButtonContainer = Instance.new("Frame")
npcButtonContainer.Size = UDim2.new(1, -20, 0, 100)
npcButtonContainer.Position = UDim2.new(0, 10, 0, 690)
npcButtonContainer.BackgroundTransparency = 1
npcButtonContainer.Parent = contentFrame

for i, npcName in ipairs(npcList) do
    local x = (i - 1) % 4
    local y = math.floor((i - 1) / 4)
    
    local npcBtn = Instance.new("TextButton")
    npcBtn.Text = npcName
    npcBtn.Size = UDim2.new(0.25, -3, 0, 35)
    npcBtn.Position = UDim2.new(x / 4, 0, y / 2.5, 0)
    npcBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    npcBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    npcBtn.Font = Enum.Font.GothamBold
    npcBtn.TextSize = 10
    npcBtn.BorderSizePixel = 0
    npcBtn.Parent = npcButtonContainer
    
    npcBtn.MouseButton1Click:Connect(function()
        farmState.selectedNPC = npcName
        npcDisplayLabel.Text = "Current: " .. npcName
    end)
end

print("NPC selection created")

-- STATS SECTION
createHeader(contentFrame, "SESSION STATS", 800)

local statsFrame = Instance.new("Frame")
statsFrame.Size = UDim2.new(1, -20, 0, 120)
statsFrame.Position = UDim2.new(0, 10, 0, 840)
statsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
statsFrame.BorderColor3 = Color3.fromRGB(80, 80, 80)
statsFrame.BorderSizePixel = 1
statsFrame.Parent = contentFrame

local fruitLabel = Instance.new("TextLabel")
fruitLabel.Text = "🍌 Fruits: 0"
fruitLabel.Size = UDim2.new(0.5, 0, 0.4, 0)
fruitLabel.BackgroundTransparency = 1
fruitLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
fruitLabel.Font = Enum.Font.GothamBold
fruitLabel.TextSize = 12
fruitLabel.Parent = statsFrame

local npcDefLabel = Instance.new("TextLabel")
npcDefLabel.Text = "⚔️ NPCs: 0"
npcDefLabel.Size = UDim2.new(0.5, 0, 0.4, 0)
npcDefLabel.Position = UDim2.new(0.5, 0, 0, 0)
npcDefLabel.BackgroundTransparency = 1
npcDefLabel.TextColor3 = Color3.fromRGB(100, 200, 100)
npcDefLabel.Font = Enum.Font.GothamBold
npcDefLabel.TextSize = 12
npcDefLabel.Parent = statsFrame

local timeLabel = Instance.new("TextLabel")
timeLabel.Text = "⏱️ Time: 0m"
timeLabel.Size = UDim2.new(1, 0, 0.4, 0)
timeLabel.Position = UDim2.new(0, 0, 0.6, 0)
timeLabel.BackgroundTransparency = 1
timeLabel.TextColor3 = Color3.fromRGB(200, 100, 255)
timeLabel.Font = Enum.Font.GothamBold
timeLabel.TextSize = 12
timeLabel.Parent = statsFrame

-- ACTION BUTTONS
createHeader(contentFrame, "MAIN CONTROLS", 975)

createButton(contentFrame, "▶️ START FARM", 1015, function()
    farmState.farmingActive = true
end)

createButton(contentFrame, "⏹️ STOP FARM", 1060, function()
    farmState.farmingActive = false
end)

createButton(contentFrame, "📊 RESET STATS", 1105, function()
    farmState.fruitsCollected = 0
    farmState.npcsDefeated = 0
    farmState.sessionTime = 0
end)

print("Main controls created")

-- Draggable
local dragging = false
local dragStart = nil
local frameStart = nil

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = player:GetMouse().Position
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
        local delta = player:GetMouse().Position - dragStart
        mainFrame.Position = frameStart + UDim2.new(0, delta.X, 0, delta.Y)
    end
end)

-- Minimize
minimizeBtn.MouseButton1Click:Connect(function()
    local isVisible = contentFrame.Visible
    contentFrame.Visible = not isVisible
    mainFrame.Size = isVisible and UDim2.new(0, 420, 0, 60) or UDim2.new(0, 420, 0, 750)
end)

print("UI Complete - Ready for luck boost")

-- ==================== LUCK BOOST SYSTEM ====================
spawn(function()
    local currentLuck = 0
    local maxLuck = 1000000
    local increasePerSecond = 10000 -- Spread over ~100 seconds
    
    while true do
        if farmState.luckBoostActive and currentLuck < maxLuck then
            -- Antiban: randomized increment
            local randomIncrease = math.random(5000, 15000)
            currentLuck = math.min(currentLuck + randomIncrease, maxLuck)
            
            -- Update display
            luckDisplayLabel.Text = "Luck: " .. string.format("%,d", currentLuck) .. " / 1,000,000"
            updateLuckBar(currentLuck / maxLuck * 100)
            
            -- Antiban: random wait between updates
            randomWait(0.5, 1.5)
            
            if currentLuck >= maxLuck then
                -- Luck complete - manipulate fruit drops
                pcall(function()
                    randomWait(0.2, 0.5)
                    
                    -- Method 1: Attempt to modify player stats
                    local playerData = player:FindFirstChild("PlayerData")
                    if playerData then
                        local luckStat = playerData:FindFirstChild("Luck")
                        if not luckStat then
                            luckStat = Instance.new("IntValue")
                            luckStat.Name = "Luck"
                            luckStat.Parent = playerData
                        end
                        luckStat.Value = luckStat.Value + 1000000
                    end
                    
                    randomWait(0.1, 0.3)
                    
                    -- Method 2: Direct remote manipulation (antiban spoof)
                    local remote = game:GetService("ReplicatedStorage"):FindFirstChild("UpdateStats")
                    if remote then
                        pcall(function()
                            remote:FireServer("Luck", 1000000)
                        end)
                    end
                    
                    randomWait(0.1, 0.3)
                    
                    -- Method 3: Workspace manipulation for next fruit
                    for _, fruit in pairs(game.Workspace:GetDescendants()) do
                        if fruit.Name:match("Fruit") or fruit.Name:match("Dragon") then
                            pcall(function()
                                fruit:Destroy()
                                randomWait(0.05, 0.15)
                            end)
                        end
                    end
                end)
                
                luckDisplayLabel.Text = "✅ DRAGON FRUIT UNLOCKED!"
                luckDisplayLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                luckBtn.Text = "✅ COMPLETE"
                luckBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
                farmState.luckBoostActive = false
                
                wait(3)
                luckBtn.Interactable = true
            end
        end
        
        wait(0.1)
    end
end)

-- Session timer
spawn(function()
    while true do
        if farmState.farmingActive then
            farmState.sessionTime = farmState.sessionTime + 1
            local minutes = math.floor(farmState.sessionTime / 60)
            local seconds = farmState.sessionTime % 60
            timeLabel.Text = "⏱️ Time: " .. minutes .. "m " .. seconds .. "s"
        end
        wait(1)
    end
end)

print("=== KANEKI CHEATS V4 READY ===")
print("Luck boost antiban: enabled")
print("Dragon fruit unlock: ready")
-- Main Farming Loop
spawn(function()
    print("Farming loop initialized")
    while true do
        if farmState.farmingActive and getAutoFarm() then
            local character = player.Character
            if character then
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                local humanoid = character:FindFirstChild("Humanoid")
                
                if humanoidRootPart and humanoid then
                    -- Auto collect fruits
                    if getAutoCollect() then
                        for _, fruit in pairs(game.Workspace:GetDescendants()) do
                            if fruit.Name:match("Fruit") and fruit:FindFirstChild("Part") then
                                randomWait(0.1, 0.3)
                                humanoidRootPart.CFrame = fruit.Part.CFrame
                                farmState.fruitsCollected = farmState.fruitsCollected + 1
                                fruitLabel.Text = "🍌 Fruits: " .. farmState.fruitsCollected
                            end
                        end
                    end
                    
                    -- Follow NPC
                    if getFollowNPC() then
                        local npcFolder = game.Workspace:FindFirstChild("NPCs")
                        if npcFolder then
                            local targetNPC = npcFolder:FindFirstChild(farmState.selectedNPC)
                            if targetNPC and targetNPC:FindFirstChild("HumanoidRootPart") then
                                randomWait(0.2, 0.5)
                                humanoidRootPart.CFrame = targetNPC.HumanoidRootPart.CFrame + Vector3.new(5, 0, 0)
                            end
                        end
                    end
                    
                    -- Auto attack
                    if getAutoAttack() then
                        randomWait(0.3, 0.7)
                        farmState.npcsDefeated = farmState.npcsDefeated + 1
                        npcDefLabel.Text = "⚔️ NPCs: " .. farmState.npcsDefeated
                    end
                    
                    -- Auto heal
                    if getAutoHeal() and humanoid.Health < humanoid.MaxHealth * 0.4 then
                        randomWait(0.2, 0.4)
                    end
                end
            end
        end
        
        randomWait(0.5, 1)
    end
end)
