shader_type canvas_item;
render_mode blend_mix;

// Toon shading via posterization
// Creates strong flat shading look

uniform int bands : hint_range(2, 8, 1) = 4;
uniform float edge_threshold : hint_range(0.0, 0.5, 0.01) = 0.1;
uniform float brightness_floor : hint_range(0.0, 1.0, 0.01) = 0.3;

void fragment() {
	vec4 screen_color = texture(SCREEN_TEXTURE, SCREEN_UV);
	
	// Convert to luminance
	float luminance = dot(screen_color.rgb, vec3(0.299, 0.587, 0.114));
	
	// Posterize luminance
	float step_size = 1.0 / float(bands);
	float posterized = floor(luminance / step_size) * step_size;
	
	// Apply edge darkening based on luminance difference with neighbors
	vec2 pixel_size = 1.0 / SCREEN_PIXEL_SIZE;
	vec2 uv_up = SCREEN_UV + vec2(0.0, -pixel_size.y);
	vec2 uv_down = SCREEN_UV + vec2(0.0, pixel_size.y);
	vec2 uv_left = SCREEN_UV + vec2(-pixel_size.x, 0.0);
	vec2 uv_right = SCREEN_UV + vec2(pixel_size.x, 0.0);
	
	float lum_up = dot(texture(SCREEN_TEXTURE, uv_up).rgb, vec3(0.299, 0.587, 0.114));
	float lum_down = dot(texture(SCREEN_TEXTURE, uv_down).rgb, vec3(0.299, 0.587, 0.114));
	float lum_left = dot(texture(SCREEN_TEXTURE, uv_left).rgb, vec3(0.299, 0.587, 0.114));
	float lum_right = dot(texture(SCREEN_TEXTURE, uv_right).rgb, vec3(0.299, 0.587, 0.114));
	
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
	vec3 color = screen_color.rgb * (posterized / max(luminance, 0.001));
	
	COLOR = vec4(color, screen_color.a);
}