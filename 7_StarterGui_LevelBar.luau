-- PUT THIS AS A LocalScript INSIDE A ScreenGui IN: StarterGui
-- Create a ScreenGui named "MainUI" then put this LocalScript inside it named "LevelBar"

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local screenGui = script.Parent

local frame = Instance.new("Frame")
frame.Name = "LevelBarFrame"
frame.Size = UDim2.new(0.4, 0, 0.04, 0)
frame.Position = UDim2.new(0.3, 0, 0.92, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local bar = Instance.new("Frame")
bar.Name = "Fill"
bar.Size = UDim2.new(0, 0, 1, 0)
bar.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
bar.BorderSizePixel = 0
bar.Parent = frame

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, 0, 1, 0)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.new(1, 1, 1)
label.TextScaled = true
label.Font = Enum.Font.GothamBold
label.Parent = frame

local function update()
	local stats = player:FindFirstChild("leaderstats")
	if not stats then return end

	local xp = stats.XP.Value
	local level = stats.Level.Value
	local needed = 100

	bar.Size = UDim2.new(math.clamp(xp / needed, 0, 1), 0, 1, 0)
	label.Text = "Level " .. level .. "  |  XP " .. xp .. "/" .. needed
end

player.CharacterAdded:Connect(function()
	task.wait(1)
	update()
end)

task.spawn(function()
	while true do
		update()
		task.wait(0.5)
	end
end)
