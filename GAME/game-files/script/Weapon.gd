extends Node3D

@export var data: WeaponData
@export var kick_back: float = 0.06
@export var kick_up: float = 4.0

var ammo_in_mag: int
var mags_left: int
@onready var camera: Camera3D = get_tree().get_first_node_in_group("player_camera")
@onready var weapon_model: Node3D = $Sketchfab_model
@onready var crosshair: Control = get_tree().get_first_node_in_group("crosshair")
@onready var hit_feedback: Control = get_tree().get_first_node_in_group("hit_feedback")
var impact_scene = preload("res://scene/effects/impact_particles.tscn")

var can_shoot := true
var shoot_timer: float = 0.0

func _physics_process(delta: float) -> void:
	if shoot_timer > 0.0:
		shoot_timer -= delta

func can_fire() -> bool:
	return shoot_timer <= 0.0 and can_shoot

func try_shoot() -> void:
	if can_fire():
		shoot()

func setup(_data: WeaponData):
	data = _data
	ammo_in_mag = data.mag_size
	mags_left = data.max_mags

func apply_recoil(vertical: float, horizontal_range: float):
	if camera == null:
		return

	if camera.has_method("add_recoil"):
		var horizontal := randf_range(-horizontal_range, horizontal_range)
		camera.add_recoil(vertical, horizontal)

	if camera.has_method("add_kick"):
		camera.add_kick()

func shoot():
	if not can_shoot:
		return
	
	if ammo_in_mag <= 0:
		reload()
		return
	
	ammo_in_mag -= 1
	shoot_timer = data.fire_rate
	
	fire_bullet()
	apply_recoil(data.recoil_vertical, data.recoil_horizontal)
	camera.add_kick()
	play_kick()
	if crosshair:
		crosshair.on_shoot()
	play_shoot_fx()

func fire_bullet():
	var space = get_world_3d().direct_space_state

	var from = camera.global_transform.origin
	var forward = -camera.global_transform.basis.z
	
	var spread_strength = data.spread
	var spread_x = randf_range(-spread_strength, spread_strength) * 0.01
	var spread_y = randf_range(-spread_strength, spread_strength) * 0.01
	
	var direction = (forward + Vector3(spread_x, spread_y, 0)).normalized()
	var to = from + direction * 1000

	var query = PhysicsRayQueryParameters3D.create(from, to)

	query.collide_with_areas = true
	query.collide_with_bodies = true

	var result = space.intersect_ray(query)

	if result:
		print("Hit:", result.collider)
		
		# Spawn impact particles
		var impact = impact_scene.instantiate()
		get_tree().root.add_child(impact)
		impact.global_transform.origin = result.position
		
		# If the collider is an enemy, damage it
		if result.collider.has_method("take_damage"):
			result.collider.take_damage(data.damage)
			
		# Show hit feedback
		if hit_feedback:
			hit_feedback.show_hit()

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

var base_position: Vector3

func _ready():
	base_position = weapon_model.position

func play_kick():
	var tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(weapon_model, "position", base_position + Vector3(0, kick_up, -kick_back), 0.1)
	tween.tween_property(weapon_model, "position", base_position, 0.2)
