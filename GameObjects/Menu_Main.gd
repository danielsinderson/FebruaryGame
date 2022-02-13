extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/button_start.grab_focus()
	
	# Force maximized windows
	OS.set_window_maximized(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_button_start_pressed():
	get_tree().change_scene("res://GameObjects/Menu_Equipment.tscn")


func _on_button_quit_pressed():
	get_tree().quit()


func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer.play()
