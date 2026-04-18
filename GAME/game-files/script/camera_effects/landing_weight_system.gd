class_name LandingWeightSystem
extends Node

## Landing & Movement Weight System
## Impact feedback, sprint lean, and strafe tilt

# ========================
# 🎛️ Configuration
# ========================

@export_group("Landing & Weight")
@export var enabled: bool = true
@export var landing_dip_amount: float = 0.1
@export var landing_dip_speed: float = 8.0
@export var landing_dip_damping: float = 0.5
@export var sprint_lean_amount: float = 0.02
@export var sprint_lean_speed: float = 3.0
@export var strafe_tilt_amount: float = 0.02
@export var strafe_tilt_speed: float = 5.0

# ========================
# 🧠 Internal State
# ========================

var _landing_dip_offset: float = 0.0
var _landing_dip_velocity: float = 0.0
var _current_lean: float = 0.0
var _current_tilt: float = 0.0

# ========================
# 🎮 Public API
# ========================

func update(delta: float, landed: bool, accel: float, strafe_left: bool, strafe_right: bool, sprinting: bool) -> void:
	"""Update landing and weight effects."""
	if not enabled:
		return
	
	# Update landing dip
	_update_landing_dip(delta, landed)
	
	# Update sprint lean
	_update_sprint_lean(delta, sprinting)
	
	# Update strafe tilt
	_update_strafe_tilt(delta, strafe_left, strafe_right)

func get_offset() -> Vector3:
	"""Get current landing and lean offset."""
	if not enabled:
		return Vector3.ZERO
	return Vector3(0.0, _landing_dip_offset, _current_lean)

func get_tilt() -> float:
	"""Get current strafe tilt angle."""
	if not enabled:
		return 0.0
	return _current_tilt

func _update_landing_dip(delta: float, landed: bool) -> void:
	"""Update landing dip with spring physics."""
	# Trigger landing dip
	if landed:
		_landing_dip_offset = -landing_dip_amount
		_landing_dip_velocity = 0.0
	
	# Spring recovery
	if abs(_landing_dip_offset) > 0.001:
		var spring_force = -_landing_dip_offset * landing_dip_speed * landing_dip_speed
		var damping = -_landing_dip_velocity * landing_dip_speed * landing_dip_damping
		
		_landing_dip_velocity += (spring_force + damping) * delta
		_landing_dip_offset += _landing_dip_velocity * delta
	else:
		_landing_dip_offset = 0.0
		_landing_dip_velocity = 0.0

func _update_sprint_lean(delta: float, sprinting: bool) -> void:
	"""Update forward lean when sprinting."""
	# Calculate target lean
	var target_lean = 0.0
	if sprinting:
		target_lean = sprint_lean_amount
	
	# Smooth transition
	_current_lean = lerp(_current_lean, target_lean, sprint_lean_speed * delta)

func _update_strafe_tilt(delta: float, strafe_left: bool, strafe_right: bool) -> void:
	"""Update camera tilt when strafing."""
	# Disable strafe tilt to prevent A/D rotation
	_current_tilt = lerp(_current_tilt, 0.0, strafe_tilt_speed * delta)
