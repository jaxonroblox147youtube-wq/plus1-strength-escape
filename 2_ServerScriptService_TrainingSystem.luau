-- PUT THIS SCRIPT IN: ServerScriptService
-- Name it: TrainingSystem

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ProximityPromptService = game:GetService("ProximityPromptService")

local GameConfig = require(ReplicatedStorage:WaitForChild("GameConfig"))

-- Create a simple RemoteEvent for feedback
local remotes = Instance.new("Folder")
remotes.Name = "Remotes"
remotes.Parent = ReplicatedStorage

local TrainError = Instance.new("RemoteEvent")
TrainError.Name = "TrainError"
TrainError.Parent = remotes

local function getBarConfig(barName)
	return GameConfig.PullUpBars[barName]
end

local function startTraining(player, bar)
	local stats = player:FindFirstChild("leaderstats")
	local data = player:FindFirstChild("Data")
	if not stats or not data then return end

	local rebirths = stats.Rebirths.Value
	local config = getBarConfig(bar.Name)

	if not config then return end

	if rebirths < config.RequiredRebirths then
		TrainError:FireClient(player, "You need " .. config.RequiredRebirths .. " Rebirths to use this bar!")
		return
	end

	if data.IsTraining.Value then return end
	data.IsTraining.Value = true

	-- Training loop
	task.spawn(function()
		while data.IsTraining.Value and player.Parent do
			local multi = stats.Multiplier.Value * config.Multiplier
			stats.Strength.Value += math.floor(GameConfig.BaseStrengthPerTick * multi)
			stats.XP.Value += 1

			-- Simple level up
			if stats.XP.Value >= GameConfig.XPPerLevel then
				stats.XP.Value = 0
				stats.Level.Value += 1
			end

			task.wait(GameConfig.TrainInterval)
		end
	end)
end

local function stopTraining(player)
	local data = player:FindFirstChild("Data")
	if data then
		data.IsTraining.Value = false
	end
end

-- Setup ProximityPrompts on all pull-up bars
local function setupBars()
	for barName, config in pairs(GameConfig.PullUpBars) do
		local bar = workspace:FindFirstChild(barName, true)
		if bar and bar:IsA("BasePart") then
			local prompt = bar:FindFirstChildOfClass("ProximityPrompt")
			if not prompt then
				prompt = Instance.new("ProximityPrompt")
				prompt.ActionText = "Train (Hold E)"
				prompt.ObjectText = "Pull Up Bar (Req: " .. config.RequiredRebirths .. " Rebirths)"
				prompt.HoldDuration = 0.3
				prompt.MaxActivationDistance = 10
				prompt.Parent = bar
			end

			prompt.Triggered:Connect(function(player)
				startTraining(player, bar)
			end)
		end
	end
end

-- Jump to stop training
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		local humanoid = char:WaitForChild("Humanoid")
		humanoid.StateChanged:Connect(function(_, newState)
			if newState == Enum.HumanoidStateType.Jumping then
				stopTraining(player)
			end
		end)
	end)
end

-- Also stop when they die or leave
Players.PlayerRemoving:Connect(stopTraining)

task.wait(1)
setupBars()

print("[+1 Strength Escape] TrainingSystem loaded")
