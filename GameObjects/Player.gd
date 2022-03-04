extends KinematicBody

var torch = true # temporary boolean for torch

# How fast the player moves in meters per second.
export var speed = 7
# The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration = 75
var velocity = Vector3.ZERO

onready var animation = $Mesh/PixelMesh/AnimationPlayer

func _physics_process(delta):
	var direction = Vector3.ZERO
	var collision_shape = get_node("CollisionShape")
	
	var moving_right = Input.is_action_pressed("ui_right")
	var moving_left = Input.is_action_pressed("ui_left")
	var moving_up = Input.is_action_pressed("ui_up")
	var moving_down = Input.is_action_pressed("ui_down")
	var moving_idle = true
	
	var player_mesh = $Mesh
	#var pixel_mesh = player_mesh.get_node("PixelMesh")
	
	if moving_right:
		direction.x += 1
		
		# Rotate the CollisionShape
		collision_shape.rotation_degrees.y = 90 # This rotates the torch
		
		# Set the sprite orientation
		if player_mesh.scale.x < 0:
			player_mesh.scale.x = abs(player_mesh.scale.x) # Sets the "sprite" direction
			#player_mesh.scale.z = abs(player_mesh.scale.z)
			#collision_shape.scale.z = abs(collision_shape.scale.z)
		
		# Change the animation
		if torch:
			animation.play("walking_side_torch")
		else:
			animation.play("walking_side")
		
		moving_idle = false
		
	if moving_left:
		direction.x -= 1
		
		# Rotate the CollisionShape
		collision_shape.rotation_degrees.y = -90
		
		# Set the sprite orientation
		if player_mesh.scale.x > 0: # if positive
			player_mesh.scale.x = -player_mesh.scale.x # set the "sprite" direction
			#player_mesh.scale.z = -player_mesh.scale.z
			#collision_shape.scale.z = -collision_shape.scale.z
			
		# Change the animation
		if torch:
			animation.play("walking_side_torch")
		else:
			animation.play("walking_side")
		
		moving_idle = false
	
	if moving_down:
		direction.z += 1
		
		# Rotate the CollisionShape
		collision_shape.rotation_degrees.y = 0
		
		# Set the sprite orientation
		player_mesh.scale.x = abs(player_mesh.scale.x)
		#collision_shape.scale.z = abs(collision_shape.scale.z)
		
		# Change the animation
		if torch:
			animation.play("walking_down_torch")
		else:
			animation.play("walking_down")
			
		moving_idle = false
	
	if moving_up:
		direction.z -= 1
		
		# Rotate the CollisionShape
		collision_shape.rotation_degrees.y = 180
		
		# Set the sprite orientation
		player_mesh.scale.x = abs(player_mesh.scale.x)
		#collision_shape.scale.z = -collision_shape.scale.z
		
		# Change the animation
		if torch:
			animation.play("walking_up_torch")
		else:
			animation.play("walking_up")
		
		moving_idle = false
		
	if moving_idle: # If not moving
		# If player was moving right/left
		if abs(collision_shape.rotation_degrees.y) == 90:
			if torch:
				animation.play("idle_side_torch")
			else:
				animation.play("idle_side")
			
		# If player was moving down
		if collision_shape.rotation_degrees.y == 0:
			if torch:
				animation.play("idle_front_torch")
			else:
				animation.play("idle_front")
		
		# If player was moving up
		if collision_shape.rotation_degrees.y == 180:
			if torch:
				animation.play("idle_back_torch")
			else:
				animation.play("idle_back")

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	velocity.y -= fall_acceleration * delta
	velocity = move_and_slide(velocity, Vector3.UP)
