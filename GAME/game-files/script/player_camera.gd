extends Camera3D

# ========================
# 🎛️ CONFIG
# ========================

@export var mouse_sensitivity := 0.003
@export var rotation_smoothness := 10.0

@export var distance := 6.0
@export var height := 3.0

@export var follow_smoothness := 8.0
@export var dead_zone := 0.1

@export var min_pitch := deg_to_rad(30)
@export var max_pitch := deg_to_rad(55)

# ========================
# 🧠 INTERNAL
# ========================

var yaw := 0.0
var pitch := deg_to_rad(45)

var target_yaw := 0.0
var target_pitch := pitch

var player: CharacterBody3D

# ========================
# 🚀 INIT
# ========================

func _ready():
	player = get_parent()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# ========================
# 🖱️ INPUT
# ========================

func _input(event):
	if event is InputEventMouseMotion:
		target_yaw -= event.relative.x * mouse_sensitivity
		target_pitch -= event.relative.y * mouse_sensitivity
		target_pitch = clamp(target_pitch, min_pitch, max_pitch)

# ========================
# ⚙️ MAIN LOOP
# ========================

func _physics_process(delta):
	_update_rotation(delta)
	_update_position(delta)

# ========================
# 🔄 ROTATION
# ========================

func _update_rotation(delta):
	yaw = lerp(yaw, target_yaw, rotation_smoothness * delta)
	pitch = lerp(pitch, target_pitch, rotation_smoothness * delta)

# ========================
# 📍 POSITION
# ========================

func _update_position(delta):
	var target_pos = player.global_transform.origin

	# Orbit calculation
	var rot = Basis(Vector3.UP, yaw) * Basis(Vector3.RIGHT, pitch)
	var offset = rot.z * distance
	offset.y += height

	var desired_pos = target_pos + offset

	# Smooth follow
	if global_transform.origin.distance_to(desired_pos) > dead_zone:
		global_transform.origin = global_transform.origin.lerp(
			desired_pos,
			follow_smoothness * delta
		)

	# Snap fix
	if global_transform.origin.distance_to(desired_pos) < 0.02:
		global_transform.origin = desired_pos

	look_at(target_pos, Vector3.UP)
