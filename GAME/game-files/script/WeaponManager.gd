extends Node

signal weapon_state_changed(data)

var current_weapon
var previous_weapon

var inventory = {} # gun_id -> weapon instance

@export var weapon_holder: Node3D
@export var weapon_scenes: Dictionary # gun_id -> PackedScene
@export var weapon_datas: Dictionary # gun_id -> WeaponData

func _ready() -> void:
	add_to_group("weapon_manager")
	get_tree().call_group("game_manager", "register_weapon_manager", self)

func add_weapon(gun_id: String):
	if inventory.has(gun_id):
		return

	if weapon_scenes == null or not weapon_scenes.has(gun_id):
		print("Weapon scene missing for id:", gun_id)
		return

	if weapon_datas == null or not weapon_datas.has(gun_id):
		print("Weapon data missing for id:", gun_id)
		return

	var weapon_scene = weapon_scenes[gun_id]
	var weapon = weapon_scene.instantiate()

	weapon_holder.add_child(weapon)

	weapon.setup(weapon_datas[gun_id])

	inventory[gun_id] = weapon

	equip_weapon(gun_id)

func equip_weapon(gun_id: String):
	if not inventory.has(gun_id):
		return
	
	if current_weapon:
		current_weapon.visible = false
		previous_weapon = current_weapon
	
	current_weapon = inventory[gun_id]
	current_weapon.visible = true
	
	current_weapon.play_draw()
	
	emit_signal("weapon_state_changed", get_save_data())

func shoot():
	if current_weapon:
		current_weapon.shoot()

func reload():
	if current_weapon:
		current_weapon.reload()

func get_save_data():
	print("[WM] SAVE DEBUG")
	print("current_weapon:", current_weapon)
	if current_weapon:
		print("weapon id:", current_weapon.data.gun_id if current_weapon.data else "NO DATA")
	print("inventory keys:", inventory.keys())
	
	var inv = {}
	
	for id in inventory:
		var w = inventory[id]
		inv[id] = {
			"ammo_in_mag": w.ammo_in_mag,
			"mags_left": w.mags_left
		}
	
	var current_id = ""
	if current_weapon != null and current_weapon.data != null:
		current_id = current_weapon.data.gun_id
	
	return {
		"current_weapon_id": current_id,
		"inventory": inv
	}

func load_from_save(data):
	if data.is_empty():
		return
	
	print("[WM] LOAD FROM SAVE data:", data)
	
	for id in data["inventory"]:
		add_weapon(id)
		
		var w = inventory[id]
		var saved = data["inventory"][id]
		
		w.ammo_in_mag = saved["ammo_in_mag"]
		w.mags_left = saved["mags_left"]
	
	var current_id = data.get("current_weapon_id", "")
	if current_id != "" and inventory.has(current_id):
		equip_weapon(current_id)
	else:
		print("[WM] WARNING: Cannot equip saved weapon ID: ", current_id)
