-- PUT THIS SCRIPT IN: ServerScriptService
-- Name it: MapBuilder
-- This creates the entire basic map automatically

local function createPart(name, size, position, color, anchored)
	local part = Instance.new("Part")
	part.Name = name
	part.Size = size
	part.Position = position
	part.Anchored = anchored ~= false
	part.BrickColor = BrickColor.new(color or "Medium stone grey")
	part.TopSurface = Enum.SurfaceType.Smooth
	part.BottomSurface = Enum.SurfaceType.Smooth
	part.Parent = workspace
	return part
end

-- Clear old map parts if re-running
for _, name in ipairs({"Spawn", "Floor", "PullUpBar_1", "PullUpBar_2", "PullUpBar_3", "PullUpBar_4", "PullUpBar_5", "BossArea"}) do
	local old = workspace:FindFirstChild(name)
	if old then old:Destroy() end
end

-- Big floor
createPart("Floor", Vector3.new(200, 1, 200), Vector3.new(0, 0, 0), "Dark stone grey")

-- Spawn point
local spawn = Instance.new("SpawnLocation")
spawn.Name = "Spawn"
spawn.Size = Vector3.new(12, 1, 12)
spawn.Position = Vector3.new(0, 1, -30)
spawn.Anchored = true
spawn.BrickColor = BrickColor.new("Bright green")
spawn.Duration = 0
spawn.Parent = workspace

-- Pull Up Bars (5 different rebirth tiers)
local barPositions = {
	{Name = "PullUpBar_1", Pos = Vector3.new(-20, 5, 0), Color = "Bright blue"},
	{Name = "PullUpBar_2", Pos = Vector3.new(-10, 5, 0), Color = "Bright green"},
	{Name = "PullUpBar_3", Pos = Vector3.new(0, 5, 0), Color = "Bright yellow"},
	{Name = "PullUpBar_4", Pos = Vector3.new(10, 5, 0), Color = "Bright orange"},
	{Name = "PullUpBar_5", Pos = Vector3.new(20, 5, 0), Color = "Bright red"},
}

for _, info in ipairs(barPositions) do
	local bar = createPart(info.Name, Vector3.new(6, 1, 1), info.Pos, info.Color)
	-- Add two poles so it looks like a pull-up bar
	createPart(info.Name .. "_PoleL", Vector3.new(0.5, 6, 0.5), info.Pos + Vector3.new(-2.5, -2.5, 0), "Black")
	createPart(info.Name .. "_PoleR", Vector3.new(0.5, 6, 0.5), info.Pos + Vector3.new(2.5, -2.5, 0), "Black")
end

-- Boss area marker
createPart("BossArea", Vector3.new(20, 1, 20), Vector3.new(0, 0.5, 50), "Really red")

print("[+1 Strength Escape] MapBuilder finished - 5 Pull Up Bars + Spawn + Boss Area created")
