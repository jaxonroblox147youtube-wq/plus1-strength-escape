-- PUT THIS SCRIPT IN: ServerScriptService
-- Name it: ShopSystem

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameConfig = require(ReplicatedStorage:WaitForChild("GameConfig"))

local remotes = ReplicatedStorage:WaitForChild("Remotes")

local BuyMultiplier = Instance.new("RemoteEvent")
BuyMultiplier.Name = "BuyMultiplier"
BuyMultiplier.Parent = remotes

BuyMultiplier.OnServerEvent:Connect(function(player, index)
	local stats = player:FindFirstChild("leaderstats")
	if not stats then return end

	local item = GameConfig.ShopMultipliers[index]
	if not item then return end

	if stats.Wins.Value >= item.Cost then
		stats.Wins.Value -= item.Cost
		stats.Multiplier.Value = item.Multi
		print(player.Name .. " bought " .. item.Name)
	end
end

print("[+1 Strength Escape] ShopSystem loaded")
