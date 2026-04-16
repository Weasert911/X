shader_type canvas_item;
render_mode blend_mix;

// Subtle animated film grain
// Helps hide banding in flat toon shading

uniform float intensity : hint_range(0.0, 0.2, 0.001) = 0.03;
uniform float speed : hint_range(0.0, 5.0, 0.1) = 1.0;
uniform float scale : hint_range(0.5, 10.0, 0.1) = 3.0;
uniform bool colored : hint_toggle = false;

// Simple pseudo‑random hash
float hash(vec2 p) {
	return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

// 2D noise
float noise(vec2 uv) {
	vec2 i = floor(uv);
	vec2 f = fract(uv);
	
	float a = hash(i);
	float b = hash(i + vec2(1.0, 0.0));
	float c = hash(i + vec2(0.0, 1.0));
	float d = hash(i + vec2(1.0, 1.0));
	
	vec2 u = f * f * (3.0 - 2.0 * f);
	return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

void fragment() {
	vec4 screen_color = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	// Animated noise coordinate
	vec2 uv = SCREEN_UV * scale + vec2(TIME * 0.1 * speed, TIME * 0.07 * speed);
	float grain = noise(uv * 100.0) * 2.0 - 1.0; // range -1..1
	
	// Apply intensity
	grain *= intensity;
	
	vec3 grain_rgb;
	if (colored) {
		// Slight color variation
		float grain_r = noise(uv * 97.0) * 2.0 - 1.0;
		float grain_g = noise(uv * 103.0) * 2.0 - 1.0;
		float grain_b = noise(uv * 101.0) * 2.0 - 1.0;
		grain_rgb = vec3(grain_r, grain_g, grain_b) * intensity;
	} else {
		grain_rgb = vec3(grain);
	}
	
	// Add grain to color (preserve luminance)
	vec3 color = screen_color.rgb + grain_rgb;
	
	COLOR = vec4(color, screen_color.a);
}