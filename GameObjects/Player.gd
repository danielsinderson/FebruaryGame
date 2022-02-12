extends KinematicBody2D


var path := PoolVector2Array() setget set_path
var index = 1
var equipment := GameData.equipment_chosen



func _process(delta):
	pass


func move_along_path():
	var length = path.size()
	if length > 1:
		global_position = path[index]
		if index < length-1:
			index += 1
		else:
			set_process(false)


func set_path(value : PoolVector2Array):
	path = value
	if value.size() == 0:
		return
	


func _on_Timer_timeout():
	move_along_path()
	print(global_position)
