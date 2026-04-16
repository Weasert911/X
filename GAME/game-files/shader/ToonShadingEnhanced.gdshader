shader_type canvas_item;
render_mode blend_mix;

// Enhanced Toon Shading with built‑in color adjustment
// Combines BaseColor (contrast/saturation/brightness) with posterization and edge darkening

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

// BaseColor uniforms
uniform float contrast : hint_range(0.5, 2.0) = 1.2;
uniform float saturation : hint_range(0.0, 3.0) = 1.3;
uniform float brightness : hint_range(0.5, 1.5) = 1.0;

// ToonShading uniforms
uniform int bands : hint_range(2, 128) = 4;
uniform float edge_threshold : hint_range(0.0, 0.5) = 0.1;
uniform float brightness_floor : hint_range(0.0, 1.0) = 0.3;

void fragment() {
	vec4 screen_color = texture(screen_texture, SCREEN_UV);
	
	// --- BaseColor adjustments ---
	vec3 color = screen_color.rgb * brightness;
	color = (color - 0.5) * contrast + 0.5;
	float luminance_pre = dot(color, vec3(0.299, 0.587, 0.114));
	color = mix(vec3(luminance_pre), color, saturation);
	
	// --- Toon shading ---
	// Convert to luminance after color adjustment
	float luminance = dot(color, vec3(0.299, 0.587, 0.114));
	
	// Posterize luminance
	float step_size = 1.0 / float(bands);
	float posterized = floor(luminance / step_size) * step_size;
	
	// Apply edge darkening based on luminance difference with neighbors
	vec2 pixel_size = SCREEN_PIXEL_SIZE;
	vec2 uv_up = SCREEN_UV + vec2(0.0, -pixel_size.y);
	vec2 uv_down = SCREEN_UV + vec2(0.0, pixel_size.y);
	vec2 uv_left = SCREEN_UV + vec2(-pixel_size.x, 0.0);
	vec2 uv_right = SCREEN_UV + vec2(pixel_size.x, 0.0);
	
	float lum_up = dot(texture(screen_texture, uv_up).rgb, vec3(0.299, 0.587, 0.114));
	float lum_down = dot(texture(screen_texture, uv_down).rgb, vec3(0.299, 0.587, 0.114));
	float lum_left = dot(texture(screen_texture, uv_left).rgb, vec3(0.299, 0.587, 0.114));
	float lum_right = dot(texture(screen_texture, uv_right).rgb, vec3(0.299, 0.587, 0.114));
	
	float edge = 0.0;
	edge += abs(luminance - lum_up);
	edge += abs(luminance - lum_down);
	edge += abs(luminance - lum_left);
	edge += abs(luminance - lum_right);
	edge *= 0.25;
	
	// Darken edges
	if (edge > edge_threshold) {
		posterized *= 0.7;
	}
	
	// Ensure minimum brightness
	posterized = max(posterized, brightness_floor);
	
	// Reconstruct color with posterized luminance while preserving hue
	vec3 final_color = color * (posterized / max(luminance, 0.001));
	
	COLOR = vec4(final_color, screen_color.a);
}