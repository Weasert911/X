extends CanvasLayer

# Post‑Processing Controller
# Provides runtime control over the shader stack uniforms
# Updated for combined shaders (ToonShadingEnhanced, ChaosFXEnhanced)

@export var chaos_level: float = 0.0:
	set(value):
		chaos_level = clamp(value, 0.0, 1.0)
		_update_chaos_fx()

@export var outline_thickness: float = 2.5:
	set(value):
		outline_thickness = value
		_update_outline()

@export var toon_bands: int = 4:
	set(value):
		toon_bands = clampi(value, 2, 8)
		_update_toon()

@export var color_warmth: float = 1.3:
	set(value):
		color_warmth = value
		_update_color_grading()

# Node references
@onready var toon_material: ShaderMaterial = $ColorRect_ToonLightingShader.material
@onready var outline_material: ShaderMaterial = $ColorRect_OutlineShader.material
@onready var chaos_fx_material: ShaderMaterial = $ColorRect_VignetteOrChaosFXShader.material

func _ready() -> void:
	# Initialize all shader parameters
	_update_all()

func _update_all() -> void:
	_update_toon()
	_update_outline()
	_update_color_grading()
	_update_chaos_fx()

func _update_toon() -> void:
	if toon_material:
		toon_material.set_shader_parameter("bands", toon_bands)
		# Optionally set other ToonShadingEnhanced parameters (contrast, saturation, brightness)
		# toon_material.set_shader_parameter("contrast", 1.2)
		# toon_material.set_shader_parameter("saturation", 1.3)
		# toon_material.set_shader_parameter("brightness", 1.0)

func _update_outline() -> void:
	if outline_material:
		outline_material.set_shader_parameter("outline_thickness", outline_thickness)

func _update_color_grading() -> void:
	if chaos_fx_material:
		# Color grading parameters are now part of ChaosFXEnhanced
		chaos_fx_material.set_shader_parameter("warmth", color_warmth)
		# Optionally set other color grading parameters:
		# chaos_fx_material.set_shader_parameter("cool_shadows", 0.3)
		# chaos_fx_material.set_shader_parameter("contrast", 1.4)
		# chaos_fx_material.set_shader_parameter("saturation", 1.1)
		# chaos_fx_material.set_shader_parameter("vibrance", 1.3)

func _update_chaos_fx() -> void:
	if chaos_fx_material:
		chaos_fx_material.set_shader_parameter("chaos_level", chaos_level)

# Public API for gameplay systems
func set_chaos_level(level: float, duration: float = 0.0) -> void:
	if duration > 0.0:
		var tween = create_tween()
		tween.tween_property(self, "chaos_level", level, duration)
	else:
		self.chaos_level = level

func pulse_outline(thickness: float, duration: float = 0.3) -> void:
	var original = outline_thickness
	var tween = create_tween()
	tween.tween_property(self, "outline_thickness", thickness, duration * 0.5)
	tween.tween_property(self, "outline_thickness", original, duration * 0.5)

# Example: call from gameplay when chaos increases (e.g., many explosions)
func notify_chaos_event(intensity: float = 0.2) -> void:
	set_chaos_level(chaos_level + intensity, 0.5)
