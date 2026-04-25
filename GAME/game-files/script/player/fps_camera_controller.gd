extends Camera3D
class_name FPSCameraController

@export_group("Mouse Look")
@export var mouse_sensitivity: float = 0.002
@export var pitch_min: float = -80.0
@export var pitch_max: float = 80.0
@export var enable_smoothing: bool = false
@export var smoothing_speed: float = 10.0

@export_group("FOV")
@export var base_fov: float = 75.0
@export var fov_kick_enabled: bool = true
@export var fov_kick_amount: float = 10.0
@export var fov_kick_speed: float = 5.0

@export_group("Head Bob")
@export var head_bob_enabled: bool = true
@export var head_bob_speed: float = 12.0
@export var head_bob_amount: float = 0.05
@export var head_bob_sprint_multiplier: float = 1.5

@export_group("Landing")
@export var landing_dip_enabled: bool = true
@export var landing_dip_amount: float = 0.1
@export var landing_dip_speed: float = 8.0

@onready var head_pivot: Node3D = get_parent()
@onready var player: CharacterBody3D = head_pivot.get_parent()
@onready var camera_effects_manager: CameraEffectsManager = get_node_or_null("../CameraEffectsManager")

var _yaw_input: float = 0.0
var _pitch_input: float = 0.0
var _current_yaw: float = 0.0
var _current_pitch: float = 0.0
var _target_yaw: float = 0.0
var _target_pitch: float = 0.0

var _head_bob_timer: float = 0.0
var _current_fov: float = 75.0
var _landing_dip_offset: float = 0.0
var _landing_dip_velocity: float = 0.0

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
	
	if camera_effects_manager:
		var effects = camera_effects_manager.get_effects(delta)
		position = effects.position_offset
		rotation += effects.rotation_offset
		fov = effects.fov
	else:
		_update_head_bob(delta)
		_update_fov_kick(delta)
		_update_landing_dip(delta)
	
	_emit_camera_direction()

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
	rotation.x = _current_pitch
	
	_yaw_input = 0.0
	_pitch_input = 0.0

func _update_head_bob(delta: float) -> void:
	if not head_bob_enabled:
		return
	
	if is_grounded and movement_speed > 0.1:
		var bob_speed: float = head_bob_speed
		if is_sprinting:
			bob_speed *= head_bob_sprint_multiplier
		
		_head_bob_timer += bob_speed * delta
		
		var bob_offset: float = sin(_head_bob_timer) * head_bob_amount
		
		position.y = bob_offset
	else:
		position.y = lerp(position.y, 0.0, 10.0 * delta)

func _update_fov_kick(delta: float) -> void:
	if not fov_kick_enabled:
		return
	
	var target_fov: float = base_fov
	if is_sprinting:
		target_fov += fov_kick_amount
	
	var fov_diff: float = target_fov - _current_fov
	var fov_change: float = fov_kick_speed * delta
	
	if abs(fov_diff) < fov_change:
		_current_fov = target_fov
	else:
		_current_fov += sign(fov_diff) * fov_change
	
	fov = _current_fov

func _update_landing_dip(delta: float) -> void:
	if not landing_dip_enabled:
		return
	
	if just_landed:
		_landing_dip_offset = -landing_dip_amount
		_landing_dip_velocity = 0.0
		just_landed = false
	
	if abs(_landing_dip_offset) > 0.001:
		var spring_force: float = -_landing_dip_offset * landing_dip_speed * landing_dip_speed
		var damping: float = -_landing_dip_velocity * landing_dip_speed * 0.5
		
		_landing_dip_velocity += (spring_force + damping) * delta
		_landing_dip_offset += _landing_dip_velocity * delta
		
		position.y += _landing_dip_offset
	else:
		_landing_dip_offset = 0.0
		_landing_dip_velocity = 0.0

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

func set_player_state(sprinting: bool, grounded: bool, landed: bool, speed: float) -> void:
	is_sprinting = sprinting
	is_grounded = grounded
	just_landed = landed
	movement_speed = speed

func reset_camera() -> void:
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
