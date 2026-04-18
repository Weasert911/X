class_name BlinkSystem
extends Node

@export_group("Blinking")
@export var enabled: bool = true
@export var blink_interval_min: float = 2.0
@export var blink_interval_max: float = 6.0
@export var blink_duration: float = 0.15
@export var idle_blink_multiplier: float = 1.5
@export var implementation_mode: int = 0

var _blink_timer: float = 0.0
var _is_blinking: bool = false
var _blink_progress: float = 0.0
var _is_idle: bool = false

signal blink_started
signal blink_ended

func update(delta: float) -> void:
	if not enabled:
		return
	
	_blink_timer -= delta
	
	if _blink_timer <= 0.0:
		_start_blink()
	
	if _is_blinking:
		_blink_progress += delta / blink_duration
		
		if _blink_progress >= 1.0:
			_end_blink()

func get_alpha() -> float:
	if not enabled or not _is_blinking:
		return 0.0
	
	var t = _blink_progress
	return smoothstep(0.0, 0.3, t) * (1.0 - smoothstep(0.7, 1.0, t))

func set_idle_state(is_idle: bool) -> void:
	_is_idle = is_idle

func _start_blink() -> void:
	_is_blinking = true
	_blink_progress = 0.0
	blink_started.emit()
	
	var interval = randf_range(blink_interval_min, blink_interval_max)
	if _is_idle:
		interval *= idle_blink_multiplier
	_blink_timer = interval

func _end_blink() -> void:
	_is_blinking = false
	_blink_progress = 0.0
	blink_ended.emit()
