# FebruaryGame
Game Jam with Matt T

## How to Play in a Browser
Follow these steps to test play the game in a browser/host the game on a local server:
1. Navigate to the res://Exports/HTML5 directory in a Terminal
	```bash
	- cd /your/path/to/Exports/HTML5
	```
2. Edit the variables in "FebruaryGameJam-server_run.sh"
	- Change PROJECT_PATH to the absolute path of the HTML5 folder
	- change LOCAL_ADDRESS to the host machine's local address (default is 172.0.0.1)
	- Change PORT to whatever value is best
		- "7007" is the current default. Use whatever port you'd like, but try to avoid port conflicts with other web apps on your server/machine

3. Start the server
	```bash
	- sh FebruaryGameJam-server_run.sh
	```
4. From a computer that is connected to the local network, open a web browser and navigate to the server address
	- 127.0.0.1:7007 (local.ip.address.portnumber)


## TO DO LIST
### GRAPHIC ASSETS
- [x] Hallway map 
  - [x] Floor tile
  - [x] Wall tile
    - [x] Front projection
    - [x] Top projection 
  - [x] Pit tile
    - [x] Front projection
- [x] Door sprite
- [x] Wall Sconce sprite
- [x] Character sprite
  - [x] with Torch (Equipment A)
  - [x] with Sword (Equipment B)
  - [x] animated
- [x] Light texture tile
- [x] Torch (Equipment A) Icon
- [x] Sword (Equipment B) Icon
- [x] Ligh2D Nodes and occlusion
- [ ] Tiles for the Pit
- [x] Starting Menu
  - [x] Start
  - [x] Quit
  - [x] Changes to Equipment Menu
- [x] Equipment Menu (at the start of the level)
  - [x] Built scene and buttons
  - [x] Change to World scene with relevant game state (scraptured)
- [x] Rebuild World scene for designed layout
- [ ] Pause Menu
  - [ ] Continue
  - [ ] Quit
  - [ ] How to play


### AUDIO ASSETS
- [x] Music - Menu
- [x] Music - Gameplay
- [x] FX - Walking
- [x] FX - Reach Goal
- [x] FX - Die
- [ ] FX - Click Button 

### GAME OBJECTS
- [x] World
- [x] Player 
  - [x] movement
  - [x] pathfinding
  - [x] collisions
  - [x] animation
  - [x] sounds
- [x] Obstruction A
- [ ] Obstruction B
- [x] Tilemap
- [x] Goal
