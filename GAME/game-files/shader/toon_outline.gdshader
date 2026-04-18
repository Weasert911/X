shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

//////////////////////////
// COLOR CONTROL
//////////////////////////
uniform float brightness : hint_range(0.8, 3) = 1.0;
uniform float contrast   : hint_range(0.8, 3) = 1.1;
uniform float saturation : hint_range(0.8, 3) = 1.2;

//////////////////////////
// TOON BANDING
//////////////////////////
uniform int bands : hint_range(2, 6) = 4;

//////////////////////////
// OUTLINE
//////////////////////////
uniform float outline_thickness : hint_range(0.5, 6) = 1.2;
uniform float color_threshold   : hint_range(0.05, 0.3) = 0.15;
uniform vec4 outline_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float outline_intensity : hint_range(0.0, 4) = 1.0;

//////////////////////////
// EDGE DARKENING (SUBTLE)
//////////////////////////
uniform float edge_darkening : hint_range(0.0, 1) = 0.15;

//////////////////////////

float luminance(vec3 c) {
	return dot(c, vec3(0.299, 0.587, 0.114));
}

vec3 apply_color_controls(vec3 col) {
	// brightness
	col *= brightness;

	// contrast
	col = (col - 0.5) * contrast + 0.5;

	// saturation
	float l = luminance(col);
	col = mix(vec3(l), col, saturation);

	return col;
}

vec3 apply_toon(vec3 col) {
	float l = luminance(col);

	// posterize luminance
	float b = float(bands);
	l = floor(l * b) / (b - 1.0);

	// reconstruct color (preserve hue)
	return normalize(col + 0.0001) * l;
}

void fragment() {
	vec2 uv = SCREEN_UV;
	
	vec2 px = SCREEN_PIXEL_SIZE * outline_thickness;

	// Sample 8 neighbors for Sobel edge detection
	// Top row
	vec3 c00 = texture(SCREEN_TEXTURE, uv + vec2(-px.x, -px.y)).rgb;
	vec3 c01 = texture(SCREEN_TEXTURE, uv + vec2(0.0, -px.y)).rgb;
	vec3 c02 = texture(SCREEN_TEXTURE, uv + vec2(px.x, -px.y)).rgb;
	
	// Middle row (skip center)
	vec3 c10 = texture(SCREEN_TEXTURE, uv + vec2(-px.x, 0.0)).rgb;
	vec3 c12 = texture(SCREEN_TEXTURE, uv + vec2(px.x, 0.0)).rgb;
	
	// Bottom row
	vec3 c20 = texture(SCREEN_TEXTURE, uv + vec2(-px.x, px.y)).rgb;
	vec3 c21 = texture(SCREEN_TEXTURE, uv + vec2(0.0, px.y)).rgb;
	vec3 c22 = texture(SCREEN_TEXTURE, uv + vec2(px.x, px.y)).rgb;

	vec3 base = texture(SCREEN_TEXTURE, uv).rgb;

	// --- COLOR EDGE DETECTION (Sobel on luminance) ---
	// Convert to luminance for edge detection
	float l00 = luminance(c00);
	float l01 = luminance(c01);
	float l02 = luminance(c02);
	float l10 = luminance(c10);
	float l12 = luminance(c12);
	float l20 = luminance(c20);
	float l21 = luminance(c21);
	float l22 = luminance(c22);

	// Sobel X kernel
	float sobel_color_x = (l02 + 2.0 * l12 + l22) - (l00 + 2.0 * l10 + l20);
	// Sobel Y kernel
	float sobel_color_y = (l20 + 2.0 * l21 + l22) - (l00 + 2.0 * l01 + l02);
	float color_edge = sqrt(sobel_color_x * sobel_color_x + sobel_color_y * sobel_color_y);
	// Smooth threshold to reduce noise
	color_edge = smoothstep(color_threshold, color_threshold + 0.1, color_edge);

	// --- COLOR + TOON ---
	vec3 col = apply_color_controls(base);
	col = apply_toon(col);

	// --- SUBTLE EDGE DARKENING ---
	// Darken edges slightly based on strength instead of full black outline
	col *= (1.0 - color_edge * edge_darkening);

	// --- OUTLINE MIX ---
	col = mix(col, outline_color.rgb, color_edge * outline_intensity);

	COLOR = vec4(col, 1.0);
}
