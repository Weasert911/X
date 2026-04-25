extends Node3D

@export var data: WeaponData

var ammo_in_mag: int
var mags_left: int
@onready var camera: Camera3D = get_tree().get_first_node_in_group("player_camera")

var can_shoot := true

func setup(_data: WeaponData):
	data = _data
	ammo_in_mag = data.mag_size
	mags_left = data.max_mags
func apply_recoil(recoil_value: float):
	if camera == null:
		return

	camera.rotation_degrees.x -= recoil_value
	camera.rotation_degrees.y += randf_range(-recoil_value, recoil_value)
	
func shoot():
	if not can_shoot:
		return
	
	if ammo_in_mag <= 0:
		reload()
		return
	
	ammo_in_mag -= 1
	
	# Raycast hit
	var space = get_world_3d().direct_space_state

	var from = camera.global_transform.origin
	var to = from + (-camera.global_transform.basis.z * 1000)

	var query = PhysicsRayQueryParameters3D.create(from, to)

	query.collide_with_areas = true
	query.collide_with_bodies = true

	var result = space.intersect_ray(query)

	if result:
		print("Hit:", result.collider)

	play_shoot_fx()
	apply_recoil(data.recoil)

func reload():
	if mags_left <= 0 or ammo_in_mag == data.mag_size:
		return
	
	can_shoot = false
	
	await get_tree().create_timer(data.reload_time).timeout
	
	mags_left -= 1
	ammo_in_mag = data.mag_size
	
	can_shoot = true

func play_shoot_fx():
	$AnimationPlayer.play("Rig|KDW_Shot")

func play_draw():
	$AnimationPlayer.play("Rig|KDW_Draw")
