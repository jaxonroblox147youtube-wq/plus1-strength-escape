-- PUT THIS SCRIPT IN: ServerScriptService
-- Name it: TrainingSystem

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameConfig = require(ReplicatedStorage:WaitForChild("GameConfig"))

local remotes = ReplicatedStorage:FindFirstChild("Remotes")
if not remotes then
	remotes = Instance.new("Folder")
	remotes.Name = "Remotes"
	remotes.Parent = ReplicatedStorage
end

local TrainError = remotes:FindFirstChild("TrainError") or Instance.new("RemoteEvent")
TrainError.Name = "TrainError"
TrainError.Parent = remotes

local function startTraining(player, bar)
	local stats = player:FindFirstChild("leaderstats")
	local data = player:FindFirstChild("Data")
	if not stats or not data then return end

	local config = GameConfig.PullUpBars[bar.Name]
	if not config then return end

	if stats.Rebirths.Value < config.RequiredRebirths then
		TrainError:FireClient(player, "Need " .. config.RequiredRebirths .. " Rebirths for this bar!")
		return
	end

	if data.IsTraining.Value then return end
	data.IsTraining.Value = true

	task.spawn(function()
		while data.IsTraining.Value and player.Parent do
			local multi = (stats.Multiplier.Value or 1) * (config.Multiplier or 1)
			stats.Strength.Value += math.floor(GameConfig.BaseStrengthPerTick * multi)
			stats.XP.Value += 1
			if stats.XP.Value >= (GameConfig.XPPerLevel or 100) then
				stats.XP.Value = 0
				stats.Level.Value += 1
			end
			task.wait(GameConfig.TrainInterval or 0.35)
		end
	end)
end

local function stopTraining(player)
	local data = player:FindFirstChild("Data")
	if data then data.IsTraining.Value = false end
end

local function attachPrompt(bar, config)
	local prompt = bar:FindFirstChildOfClass("ProximityPrompt")
	if not prompt then
		prompt = Instance.new("ProximityPrompt")
		prompt.Parent = bar
	end
	prompt.ActionText = "Train"
	prompt.ObjectText = (config.DisplayName or bar.Name) .. " (" .. config.RequiredRebirths .. "+ Rebirths)"
	prompt.HoldDuration = 0.25
	prompt.MaxActivationDistance = 12
	prompt.RequiresLineOfSight = false

	prompt.Triggered:Connect(function(player)
		startTraining(player, bar)
	end)
end

local function setupBars()
	for barName, config in pairs(GameConfig.PullUpBars) do
		local bar = workspace:FindFirstChild(barName, true)
		if bar then
			attachPrompt(bar, config)
		end
	end
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		local humanoid = char:WaitForChild("Humanoid")
		humanoid.StateChanged:Connect(function(_, newState)
			if newState == Enum.HumanoidStateType.Jumping then
				stopTraining(player)
			end
		end)
	end)
	if player.Character then
		local humanoid = player.Character:FindFirstChild("Humanoid")
		if humanoid then
			humanoid.StateChanged:Connect(function(_, newState)
				if newState == Enum.HumanoidStateType.Jumping then
					stopTraining(player)
				end
			end)
		end
	end
end

for _, p in ipairs(Players:GetPlayers()) do
	if p.Character then
		local humanoid = p.Character:FindFirstChild("Humanoid")
		if humanoid then
			humanoid.StateChanged:Connect(function(_, newState)
				if newState == Enum.HumanoidStateType.Jumping then
					stopTraining(p)
				end
			end)
		end
	end
end

task.wait(1.5)
setupBars()

print("[+1 Strength Escape] TrainingSystem loaded")
