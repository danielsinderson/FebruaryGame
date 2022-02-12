extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/button_start.grab_focus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_button_start_pressed():
	get_tree().change_scene("res://GameObjects/Menu_Equipment.tscn")

func _on_button_quit_pressed():
	get_tree().quit()
