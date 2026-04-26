class_name HeadBobSystem
extends Node

@export_group("Head Bob")
@export var enabled: bool = true
@export var idle_bob_amount: float = 0.005
@export var idle_bob_speed: float = 2.0
@export var walk_bob_amount: float = 0.03
@export var walk_bob_speed: float = 10.0
@export var sprint_bob_amount: float = 0.05
@export var sprint_bob_speed: float = 14.0
@export var transition_speed: float = 5.0
@export var airborne_reduction: float = 0.2
@export var horizontal_bob_ratio: float = 0.3
@export var footstep_sync_enabled: bool = false

enum BobState { IDLE, WALK, SPRINT }

var _bob_timer: float = 0.0
var _current_state: float = 0.0

signal footstep_triggered

func update(delta: float, speed: float, sprinting: bool, grounded: bool) -> void:
	if not enabled:
		return
	
	var target_state: float = 0.0
	if speed > 0.1:
		target_state = 1.0
		if sprinting:
			target_state = 2.0
	
	_current_state = lerp(_current_state, target_state, transition_speed * delta)
	
	var bob_amount: float
	var bob_speed: float
	
	if _current_state <= 1.0:
		bob_amount = lerp(idle_bob_amount, walk_bob_amount, _current_state)
		bob_speed = lerp(idle_bob_speed, walk_bob_speed, _current_state)
	else:
		bob_amount = lerp(walk_bob_amount, sprint_bob_amount, _current_state - 1.0)
		bob_speed = lerp(walk_bob_speed, sprint_bob_speed, _current_state - 1.0)
	
	# Step 4: Add speed-based amplitude
	var speed_factor = clamp(speed, 0.0, 1.0)
	bob_amount *= speed_factor
	bob_speed *= lerp(0.5, 1.2, speed_factor)
	
	# Step 6: Fix airborne behavior
	if not grounded:
		_bob_timer = lerp(_bob_timer, 0.0, 5.0 * delta)
		return
	
	var prev_timer = _bob_timer
	_bob_timer += bob_speed * delta
	
	# Step 5: Impact snap
	var wave = sin(_bob_timer)
	if wave > 0.95:
		_bob_timer += 0.02  # small snap forward
	
	if footstep_sync_enabled and grounded and speed > 0.1:
		if sin(prev_timer) < 0.0 and sin(_bob_timer) >= 0.0:
			footstep_triggered.emit()

func get_offset() -> Vector3:
	if not enabled:
		return Vector3.ZERO
	
	var amount = _get_current_amount()
	
	# 🔥 Weighty vertical motion (main impact)
	var vertical = sin(_bob_timer) * amount
	
	# 🔥 Secondary horizontal sway (delayed, subtle)
	var horizontal = sin(_bob_timer * 0.5 + PI * 0.5) * amount * horizontal_bob_ratio
	
	# 🔥 Add slight forward/back kick (THIS adds realism)
	var forward = sin(_bob_timer * 2.0) * amount * 0.15
	
	return Vector3(horizontal, vertical, forward)

func _get_current_amount() -> float:
	if _current_state <= 1.0:
		return lerp(idle_bob_amount, walk_bob_amount, _current_state)
	else:
		return lerp(walk_bob_amount, sprint_bob_amount, _current_state - 1.0)