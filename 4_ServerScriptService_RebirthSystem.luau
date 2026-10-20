-- PUT THIS SCRIPT IN: ServerScriptService
-- Name it: RebirthSystem

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local remotes = ReplicatedStorage:WaitForChild("Remotes")

local RebirthRemote = Instance.new("RemoteEvent")
RebirthRemote.Name = "RequestRebirth"
RebirthRemote.Parent = remotes

RebirthRemote.OnServerEvent:Connect(function(player)
	local stats = player:FindFirstChild("leaderstats")
	if not stats then return end

	-- Simple rebirth requirement: 500 Strength
	if stats.Strength.Value < 500 then
		return
	end

	stats.Rebirths.Value += 1
	stats.Strength.Value = 0
	stats.Level.Value = 1
	stats.XP.Value = 0

	print(player.Name .. " rebirthed! Now has " .. stats.Rebirths.Value .. " rebirths")
end

print("[+1 Strength Escape] RebirthSystem loaded")
