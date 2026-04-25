extends Camera3D
class_name FPSCameraController

@export_group("Mouse Look")
@export var mouse_sensitivity: float = 0.002
@export var pitch_min: float = -80.0
@export var pitch_max: float = 80.0
@export var enable_smoothing: bool = false
@export var smoothing_speed: float = 10.0

@export_group("Camera Settings")
@export var base_fov: float = 75.0
@export var fov_smoothing: float = 0.15

@onready var head_pivot: Node3D = get_parent()
@onready var player: CharacterBody3D = head_pivot.get_parent()
@onready var camera_effects_manager: CameraEffectsManager = get_node_or_null("../CameraEffectsManager")
@onready var blink_overlay: ColorRect = get_node_or_null("../UI/BlinkOverlay") # Make sure this node exists in the player scene

var _yaw_input: float = 0.0
var _pitch_input: float = 0.0
var _current_yaw: float = 0.0
var _current_pitch: float = 0.0
var _target_yaw: float = 0.0
var _target_pitch: float = 0.0
var recoil_offset: float = 0.0

var _current_fov: float = 75.0

var is_sprinting: bool = false
var is_grounded: bool = true
var just_landed: bool = false
var movement_speed: float = 0.0

signal camera_direction_changed(forward: Vector3, right: Vector3)

func _ready() -> void:
	add_to_group("player_camera")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	_current_fov = base_fov
	fov = _current_fov
	
	_current_yaw = player.rotation.y
	_current_pitch = rotation.x
	_target_yaw = _current_yaw
	_target_pitch = _current_pitch
	
	head_pivot.rotation.y = 0.0

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_yaw_input = -event.relative.x * mouse_sensitivity
		_pitch_input = -event.relative.y * mouse_sensitivity
	
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif event is InputEventMouseButton and event.pressed:
		if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta: float) -> void:
	_handle_mouse_look(delta)
	
	var effects_offset := Vector3.ZERO
	var effects_rotation := Vector3.ZERO
	var effects_fov := base_fov
	var blink_alpha := 0.0
	
	if camera_effects_manager:
		var effects = camera_effects_manager.get_effects(delta)
		effects_offset = effects.position_offset
		effects_rotation = effects.rotation_offset
		effects_fov = effects.fov
		blink_alpha = effects.blink_alpha
	
	# Set camera position relative to head pivot
	global_position = head_pivot.global_position + effects_offset
	
	# Apply rotations additively
	rotation.x = _current_pitch + recoil_offset + effects_rotation.x
	rotation.y = 0.0  # Y rotation is handled by the head pivot
	rotation.z = effects_rotation.z  # Apply tilt effects
	
	# Apply FOV changes
	_current_fov = lerp(_current_fov, effects_fov, fov_smoothing)
	fov = _current_fov
	
	# Apply blink effect
	if blink_overlay:
		blink_overlay.modulate.a = blink_alpha
	
	_emit_camera_direction()
	
	# Decay recoil
	recoil_offset = lerp(recoil_offset, 0.0, 10.0 * delta)

func _handle_mouse_look(delta: float) -> void:
	_target_yaw += _yaw_input
	_target_pitch += _pitch_input
	
	_target_pitch = clamp(_target_pitch, deg_to_rad(pitch_min), deg_to_rad(pitch_max))
	
	if enable_smoothing:
		var smooth_factor: float = smoothing_speed * delta
		_current_yaw = lerp_angle(_current_yaw, _target_yaw, smooth_factor)
		_current_pitch = lerp_angle(_current_pitch, _target_pitch, smooth_factor)
	else:
		_current_yaw = _target_yaw
		_current_pitch = _target_pitch
	
	head_pivot.rotation.y = 0.0
	player.rotation.y = _current_yaw
	# Pitch is now handled in _process with additive effects
	
	_yaw_input = 0.0
	_pitch_input = 0.0


func _emit_camera_direction() -> void:
	var forward: Vector3 = -global_transform.basis.z
	var right: Vector3 = global_transform.basis.x
	
	forward.y = 0.0
	right.y = 0.0
	
	forward = forward.normalized()
	right = right.normalized()
	
	camera_direction_changed.emit(forward, right)

func get_forward_direction() -> Vector3:
	var forward: Vector3 = -global_transform.basis.z
	forward.y = 0.0
	return forward.normalized()

func get_right_direction() -> Vector3:
	var right: Vector3 = global_transform.basis.x
	right.y = 0.0
	return right.normalized()


func add_recoil(amount: float) -> void:
	recoil_offset -= amount

func reset_camera() -> void:
	# Preserve current player yaw to avoid camera snapping
	_current_yaw = player.rotation.y
	_target_yaw = _current_yaw
	
	# Reset pitch and other camera properties
	_current_pitch = 0.0
	_target_pitch = 0.0
	
	recoil_offset = 0.0
	
	_current_fov = base_fov
	fov = base_fov
	
	# Reset base position and rotation
	position = Vector3.ZERO
	rotation = Vector3.ZERO
