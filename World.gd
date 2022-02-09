extends Node2D


onready var nav_2d := $YSort/Navigation2D
onready var player := $YSort/Player
onready var goal := $YSort/Goal

var path

func _ready():
	path = nav_2d.get_simple_path(player.global_position, goal.global_position)
	player.path = path
