extends KinematicBody2D


var path := PoolVector2Array() setget set_path
var index = 1
var equipment := GameData.equipment_chosen

var facing := Vector2(0, 1)

func move_along_path():
	var length = path.size()
	if length > 1:
		global_position = path[index]
		if index < length-1:
			index += 1
			set_sprite()
			if $walk.playing == false:
				$walk.play()
		else:
			GameData.equipment_chosen = []
			get_tree().change_scene_to(load("res://GameObjects/Menu_Win.tscn"))


func set_path(value : PoolVector2Array):
	path = value
	if value.size() == 0:
		return


func set_sprite():
	facing = path[index] - path[index-1]
	if facing.y > 0:
		$PlayerSprite.frame_coords.y = 1
	elif facing.y < 0:
		$PlayerSprite.frame_coords.y = 2
	else:
		$PlayerSprite.frame_coords.y = 3
	
	if "sword" in equipment:
		$PlayerSprite.frame_coords.x = (index % 8) + 16
	elif "torch" in equipment:
		$PlayerSprite.frame_coords.x = (index % 8) + 8


func die():
	GameData.equipment_chosen = []
	queue_free()
	get_tree().change_scene_to(load("res://GameObjects/Menu_Lose.tscn"))


func _on_Timer_timeout():
	move_along_path()


func _on_Light2D_ready():
	if "sword" in equipment:
		$Light2D.visible = false
