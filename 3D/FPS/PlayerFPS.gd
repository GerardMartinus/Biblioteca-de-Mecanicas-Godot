extends CharacterBody3D


@export_category("Character Settings")
@export var SPEED = 5.0
@export var NORMAL_SPEED = 5.0
@export var RUNNING_SPEED = 8.0
@export var JUMP_VELOCITY = 5

@export_category("Mouse Settings")
@export var sens = 0.5

# Para manter a posição onde esta olhando quando aperta o ESC 
@onready var mouse_on = true
@onready var head_vertical = $Head/Vertical

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Start with mouse hidden
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion and mouse_on:
		rotate_y(deg_to_rad(-event.relative.x * sens))
		head_vertical.rotate_x(deg_to_rad(-event.relative.y * sens))
		head_vertical.rotation.x = clamp(head_vertical.rotation.x, deg_to_rad(-60), deg_to_rad(35))

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
		# Mouse Input Camera
	if Input.is_action_just_pressed("player_exit"):
		mouse_on = false
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	if Input.is_action_just_pressed("mouse_left"):
		mouse_on = true
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	if Input.is_action_pressed("player_run"):
		SPEED = RUNNING_SPEED
	else:
		SPEED = NORMAL_SPEED

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("player_left", "player_right", "player_front", "player_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
