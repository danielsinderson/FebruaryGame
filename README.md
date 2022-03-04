# FebruaryGame
Game Jam with Matt T

## 3D Development
The Develop branch is currently working on transitioning the project to the 3D engine. 

I've added the old 2D project files to the "Archive" directory, so we can reference as needed. 

The "main" branch contains the last working snapshot of the 2D version.

## How to Play in a Browser
### CURRENTLY BROKEN
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
