extends CharacterBody3D

const SPEED: float = 5.0
const JUMP_VELOCITY: float = 4.5

@onready var actor: Node3D = $Actor


func _ready() -> void:
	# Separate actor transform to allow manual interpolation
	actor.top_level = true
	
	# Disable actor physics interpolation as we will manually interpolate
	actor.physics_interpolation_mode = Node.PHYSICS_INTERPOLATION_MODE_OFF


func _process(_delta: float) -> void:
	# Update actor position to follow the FirstPersonController
	if is_physics_interpolated_and_enabled():
		# If the project settings use physics interpolation
		actor.position = get_global_transform_interpolated().origin
	else:
		# If no physics interpolation, no need to use interpolated position
		actor.position = global_transform.origin


func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration
	# Use the actor global basis to determine forward direction
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right",
			"move_forward", "move_backward")
	var direction: Vector3 = (actor.global_transform.basis *
			Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
