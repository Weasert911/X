shader_type canvas_item;
render_mode blend_mix;

// Fast stylized outline using color difference (4 samples)
// No heavy Sobel, no dilation loops – performance‑friendly

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float outline_thickness : hint_range(1.0, 50.0) = 1.5;
uniform float edge_threshold : hint_range(0.0, 0.5) = 0.2;
uniform vec4 outline_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float outline_intensity : hint_range(0.0, 1.0) = 1.0;

void fragment() {
	vec2 pixel = SCREEN_PIXEL_SIZE * outline_thickness;

	vec3 center = texture(screen_texture, SCREEN_UV).rgb;

	// 4‑direction sampling (cheap)
	vec3 left   = texture(screen_texture, SCREEN_UV + vec2(-pixel.x, 0.0)).rgb;
	vec3 right  = texture(screen_texture, SCREEN_UV + vec2(pixel.x, 0.0)).rgb;
	vec3 up     = texture(screen_texture, SCREEN_UV + vec2(0.0, -pixel.y)).rgb;
	vec3 down   = texture(screen_texture, SCREEN_UV + vec2(0.0, pixel.y)).rgb;

	// Average color difference
	float diff =
		length(center - left) +
		length(center - right) +
		length(center - up) +
		length(center - down);

	diff *= 0.25; // normalize

	// Edge mask with smooth threshold
	float edge = smoothstep(edge_threshold, edge_threshold + 0.1, diff);

	// Blend with outline color
	vec3 final_color = mix(center, outline_color.rgb, edge * outline_intensity);

	COLOR = vec4(final_color, 1.0);
}