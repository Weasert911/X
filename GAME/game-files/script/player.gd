extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Mouse look settings
const MOUSE_SENSITIVITY = 0.002
const MAX_PITCH = deg_to_rad(89.0)  # 89 degrees up/down

# Camera references
@onready var camera: Camera3D = $Camera3D

# Rotation accumulators
var mouse_rotation: Vector2 = Vector2.ZERO


func _ready() -> void:
	# Capture mouse
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		# Accumulate mouse motion
		mouse_rotation -= event.relative * MOUSE_SENSITIVITY
		# Clamp vertical rotation to prevent over-rotation
		mouse_rotation.y = clamp(mouse_rotation.y, -MAX_PITCH, MAX_PITCH)
		
		# Apply rotations
		# Horizontal rotation (yaw) affects the player node
		rotation.y = mouse_rotation.x
		# Vertical rotation (pitch) affects only the camera
		camera.rotation.x = mouse_rotation.y
	
	# Optional: Press Escape to release mouse
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			else:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# Movement is now relative to camera's horizontal orientation
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Create a basis that only considers the player's yaw (horizontal rotation)
	var camera_basis = Basis(Vector3.UP, rotation.y)
	var direction := (camera_basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
