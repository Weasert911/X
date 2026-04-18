extends Camera3D
class_name FPSCameraController

## FPS Camera Controller
## Handles mouse look, camera effects, and polish features for first-person gameplay.

# 🎮 Mouse Look Settings
@export_group("Mouse Look")
@export var mouse_sensitivity: float = 0.002  # Radians per pixel
@export var pitch_min: float = -80.0  # Degrees - Minimum look down
@export var pitch_max: float = 80.0  # Degrees - Maximum look up
@export var enable_smoothing: bool = false  # Optional input smoothing
@export var smoothing_speed: float = 10.0  # Smoothing speed when enabled

# 🎥 FOV Settings
@export_group("FOV")
@export var base_fov: float = 75.0  # Degrees - Default FOV
@export var fov_kick_enabled: bool = true  # Enable FOV kick on sprint
@export var fov_kick_amount: float = 10.0  # FOV increase when sprinting
@export var fov_kick_speed: float = 5.0  # FOV transition speed

# 🚶 Head Bob Settings
@export_group("Head Bob")
@export var head_bob_enabled: bool = true  # Enable head bob
@export var head_bob_speed: float = 12.0  # Hz - Bob frequency
@export var head_bob_amount: float = 0.05  # Meters - Bob amplitude
@export var head_bob_sprint_multiplier: float = 1.5  # Speed multiplier when sprinting

# 🪂 Landing Settings
@export_group("Landing")
@export var landing_dip_enabled: bool = true  # Enable landing camera dip
@export var landing_dip_amount: float = 0.1  # Meters - Camera dip on land
@export var landing_dip_speed: float = 8.0  # Recovery speed

# 🔧 Node References
@onready var head_pivot: Node3D = get_parent()
@onready var player: CharacterBody3D = head_pivot.get_parent()
@onready var camera_effects_manager: CameraEffectsManager = get_node_or_null("../CameraEffectsManager")

# 📊 State Variables
var _yaw_input: float = 0.0  # Horizontal mouse input
var _pitch_input: float = 0.0  # Vertical mouse input
var _current_yaw: float = 0.0  # Current yaw angle
var _current_pitch: float = 0.0  # Current pitch angle
var _target_yaw: float = 0.0  # Target yaw for smoothing
var _target_pitch: float = 0.0  # Target pitch for smoothing

# 🎭 Effect State Variables
var _head_bob_timer: float = 0.0  # Time accumulator for head bob
var _current_fov: float = 75.0  # Current FOV value
var _landing_dip_offset: float = 0.0  # Current landing dip offset
var _landing_dip_velocity: float = 0.0  # Landing dip recovery velocity

# 📡 Player State (set by PlayerController)
var is_sprinting: bool = false
var is_grounded: bool = true
var just_landed: bool = false
var movement_speed: float = 0.0

# 🎯 Signals
signal camera_direction_changed(forward: Vector3, right: Vector3)

func _ready() -> void:
	# Initialize cursor capture
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	# Set initial FOV
	_current_fov = base_fov
	fov = _current_fov
	
	# Initialize rotation angles
	# Yaw from player rotation (body), pitch from camera rotation
	_current_yaw = player.rotation.y
	_current_pitch = rotation.x
	_target_yaw = _current_yaw
	_target_pitch = _current_pitch
	
	# Ensure head pivot has no y rotation
	head_pivot.rotation.y = 0.0

func _input(event: InputEvent) -> void:
	# Handle mouse look input
	if event is InputEventMouseMotion:
		_yaw_input = -event.relative.x * mouse_sensitivity
		_pitch_input = -event.relative.y * mouse_sensitivity
	
	# Handle cursor toggle (ESC to unlock, click to lock)
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif event is InputEventMouseButton and event.pressed:
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta: float) -> void:
	# Handle mouse look
	_handle_mouse_look(delta)
	
	# Update and apply camera effects through manager
	if camera_effects_manager:
		var effects = camera_effects_manager.get_effects(delta)
		position = effects.position_offset
		rotation += effects.rotation_offset
		fov = effects.fov
	else:
		# Fallback to legacy effects if manager not available
		_update_head_bob(delta)
		_update_fov_kick(delta)
		_update_landing_dip(delta)
	
	# Emit camera direction signal
	_emit_camera_direction()

## 🎮 Mouse Look System
func _handle_mouse_look(delta: float) -> void:
	# Apply input to target angles
	_target_yaw += _yaw_input
	_target_pitch += _pitch_input
	
	# Clamp pitch to prevent over-rotation
	_target_pitch = clamp(_target_pitch, deg_to_rad(pitch_min), deg_to_rad(pitch_max))
	
	# Apply smoothing if enabled
	if enable_smoothing:
		var smooth_factor: float = smoothing_speed * delta
		_current_yaw = lerp_angle(_current_yaw, _target_yaw, smooth_factor)
		_current_pitch = lerp_angle(_current_pitch, _target_pitch, smooth_factor)
	else:
		_current_yaw = _target_yaw
		_current_pitch = _target_pitch
	
	# Apply rotations: Player rotates on Y axis (yaw), Camera rotates on X axis (pitch)
	# Reset head_pivot y rotation to 0 so camera pitch is independent
	head_pivot.rotation.y = 0.0
	player.rotation.y = _current_yaw
	rotation.x = _current_pitch
	
	# Reset input for next frame
	_yaw_input = 0.0
	_pitch_input = 0.0

## 🚶 Head Bob System
func _update_head_bob(delta: float) -> void:
	if not head_bob_enabled:
		return
	
	# Only bob when moving on ground
	if is_grounded and movement_speed > 0.1:
		# Calculate bob speed (faster when sprinting)
		var bob_speed: float = head_bob_speed
		if is_sprinting:
			bob_speed *= head_bob_sprint_multiplier
		
		# Update timer
		_head_bob_timer += bob_speed * delta
		
		# Calculate bob offset (sine wave for smooth motion)
		var bob_offset: float = sin(_head_bob_timer) * head_bob_amount
		
		# Apply to camera position (vertical only)
		position.y = bob_offset
	else:
		# Reset to neutral position
		position.y = lerp(position.y, 0.0, 10.0 * delta)

## 🎥 FOV Kick System
func _update_fov_kick(delta: float) -> void:
	if not fov_kick_enabled:
		return
	
	# Calculate target FOV
	var target_fov: float = base_fov
	if is_sprinting:
		target_fov += fov_kick_amount
	
	# Smoothly transition to target FOV
	var fov_diff: float = target_fov - _current_fov
	var fov_change: float = fov_kick_speed * delta
	
	if abs(fov_diff) < fov_change:
		_current_fov = target_fov
	else:
		_current_fov += sign(fov_diff) * fov_change
	
	# Apply FOV
	fov = _current_fov

## 🪂 Landing Dip System
func _update_landing_dip(delta: float) -> void:
	if not landing_dip_enabled:
		return
	
	# Trigger landing dip when player lands
	if just_landed:
		_landing_dip_offset = -landing_dip_amount
		_landing_dip_velocity = 0.0
		just_landed = false  # Reset flag
	
	# Smoothly recover from dip
	if abs(_landing_dip_offset) > 0.001:
		# Spring-like recovery
		var spring_force: float = -_landing_dip_offset * landing_dip_speed * landing_dip_speed
		var damping: float = -_landing_dip_velocity * landing_dip_speed * 0.5
		
		_landing_dip_velocity += (spring_force + damping) * delta
		_landing_dip_offset += _landing_dip_velocity * delta
		
		# Apply to camera position
		position.y += _landing_dip_offset
	else:
		_landing_dip_offset = 0.0
		_landing_dip_velocity = 0.0

## 📡 Camera Direction
func _emit_camera_direction() -> void:
	# Get forward and right vectors from camera
	var forward: Vector3 = -global_transform.basis.z
	var right: Vector3 = global_transform.basis.x
	
	# Flatten to horizontal plane (remove Y component)
	forward.y = 0.0
	right.y = 0.0
	
	# Normalize
	forward = forward.normalized()
	right = right.normalized()
	
	# Emit signal for player controller
	camera_direction_changed.emit(forward, right)

## 🔧 Public API for PlayerController

func get_forward_direction() -> Vector3:
	"""Returns the camera's forward direction (flattened to XZ plane)."""
	var forward: Vector3 = -global_transform.basis.z
	forward.y = 0.0
	return forward.normalized()

func get_right_direction() -> Vector3:
	"""Returns the camera's right direction (flattened to XZ plane)."""
	var right: Vector3 = global_transform.basis.x
	right.y = 0.0
	return right.normalized()

func set_player_state(sprinting: bool, grounded: bool, landed: bool, speed: float) -> void:
	"""Set player state from PlayerController."""
	is_sprinting = sprinting
	is_grounded = grounded
	just_landed = landed
	movement_speed = speed

func reset_camera() -> void:
	"""Reset camera to default state."""
	_current_yaw = 0.0
	_current_pitch = 0.0
	_target_yaw = 0.0
	_target_pitch = 0.0
	_current_fov = base_fov
	fov = base_fov
	_head_bob_timer = 0.0
	_landing_dip_offset = 0.0
	_landing_dip_velocity = 0.0
	position.y = 0.0
	head_pivot.rotation.y = 0.0
	player.rotation.y = 0.0
	rotation.x = 0.0
