extends Control

# Hit feedback UI element that shows hit markers

@onready var hit_marker: TextureRect = $HitMarker

func _ready():
    hit_marker.modulate.a = 0.0

func show_hit():
    # Make hit marker visible and fade out
    hit_marker.modulate.a = 1.0
    
    var tween = create_tween()
    tween.tween_property(hit_marker, "modulate:a", 0.0, 0.5)
