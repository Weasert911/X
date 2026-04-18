class_name DynamicFOVSystem
extends Node

## Dynamic FOV & Motion Feedback System
## Smooth FOV changes with sprint, jump, and landing feedback

# ========================
# 🎛️ Configuration
# ========================

@export_group("Dynamic FOV")
@export var enabled: bool = true
@export var base_fov: float = 75.0
@export var sprint_fov_increase: float = 10.0
@export var fov_transition_speed: float = 5.0
@export var jump_fov_pulse: float = 2.0
@export var land_fov_pulse: float = 3.0
@export var pulse_decay_speed: float = 10.0

# ========================
# 🧠 Internal State
# ========================

var _current_fov: float = 75.0
var _fov_pulse: float = 0.0

# ========================
# 🎮 Public API
# ========================

func update(delta: float, sprinting: bool, jumped: bool, landed: bool) -> void:
	"""Update FOV based on player state."""
	if not enabled:
		return
	
	# Calculate base target FOV
	var target = base_fov
	if sprinting:
		target += sprint_fov_increase
	
	# Apply jump pulse
	if jumped:
		_fov_pulse = jump_fov_pulse
	
	# Apply landing pulse
	if landed:
		_fov_pulse = land_fov_pulse
	
	# Decay pulse
	if abs(_fov_pulse) > 0.01:
		_fov_pulse = lerp(_fov_pulse, 0.0, pulse_decay_speed * delta)
	else:
		_fov_pulse = 0.0
	
	# Add pulse to target
	target += _fov_pulse
	
	# Smooth transition
	_current_fov = lerp(_current_fov, target, fov_transition_speed * delta)

func get_fov() -> float:
	"""Get current FOV value."""
	if not enabled:
		return base_fov
	return _current_fov

func set_base_fov(fov: float) -> void:
	"""Set the base FOV value."""
	base_fov = fov
