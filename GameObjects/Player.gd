extends KinematicBody2D


var path := PoolVector2Array() setget set_path



func _process(delta):
	move_along_path()


func move_along_path():
	if len(path) > 1:
		global_position = path[1]


func set_path(value : PoolVector2Array):
	path = value
	if value.size() == 0:
		return
	
