extends GPUParticles3D

@export var particle_count: int = 100
@export var emission_rate: float = 10.0
@export var particle_lifetime: float = 8.0
@export var particle_size_min: float = 0.05
@export var particle_size_max: float = 0.15

func _ready() -> void:
	_configure_particles()

func _configure_particles() -> void:
	amount = particle_count
	emitting = true
	lifetime = particle_lifetime
	
	emission_shape = 3
	emission_box_extents = Vector3(20, 10, 5)
	
	var process_material = ParticleProcessMaterial.new()
	
	process_material.gravity = Vector3(0, -0.1, 0)
	
	process_material.initial_velocity_min = 0.1
	process_material.initial_velocity_max = 0.3
	
	process_material.angular_velocity_min = -10.0
	process_material.angular_velocity_max = 10.0
	
	process_material.scale_min = particle_size_min
	process_material.scale_max = particle_size_max
	
	process_material.color = Color(0.3, 0.3, 0.35, 0.3)
	
	var color_ramp = Gradient.new()
	color_ramp.add_point(0.0, Color(0.3, 0.3, 0.35, 0.0))
	color_ramp.add_point(0.2, Color(0.3, 0.3, 0.35, 0.3))
	color_ramp.add_point(0.8, Color(0.3, 0.3, 0.35, 0.3))
	color_ramp.add_point(1.0, Color(0.3, 0.3, 0.35, 0.0))
	process_material.color_ramp = color_ramp
	
	process_material.turbulence_enabled = true
	process_material.turbulence_strength = 0.1
	process_material.turbulence_noise_scale = 5.0
	
	self.process_material = process_material
	
	var draw_material = StandardMaterial3D.new()
	draw_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	draw_material.albedo_color = Color(1, 1, 1, 0.3)
	draw_material.noise_enabled = true
	draw_material.noise_scale = 10.0
	self.draw_pass_1 = draw_material
