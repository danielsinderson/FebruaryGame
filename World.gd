extends Node2D


onready var player := $Player
onready var goal := $Goal
onready var tilemap := $Floor
onready var pathfinding := $Pathfinding




func _ready():
	pathfinding.create_navigation_map(tilemap, false)
	var new_path = pathfinding.get_new_path(player.position, goal.position)
	player.path = new_path
	
