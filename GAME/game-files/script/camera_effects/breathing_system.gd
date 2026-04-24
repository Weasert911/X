class_name BreathingSystem
extends Node

@export_group("Breathing")
@export var enabled: bool = true
@export var idle_breath_amount: float = 0.003
@export var idle_breath_speed: float = 0.25
@export var sprint_breath_amount: float = 0.008
@export var sprint_breath_speed: float = 0.5
@export var transition_speed: float = 2.0

var _breath_timer: float = 0.0
var _current_amount: float = 0.003
var _current_speed: float = 0.25

func update(delta: float, sprinting: bool) -> void:
	if not enabled:
		return
	
	var target_amount = idle_breath_amount
	var target_speed = idle_breath_speed
	
	if sprinting:
		target_amount = sprint_breath_amount
		target_speed = sprint_breath_speed
	
	_current_amount = lerp(_current_amount, target_amount, transition_speed * delta)
	_current_speed = lerp(_current_speed, target_speed, transition_speed * delta)
	
	_breath_timer += _current_speed * delta

func get_offset() -> Vector3:
	if not enabled:
		return Vector3.ZERO
	
	return Vector3(0.0, sin(_breath_timer) * _current_amount, 0.0)