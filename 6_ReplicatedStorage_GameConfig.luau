-- PUT THIS AS A ModuleScript IN: ReplicatedStorage
-- Name it: GameConfig

local GameConfig = {}

-- How much strength you gain per pull-up tick
GameConfig.BaseStrengthPerTick = 1

-- How often strength is given while training (seconds)
GameConfig.TrainInterval = 0.5

-- Pull-up bars and the rebirth required to use them
-- Create parts in Workspace named exactly like the keys below
GameConfig.PullUpBars = {
	["PullUpBar_1"] = { RequiredRebirths = 0, Multiplier = 1 },
	["PullUpBar_2"] = { RequiredRebirths = 1, Multiplier = 2 },
	["PullUpBar_3"] = { RequiredRebirths = 3, Multiplier = 4 },
	["PullUpBar_4"] = { RequiredRebirths = 5, Multiplier = 8 },
	["PullUpBar_5"] = { RequiredRebirths = 10, Multiplier = 15 },
}

-- XP needed for each level
GameConfig.XPPerLevel = 100

-- Boss settings
GameConfig.Bosses = {
	[1] = { Name = "Weak Boss", Health = 50, Damage = 0, StrengthReward = 25, WinsReward = 1 },
	[2] = { Name = "Strong Boss", Health = 200, Damage = 5, StrengthReward = 100, WinsReward = 3 },
	[3] = { Name = "Elite Boss", Health = 500, Damage = 15, StrengthReward = 300, WinsReward = 8 },
	[4] = { Name = "Final Boss", Health = 1500, Damage = 30, StrengthReward = 1000, WinsReward = 20 },
}

-- Shop multipliers (cost in Wins)
GameConfig.ShopMultipliers = {
	{ Name = "2x Multiplier", Cost = 5, Multi = 2 },
	{ Name = "5x Multiplier", Cost = 20, Multi = 5 },
	{ Name = "10x Multiplier", Cost = 50, Multi = 10 },
}

return GameConfig
