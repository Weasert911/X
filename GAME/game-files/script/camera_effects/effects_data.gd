class_name EffectsData
extends RefCounted

var position_offset: Vector3 = Vector3.ZERO
var rotation_offset: Vector3 = Vector3.ZERO
var fov: float = 75.0
var blink_alpha: float = 0.0

func _init(p_offset: Vector3 = Vector3.ZERO, r_offset: Vector3 = Vector3.ZERO, f: float = 75.0, blink: float = 0.0):
	position_offset = p_offset
	rotation_offset = r_offset
	fov = f
	blink_alpha = blink