-- PUT THIS SCRIPT IN: ServerScriptService
-- Name it: CombatSystem

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameConfig = require(ReplicatedStorage:WaitForChild("GameConfig"))
local remotes = ReplicatedStorage:FindFirstChild("Remotes") or Instance.new("Folder")
remotes.Name = "Remotes"
remotes.Parent = ReplicatedStorage

local AttackRemote = remotes:FindFirstChild("AttackBoss") or Instance.new("RemoteEvent")
AttackRemote.Name = "AttackBoss"
AttackRemote.Parent = remotes

local BossUpdate = remotes:FindFirstChild("BossUpdate") or Instance.new("RemoteEvent")
BossUpdate.Name = "BossUpdate"
BossUpdate.Parent = remotes

local currentBoss = nil
local currentBossData = nil

local function spawnBoss(stage)
	local config = GameConfig.Bosses[stage]
	if not config then return end

	if currentBoss then currentBoss:Destroy() end

	local boss = Instance.new("Model")
	boss.Name = config.Name

	-- Body
	local torso = Instance.new("Part")
	torso.Name = "Torso"
	torso.Size = Vector3.new(8, 10, 5)
	torso.Position = Vector3.new(0, 8, 55)
	torso.Anchored = true
	torso.Material = Enum.Material.Neon
	torso.Color = config.Color or Color3.fromRGB(255, 80, 80)
	torso.Parent = boss

	local head = Instance.new("Part")
	head.Name = "Head"
	head.Shape = Enum.PartType.Ball
	head.Size = Vector3.new(5, 5, 5)
	head.Position = torso.Position + Vector3.new(0, 7.5, 0)
	head.Anchored = true
	head.Material = Enum.Material.SmoothPlastic
	head.Color = config.Color or Color3.fromRGB(255, 80, 80)
	head.Parent = boss

	local humanoid = Instance.new("Humanoid")
	humanoid.MaxHealth = config.Health
	humanoid.Health = config.Health
	humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
	humanoid.Parent = boss

	local billboard = Instance.new("BillboardGui")
	billboard.Size = UDim2.new(0, 220, 0, 55)
	billboard.StudsOffset = Vector3.new(0, 8, 0)
	billboard.AlwaysOnTop = true
	billboard.Parent = head

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = config.Name .. "\nHP: " .. config.Health
	label.TextColor3 = Color3.new(1, 1, 1)
	label.TextScaled = true
	label.Font = Enum.Font.GothamBold
	label.Parent = billboard

	currentBoss = boss
	currentBossData = { Config = config, Stage = stage, Label = label, Humanoid = humanoid, Part = part }
	boss.Parent = workspace

	BossUpdate:FireAllClients(config.Name, humanoid.Health, humanoid.MaxHealth, stage)
end

AttackRemote.OnServerEvent:Connect(function(player)
	if not currentBossData then return end
	local stats = player:FindFirstChild("leaderstats")
	if not stats then return end

	local damage = math.max(1, math.floor(stats.Strength.Value * 0.15 * (stats.Multiplier.Value or 1)))
	currentBossData.Humanoid.Health = math.max(0, currentBossData.Humanoid.Health - damage)
	currentBossData.Label.Text = currentBossData.Config.Name .. "\nHP: " .. math.floor(currentBossData.Humanoid.Health)
	BossUpdate:FireAllClients(currentBossData.Config.Name, currentBossData.Humanoid.Health, currentBossData.Humanoid.MaxHealth, currentBossData.Stage)

	if currentBossData.Humanoid.Health <= 0 then
		stats.Strength.Value += currentBossData.Config.StrengthReward
		stats.Wins.Value += currentBossData.Config.WinsReward
		local nextStage = currentBossData.Stage + 1
		currentBoss:Destroy()
		currentBoss = nil
		currentBossData = nil
		if GameConfig.Bosses[nextStage] then
			task.wait(2)
			spawnBoss(nextStage)
		end
	end
end

task.spawn(function()
	while true do
		task.wait(1.5)
		if currentBossData and currentBossData.Config.Damage > 0 then
			for _, p in ipairs(Players:GetPlayers()) do
				local char = p.Character
				if char and char:FindFirstChild("Humanoid") then
					char.Humanoid:TakeDamage(currentBossData.Config.Damage)
				end
			end
		end
	end
end

task.wait(2)
spawnBoss(1)

print("[+1 Strength Escape] CombatSystem loaded")
