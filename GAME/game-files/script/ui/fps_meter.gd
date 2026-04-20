extends Control

@onready var fps_label: Label = $Label

var frame_count: int = 0
var elapsed_time: float = 0.0
var current_fps: float = 0.0

const UPDATE_INTERVAL: float = 0.1

func _ready() -> void:
	if fps_label:
		fps_label.text = "FPS: 0"
	else:
		push_error("FPS Meter: Label node not found!")

func _process(delta: float) -> void:
	frame_count += 1
	elapsed_time += delta
	
	if elapsed_time >= UPDATE_INTERVAL:
		current_fps = frame_count / elapsed_time
		frame_count = 0
		elapsed_time = 0.0
		
		if fps_label:
			if current_fps >= 100:
				fps_label.text = "FPS: %d" % int(current_fps)
			else:
				fps_label.text = "FPS: %.1f" % current_fps
			
			_update_color_based_on_fps(current_fps)

func _update_color_based_on_fps(fps: float) -> void:
	if fps >= 60:
		fps_label.modulate = Color(0.0, 1.0, 0.0, 1.0)
	elif fps >= 30:
		fps_label.modulate = Color(1.0, 1.0, 0.0, 1.0)
	else:
		fps_label.modulate = Color(1.0, 0.0, 0.0, 1.0)

func get_fps() -> float:
	return current_fps

func toggle_meter_visibility() -> void:
	visible = not visible

func set_meter_visible(is_visible: bool) -> void:
	visible = is_visible
