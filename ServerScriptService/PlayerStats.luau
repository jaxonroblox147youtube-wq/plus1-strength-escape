-- [[ +1 Strength Escape - Player Stats System ]]
-- Put this Script in ServerScriptService

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

	print("[Stats] Setup complete for " .. player.Name)
end

-- Existing players
for _, player in ipairs(Players:GetPlayers()) do
	setupPlayer(player)
end

-- New players
Players.PlayerAdded:Connect(setupPlayer)

print("[+1 Strength Escape] Player Stats System loaded!")
