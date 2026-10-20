-- PUT THIS LocalScript IN: StarterPlayer > StarterPlayerScripts
-- Name it: ClientController

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local remotes = ReplicatedStorage:WaitForChild("Remotes")

local AttackRemote = remotes:WaitForChild("AttackBoss")
local TrainError = remotes:WaitForChild("TrainError")
local BossUpdate = remotes:WaitForChild("BossUpdate")
local RebirthRemote = remotes:WaitForChild("RequestRebirth")
local BuyMultiplier = remotes:WaitForChild("BuyMultiplier")

-- Click to attack
UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		AttackRemote:FireServer()
	end
end

-- Show training errors
TrainError.OnClientEvent:Connect(function(message)
	warn(message)
	-- You can replace this with a proper GUI notification later
end

-- Simple rebirth key (press R)
UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == Enum.KeyCode.R then
		RebirthRemote:FireServer()
	end
end

print("[Client] Loaded - Click to attack, Jump to stop training, R to Rebirth")
