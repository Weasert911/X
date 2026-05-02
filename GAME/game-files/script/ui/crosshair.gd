extends CanvasLayer

# Crosshair expansion settings
@export var max_spread: float = 50.0
@export var expand_amount: float = 8.0
@export var recovery_speed: float = 30.0

@onready var dot: Panel = $CenterDot/Dot
@export var color : Color
var spread: float = 0.0

func _ready():
	dot.position = Vector2(-dot.size.x/2, -dot.size.y/2)

func set_color():
	dot.self_modulate = color

# Called when player shoots
func on_shoot():
	spread = min(spread + expand_amount, max_spread)
	update_visual()

func _process(delta):
	# Gradually recover spread
	if spread > 0:
		spread = max(0, spread - recovery_speed * delta)
		update_visual()

# Update crosshair position based on current spread
func update_visual():
	# For now just move the dot, but we can expand this for multi-part crosshairs
	dot.position = Vector2(-dot.size.x/2 + spread, -dot.size.y/2 + spread)
