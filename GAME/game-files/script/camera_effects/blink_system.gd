class_name BlinkSystem
extends Node

## Eye Blinking System
## Random interval eye blinking for natural feel

# ========================
# 🎛️ Configuration
# ========================

@export_group("Blinking")
@export var enabled: bool = true
@export var blink_interval_min: float = 2.0
@export var blink_interval_max: float = 6.0
@export var blink_duration: float = 0.15
@export var idle_blink_multiplier: float = 1.5
@export var implementation_mode: int = 0  # 0=UI overlay, 1=FOV dip, 2=Exposure dip

# ========================
# 🧠 Internal State
# ========================

var _blink_timer: float = 0.0
var _is_blinking: bool = false
var _blink_progress: float = 0.0
var _is_idle: bool = false

# ========================
# 🎮 Public API
# ========================

signal blink_started
signal blink_ended

func update(delta: float) -> void:
	"""Update blinking system."""
	if not enabled:
		return
	
	# Update timer
	_blink_timer -= delta
	
	# Check if time to blink
	if _blink_timer <= 0.0:
		_start_blink()
	
	# Update blink progress
	if _is_blinking:
		_blink_progress += delta / blink_duration
		
		if _blink_progress >= 1.0:
			_end_blink()

func get_alpha() -> float:
	"""Get current blink alpha (0.0 = open, 1.0 = closed)."""
	if not enabled or not _is_blinking:
		return 0.0
	
	# Smooth curve: quick close, quick open
	var t = _blink_progress
	return smoothstep(0.0, 0.3, t) * (1.0 - smoothstep(0.7, 1.0, t))

func set_idle_state(is_idle: bool) -> void:
	"""Set whether player is idle (affects blink interval)."""
	_is_idle = is_idle

func _start_blink() -> void:
	"""Start a new blink."""
	_is_blinking = true
	_blink_progress = 0.0
	blink_started.emit()
	
	# Schedule next blink
	var interval = randf_range(blink_interval_min, blink_interval_max)
	if _is_idle:
		interval *= idle_blink_multiplier
	_blink_timer = interval

func _end_blink() -> void:
	"""End current blink."""
	_is_blinking = false
	_blink_progress = 0.0
	blink_ended.emit()
