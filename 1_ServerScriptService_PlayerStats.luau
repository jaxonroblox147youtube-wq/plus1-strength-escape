-- PUT THIS SCRIPT IN: ServerScriptService
-- Name it: PlayerStats

local Players = game:GetService("Players")

local function setupPlayer(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local Strength = Instance.new("IntValue")
	Strength.Name = "Strength"
	Strength.Value = 0
	Strength.Parent = leaderstats

	local Rebirths = Instance.new("IntValue")
	Rebirths.Name = "Rebirths"
	Rebirths.Value = 0
	Rebirths.Parent = leaderstats

	local Wins = Instance.new("IntValue")
	Wins.Name = "Wins"
	Wins.Value = 0
	Wins.Parent = leaderstats

	local Multiplier = Instance.new("NumberValue")
	Multiplier.Name = "Multiplier"
	Multiplier.Value = 1
	Multiplier.Parent = leaderstats

	local Level = Instance.new("IntValue")
	Level.Name = "Level"
	Level.Value = 1
	Level.Parent = leaderstats

	local XP = Instance.new("IntValue")
	XP.Name = "XP"
	XP.Value = 0
	XP.Parent = leaderstats

	-- Extra values that don't show on leaderboard
	local data = Instance.new("Folder")
	data.Name = "Data"
	data.Parent = player

	local Training = Instance.new("BoolValue")
	Training.Name = "IsTraining"
	Training.Value = false
	Training.Parent = data

	print("[Stats] Setup complete for " .. player.Name)
end

for _, player in ipairs(Players:GetPlayers()) do
	setupPlayer(player)
end

Players.PlayerAdded:Connect(setupPlayer)

print("[+1 Strength Escape] PlayerStats loaded")
