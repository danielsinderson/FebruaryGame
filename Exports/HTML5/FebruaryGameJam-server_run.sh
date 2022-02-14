PROJECT_PATH='/run/media/lilt/Winux/Godot/FebruaryJam/Exports/HTML5'
LOCAL_ADDRESS=192.168.1.8
PORT=7007

# Change into the directory
cd $PROJECT_PATH

# starts the server 
python -m http.server --bind $LOCAL_ADDRESS $PORT
