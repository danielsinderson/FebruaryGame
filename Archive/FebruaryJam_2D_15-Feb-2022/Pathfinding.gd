extends Node2D

var astar = AStar2D.new()
var tilemap : TileMap
var half_cell_size : Vector2
var used_rect : Rect2

var excluded_groups := []



func create_navigation_map(tilemap : TileMap, include_diagonals=true):
	self.tilemap = tilemap
	
	half_cell_size = tilemap.cell_size / 2 # offset position to middle of tile 
	used_rect = tilemap.get_used_rect() # size of tilemap area
	
	var tiles = tilemap.get_used_cells() # gets cells in tilemap
	
	add_traversable_tiles(tiles) 
	connect_traversable_tiles(tiles, include_diagonals)
	

# add tiles to the AStar graph as vertices
func add_traversable_tiles(tiles : Array):
	for tile in tiles:
		var id = get_id_for_point(tile)
		astar.add_point(id, tile)
		# print(tile, id)


# add tile adjacency to AStar graph as edges
func connect_traversable_tiles(tiles : Array, include_diagonals : bool):
	for tile in tiles:
		var id = get_id_for_point(tile)
		
		if include_diagonals:
			for x in range(3):
				for y in range(3): # nested loop iterates over a 3x3 square
					# center 3x3 square at current tile, then get id
					var target = tile + Vector2(x - 1, y - 1) 
					var target_id = get_id_for_point(target)
				
					# skips center tile and ignores positions that go off our tilemap
					if tile == target or not astar.has_point(target_id):
						continue
				
					# true is for bidirectionality
					astar.connect_points(id, target_id, true)
		
		else:
			var neighbors = [Vector2(0, -1), Vector2(0, 1), Vector2(-1, 0), Vector2(1, 0)]
			for neighbor in neighbors:
				var target = tile + neighbor
				var target_id = get_id_for_point(target)
				
				if not astar.has_point(target_id):
					continue
				
				# true is for bidirectionality
				astar.connect_points(id, target_id, true)


func add_to_excluded_groups(group : String):
	if not group in excluded_groups:
		excluded_groups.append(group)


func remove_from_excluded_groups(group : String):
	if group in excluded_groups:
		excluded_groups.erase(group)


func update_navigation_map(groups_to_remove : Array):
	# re-enable all A* vertices
	for point in astar.get_points():
		astar.set_point_disabled(point, false)
	
	for group in groups_to_remove:
		remove_group_from_pathfinding(group)


func remove_group_from_pathfinding(group : String):
	# get all nodes in the scene tree that are in the "obstacles" group
	var obstacles = get_tree().get_nodes_in_group(group)
	# iterate over them and disable their A* vertices based on node type
	for obstacle in obstacles:
		if obstacle is TileMap:
			var tiles = obstacle.get_used_cells()
			for tile in tiles:
				var id = get_id_for_point(tile)
				if astar.has_point(id):
					astar.set_point_disabled(id, true)
		if obstacle is KinematicBody2D:
			pass



# create a deterministic hash for each vertex (as a point in space) 
# used for consistent storage and retrieval
func get_id_for_point(point : Vector2):
	var x = int(point.x)
	var y = int(point.y) * 1000
	return x+y


# get a path from start to end in world coordinates
# converts world coordinates to map, finds a path, then converts the path back to world
func get_new_path(start : Vector2, end : Vector2):
	update_navigation_map(excluded_groups)
	# convert world coordinates to tilemap coordinates
	var start_tile = tilemap.world_to_map(start)
	var end_tile = tilemap.world_to_map(end)
	
	# get ids for the tilemap coordinates
	var start_id = get_id_for_point(start_tile)
	var end_id = get_id_for_point(end_tile)
	
	# make sure that those ids are part of our AStar graph 
	if not astar.has_point(start_id) or not astar.has_point(end_id):
		return []
	
	# get path in tilemap coordinates
	var path_map = astar.get_point_path(start_id, end_id)
	
	# convert tilemap path to a path in world coordinates
	var path_world = []
	for point in path_map:
		var point_world = tilemap.map_to_world(point) + half_cell_size
		path_world.append(point_world)
	
	return path_world
	
