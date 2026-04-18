class_name LandingWeightSystem
extends Node

@export_group("Landing & Weight")
@export var enabled: bool = true
@export var landing_dip_amount: float = 0.1
@export var landing_dip_speed: float = 8.0
@export var landing_dip_damping: float = 0.5
@export var sprint_lean_amount: float = 0.02
@export var sprint_lean_speed: float = 3.0
@export var strafe_tilt_amount: float = 0.02
@export var strafe_tilt_speed: float = 5.0

var _landing_dip_offset: float = 0.0
var _landing_dip_velocity: float = 0.0
var _current_lean: float = 0.0
var _current_tilt: float = 0.0

func update(delta: float, landed: bool, accel: float, strafe_left: bool, strafe_right: bool, sprinting: bool) -> void:
	if not enabled:
		return
	
	_update_landing_dip(delta, landed)
	
	_update_sprint_lean(delta, sprinting)
	
	_update_strafe_tilt(delta, strafe_left, strafe_right)

func get_offset() -> Vector3:
	if not enabled:
		return Vector3.ZERO
	return Vector3(0.0, _landing_dip_offset, _current_lean)

func get_tilt() -> float:
	if not enabled:
		return 0.0
	return _current_tilt

func _update_landing_dip(delta: float, landed: bool) -> void:
	if landed:
		_landing_dip_offset = -landing_dip_amount
		_landing_dip_velocity = 0.0
	
	if abs(_landing_dip_offset) > 0.001:
		var spring_force = -_landing_dip_offset * landing_dip_speed * landing_dip_speed
		var damping = -_landing_dip_velocity * landing_dip_speed * landing_dip_damping
		
		_landing_dip_velocity += (spring_force + damping) * delta
		_landing_dip_offset += _landing_dip_velocity * delta
	else:
		_landing_dip_offset = 0.0
		_landing_dip_velocity = 0.0

func _update_sprint_lean(delta: float, sprinting: bool) -> void:
	var target_lean = 0.0
	if sprinting:
		target_lean = sprint_lean_amount
	
	_current_lean = lerp(_current_lean, target_lean, sprint_lean_speed * delta)

func _update_strafe_tilt(delta: float, strafe_left: bool, strafe_right: bool) -> void:
	_current_tilt = lerp(_current_tilt, 0.0, strafe_tilt_speed * delta)
