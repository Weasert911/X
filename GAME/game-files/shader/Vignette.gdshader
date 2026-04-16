shader_type canvas_item;
render_mode blend_mix;

// Subtle vignette (edge darkening)
// Never over‑darkens center, preserves gameplay visibility

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float strength : hint_range(0.0, 1.0) = 0.3;
uniform float smoothness : hint_range(0.0, 1.0) = 0.5;
uniform float roundness : hint_range(0.0, 1.0) = 0.5;
uniform vec2 center = vec2(0.5, 0.5);

void fragment() {
	vec4 screen_color = texture(screen_texture, SCREEN_UV);
	vec2 uv = SCREEN_UV;
	
	// Distance from center, with aspect‑ratio correction
	vec2 centered = (uv - center) * vec2(SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y, 1.0);
	float dist = length(centered);
	
	// Apply roundness (elliptical shape)
	dist = pow(dist, 1.0 / (roundness + 0.5));
	
	// Vignette curve
	float vignette = smoothstep(0.0, smoothness, dist);
	vignette = 1.0 - vignette * strength;
	
	// Ensure center is never darkened beyond a minimum
	vignette = max(vignette, 1.0 - strength);
	
	vec3 color = screen_color.rgb * vignette;
	COLOR = vec4(color, screen_color.a);
}