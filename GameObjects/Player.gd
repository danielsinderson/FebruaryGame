extends KinematicBody

var torch = true # temporary boolean for torch

# How fast the player moves in meters per second.
export var speed = 7
# The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration = 75
var velocity = Vector3.ZERO

onready var animation = $Froggy/AnimationPlayer

func _physics_process(delta):
	var direction = Vector3.ZERO
	
	# Spatial containing all PixelMeshes
	var player_mesh = $Froggy
	
	# Enable torch visibility 
	if torch:
		$Froggy/mesh_torch.visible = true
	
	# Collision shape will rotate to keep track of which 
	# direction the player is facing. Value is checked
	# when 'idle'. See 'moving_idle'
	var collision_shape = get_node("CollisionShape")
	
	# Input variables for player movement
	var moving_right = Input.is_action_pressed("ui_right")
	var moving_left = Input.is_action_pressed("ui_left")
	var moving_up = Input.is_action_pressed("ui_up")
	var moving_down = Input.is_action_pressed("ui_down")
	
	# Boolean for whether player is idle/moving (true:idle, false:moving)
	var moving_idle = true # Is idle
	
	if moving_right:
		direction.x += 1
		
		# Rotate the CollisionShape
		collision_shape.rotation_degrees.y = 90 # This rotates the torch
		
		# Set the sprite orientation
		if player_mesh.scale.x < 0:
			player_mesh.scale.x = abs(player_mesh.scale.x) # Sets the "sprite" direction
			player_mesh.scale.z = abs(player_mesh.scale.z)
		
		# Change the animation
		animation.play("walking_side")
		
		# Is not idle
		moving_idle = false
		
	if moving_left:
		direction.x -= 1
		
		# Rotate the CollisionShape
		collision_shape.rotation_degrees.y = -90
		
		# Set the sprite orientation
		if player_mesh.scale.x > 0: # if positive
			player_mesh.scale.x = -player_mesh.scale.x # set the "sprite" direction
			player_mesh.scale.z = -player_mesh.scale.z
			
		# Change the animation
		animation.play("walking_side")
		
		moving_idle = false
	
	if moving_down:
		direction.z += 1
		
		# Rotate the CollisionShape
		collision_shape.rotation_degrees.y = 0
		
		# Set the sprite orientation
		if player_mesh.scale.x < 0:
			player_mesh.scale.x = abs(player_mesh.scale.x) # Sets the "sprite" direction
			player_mesh.scale.z = abs(player_mesh.scale.z)
		
		# Change the animation
		animation.play("walking_down")
			
		moving_idle = false
	
	if moving_up:
		direction.z -= 1
		
		# Rotate the CollisionShape
		collision_shape.rotation_degrees.y = 180
		
		# Set the sprite orientation
		if player_mesh.scale.x < 0: 
			player_mesh.scale.x = abs(player_mesh.scale.x) # set the "sprite" direction
			player_mesh.scale.z = abs(player_mesh.scale.z)
		#player_mesh.scale.x = -(abs(player_mesh.scale.x))
		
		# Change the animation
		animation.play("walking_up")
		
		moving_idle = false
		
	if moving_idle: # If not moving
		# If player was moving right/left
		if abs(collision_shape.rotation_degrees.y) == 90:
			animation.play("idle_side")
			
		# If player was moving down
		if collision_shape.rotation_degrees.y == 0:
			animation.play("idle_front")
		
		# If player was moving up
		if collision_shape.rotation_degrees.y == 180:
				animation.play("idle_back")

	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	velocity.y -= fall_acceleration * delta
	velocity = move_and_slide(velocity, Vector3.UP)
