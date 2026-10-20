-- PUT THIS AS A LocalScript INSIDE THE SAME ScreenGui AS THE LEVEL BAR
-- Name it: ShopAndNotify
-- (Inside StarterGui > MainUI)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local remotes = ReplicatedStorage:WaitForChild("Remotes")
local BuyMultiplier = remotes:WaitForChild("BuyMultiplier")
local TrainError = remotes:WaitForChild("TrainError")

local screenGui = script.Parent

-- ===== NOTIFICATION SYSTEM =====
local function notify(text, color)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0.35, 0, 0.07, 0)
	frame.Position = UDim2.new(0.325, 0, -0.1, 0)
	frame.BackgroundColor3 = color or Color3.fromRGB(40, 40, 40)
	frame.BorderSizePixel = 0
	frame.Parent = screenGui

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = frame

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -20, 1, 0)
	label.Position = UDim2.new(0, 10, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextScaled = true
	label.Font = Enum.Font.GothamBold
	label.Parent = frame

	-- Slide in
	TweenService:Create(frame, TweenInfo.new(0.4), {Position = UDim2.new(0.325, 0, 0.05, 0)}):Play()

	task.delay(3, function()
		local tween = TweenService:Create(frame, TweenInfo.new(0.4), {Position = UDim2.new(0.325, 0, -0.15, 0)})
		tween:Play()
		tween.Completed:Wait()
		frame:Destroy()
	end)
end

TrainError.OnClientEvent:Connect(function(msg)
	notify(msg, Color3.fromRGB(180, 40, 40))
end

-- ===== SHOP GUI =====
local shopButton = Instance.new("TextButton")
shopButton.Name = "ShopButton"
shopButton.Size = UDim2.new(0.12, 0, 0.06, 0)
shopButton.Position = UDim2.new(0.02, 0, 0.85, 0)
shopButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
shopButton.Text = "SHOP"
shopButton.TextColor3 = Color3.new(1, 1, 1)
shopButton.TextScaled = true
shopButton.Font = Enum.Font.GothamBold
shopButton.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = shopButton

local shopFrame = Instance.new("Frame")
shopFrame.Name = "ShopFrame"
shopFrame.Size = UDim2.new(0.4, 0, 0.5, 0)
shopFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
shopFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
shopFrame.Visible = false
shopFrame.Parent = screenGui

local shopCorner = Instance.new("UICorner")
shopCorner.CornerRadius = UDim.new(0, 12)
shopCorner.Parent = shopFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.15, 0)
title.BackgroundTransparency = 1
title.Text = "MULTIPLIER SHOP"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = shopFrame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0.1, 0, 0.12, 0)
closeBtn.Position = UDim2.new(0.88, 0, 0.02, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.TextScaled = true
closeBtn.Parent = shopFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
	shopFrame.Visible = false
end)

shopButton.MouseButton1Click:Connect(function()
	shopFrame.Visible = not shopFrame.Visible
end

-- Shop items
local items = {
	{Name = "2x Multiplier", Cost = 5, Index = 1},
	{Name = "5x Multiplier", Cost = 20, Index = 2},
	{Name = "10x Multiplier", Cost = 50, Index = 3},
}

for i, item in ipairs(items) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0.8, 0, 0.15, 0)
	btn.Position = UDim2.new(0.1, 0, 0.2 + (i * 0.18), 0)
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
	btn.Text = item.Name .. "  -  " .. item.Cost .. " Wins"
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.TextScaled = true
	btn.Font = Enum.Font.Gotham
	btn.Parent = shopFrame

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 8)
	btnCorner.Parent = btn

	btn.MouseButton1Click:Connect(function()
		BuyMultiplier:FireServer(item.Index)
		notify("Bought " .. item.Name .. "!", Color3.fromRGB(40, 160, 80))
	end)
end

print("[Client] Shop + Notifications ready")
