-- PUT THIS AS ModuleScript IN ReplicatedStorage
-- Name: GameConfig

local GameConfig = {}

GameConfig.BaseStrengthPerTick = 1
GameConfig.TrainInterval = 0.35

-- Higher bars = more strength. Locked by rebirth count.
GameConfig.PullUpBars = {
	["PullUpBar_1"] = { RequiredRebirths = 0, Multiplier = 1, DisplayName = "Wood Bar" },
	["PullUpBar_2"] = { RequiredRebirths = 1, Multiplier = 3, DisplayName = "Iron Bar" },
	["PullUpBar_3"] = { RequiredRebirths = 3, Multiplier = 8, DisplayName = "Steel Bar" },
	["PullUpBar_4"] = { RequiredRebirths = 6, Multiplier = 20, DisplayName = "Gold Bar" },
	["PullUpBar_5"] = { RequiredRebirths = 12, Multiplier = 50, DisplayName = "Diamond Bar" },
}

GameConfig.XPPerLevel = 100

-- Stage 1 boss does NO damage. Later bosses do.
GameConfig.Bosses = {
	[1] = { Name = "Training Dummy", Health = 40, Damage = 0, StrengthReward = 30, WinsReward = 1, Color = Color3.fromRGB(100, 200, 100) },
	[2] = { Name = "Stone Golem", Health = 180, Damage = 8, StrengthReward = 120, WinsReward = 3, Color = Color3.fromRGB(120, 120, 120) },
	[3] = { Name = "Flame Knight", Health = 450, Damage = 18, StrengthReward = 350, WinsReward = 8, Color = Color3.fromRGB(255, 100, 40) },
	[4] = { Name = "Void Titan", Health = 1200, Damage = 35, StrengthReward = 900, WinsReward = 20, Color = Color3.fromRGB(80, 20, 120) },
	[5] = { Name = "God of Strength", Health = 3000, Damage = 55, StrengthReward = 2500, WinsReward = 50, Color = Color3.fromRGB(255, 215, 0) },
}

GameConfig.ShopMultipliers = {
	{ Name = "2x Multiplier", Cost = 5, Multi = 2 },
	{ Name = "5x Multiplier", Cost = 20, Multi = 5 },
	{ Name = "10x Multiplier", Cost = 50, Multi = 10 },
	{ Name = "25x Multiplier", Cost = 150, Multi = 25 },
}

GameConfig.XPPerLevel = 100
GameConfig.BaseStrengthPerTick = 1
GameConfig.TrainInterval = 0.35
GameConfig.RebirthStrengthCost = 500

return GameConfig
