shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

//////////////////////////
// COLOR CONTROL
//////////////////////////
uniform float brightness : hint_range(0.8, 1.2) = 1.0;
uniform float contrast   : hint_range(0.8, 1.5) = 1.1;
uniform float saturation : hint_range(0.8, 1.5) = 1.2;

//////////////////////////
// TOON BANDING
//////////////////////////
uniform int bands : hint_range(2, 6) = 4;

//////////////////////////
// OUTLINE
//////////////////////////
uniform float outline_thickness : hint_range(0.5, 2.5) = 1.2;
uniform float color_threshold   : hint_range(0.05, 0.3) = 0.15;
uniform vec4 outline_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float outline_intensity : hint_range(0.0, 1.5) = 1.0;

//////////////////////////
// EDGE DARKENING (SUBTLE)
//////////////////////////
uniform float edge_darkening : hint_range(0.0, 0.4) = 0.15;

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

float edge_detect(vec3 center, vec2 uv, vec2 px) {
	vec3 left  = texture(SCREEN_TEXTURE, uv + vec2(-px.x, 0.0)).rgb;
	vec3 right = texture(SCREEN_TEXTURE, uv + vec2(px.x, 0.0)).rgb;
	vec3 up    = texture(SCREEN_TEXTURE, uv + vec2(0.0, -px.y)).rgb;
	vec3 down  = texture(SCREEN_TEXTURE, uv + vec2(0.0, px.y)).rgb;

	float diff =
		length(center - left) +
		length(center - right) +
		length(center - up) +
		length(center - down);

	diff *= 0.25;

	return smoothstep(color_threshold, color_threshold + 0.1, diff);
}

void fragment() {
	vec2 uv = SCREEN_UV;
	vec2 px = SCREEN_PIXEL_SIZE * outline_thickness;

	vec3 base = texture(SCREEN_TEXTURE, uv).rgb;

	// --- EDGE DETECTION (on original color) ---
	float edge = edge_detect(base, uv, px);

	// --- COLOR + TOON ---
	vec3 col = apply_color_controls(base);
	col = apply_toon(col);

	// --- SUBTLE EDGE DARKENING ---
	col *= (1.0 - edge * edge_darkening);

	// --- OUTLINE MIX ---
	col = mix(col, outline_color.rgb, edge * outline_intensity);

	COLOR = vec4(col, 1.0);
}