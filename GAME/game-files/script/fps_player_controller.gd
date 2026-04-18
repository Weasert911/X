extends CharacterBody3D
class_name FPSPlayerController

## FPS Player Controller
## Handles camera-relative movement, acceleration/deceleration, ground/air control,
## jumping with coyote time and jump buffer, and sprint system.

# ========================
# 🎛️ CONFIG - Movement
# ========================

@export_group("Movement")
@export var walk_speed: float = 5.0           # m/s - Normal walking speed
@export var sprint_speed: float = 8.0          # m/s - Sprinting speed
@export var acceleration: float = 15.0        # m/s² - Ground acceleration rate
@export var deceleration: float = 20.0        # m/s² - Ground deceleration rate
@export var air_acceleration: float = 5.0     # m/s² - Air acceleration rate
@export var air_deceleration: float = 2.0     # m/s² - Air deceleration rate
@export var ground_control: float = 1.0       # Ground control multiplier
@export var air_control: float = 0.3          # Air control multiplier

# ========================
# 🎛️ CONFIG - Jump & Gravity
# ========================

@export_group("Jump & Gravity")
@export var jump_force: float = 8.0          # m/s - Jump upward velocity
@export var gravity: float = 20.0             # m/s² - Downward gravity force
@export var coyote_time: float = 0.15         # seconds - Coyote time after leaving ground
@export var jump_buffer: float = 0.1          # seconds - Jump buffer before landing

# ========================
# 🎛️ CONFIG - Ground Detection
# ========================

@export_group("Ground Detection")
@export var ground_check_distance: float = 0.1 # meters - Raycast length
@export var ground_check_offset: float = 0.05  # meters - Offset from bottom
@export var max_slope_angle: float = 45.0      # degrees - Walkable slope

# ========================
# 🔧 Node References
# ========================

@onready var head_pivot: Node3D = $HeadPivot
@onready var camera_controller: FPSCameraController = $HeadPivot/Camera3D
@onready var camera_effects_manager: CameraEffectsManager = $HeadPivot/CameraEffectsManager

# ========================
# 🧠 INTERNAL - State
# ========================

var input_dir: Vector2 = Vector2.ZERO
var is_sprinting: bool = false
var was_on_floor: bool = true
var time_since_left_ground: float = 0.0
var jump_buffer_timer: float = 0.0
var just_landed: bool = false
var horizontal_velocity: Vector3 = Vector3.ZERO
var is_strafing_left: bool = false
var is_strafing_right: bool = false
var just_jumped: bool = false
var current_acceleration: float = 0.0
var previous_horizontal_velocity: Vector3 = Vector3.ZERO

# ========================
# 🎮 INPUT
# ========================

func _get_movement_input() -> Vector2:
	"""Get WASD input vector."""
	return Input.get_vector("move_left", "move_right", "move_backward", "move_forward")

func _get_sprint_input() -> bool:
	"""Get sprint input state."""
	return Input.is_action_pressed("sprint")

func _get_jump_input() -> bool:
	"""Get jump input state."""
	return Input.is_action_just_pressed("jump")

# ========================
# 🚀 MAIN LOOP
# ========================

func _physics_process(delta: float) -> void:
	# Get input
	input_dir = _get_movement_input()
	is_sprinting = _get_sprint_input()
	
	# Check ground state
	_check_ground_state()
	
	# Handle jump with coyote time and jump buffer
	_handle_jump()
	
	# Apply gravity
	_apply_gravity(delta)
	
	# Handle movement with acceleration/deceleration
	_handle_movement(delta)
	
	# Move the character
	move_and_slide()
	
	# Calculate acceleration and detect strafing
	_update_movement_state(delta)
	
	# Update camera state
	_update_camera_state()

# ========================
# 🌍 MOVEMENT
# ========================

func _handle_movement(delta: float) -> void:
	"""Handle camera-relative movement with acceleration/deceleration."""
	var direction = Vector3.ZERO
	
	if input_dir != Vector2.ZERO:
		# Get camera-relative directions
		var forward = camera_controller.get_forward_direction()
		var right = camera_controller.get_right_direction()
		
		# Calculate world-space direction
		direction = (forward * input_dir.y + right * input_dir.x).normalized()
	
	# Determine target speed
	var target_speed = walk_speed
	if is_sprinting:
		target_speed = sprint_speed
	
	# Calculate target velocity
	var target_velocity = direction * target_speed
	
	# Determine acceleration/deceleration rates based on state
	var accel_rate = acceleration
	var decel_rate = deceleration
	var control_multiplier = ground_control
	
	if not is_on_floor():
		accel_rate = air_acceleration
		decel_rate = air_deceleration
		control_multiplier = air_control
	
	# Apply acceleration/deceleration to horizontal velocity
	if direction != Vector3.ZERO:
		# Accelerating towards target velocity
		horizontal_velocity = horizontal_velocity.lerp(target_velocity, accel_rate * control_multiplier * delta)
	else:
		# Decelerating to zero
		horizontal_velocity = horizontal_velocity.lerp(Vector3.ZERO, decel_rate * control_multiplier * delta)
	
	# Apply horizontal velocity to character velocity
	velocity.x = horizontal_velocity.x
	velocity.z = horizontal_velocity.z
	
	# Kill micro jitter
	if abs(velocity.x) < 0.01: velocity.x = 0
	if abs(velocity.z) < 0.01: velocity.z = 0

# ========================
# 🦘 JUMP
# ========================

func _handle_jump() -> void:
	"""Handle jump input with coyote time and jump buffer."""
	var jump_pressed = _get_jump_input()
	
	# Jump buffer: remember jump press for a short time
	if jump_pressed:
		jump_buffer_timer = jump_buffer
	
	# Check if we can jump (grounded or within coyote time)
	var can_jump = is_on_floor() or (time_since_left_ground < coyote_time)
	
	# Execute jump if conditions met
	if can_jump and jump_buffer_timer > 0:
		velocity.y = jump_force
		jump_buffer_timer = 0  # Consume the buffered jump
		time_since_left_ground = coyote_time + 1  # Disable coyote time after jump
		just_jumped = true  # Set jump flag for camera effects

# ========================
# 🌌 GRAVITY
# ========================

func _apply_gravity(delta: float) -> void:
	"""Apply manual gravity."""
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		if velocity.y < 0:
			velocity.y = 0

# ========================
# 🌍 GROUND DETECTION
# ========================

func _check_ground_state() -> void:
	"""Check ground state and handle landing detection."""
	var currently_on_floor = is_on_floor()
	
	# Detect landing
	if not was_on_floor and currently_on_floor:
		just_landed = true
		time_since_left_ground = 0.0
	
	# Track time since leaving ground for coyote time
	if not currently_on_floor:
		time_since_left_ground += get_physics_process_delta_time()
	
	# Update previous state
	was_on_floor = currently_on_floor

# ========================
# 📡 CAMERA INTEGRATION
# ========================

func _update_camera_state() -> void:
	"""Update camera controller with player state."""
	# Calculate horizontal speed for camera effects
	var horizontal_speed = horizontal_velocity.length()
	
	# Send state to camera effects manager
	camera_effects_manager.set_player_state(
		is_sprinting,
		is_on_floor(),
		just_landed,
		horizontal_speed,
		is_strafing_left,
		is_strafing_right,
		just_jumped,
		current_acceleration,
		false  # TODO: Add aiming state when implemented
	)
	
	# Reset one-shot flags after sending to camera
	just_landed = false
	just_jumped = false

func _update_movement_state(delta: float) -> void:
	"""Update movement state for camera effects."""
	# Calculate acceleration
	current_acceleration = (horizontal_velocity - previous_horizontal_velocity).length() / delta
	previous_horizontal_velocity = horizontal_velocity
	
	# Detect strafing
	is_strafing_left = input_dir.x < -0.5
	is_strafing_right = input_dir.x > 0.5

# ========================
# 📊 PUBLIC API
# ========================

func get_horizontal_velocity() -> Vector3:
	"""Returns the horizontal (XZ) velocity for camera effects."""
	return horizontal_velocity

func get_movement_speed() -> float:
	"""Returns the current movement speed."""
	return horizontal_velocity.length()

func is_player_sprinting() -> bool:
	"""Returns whether the player is sprinting."""
	return is_sprinting

func is_player_grounded() -> bool:
	"""Returns whether the player is on the ground."""
	return is_on_floor()
