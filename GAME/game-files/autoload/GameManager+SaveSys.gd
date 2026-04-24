extends Node

const SAVE_PATH = "user://save.json"

var current_level: String = ""
var player: Node3D = null

var checkpoint_transform: Transform3D = Transform3D.IDENTITY

func _ready():
	print("[GM] Initialized")

	await get_tree().process_frame

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

func load_level(path: String):
	current_level = path
	print("[GM] Loading:", path)
	get_tree().change_scene_to_file(path)

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
	var data = {
		"version": 1,  # Current schema version
		"level": get_tree().current_scene.scene_file_path,
		"checkpoint": {
			"position": {
				"x": checkpoint_transform.origin.x,
				"y": checkpoint_transform.origin.y,
				"z": checkpoint_transform.origin.z
			}
		}
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

	print("[GM] Loading game...")

	await load_level_async(current_level)

func load_level_async(path):
	await get_tree().process_frame
	get_tree().change_scene_to_file(path)
	await get_tree().process_frame
	await get_tree().process_frame

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