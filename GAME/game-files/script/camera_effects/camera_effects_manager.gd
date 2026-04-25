class_name CameraEffectsManager
extends Node3D

@onready var head_bob: HeadBobSystem = $HeadBobSystem
@onready var blink: BlinkSystem = $BlinkSystem
@onready var micro_motion: MicroMotionSystem = $MicroMotionSystem
@onready var landing: LandingWeightSystem = $LandingWeightSystem
@onready var breathing: BreathingSystem = $BreathingSystem
@onready var dynamic_fov: DynamicFOVSystem = $DynamicFOVSystem

var blink_alpha: float = 0.0

var is_sprinting: bool = false
var is_grounded: bool = true
var movement_speed: float = 0.0
var is_strafing_left: bool = false
var is_strafing_right: bool = false
var just_landed: bool = false
var just_jumped: bool = false
var current_acceleration: float = 0.0
var is_aiming: bool = false

func set_player_state(
	sprinting: bool,
	grounded: bool,
	landed: bool,
	speed: float,
	strafe_left: bool = false,
	strafe_right: bool = false,
	jumped: bool = false,
	accel: float = 0.0,
	aiming: bool = false
) -> void:
	is_sprinting = sprinting
	is_grounded = grounded
	just_landed = landed
	movement_speed = speed
	is_strafing_left = strafe_left
	is_strafing_right = strafe_right
	just_jumped = jumped
	current_acceleration = accel
	is_aiming = aiming

func get_effects(delta: float) -> EffectsData:
	head_bob.update(delta, movement_speed, is_sprinting, is_grounded)
	blink.update(delta)
	micro_motion.update(delta, movement_speed, is_aiming)
	landing.update(delta, just_landed, current_acceleration, is_strafing_left, is_strafing_right, is_sprinting)
	breathing.update(delta, is_sprinting)
	dynamic_fov.update(delta, is_sprinting, just_jumped, just_landed)
	
	var total_offset = Vector3.ZERO
	total_offset += head_bob.get_offset()
	total_offset += landing.get_offset()
	total_offset += breathing.get_offset()
	total_offset += micro_motion.get_offset()
	
	var total_rotation = Vector3.ZERO
	total_rotation.z = landing.get_tilt()
	total_rotation += micro_motion.get_rotation()
	
	var target_fov = dynamic_fov.get_fov()
	blink_alpha = blink.get_alpha()
	
	return EffectsData.new(total_offset, total_rotation, target_fov, blink_alpha)