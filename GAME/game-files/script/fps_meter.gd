extends Control

# Reference to the Label node
@onready var fps_label: Label = $Label

# Variables for FPS calculation
var frame_count: int = 0
var elapsed_time: float = 0.0
var current_fps: float = 0.0

# Update interval in seconds (how often to update the display)
const UPDATE_INTERVAL: float = 0.1

func _ready() -> void:
	# Ensure the label exists
	if fps_label:
		fps_label.text = "FPS: 0"
	else:
		push_error("FPS Meter: Label node not found!")

func _process(delta: float) -> void:
	# Accumulate frame count and time
	frame_count += 1
	elapsed_time += delta
	
	# Update FPS calculation at regular intervals
	if elapsed_time >= UPDATE_INTERVAL:
		current_fps = frame_count / elapsed_time
		frame_count = 0
		elapsed_time = 0.0
		
		# Update the label text
		if fps_label:
			# Format FPS as integer or with one decimal place
			if current_fps >= 100:
				fps_label.text = "FPS: %d" % int(current_fps)
			else:
				fps_label.text = "FPS: %.1f" % current_fps
			
			# Optional: Change color based on FPS performance
			_update_color_based_on_fps(current_fps)

# Optional: Visual feedback based on FPS
func _update_color_based_on_fps(fps: float) -> void:
	if fps >= 60:
		# Good performance - green
		fps_label.modulate = Color(0.0, 1.0, 0.0, 1.0)  # Green
	elif fps >= 30:
		# Acceptable performance - yellow
		fps_label.modulate = Color(1.0, 1.0, 0.0, 1.0)  # Yellow
	else:
		# Poor performance - red
		fps_label.modulate = Color(1.0, 0.0, 0.0, 1.0)  # Red

# Helper function to get current FPS (can be called from other scripts)
func get_fps() -> float:
	return current_fps

# Toggle visibility (useful for debugging)
func toggle_meter_visibility() -> void:
	visible = not visible

# Set visibility explicitly
func set_meter_visible(is_visible: bool) -> void:
	visible = is_visible
