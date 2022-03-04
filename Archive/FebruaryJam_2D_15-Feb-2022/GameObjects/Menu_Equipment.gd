extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_button_torch_pressed():
	GameData.equipment_chosen.append("torch")
	get_tree().change_scene("res://World.tscn")


func _on_button_sword_pressed():
	GameData.equipment_chosen.append("sword")
	get_tree().change_scene("res://World.tscn")
