class_name MicroMotionSystem
extends Node

@export_group("Micro Motion")
@export var enabled: bool = true
@export var position_noise_scale: float = 0.002
@export var rotation_noise_scale: float = 0.0005
@export var noise_speed: float = 1.0
@export var aiming_reduction: float = 0.1
@export var movement_multiplier: float = 2.0
@export var noise_seed: int = 12345

var _noise_time: float = 0.0
var _rng: RandomNumberGenerator

func _ready() -> void:
	_rng = RandomNumberGenerator.new()
	_rng.seed = noise_seed

func update(delta: float, speed: float, aiming: bool) -> void:
	if not enabled:
		return
	
	_noise_time += noise_speed * delta

func get_offset() -> Vector3:
	if not enabled:
		return Vector3.ZERO
	
	var noise_x = sin(_noise_time) * 0.5 + sin(_noise_time * 2.3) * 0.3 + sin(_noise_time * 4.7) * 0.2
	var noise_y = cos(_noise_time * 1.1) * 0.5 + cos(_noise_time * 2.7) * 0.3 + cos(_noise_time * 5.3) * 0.2
	var noise_z = sin(_noise_time * 0.9) * 0.5 + sin(_noise_time * 2.1) * 0.3 + sin(_noise_time * 4.9) * 0.2
	
	var scale = position_noise_scale
	if is_aiming:
		scale *= aiming_reduction
	elif movement_speed > 0.1:
		scale *= movement_multiplier
	
	return Vector3(noise_x, noise_y, noise_z) * scale

func get_rotation() -> Vector3:
	if not enabled:
		return Vector3.ZERO
	
	var rot_noise_x = cos(_noise_time * 1.3) * 0.5 + cos(_noise_time * 2.9) * 0.3 + cos(_noise_time * 5.1) * 0.2
	var rot_noise_y = sin(_noise_time * 0.7) * 0.5 + sin(_noise_time * 2.5) * 0.3 + sin(_noise_time * 4.3) * 0.2
	var rot_noise_z = cos(_noise_time * 1.5) * 0.5 + cos(_noise_time * 3.1) * 0.3 + cos(_noise_time * 5.7) * 0.2
	
	var rot_scale = rotation_noise_scale
	if is_aiming:
		rot_scale *= aiming_reduction
	elif movement_speed > 0.1:
		rot_scale *= movement_multiplier
	
	return Vector3(rot_noise_x, rot_noise_y, rot_noise_z) * rot_scale

var is_aiming: bool = false
var movement_speed: float = 0.0
