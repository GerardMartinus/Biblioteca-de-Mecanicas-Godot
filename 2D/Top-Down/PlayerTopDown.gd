extends CharacterBody2D


const SPEED = 300.0
var player_direction : Vector2

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	player_direction.x = Input.get_axis("player_left", "player_right")
	player_direction.y = Input.get_axis("player_front", "player_back")
	
	if player_direction:
		velocity = player_direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	move_and_slide()
