extends Camera3D

@export var horizontal_offset: float = 0.0
@export var vertical_offset: float = 2.0
@export var depth_offset: float = 10.0
@export var camera_on_right_side: bool = true

@export var framing_offset_x: float = 0.5

@export var follow_speed_x: float = 5.0
@export var follow_speed_y: float = 4.0
@export var follow_speed_z: float = 5.0

@export var movement_direction_offset: float = 0.3
@export var movement_direction_smoothing: float = 5.0

@export var camera_angle_degrees: float = -10.0

var target_player: CharacterBody3D
var current_direction_offset: float = 0.0

func _ready() -> void:
	_find_player()
	rotation_degrees.x = camera_angle_degrees
	rotation_degrees.y = 0.0
	rotation_degrees.z = 0.0

func _find_player() -> void:
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		target_player = players[0]
	else:
		for node in get_tree().get_nodes_in_group("*"):
			if node is CharacterBody3D:
				target_player = node
				break

func _process(delta: float) -> void:
	if not target_player:
		_find_player()
		if not target_player:
			return
	
	var player_pos: Vector3 = target_player.global_position
	var target_position: Vector3 = Vector3.ZERO
	
	target_position.x = player_pos.x + framing_offset_x
	target_position.y = player_pos.y + vertical_offset
	
	if camera_on_right_side:
		target_position.z = player_pos.z + depth_offset + horizontal_offset
	else:
		target_position.z = player_pos.z - depth_offset + horizontal_offset
	
	if target_player.has_method("get_last_movement_direction"):
		var direction: float = target_player.get_last_movement_direction()
		current_direction_offset = lerp(current_direction_offset, direction * movement_direction_offset, movement_direction_smoothing * delta)
		target_position.x += current_direction_offset
	
	global_position.x = lerp(global_position.x, target_position.x, follow_speed_x * delta)
	global_position.y = lerp(global_position.y, target_position.y, follow_speed_y * delta)
	global_position.z = lerp(global_position.z, target_position.z, follow_speed_z * delta)
	
	var look_target: Vector3 = player_pos + Vector3(0, 1.0, 0)
	look_at(look_target, Vector3.UP)
	
	rotation_degrees.x += camera_angle_degrees
