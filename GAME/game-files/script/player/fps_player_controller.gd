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

@export_group("Stamina")
@export var max_stamina: float = 5.0
@export var stamina_drain_rate: float = 1.2
@export var stamina_regen_rate: float = 0.8
@export var stamina_regen_delay: float = 1.0
@export var min_stamina_to_sprint: float = 0.5

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
var stamina: float = max_stamina
var stamina_delay_timer: float = 0.0
var sprint_factor: float = 0.0
var smoothed_speed: float = 0.0
var coyote_timer: float = 0.0

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
	_update_stamina(delta)
	
	if is_sprinting:
		sprint_factor = lerp(sprint_factor, 1.0, 8.0 * delta)
	else:
		sprint_factor = lerp(sprint_factor, 0.0, 6.0 * delta)
	
	_check_ground_state()
	
	_handle_jump()
	
	_apply_gravity(delta)
	
	_handle_movement(delta)
	
	move_and_slide()
	
	_update_movement_state(delta)
	
	_update_camera_state(delta)
	
func _handle_movement(delta: float) -> void:
	var direction = Vector3.ZERO
	
	if input_dir != Vector2.ZERO:
		var forward = camera_controller.get_forward_direction()
		var right = camera_controller.get_right_direction()
		
		direction = (forward * input_dir.y + right * input_dir.x).normalized()
	
	var target_speed = lerp(walk_speed, sprint_speed, sprint_factor)
	
	var accel = acceleration
	var decel = deceleration
	
	if not is_on_floor():
		accel = air_acceleration
		decel = air_deceleration
	
	if input_dir != Vector2.ZERO:
		_apply_ground_movement(direction, target_speed, accel, delta)
	else:
		_apply_ground_movement(Vector3.ZERO, 0.0, decel, delta)

func _handle_jump() -> void:
	var jump_pressed = _get_jump_input()
	
	if jump_pressed:
		jump_buffer_timer = jump_buffer
	else:
		jump_buffer_timer -= get_physics_process_delta_time()
	
	coyote_timer = coyote_time if is_on_floor() else max(coyote_timer - get_physics_process_delta_time(), 0.0)
	
	var can_jump = is_on_floor() or coyote_timer > 0
	
	if can_jump and jump_buffer_timer > 0:
		velocity.y = jump_force
		jump_buffer_timer = 0
		coyote_timer = 0
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

func _update_camera_state(delta: float) -> void:
	var current_speed = horizontal_velocity.length()
	var t := 1.0 - exp(-10.0 * delta)
	smoothed_speed = lerp(smoothed_speed, current_speed, t)
	
	camera_effects_manager.set_player_state(
		is_sprinting,
		is_on_floor(),
		just_landed,
		smoothed_speed,
		is_strafing_left,
		is_strafing_right,
		just_jumped,
		current_acceleration,
		false
	)
	
	# Set idle state for blink system
	var is_idle: bool = input_dir == Vector2.ZERO and horizontal_velocity.length() < 0.1
	camera_effects_manager.blink.set_idle_state(is_idle)
	
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

func _update_stamina(delta: float) -> void:
	var wants_sprint = Input.is_action_pressed("sprint") and input_dir != Vector2.ZERO

	if wants_sprint and stamina > min_stamina_to_sprint:
		is_sprinting = true
		stamina -= stamina_drain_rate * delta
		stamina_delay_timer = stamina_regen_delay
	else:
		is_sprinting = false
		stamina_delay_timer -= delta
		if stamina_delay_timer <= 0:
			stamina += stamina_regen_rate * delta

	stamina = clamp(stamina, 0.0, max_stamina)

func _apply_ground_movement(direction: Vector3, target_speed: float, accel: float, delta: float) -> void:
	var target_vel = direction * target_speed
	
	var current = Vector3(velocity.x, 0, velocity.z)
	var diff = target_vel - current
	
	var accel_step = accel * delta
	
	if diff.length() < accel_step:
		current = target_vel
	else:
		current += diff.normalized() * accel_step
	
	velocity.x = current.x
	velocity.z = current.z
	
	if abs(velocity.x) < 0.01: velocity.x = 0
	if abs(velocity.z) < 0.01: velocity.z = 0

func is_player_sprinting() -> bool:
	return is_sprinting

func is_player_grounded() -> bool:
	return is_on_floor()


func _input(event: InputEvent) -> void:

	if event.is_action_pressed("shoot"):
		weapon_manager.shoot()
	
	if event.is_action_pressed("reload"):
		weapon_manager.reload()
