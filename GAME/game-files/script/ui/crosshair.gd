extends CanvasLayer

@onready var dot: Panel = $CenterDot/Dot

func _ready():
    # Make sure the crosshair is centered
    dot.position = Vector2(-dot.size.x/2, -dot.size.y/2)

func set_color(color: Color):
    dot.self_modulate = color