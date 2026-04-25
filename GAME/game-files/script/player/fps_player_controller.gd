extends CharacterBody3D
class_name FPSPlayerController

@export_group("Movement")
@export var walk_speed: float = 5.0
@export var sprint_speed: float = 8.0
@export var acceleration: float = 15.0

@export_group("Player Stats")
@export var health: int = 100
@export var ammo: int = 30
@export var deceleration: float = 20.0
@export var air_acceleration: float = 5.0
@export var air_deceleration: float = 2.0
@export var ground_control: float = 1.0
@export var air_control: float = 0.3

@export_group("Jump & Gravity")
@export var jump_force: float = 8.0
@export var gravity: float = 20.0
@export var coyote_time: float = 0.15
@export var jump_buffer: float = 0.1

@export_group("Ground Detection")
@export var ground_check_distance: float = 0.1
@export var ground_check_offset: float = 0.05
@export var max_slope_angle: float = 45.0

@onready var weapon_manager = $WeaponManager

@onready var head_pivot: Node3D = $HeadPivot
@onready var camera_controller: FPSCameraController = $HeadPivot/Camera3D
@onready var camera_effects_manager: CameraEffectsManager = $HeadPivot/CameraEffectsManager
@onready var ray: RayCast3D = $HeadPivot/Camera3D/RayCast3D

var input_dir: Vector2 = Vector2.ZERO
var is_sprinting: bool = false
var was_on_floor: bool = true
var time_since_left_ground: float = 0.0
var jump_buffer_timer: float = 0.0
var just_landed: bool = false
var horizontal_velocity: Vector3 = Vector3.ZERO
var is_strafing_left: bool = false
var is_strafing_right: bool = false
var just_jumped: bool = false
var current_acceleration: float = 0.0
var previous_horizontal_velocity: Vector3 = Vector3.ZERO

var crosshair: CanvasLayer

func _get_movement_input() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_backward", "move_forward")

func _get_sprint_input() -> bool:
	return Input.is_action_pressed("sprint")

func _get_jump_input() -> bool:
	return Input.is_action_just_pressed("jump")

func _ready() -> void:
	add_to_group("player")
	
	ray.collision_mask = 1
	
	var crosshair_scene = preload("res://scene/crosshair.tscn")
	var crosshair_instance = crosshair_scene.instantiate()
	add_child(crosshair_instance)
	crosshair = crosshair_instance
	if not InputMap.has_action("shoot"):
		InputMap.add_action("shoot")
		var key_event = InputEventMouseButton.new()
		key_event.button_index = MOUSE_BUTTON_LEFT
		InputMap.action_add_event("shoot", key_event)

	if not InputMap.has_action("reload"):
		InputMap.add_action("reload")
		var key_event = InputEventKey.new()
		key_event.keycode = KEY_R
		InputMap.action_add_event("reload", key_event)

func _physics_process(delta: float) -> void:
	input_dir = _get_movement_input()
	is_sprinting = _get_sprint_input()
	
	_check_ground_state()
	
	_handle_jump()
	
	_apply_gravity(delta)
	
	_handle_movement(delta)
	
	move_and_slide()
	
	_update_movement_state(delta)
	
	_update_camera_state()
	
func _handle_movement(delta: float) -> void:
	var direction = Vector3.ZERO
	
	if input_dir != Vector2.ZERO:
		var forward = camera_controller.get_forward_direction()
		var right = camera_controller.get_right_direction()
		
		direction = (forward * input_dir.y + right * input_dir.x).normalized()
	
	var target_speed = walk_speed
	if is_sprinting:
		target_speed = sprint_speed
	
	var target_velocity = direction * target_speed
	
	var accel_rate = acceleration
	var decel_rate = deceleration
	var control_multiplier = ground_control
	
	if not is_on_floor():
		accel_rate = air_acceleration
		decel_rate = air_deceleration
		control_multiplier = air_control
	
	if direction != Vector3.ZERO:
		horizontal_velocity = horizontal_velocity.lerp(target_velocity, accel_rate * control_multiplier * delta)
	else:
		horizontal_velocity = horizontal_velocity.lerp(Vector3.ZERO, decel_rate * control_multiplier * delta)
	
	velocity.x = horizontal_velocity.x
	velocity.z = horizontal_velocity.z
	
	if abs(velocity.x) < 0.01: velocity.x = 0
	if abs(velocity.z) < 0.01: velocity.z = 0

func _handle_jump() -> void:
	var jump_pressed = _get_jump_input()
	
	if jump_pressed:
		jump_buffer_timer = jump_buffer
	
	var can_jump = is_on_floor() or (time_since_left_ground < coyote_time)
	
	if can_jump and jump_buffer_timer > 0:
		velocity.y = jump_force
		jump_buffer_timer = 0
		time_since_left_ground = coyote_time + 1
		just_jumped = true

func _apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		if velocity.y < 0:
			velocity.y = 0

func _check_ground_state() -> void:
	var currently_on_floor = is_on_floor()
	
	if not was_on_floor and currently_on_floor:
		just_landed = true
		time_since_left_ground = 0.0
	
	if not currently_on_floor:
		time_since_left_ground += get_physics_process_delta_time()
	
	was_on_floor = currently_on_floor

func _update_camera_state() -> void:
	var horizontal_speed = horizontal_velocity.length()
	
	camera_effects_manager.set_player_state(
		is_sprinting,
		is_on_floor(),
		just_landed,
		horizontal_speed,
		is_strafing_left,
		is_strafing_right,
		just_jumped,
		current_acceleration,
		false
	)
	
	just_landed = false
	just_jumped = false

func _update_movement_state(delta: float) -> void:
	current_acceleration = (horizontal_velocity - previous_horizontal_velocity).length() / delta
	previous_horizontal_velocity = horizontal_velocity
	
	is_strafing_left = input_dir.x < -0.5
	is_strafing_right = input_dir.x > 0.5

func get_horizontal_velocity() -> Vector3:
	return horizontal_velocity

func get_movement_speed() -> float:
	return horizontal_velocity.length()

func is_player_sprinting() -> bool:
	return is_sprinting

func is_player_grounded() -> bool:
	return is_on_floor()


func _input(event: InputEvent) -> void:

	if event.is_action_pressed("shoot"):
		weapon_manager.shoot()
	
	if event.is_action_pressed("reload"):
		weapon_manager.reload()
