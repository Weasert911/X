extends CharacterBody3D

# ========================
# 🎛️ CONFIG
# ========================

@export var move_speed := 8.0
@export var acceleration := 20.0
@export var deceleration := 25.0

@export var jump_force := 7.5
@export var gravity := 20.0

@export var rotation_speed := 10.0

# ========================
# 🧠 INTERNAL
# ========================

@onready var camera_rig: Node3D = $CameraRig
@onready var cam: Camera3D = $CameraRig/Camera3D

var input_dir := Vector2.ZERO
var current_velocity := Vector3.ZERO  # Track current velocity for camera system

# ========================
# 🎮 INPUT
# ========================

func _get_input():
	input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")

# ========================
# 🚀 MAIN LOOP
# ========================

func _physics_process(delta):
	_get_input()
	_apply_gravity(delta)
	_handle_jump()
	_handle_movement(delta)
	move_and_slide()
	
	# Update current velocity for camera system
	current_velocity = velocity

# ========================
# 🌍 MOVEMENT
# ========================

func _handle_movement(delta):
	var direction = Vector3.ZERO

	if input_dir != Vector2.ZERO:
		# World-space movement (camera no longer rotates)
		# Forward is negative Z, Right is positive X
		var forward = Vector3.FORWARD  # -Z
		var right = Vector3.RIGHT     # +X

		direction = (forward * input_dir.y + right * input_dir.x).normalized()

	var target_velocity = direction * move_speed

	# Smooth accel/decel
	velocity.x = move_toward(velocity.x, target_velocity.x, acceleration * delta)
	velocity.z = move_toward(velocity.z, target_velocity.z, acceleration * delta)

	if direction == Vector3.ZERO:
		velocity.x = move_toward(velocity.x, 0, deceleration * delta)
		velocity.z = move_toward(velocity.z, 0, deceleration * delta)

	# Kill micro jitter
	if abs(velocity.x) < 0.05: velocity.x = 0
	if abs(velocity.z) < 0.05: velocity.z = 0

	_handle_rotation(direction, delta)

# ========================
# 🔄 ROTATION
# ========================

func _handle_rotation(direction: Vector3, delta):
	if direction.length() > 0.1:
		var target_angle = atan2(direction.x, direction.z)
		rotation.y = lerp_angle(rotation.y, target_angle, rotation_speed * delta)

# ========================
# 🦘 JUMP
# ========================

func _handle_jump():
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_force

# ========================
# 🌌 GRAVITY
# ========================

func _apply_gravity(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		if velocity.y < 0:
			velocity.y = 0

# ========================
# 📊 VELOCITY ACCESS
# ========================

func get_current_velocity() -> Vector3:
	return current_velocity
