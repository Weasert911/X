extends Node3D
class_name CameraController

# ========================
# 🎛️ CONFIG
# ========================

@export_group("Core Follow")
@export var follow_speed: float = 8.0
@export var follow_damping: float = 0.1
@export var screen_bias_y: float = 0.15  # Player position bias below center (0-1 range)

@export_group("Camera Angle")
@export var camera_angle_degrees: float = 40.0  # Fixed tilt angle (30-45° range)

@export_group("Camera Distance")
@export var base_distance: float = 12.0  # Base distance from player
@export var base_height: float = 8.0  # Base height above player

@export_group("Velocity Lag")
@export var lag_strength: float = 0.3  # How much camera lags behind movement (0-1)
@export var lag_max_distance: float = 2.0  # Maximum lag distance in world units
@export var catch_up_speed: float = 12.0  # How fast camera catches up when stopping
@export var acceleration_smoothing: float = 0.15  # Smoothing factor for acceleration changes

@export_group("Elastic Catch-Up")
@export var spring_stiffness: float = 15.0  # Spring constant for elastic catch-up
@export var spring_damping: float = 0.7  # Damping factor to prevent oscillation
@export var velocity_threshold: float = 0.5  # Velocity threshold for spring activation

# ========================
# 🧠 INTERNAL
# ========================

@onready var camera: Camera3D = $Camera3D

var player: CharacterBody3D
var current_position: Vector3
var target_position: Vector3

# Velocity lag variables
var current_lag_offset: Vector3 = Vector3.ZERO
var previous_velocity: Vector3 = Vector3.ZERO
var current_acceleration: Vector3 = Vector3.ZERO
var lag_velocity: Vector3 = Vector3.ZERO  # Velocity of the lag offset for spring physics

# ========================
# 🚀 INIT
# ========================

func _ready():
	# Get player reference (parent node)
	player = get_parent() as CharacterBody3D
	
	# Initialize camera position
	current_position = global_position
	
	# Set fixed rotation for angled top-down view
	# Camera looks down at fixed angle, no rotation around Y axis
	var angle_rad = deg_to_rad(camera_angle_degrees)
	rotation_degrees.x = -camera_angle_degrees  # Tilt down
	rotation_degrees.y = 0.0  # No rotation around Y axis
	rotation_degrees.z = 0.0

# ========================
# ⚙️ MAIN LOOP
# ========================

func _process(delta: float):
	# Frame-rate independent update
	update_camera_position(delta)

# ========================
# 📍 CAMERA POSITION
# ========================

func update_camera_position(delta: float):
	if not player:
		return
	
	# Get player velocity for lag calculations
	var player_velocity = player.get_current_velocity() if player.has_method("get_current_velocity") else Vector3.ZERO
	
	# Smooth acceleration for micro-movements
	smooth_acceleration(player_velocity, delta)
	
	# Calculate velocity-based lag
	calculate_velocity_lag(delta, player_velocity)
	
	# Get target position with screen bias applied
	target_position = get_target_position()
	
	# Apply lag offset to target position
	target_position = apply_lag_to_position(target_position)
	
	# Smoothly interpolate current position to target
	current_position = smooth_damp(current_position, target_position, delta)
	
	# Apply position to the rig
	global_position = current_position
	
	# Store previous velocity for next frame
	previous_velocity = player_velocity

# ========================
# 🎯 TARGET POSITION
# ========================

func get_target_position() -> Vector3:
	if not player:
		return Vector3.ZERO
	
	var player_pos = player.global_position
	
	# Calculate screen bias offset
	# Since camera looks down negative Z, bias moves target in negative Z direction
	var bias_offset = Vector3(0, 0, -screen_bias_y * base_distance)
	
	# Apply bias to player position
	var biased_position = player_pos + bias_offset
	
	# Calculate camera position based on fixed angle
	var angle_rad = deg_to_rad(camera_angle_degrees)
	
	# Camera is positioned behind and above the biased target
	var camera_pos = Vector3(
		biased_position.x,
		biased_position.y + base_height,
		biased_position.z + base_distance * cos(angle_rad)
	)
	
	return camera_pos

# ========================
# 🔄 SMOOTH DAMPING
# ========================

func smooth_damp(current: Vector3, target: Vector3, delta: float) -> Vector3:
	# Exponential smoothing for frame-rate independent interpolation
	# Formula: current = current + (target - current) * speed * delta
	return current + (target - current) * follow_speed * delta

# ========================
# 📊 ACCELERATION SMOOTHING
# ========================

func smooth_acceleration(velocity: Vector3, delta: float):
	# Calculate raw acceleration
	var raw_acceleration = Vector3.ZERO
	if delta > 0:
		raw_acceleration = (velocity - previous_velocity) / delta
	
	# Apply exponential smoothing to reduce jitter
	current_acceleration = current_acceleration.lerp(raw_acceleration, acceleration_smoothing)

# ========================
# 🎯 VELOCITY LAG
# ========================

func calculate_velocity_lag(delta: float, player_velocity: Vector3):
	# Get horizontal velocity (ignore Y axis for camera lag)
	var horizontal_velocity = Vector3(player_velocity.x, 0, player_velocity.z)
	var velocity_magnitude = horizontal_velocity.length()
	
	# Check if player is moving fast enough to trigger lag
	if velocity_magnitude > velocity_threshold:
		# Calculate lag based on velocity direction and magnitude
		var velocity_direction = horizontal_velocity.normalized()
		
		# Apply lag strength and clamp to max distance
		var target_lag_offset = velocity_direction * velocity_magnitude * lag_strength
		target_lag_offset = target_lag_offset.limit_length(lag_max_distance)
		
		# Smoothly interpolate current lag to target
		current_lag_offset = current_lag_offset.lerp(target_lag_offset, catch_up_speed * delta)
		
		# Reset lag velocity when actively moving
		lag_velocity = Vector3.ZERO
	else:
		# Player is stopping - use elastic catch-up with spring physics
		apply_elastic_catch_up(delta)

# ========================
# 🔄 ELASTIC CATCH-UP
# ========================

func apply_elastic_catch_up(delta: float):
	# Spring physics: force = (target - current) * spring_constant - velocity * damping
	var spring_force = (Vector3.ZERO - current_lag_offset) * spring_stiffness
	var damping_force = -lag_velocity * spring_damping
	
	# Apply forces to lag velocity
	lag_velocity += (spring_force + damping_force) * delta
	
	# Update lag offset based on velocity
	current_lag_offset += lag_velocity * delta
	
	# Kill micro jitter
	if current_lag_offset.length() < 0.01:
		current_lag_offset = Vector3.ZERO
		lag_velocity = Vector3.ZERO

# ========================
# 📍 APPLY LAG TO POSITION
# ========================

func apply_lag_to_position(base_position: Vector3) -> Vector3:
	# Apply lag offset to camera position
	# Lag is applied opposite to movement direction (camera trails behind)
	return base_position - current_lag_offset
