shader_type canvas_item;
render_mode blend_mix;

// Chaos FX Enhanced: Combines Color Grading with dynamic chaos effects
// Applies color grading first, then chaos‑based distortion, vignette, shake, and color shift

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

// ColorGrading uniforms
uniform float warmth : hint_range(0.0, 2.0) = 1.2;
uniform float cool_shadows : hint_range(0.0, 1.0) = 0.3;
uniform float contrast : hint_range(0.5, 2.0) = 1.4;
uniform float saturation : hint_range(0.0, 2.0) = 1.1;
uniform float vibrance : hint_range(0.0, 2.0) = 1.3;

// ChaosFX uniforms
uniform float chaos_level : hint_range(0.0, 1.0) = 0.0;
uniform float vignette_strength : hint_range(0.0, 1.0) = 0.3;
uniform float distortion_strength : hint_range(0.0, 0.1) = 0.02;
uniform float shake_intensity : hint_range(0.0, 0.05) = 0.01;
uniform float chaos_color_shift : hint_range(0.0, 0.1) = 0.03;

// Simple pseudo‑random for shake
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

// Color grading function
vec3 apply_color_grading(vec3 color) {
	// Apply contrast
	color = (color - 0.5) * contrast + 0.5;
	
	// Apply saturation with vibrance (boost less saturated colors more)
	float lum = dot(color, vec3(0.299, 0.587, 0.114));
	vec3 diff = color - lum;
	float sat = length(diff);
	float sat_boost = 1.0 + (vibrance - 1.0) * (1.0 - sat);
	color = lum + diff * saturation * sat_boost;
	
	// Split‑toning: warm highlights, cool shadows
	float highlight_mask = smoothstep(0.6, 0.9, lum);
	float shadow_mask = smoothstep(0.1, 0.4, lum);
	
	// Warm tint (yellow‑orange)
	vec3 warm_tint = vec3(1.0, 0.85, 0.6);
	// Cool tint (blue‑cyan)
	vec3 cool_tint = vec3(0.6, 0.8, 1.0);
	
	color = mix(color, color * warm_tint, highlight_mask * warmth);
	color = mix(color, color * cool_tint, (1.0 - shadow_mask) * cool_shadows);
	
	// Clamp to avoid overshoot
	color = clamp(color, 0.0, 1.0);
	return color;
}

void fragment() {
	vec2 uv = SCREEN_UV;
	
	// Apply screen shake based on chaos_level
	float shake = chaos_level * shake_intensity;
	vec2 shake_offset = vec2(
		noise(vec2(TIME * 10.0, 0.0)) * 2.0 - 1.0,
		noise(vec2(0.0, TIME * 10.0)) * 2.0 - 1.0
	) * shake;
	
	// Apply radial distortion (barrel/pincushion) based on chaos
	float distortion = chaos_level * distortion_strength;
	vec2 centered = uv - 0.5;
	float dist = length(centered);
	vec2 distorted_uv = uv + centered * dist * distortion;
	
	// Combine shake and distortion
	vec2 final_uv = distorted_uv + shake_offset;
	
	// Sample screen texture with chaos‑adjusted UV
	vec4 screen_color = texture(screen_texture, final_uv);
	vec3 color = screen_color.rgb;
	
	// Apply color grading
	color = apply_color_grading(color);
	
	// Dynamic vignette that intensifies with chaos
	float vignette_dist = length(centered * vec2(SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y, 1.0));
	float vignette = smoothstep(0.0, 0.7, vignette_dist);
	vignette = 1.0 - vignette * (vignette_strength + chaos_level * 0.5);
	vignette = max(vignette, 0.7); // Never completely darken center
	
	// Apply vignette
	color *= vignette;
	
	// Subtle color shift (red/blue channel separation) at high chaos
	if (chaos_level > 0.5) {
		float shift = chaos_color_shift * (chaos_level - 0.5) * 2.0;
		vec2 shift_uv_r = final_uv + vec2(shift, 0.0);
		vec2 shift_uv_b = final_uv - vec2(shift, 0.0);
		color.r = texture(screen_texture, shift_uv_r).r;
		color.b = texture(screen_texture, shift_uv_b).b;
	}
	
	// Slight brightness boost at peak chaos
	color *= 1.0 + chaos_level * 0.1;
	
	COLOR = vec4(color, screen_color.a);
}