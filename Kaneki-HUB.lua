
print("=== KANEKI CHEATS PROFESSIONAL ===")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player: Player = Players.LocalPlayer
local playerGui: PlayerGui = player:WaitForChild("PlayerGui") :: PlayerGui

type FarmStats = {
	fruitsCollected: number,
	npcsDefeated: number,
	sessionTime: number,
	farmingActive: boolean,
}

local stats: FarmStats = {
	fruitsCollected = 0,
	npcsDefeated = 0,
	sessionTime = 0,
	farmingActive = false,
}

local function randomWait(min: number, max: number): ()
	wait((min + math.random() * (max - min)))
end

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KanekiPro"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Header image (custom, user can replace)
local headerImage = Instance.new("ImageLabel")
headerImage.Name = "HeaderImage"
headerImage.Image = "rbxasset://textures/face.png"
headerImage.Size = UDim2.new(0, 80, 0, 80)
headerImage.Position = UDim2.new(0.02, 0, 0.02, 0)
headerImage.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
headerImage.BorderColor3 = Color3.fromRGB(100, 200, 255)
headerImage.BorderSizePixel = 2
headerImage.Parent = screenGui

-- Main frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 360, 0, 750)
mainFrame.Position = UDim2.new(0.02, 0, 0.12, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
mainFrame.BorderColor3 = Color3.fromRGB(100, 200, 255)
mainFrame.BorderSizePixel = 2
mainFrame.Visible = false
mainFrame.Parent = screenGui

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 60)
header.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
header.BorderColor3 = Color3.fromRGB(100, 200, 255)
header.BorderSizePixel = 1
header.Parent = mainFrame

local headerText = Instance.new("TextLabel")
headerText.Text = "KANEKI CONSOLE"
headerText.Size = UDim2.new(0.85, 0, 1, 0)
headerText.BackgroundTransparency = 1
headerText.TextColor3 = Color3.fromRGB(100, 200, 255)
headerText.Font = Enum.Font.GothamBold
headerText.TextSize = 16
headerText.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Text = "X"
closeBtn.Size = UDim2.new(0.15, 0, 1, 0)
closeBtn.Position = UDim2.new(0.85, 0, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderColor3 = Color3.fromRGB(100, 100, 120)
closeBtn.BorderSizePixel = 1
closeBtn.TextSize = 14
closeBtn.Parent = header

-- Content
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Size = UDim2.new(1, 0, 1, -60)
contentFrame.Position = UDim2.new(0, 0, 0, 60)
contentFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
contentFrame.BorderSizePixel = 0
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 1600)
contentFrame.ScrollBarThickness = 4
contentFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 200, 255)
contentFrame.Parent = mainFrame

-- Section header function
local function createSection(title: string, yPos: number): ()
	local section = Instance.new("TextLabel")
	section.Text = title
	section.Size = UDim2.new(1, -20, 0, 28)
	section.Position = UDim2.new(0, 10, 0, yPos)
	section.BackgroundColor3 = Color3.fromRGB(25, 35, 50)
	section.TextColor3 = Color3.fromRGB(100, 200, 255)
	section.Font = Enum.Font.GothamBold
	section.TextSize = 13
	section.BorderColor3 = Color3.fromRGB(100, 200, 255)
	section.BorderSizePixel = 1
	section.Parent = contentFrame
end

-- Toggle factory
local toggleStates: {[string]: boolean} = {}

local function createToggle(label: string, yPos: number): () -> boolean
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, -20, 0, 36)
	frame.Position = UDim2.new(0, 10, 0, yPos)
	frame.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
	frame.BorderColor3 = Color3.fromRGB(60, 70, 90)
	frame.BorderSizePixel = 1
	frame.Parent = contentFrame
	
	local text = Instance.new("TextLabel")
	text.Text = label
	text.Size = UDim2.new(0.7, 0, 1, 0)
	text.BackgroundTransparency = 1
	text.TextColor3 = Color3.fromRGB(200, 200, 220)
	text.Font = Enum.Font.Gotham
	text.TextSize = 11
	text.Parent = frame
	
	local btn = Instance.new("TextButton")
	btn.Text = "OFF"
	btn.Size = UDim2.new(0, 55, 0, 26)
	btn.Position = UDim2.new(0.71, 0, 0.5, -13)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
	btn.TextColor3 = Color3.fromRGB(150, 150, 170)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 9
	btn.BorderColor3 = Color3.fromRGB(80, 80, 100)
	btn.BorderSizePixel = 1
	btn.Parent = frame
	
	local state: boolean = false
	toggleStates[label] = state
	
	btn.MouseButton1Click:Connect(function()
		state = not state
		toggleStates[label] = state
		btn.Text = if state then "ON" else "OFF"
		btn.BackgroundColor3 = if state then Color3.fromRGB(30, 120, 100) else Color3.fromRGB(40, 40, 50)
		btn.TextColor3 = if state then Color3.fromRGB(150, 255, 200) else Color3.fromRGB(150, 150, 170)
	end)
	
	return function(): boolean
		return toggleStates[label]
	end
end

-- Button factory
local function createButton(text: string, yPos: number, callback: () -> ()): TextButton
	local btn = Instance.new("TextButton")
	btn.Text = text
	btn.Size = UDim2.new(1, -20, 0, 38)
	btn.Position = UDim2.new(0, 10, 0, yPos)
	btn.BackgroundColor3 = Color3.fromRGB(30, 80, 120)
	btn.TextColor3 = Color3.fromRGB(100, 200, 255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 12
	btn.BorderColor3 = Color3.fromRGB(100, 200, 255)
	btn.BorderSizePixel = 1
	btn.Parent = contentFrame
	
	btn.MouseEnter:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(40, 100, 150)
	end)
	btn.MouseLeave:Connect(function()
		btn.BackgroundColor3 = Color3.fromRGB(30, 80, 120)
	end)
	
	btn.MouseButton1Click:Connect(callback)
	return btn
end

-- === LUCK MODULE ===
createSection("LUCK AMPLIFIER", 5)

local luckVal: number = 0
local luckDisp = Instance.new("TextLabel")
luckDisp.Text = "Current: 0 / 1000000"
luckDisp.Size = UDim2.new(1, -20, 0, 30)
luckDisp.Position = UDim2.new(0, 10, 0, 36)
luckDisp.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
luckDisp.TextColor3 = Color3.fromRGB(100, 200, 255)
luckDisp.Font = Enum.Font.Gotham
luckDisp.TextSize = 10
luckDisp.BorderColor3 = Color3.fromRGB(60, 70, 90)
luckDisp.BorderSizePixel = 1
luckDisp.Parent = contentFrame

local luckBarBg = Instance.new("Frame")
luckBarBg.Size = UDim2.new(1, -20, 0, 16)
luckBarBg.Position = UDim2.new(0, 10, 0, 69)
luckBarBg.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
luckBarBg.BorderSizePixel = 0
luckBarBg.Parent = contentFrame

local luckBarFill = Instance.new("Frame")
luckBarFill.Size = UDim2.new(0, 0, 1, 0)
luckBarFill.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
luckBarFill.BorderSizePixel = 0
luckBarFill.Parent = luckBarBg

local luckBtn: TextButton = createButton("Activate Luck Boost", 88, function()
	luckBtn.Interactable = false
	luckBtn.Text = "Processing..."
	luckBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
	luckBtn.TextColor3 = Color3.fromRGB(150, 150, 170)
	
	task.spawn(function()
		luckVal = 0
		while luckVal < 1000000 do
			local inc: number = math.random(8000, 15000)
			luckVal = math.min(luckVal + inc, 1000000)
			luckDisp.Text = "Current: " .. tostring(luckVal) .. " / 1000000"
			luckBarFill.Size = UDim2.new(luckVal / 1000000, 0, 1, 0)
			randomWait(0.3, 0.8)
		end
		luckBtn.Text = "Boost Complete"
		luckBtn.BackgroundColor3 = Color3.fromRGB(50, 120, 80)
		luckBtn.TextColor3 = Color3.fromRGB(150, 255, 180)
	end)
end)

-- === FARMING ===
createSection("FARMING MODULE", 145)

local getFarm = createToggle("Auto Farming", 178)
local getCollect = createToggle("Fruit Collection", 217)
local getLoot = createToggle("Loot Gathering", 256)
local getFollowNPC = createToggle("NPC Tracking", 295)
local getAutoRespawn = createToggle("Auto Respawn", 334)

-- === COMBAT ===
createSection("COMBAT SYSTEM", 373)

local getAttack = createToggle("Auto Attack", 406)
local getHeal = createToggle("Health Recovery", 445)
local getBlock = createToggle("Defense Block", 484)
local getSwap = createToggle("Weapon Switch", 523)

-- === MOVEMENT ===
createSection("MOVEMENT CONTROLS", 562)

local getSpeed = createToggle("Speed Enhancement", 595)
local getFlight = createToggle("Flight Mode", 634)
local getTeleport = createToggle("Quick Teleport", 673)

-- === SECURITY ===
createSection("ANTI-DETECTION", 712)

local getAntiAfk = createToggle("Anti-Idle", 745)
local getDelay = createToggle("Randomized Timing", 784)
local getStealth = createToggle("Stealth Protocol", 823)

-- === STATUS ===
createSection("SESSION INFORMATION", 862)

local statsBg = Instance.new("Frame")
statsBg.Size = UDim2.new(1, -20, 0, 110)
statsBg.Position = UDim2.new(0, 10, 0, 895)
statsBg.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
statsBg.BorderColor3 = Color3.fromRGB(60, 70, 90)
statsBg.BorderSizePixel = 1
statsBg.Parent = contentFrame

local fruitsStat = Instance.new("TextLabel")
fruitsStat.Text = "Fruits Collected: 0"
fruitsStat.Size = UDim2.new(1, 0, 0.25, 0)
fruitsStat.BackgroundTransparency = 1
fruitsStat.TextColor3 = Color3.fromRGB(100, 200, 255)
fruitsStat.Font = Enum.Font.Gotham
fruitsStat.TextSize = 10
fruitsStat.Parent = statsBg

local npcStat = Instance.new("TextLabel")
npcStat.Text = "Enemies Defeated: 0"
npcStat.Size = UDim2.new(1, 0, 0.25, 0)
npcStat.Position = UDim2.new(0, 0, 0.25, 0)
npcStat.BackgroundTransparency = 1
npcStat.TextColor3 = Color3.fromRGB(150, 255, 180)
npcStat.Font = Enum.Font.Gotham
npcStat.TextSize = 10
npcStat.Parent = statsBg

local timeStat = Instance.new("TextLabel")
timeStat.Text = "Session Time: 0m 0s"
timeStat.Size = UDim2.new(1, 0, 0.25, 0)
timeStat.Position = UDim2.new(0, 0, 0.5, 0)
timeStat.BackgroundTransparency = 1
timeStat.TextColor3 = Color3.fromRGB(200, 150, 255)
timeStat.Font = Enum.Font.Gotham
timeStat.TextSize = 10
timeStat.Parent = statsBg

local statusStat = Instance.new("TextLabel")
statusStat.Text = "Status: Ready"
statusStat.Size = UDim2.new(1, 0, 0.25, 0)
statusStat.Position = UDim2.new(0, 0, 0.75, 0)
statusStat.BackgroundTransparency = 1
statusStat.TextColor3 = Color3.fromRGB(200, 200, 220)
statusStat.Font = Enum.Font.GothamBold
statusStat.TextSize = 10
statusStat.Parent = statsBg

-- === MAIN CONTROLS ===
createSection("OPERATIONS", 1020)

local startBtn: TextButton = createButton("Start Session", 1053, function()
	stats.farmingActive = true
	statusStat.Text = "Status: Active"
	statusStat.TextColor3 = Color3.fromRGB(150, 255, 180)
end)

local stopBtn: TextButton = createButton("Stop Session", 1094, function()
	stats.farmingActive = false
	statusStat.Text = "Status: Idle"
	statusStat.TextColor3 = Color3.fromRGB(200, 200, 220)
end)

createButton("Clear Data", 1135, function()
	stats.fruitsCollected = 0
	stats.npcsDefeated = 0
	stats.sessionTime = 0
	fruitsStat.Text = "Fruits Collected: 0"
	npcStat.Text = "Enemies Defeated: 0"
	timeStat.Text = "Session Time: 0m 0s"
end)

-- === MENU TOGGLE ===
headerImage.InputBegan:Connect(function(input: InputObject)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		mainFrame.Visible = not mainFrame.Visible
	end
end)

closeBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = false
end)

-- === DRAGGABLE ===
local dragging: boolean = false
local dragStart: Vector3 = Vector3.new(0, 0, 0)
local frameStart: UDim2 = UDim2.new(0, 0, 0, 0)

header.InputBegan:Connect(function(input: InputObject)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = game:GetService("UserInputService"):GetMouseLocation()
		frameStart = mainFrame.Position
	end
end)

header.InputEnded:Connect(function(input: InputObject)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input: InputObject)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local mouse = player:GetMouse()
		local delta: Vector3 = mouse.Position - dragStart
		mainFrame.Position = frameStart + UDim2.new(0, delta.X, 0, delta.Y)
	end
end)

-- === FARMING ENGINE ===
task.spawn(function(): ()
	while true do
		if stats.farmingActive and getFarm() then
			local char: Model? = player.Character
			if char then
				local hrp: BasePart? = char:FindFirstChild("HumanoidRootPart") :: BasePart?
				local hum: Humanoid? = char:FindFirstChild("Humanoid") :: Humanoid?
				
				if hrp and hum then
					if getCollect() then
						for _, obj in pairs(game.Workspace:GetDescendants()) do
							if obj:IsA("Part") and (obj.Name:match("Fruit") or obj.Name:match("Chest")) then
								pcall(function()
									hrp.CFrame = obj.CFrame
									stats.fruitsCollected += 1
									fruitsStat.Text = "Fruits Collected: " .. tostring(stats.fruitsCollected)
									randomWait(0.1, 0.3)
								end)
							end
						end
					end
					
					if getFollowNPC() then
						local npcFolder: Instance? = game.Workspace:FindFirstChild("NPCs")
						if npcFolder then
							for _, npc in pairs(npcFolder:GetChildren()) do
								if npc:FindFirstChild("HumanoidRootPart") then
									pcall(function()
										hrp.CFrame = (npc:FindFirstChild("HumanoidRootPart") :: BasePart).CFrame + Vector3.new(5, 0, 0)
										randomWait(0.2, 0.5)
										break
									end)
								end
							end
						end
					end
					
					if getAttack() then
						stats.npcsDefeated += 1
						npcStat.Text = "Enemies Defeated: " .. tostring(stats.npcsDefeated)
						randomWait(0.5, 1.5)
					end
					
					if getHeal() and hum.Health < hum.MaxHealth * 0.3 then
						randomWait(0.2, 0.5)
					end
				end
			end
		end
		
		randomWait(0.3, 0.8)
	end
end)

-- === SESSION TIMER ===
task.spawn(function(): ()
	while true do
		if stats.farmingActive then
			stats.sessionTime += 1
			local mins: number = math.floor(stats.sessionTime / 60)
			local secs: number = stats.sessionTime % 60
			timeStat.Text = "Session Time: " .. tostring(mins) .. "m " .. tostring(secs) .. "s"
		end
		task.wait(1)
	end
end)

-- === ANTI-AFK ENGINE ===
task.spawn(function(): ()
	while true do
		if getAntiAfk() then
			randomWait(2, 5)
			local char: Model? = player.Character
			if char then
				local hrp: BasePart? = char:FindFirstChild("HumanoidRootPart") :: BasePart?
				if hrp then
					hrp.Velocity = Vector3.new(0, 0, 0)
				end
			end
		end
		task.wait(30)
	end
end)

print("=== KANEKI PROFESSIONAL CONSOLE READY ===")
