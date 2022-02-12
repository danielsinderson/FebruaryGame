extends Node2D


onready var player := $Player
onready var goal := $Goal
onready var floor_tiles := $Floor
onready var pit_tiles := $Pits
onready var pathfinding := $Pathfinding

var player_position := Vector2.ZERO
var pit_tiles_cells := []
var pit_tile_cell_ids := []




func _ready():
	pathfinding.create_navigation_map(floor_tiles, false)
	pathfinding.add_to_excluded_groups("obstacles")
	if "torch" in player.equipment:
		pathfinding.add_to_excluded_groups("pits")
	var new_path = pathfinding.get_new_path(player.position, goal.position)
	player.path = new_path
	
	pit_tiles_cells = pit_tiles.get_used_cells()
	for cell in pit_tiles_cells:
		pit_tile_cell_ids.append(pathfinding.get_id_for_point(cell))


func _physics_process(delta):
	player_position = player.global_position
	var player_cell = floor_tiles.world_to_map(player_position)
	if pathfinding.get_id_for_point(player_cell) in pit_tile_cell_ids:
		player.queue_free()
		GameData.equipment_chosen = []
		get_tree().change_scene_to(load("res://GameObjects/Menu_Lose.tscn"))
