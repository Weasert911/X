extends CanvasLayer

@onready var dot: Panel = $CenterDot/Dot
@export var color : Color 
func _ready():
	dot.position = Vector2(-dot.size.x/2, -dot.size.y/2)

func set_color():
	dot.self_modulate = color
