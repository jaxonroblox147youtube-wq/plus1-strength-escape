# +1 Strength Escape - Full Game

## How to install (very important)

1. Download this repository as ZIP from GitHub
2. In Roblox Studio create the scripts/folders exactly as listed below
3. Copy the code from each file into the matching script

### Exact Placement

| File | Put it here |
|------|-------------|
| `1_ServerScriptService_PlayerStats.luau` | ServerScriptService (Script) |
| `2_ServerScriptService_TrainingSystem.luau` | ServerScriptService (Script) |
| `3_ServerScriptService_CombatSystem.luau` | ServerScriptService (Script) |
| `4_ServerScriptService_RebirthSystem.luau` | ServerScriptService (Script) |
| `5_ServerScriptService_ShopSystem.luau` | ServerScriptService (Script) |
| `6_ReplicatedStorage_GameConfig.luau` | ReplicatedStorage (ModuleScript named **GameConfig**) |
| `7_StarterGui_LevelBar.luau` | StarterGui → create ScreenGui named **MainUI** → put this LocalScript inside it |
| `8_StarterPlayerScripts_Client.luau` | StarterPlayer → StarterPlayerScripts (LocalScript) |
| `9_ServerScriptService_MapBuilder.luau` | ServerScriptService (Script) |
| `10_StarterGui_ShopAndNotify.luau` | Inside the same **MainUI** ScreenGui (LocalScript) |

### What the MapBuilder creates automatically
- Big floor
- Green spawn pad
- 5 Pull-Up Bars (different colors for different rebirth requirements)
- Red Boss Area

### Controls
- Walk to a Pull-Up Bar → Press **E** to train
- **Jump** to stop training
- **Left Click** to attack the boss
- Press **R** to Rebirth (needs 500 Strength)
- Click the blue **SHOP** button to buy multipliers with Wins

Enjoy!
