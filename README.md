# +1 Strength Escape - Full Game

## Install order (IMPORTANT)

1. Download ZIP from this repo
2. In Studio, create scripts exactly like this:

### ReplicatedStorage
- ModuleScript named **GameConfig** ← paste `6_ReplicatedStorage_GameConfig.luau`
- Folder named **Remotes** will be created by scripts (or create empty Folder named Remotes)

### ServerScriptService (all normal Scripts)
Paste each file into a Script with a clear name:
1. PlayerStats
2. MapBuilder
3. TrainingSystem
4. CombatSystem
5. RebirthSystem
6. ShopSystem

### StarterGui
1. Create ScreenGui named **MainUI**
2. LocalScript **LevelBar** ← `7_StarterGui_LevelBar.luau`
3. LocalScript **ShopAndNotify** ← `10_StarterGui_ShopAndNotify.luau`
4. LocalScript **BossHealthUI** ← `11_StarterGui_BossHealthUI.luau`

### StarterPlayer > StarterPlayerScripts
- LocalScript **ClientController** ← `8_StarterPlayerScripts_Client.luau`

### Controls
- Go to a pull-up bar → hold **E** / tap prompt to train
- **Jump** to stop training
- **Left click** to attack boss
- Press **R** to rebirth (needs enough Strength)
- **SHOP** button bottom-left to buy multipliers with Wins

Bars unlock by Rebirths. Higher bars = more strength. Bosses damage you except stage 1.
