extends CharacterBody2D

# Player movement parameters
@export var speed: float = 200.0
@export var acceleration: float = 15.0
@export var friction: float = 15.0

# Camera parameters
@export var camera_smoothing_enabled: bool = true
@export var camera_smoothing_speed: float = 5.0

# References
@onready var camera: Camera2D = $Camera2D
@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	# Make the camera current so it follows the player
	if camera:
		camera.make_current()
	
	# Initialize any other setup
	print("Player controller initialized")

func _physics_process(delta: float) -> void:
	# Get input direction
	var input_vector := Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	# Normalize diagonal movement
	if input_vector.length() > 0:
		input_vector = input_vector.normalized()
	
	# Apply movement
	var target_velocity = input_vector * speed
	
	# Smooth acceleration/deceleration
	velocity = velocity.lerp(target_velocity, acceleration * delta)
	
	# Apply friction when no input
	if input_vector.length() == 0:
		velocity = velocity.lerp(Vector2.ZERO, friction * delta)
	
	# Move the character
	move_and_slide()
	
	# Update sprite direction if moving horizontally
	if input_vector.x != 0:
		sprite.flip_h = input_vector.x < 0
	
	# Handle camera smoothing
	if camera_smoothing_enabled and camera:
		# Camera already follows player since it's a child node
		# Add additional smoothing if needed
		pass

func _input(event: InputEvent) -> void:
	# Handle additional input events
	if event.is_action_pressed("jump"):
		_jump()
	if event.is_action_pressed("interact"):
		_interact()

func _jump() -> void:
	# Placeholder for jump functionality
	print("Jump!")

func _interact() -> void:
	# Placeholder for interaction functionality
	print("Interact!")
