-- PUT THIS SCRIPT IN: ServerScriptService
-- Name it: CombatSystem

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")

local GameConfig = require(ReplicatedStorage:WaitForChild("GameConfig"))

local remotes = ReplicatedStorage:WaitForChild("Remotes")

local AttackRemote = Instance.new("RemoteEvent")
AttackRemote.Name = "AttackBoss"
AttackRemote.Parent = remotes

local BossUpdate = Instance.new("RemoteEvent")
BossUpdate.Name = "BossUpdate"
BossUpdate.Parent = remotes

-- Simple boss spawning (you can improve later)
local currentBoss = nil
local currentBossData = nil

local function spawnBoss(stage)
	local config = GameConfig.Bosses[stage]
	if not config then return end

	if currentBoss then
		currentBoss:Destroy()
	end

	local boss = Instance.new("Model")
	boss.Name = config.Name

	local part = Instance.new("Part")
	part.Name = "HumanoidRootPart"
	part.Size = Vector3.new(6, 8, 4)
	part.Position = Vector3.new(0, 5, 40)
	part.Anchored = true
	part.BrickColor = BrickColor.new("Really red")
	part.Parent = boss

	local humanoid = Instance.new("Humanoid")
	humanoid.MaxHealth = config.Health
	humanoid.Health = config.Health
	humanoid.Parent = boss

	local billboard = Instance.new("BillboardGui")
	billboard.Size = UDim2.new(0, 200, 0, 50)
	billboard.StudsOffset = Vector3.new(0, 5, 0)
	billboard.AlwaysOnTop = true
	billboard.Parent = part

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = config.Name .. " | HP: " .. config.Health
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextScaled = true
	label.Parent = billboard

	boss.Parent = workspace
	currentBoss = boss
	currentBossData = {
		Config = config,
		Stage = stage,
		Label = label,
		Humanoid = humanoid
	}

	BossUpdate:FireAllClients(config.Name, humanoid.Health, humanoid.MaxHealth)
end

-- Click to attack
AttackRemote.OnServerEvent:Connect(function(player)
	if not currentBoss or not currentBossData then return end

	local stats = player:FindFirstChild("leaderstats")
	if not stats then return end

	local damage = math.max(1, math.floor(stats.Strength.Value / 10))
	currentBossData.Humanoid.Health = math.max(0, currentBossData.Humanoid.Health - damage)

	currentBossData.Label.Text = currentBossData.Config.Name .. " | HP: " .. math.floor(currentBossData.Humanoid.Health)

	BossUpdate:FireAllClients(currentBossData.Config.Name, currentBossData.Humanoid.Health, currentBossData.Humanoid.MaxHealth)

	if currentBossData.Humanoid.Health <= 0 then
		-- Reward
		stats.Strength.Value += currentBossData.Config.StrengthReward
		stats.Wins.Value += currentBossData.Config.WinsReward

		local nextStage = currentBossData.Stage + 1
		currentBoss:Destroy()
		currentBoss = nil
		currentBossData = nil

		if GameConfig.Bosses[nextStage] then
			task.wait(2)
			spawnBoss(nextStage)
		else
			print("All bosses defeated!")
		end
	end
end

-- Boss damages player (except stage 1)
task.spawn(function()
	while true do
		task.wait(2)
		if currentBossData and currentBossData.Config.Damage > 0 then
			for _, player in ipairs(Players:GetPlayers()) do
				local char = player.Character
				if char and char:FindFirstChild("Humanoid") then
					char.Humanoid:TakeDamage(currentBossData.Config.Damage)
				end
			end
		end
	end
end

-- Start with first boss
task.wait(3)
spawnBoss(1)

print("[+1 Strength Escape] CombatSystem loaded")
