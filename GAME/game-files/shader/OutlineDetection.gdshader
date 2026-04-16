shader_type canvas_item;
render_mode blend_mix, unshaded;

// Outline detection via Sobel filter on luminance
// Outputs edge mask (white = edge, black = no edge)

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float edge_threshold : hint_range(0.0, 1.0) = 0.15;
uniform float edge_softness : hint_range(0.0, 1.0) = 0.05;
uniform float intensity : hint_range(0.0, 2.0) = 1.0;

void fragment() {
	vec2 uv = SCREEN_UV;
	vec2 pixel_size = 1.0 / SCREEN_PIXEL_SIZE;
	
	// Sobel kernel offsets
	vec2 offsets[9] = vec2[](
		vec2(-pixel_size.x, -pixel_size.y), vec2(0.0, -pixel_size.y), vec2(pixel_size.x, -pixel_size.y),
		vec2(-pixel_size.x, 0.0), vec2(0.0, 0.0), vec2(pixel_size.x, 0.0),
		vec2(-pixel_size.x, pixel_size.y), vec2(0.0, pixel_size.y), vec2(pixel_size.x, pixel_size.y)
	);
	
	// Sample luminance in 3x3 neighborhood
	float lum[9];
	for (int i = 0; i < 9; i++) {
		vec3 col = texture(screen_texture, uv + offsets[i]).rgb;
		lum[i] = dot(col, vec3(0.299, 0.587, 0.114));
	}
	
	// Sobel horizontal and vertical kernels
	float gx = -lum[0] - 2.0 * lum[3] - lum[6] + lum[2] + 2.0 * lum[5] + lum[8];
	float gy = -lum[0] - 2.0 * lum[1] - lum[2] + lum[6] + 2.0 * lum[7] + lum[8];
	
	float edge = sqrt(gx * gx + gy * gy);
	
	// Normalize and threshold
	edge = clamp((edge - edge_threshold) / edge_softness, 0.0, 1.0);
	edge *= intensity;
	
	COLOR = vec4(vec3(edge), 1.0);
}