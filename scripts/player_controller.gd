extends CharacterBody3D

@export var move_speed: float = 5.0
@export var acceleration: float = 20.0
@export var friction: float = 15.0
@export var jump_force: float = 8.0
@export var gravity: float = 20.0

@export var allow_jump_anywhere: bool = false

var last_movement_direction: float = 0.0
var movement_direction_smoothing: float = 10.0

var input_direction: float = 0.0

@export var ground_check_distance: float = 0.5
@export var ground_collision_mask: int = 0xFFFFFFFF
var is_grounded: bool = false

func _ready() -> void:
	add_to_group("player")
	_check_grounded()
	
	if Engine.is_editor_hint() or OS.is_debug_build():
		print("Player initialized - Position: ", global_position, ", is_grounded: ", is_grounded)

func _physics_process(delta: float) -> void:
	input_direction = Input.get_axis("ui_left", "ui_right")
	_apply_gravity(delta)
	_handle_movement(delta)
	_handle_jump()
	move_and_slide()
	_check_grounded()
	_update_movement_direction(delta)

func _apply_gravity(delta: float) -> void:
	if not is_grounded:
		velocity.y -= gravity * delta

func _handle_movement(delta: float) -> void:
	var target_velocity_x: float = input_direction * move_speed
	velocity.x = lerp(velocity.x, target_velocity_x, acceleration * delta)
	
	if input_direction == 0.0:
		velocity.x = lerp(velocity.x, 0.0, friction * delta)
	
	velocity.z = 0.0

func _handle_jump() -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if is_grounded or allow_jump_anywhere:
			velocity.y = jump_force
			if Engine.is_editor_hint() or OS.is_debug_build():
				print("Jump executed! velocity.y set to: ", velocity.y, " (grounded: ", is_grounded, ")")
		else:
			if Engine.is_editor_hint() or OS.is_debug_build():
				print("Jump failed - not grounded (velocity.y: ", velocity.y, ")")

func _check_grounded() -> void:
	is_grounded = is_on_floor()
	
	if Engine.is_editor_hint() or OS.is_debug_build():
		if Input.is_action_just_pressed("ui_accept"):
			print("Jump pressed - is_grounded: ", is_grounded, ", velocity.y: ", velocity.y)

func _update_movement_direction(delta: float) -> void:
	var target_direction: float = input_direction
	last_movement_direction = lerp(last_movement_direction, target_direction, movement_direction_smoothing * delta)

func get_last_movement_direction() -> float:
	return last_movement_direction
