extends Node

const SAVE_PATH = "user://save.json"

var weapon_manager

var current_level: String = ""
var player: Node3D = null

var checkpoint_transform: Transform3D = Transform3D.IDENTITY
var pending_weapon_data = {}

func register_weapon_manager(wm):
	weapon_manager = wm
	print("[GM] WeaponManager registered safely")

func _refresh_weapon_manager():
	await get_tree().process_frame
	weapon_manager = get_tree().get_first_node_in_group("weapon_manager")
	if weapon_manager:
		print("[GM] WeaponManager refreshed")
		return
	# If still null, wait another frame
	await get_tree().process_frame
	weapon_manager = get_tree().get_first_node_in_group("weapon_manager")
	if weapon_manager:
		print("[GM] WeaponManager refreshed after retry")
	else:
		print("[GM] WARNING: WeaponManager not found in group")

func _ready():
	print("[GM] Initialized")
	add_to_group("game_manager")
	await _refresh_weapon_manager()

	if FileAccess.file_exists(SAVE_PATH):
		print("[GM] Save found → loading")
		load_game()
	else:
		print("[GM] No save → normal spawn")
		respawn_player()

func get_player():
	if player == null:
		var players = get_tree().get_nodes_in_group("player")
		if players.size() > 0:
			player = players[0]
			print("[GM] Player registered")
	return player

func reload_level():
	if current_level == "":
		current_level = get_tree().current_scene.scene_file_path
	
	print("[GM] Reloading:", current_level)
	get_tree().change_scene_to_file(current_level)
	call_deferred("_refresh_weapon_manager")

func load_level(path: String):
	current_level = path
	print("[GM] Loading:", path)
	get_tree().change_scene_to_file(path)
	call_deferred("_refresh_weapon_manager")

func set_checkpoint_from_area(area: Area3D):
	var markers = get_tree().get_nodes_in_group("checkpoint_marker")
	
	if markers.is_empty():
		print("[GM] No checkpoint markers found")
		return

	var closest_marker: Marker3D = null
	var min_dist = INF

	for m in markers:
		var dist = m.global_transform.origin.distance_to(area.global_transform.origin)
		if dist < min_dist:
			min_dist = dist
			closest_marker = m

	if closest_marker:
		checkpoint_transform = closest_marker.global_transform
		print("[GM] Checkpoint set:", checkpoint_transform.origin)
		save_game()

func respawn_player():
	var p = get_player()
	if p == null:
		print("[GM] No player found")
		return

	if checkpoint_transform == Transform3D.IDENTITY:
		print("[GM] No checkpoint, using spawn")
		var spawns = get_tree().get_nodes_in_group("spawn")
		if spawns.size() > 0:
			p.global_transform = spawns[0].global_transform
	else:
		p.global_transform = checkpoint_transform

	print("[GM] Player respawned")

func save_game():
	if weapon_manager == null:
		weapon_manager = get_tree().get_first_node_in_group("weapon_manager")
	
	var weapon_data = {}
	if weapon_manager:
		weapon_data = weapon_manager.get_save_data()
	else:
		push_error("WeaponManager still null - cannot save weapons")
		# Continue saving without weapon data
	
	var data = {
		"version": 1,
		"level": get_tree().current_scene.scene_file_path,
		"checkpoint": {
			"position": {
				"x": checkpoint_transform.origin.x,
				"y": checkpoint_transform.origin.y,
				"z": checkpoint_transform.origin.z
			}
		},
		"weapons": weapon_data
	}

	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	print("[GM] Game Saved")

func load_game():
	if not FileAccess.file_exists(SAVE_PATH):
		print("[GM] No save file")
		return

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	if data == null:
		print("[GM] Save corrupted - deleting")
		delete_save()
		respawn_player()
		return
	current_level = data["level"]

	if data.get("version", 0) != 1:
		print("[GM] Save version mismatch - deleting outdated save")
		delete_save()
		respawn_player()
		return

	var checkpoint = data["checkpoint"]
	var p = checkpoint["position"]
	var origin = Vector3(p["x"], p["y"], p["z"])

	checkpoint_transform = Transform3D(Basis.IDENTITY, origin)

	pending_weapon_data = data.get("weapons", {})

	print("[GM] Loading game...")

	await load_level_async(current_level)

func load_level_async(path):
	await get_tree().process_frame
	get_tree().change_scene_to_file(path)
	await get_tree().process_frame
	await get_tree().process_frame

	# 🔥 re-fetch AFTER scene is ready
	_refresh_weapon_manager()

	# If still null, wait a bit more (max 5 frames)
	var attempts = 0
	while weapon_manager == null and attempts < 5:
		await get_tree().process_frame
		weapon_manager = get_tree().get_first_node_in_group("weapon_manager")
		attempts += 1

	if weapon_manager:
		weapon_manager.load_from_save(pending_weapon_data)
		pending_weapon_data = {}  # clear after applying
	else:
		print("[GM] ERROR: WeaponManager not found after load")

	respawn_player()
	print("[GM] Load complete")

func delete_save():
	var dir = DirAccess.open("user://")
	if dir:
		dir.remove(SAVE_PATH)
		print("[GM] Deleted outdated save file")

func debug_print():
	print("==== GM DEBUG ====")
	print("Level:", current_level)
	print("Player:", get_player())
	print("Checkpoint:", checkpoint_transform.origin)
	print("==================")
