PROJECT_PATH='/run/media/lilt/Winux/Godot/FebruaryJam/Exports/HTML5'

# 127.0.0.1 is default LocalHost address. Keep if testing locally on host machine
LOCAL_ADDRESS=127.0.0.1 
PORT=7007

# Change into the directory
cd $PROJECT_PATH

# starts the server 
python -m http.server --bind $LOCAL_ADDRESS $PORT
